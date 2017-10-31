#!/usr/bin/perl -w

use Data::Dumper;
use Digest::MD5 qw(md5_hex);
use File::Basename;
use Cwd 'abs_path';
use File::stat;
use utf8;

binmode(STDERR, ":utf8");

sub get_git_base() {
    return abs_path(dirname(abs_path($0))."/..");
}

sub get_database_folder() {
    return get_git_base()."/assets";
}

sub get_tools_root() {
    return abs_path(dirname(abs_path($0)));
}

$map_ctrl=0; #map 0x0e..0x1f to Z1013 Chess figures

sub map_char($) {
    my $c=shift;
    
    my $mapped=$c;
   
    if (ord($c)>=0x00 && ord($c)<=0x1f) {
        if ($map_ctrl) {
            return chr(0xf120+ord($c));
        }
        if (ord($c)>=0x0e && ord($c)<=0x1f) {
            return chr(0xf100+ord($c));
        }
        return chr(0xf1ff);
    } elsif (ord($c)>=0x20 && ord($c)<=0x7e){
        return $c;
    } else {
        if ($map_ctrl==0 && ord($c)==0x7f) {
            return chr(0xf1ff);
        }
        return chr(0xf100+ord($c));
    }
    return $c;
}

sub html_encode($) {
    my $str=shift;
    $str=~s/&/\%26/sgi;
    $str=~s/ /\%20/sgi;
    $str=~s/\[/\%5b/sgi;
    $str=~s/\\/\%5c/sgi;
    $str=~s/\]/\%5d/sgi;
    #print STDERR "$str\n";
    return $str;
}

sub xml_encode($) {
    my $str=shift;
    $str=~s/&/&amp;/sgi;
    return $str;
}

sub resolve_links($ $)
{
    my $dir=shift;
    my $content=shift;
    my $ldata="";
    #print "$dir\n";
    while($content=~s/&lt;link&gt;(.*?)&lt;\/link&gt;/<a href="$1">$1<\/a>/si)
    {
    }
    while($content=~m/<include src="(.*?)"\/>/sgi)
    {
        $str=$1;

        if (-e "$dir/$str") {
            my $len=-s "$dir/$str";
            open(LNK,"<","$dir/$str");
            binmode(LNK, ":utf8");
            read LNK, $ldata, $len;
            close(LNK);
            if ($str=~m/\.html$/) {
                #printf STDERR "e: include html\n";
            } else {
                $ldata=~s/&/&amp;>/sgi;
                $ldata=~s/</&lt;/sgi;
                $ldata=~s/>/&gt;/sgi;
                $ldata="<pre>".$ldata."</pre>\n";
            }
        } else {
            printf STDERR "e: link file not found \"$dir/%s\"\n",$str;
            $ldata="e: include-file not found $str";
        }        
        $content=~s/<include src="(.*?)"\/>/$ldata/si;
    }
    #TODO info.txt muss html-konform sein, kein ersetzen
    #     bestenfalls mal eine warnung abgeben, falls doch etwas Falsches dort steht    
    #     includes sind preformatted, nur hier sollte ersetzt werden    
    return $content;
}

%db_entry_list=();
%fail_entry_list=();
%sonst_entry_list=();

sub resolve_entry($) {

    my $filename=shift;

    my $z80len=-s $filename;
    if ($z80len%32) {
        printf STDERR "e: Dateigröße muss es Vielfaches von 32 sein. %d Bytes fehlen.\n", 32-$z80len%32 ;
        printf STDERR "   %s\n", $filename ;
    }

    open(FILE,"<:raw","$filename");
    read FILE, my $bytes, 2;
    my $aadr=unpack("v",$bytes);
    $db_entry[0]=$aadr;

    read FILE, $bytes, 2;
    my $eadr=unpack("v",$bytes);
    $db_entry[1]=$eadr;

    read FILE, $bytes, 2;
    my $sadr=unpack("v",$bytes);
    $db_entry[2]=$sadr;

    read FILE, $bytes, 6;
    read FILE, $bytes, 1;
    my $typ=unpack("a",$bytes);
    $db_entry[3]=$typ;

    my $z80ImageLen=$eadr-$aadr+1;
    if ($z80ImageLen>($z80len-32)) {
        printf STDERR "e: Ist %d Bytes kleiner, als im Header angegeben.\n", $z80ImageLen-($z80len-32) ;
        printf STDERR "   %s\n", $filename ;
    }
    
    my %knownFileTypes=(
      'C'=>"Executable",
      'D'=>"Dump",
      'M'=>"Executable ohne Autostart",
      'T'=>"Text",
      'I'=>"Dokumentation",
      'E'=>"EPROM",
      's'=>"Assembler",
      'B'=>"KC-Basic",
      'P'=>"Pascal",
      'G'=>"Grafikeditor",
      'b'=>"TinyBasic",
      ' '=>"CPM",
    );

    if (!$knownFileTypes{$typ})
    {
        my $error=sprintf "e: unbekannter Dateityp '%s' %s\n",$typ,$filename;
        print STDERR "$error";
        return $error;
    }
    read FILE, $bytes, 3;
    my $tag=unpack("a*",$bytes);
    if ("$tag" ne"\xd3\xd3\xd3") {
        printf STDERR "e: Z80-Header-Tag ist nicht korrekt, statt \"d3d3d3\" steht \"%s\" %s\n",unpack("H*",$tag),$filename;
    }
    
    my %zeichenMap=("<"=>"&lt;",">"=>"&gt;","&"=>"&amp;");
    my $displayName="";
    for ($i=0;$i<16;$i++)
    {
        read FILE, $bytes, 1;
        $bytes=map_char($bytes);
        my $subst=$zeichenMap{$bytes};
        if (!$subst){
            $subst=$bytes;
        }
        $displayName.=$subst;
        #my $chr=ord($bytes);
        #if ($chr>=0x20 && $chr<=0x7e) {
        # my $subst=$zeichenMap{$bytes};
        #    if (!$subst){
        #        $subst=$bytes;
        #    }
        #    $displayName.=$subst;
        #} else {
        #    my $subst=$zeichenMap{$bytes};
        #    if (!$subst){
        #        printf STDERR "w: Zeichenkonvertierung '\\x%02x' %s\n",$chr,$filename;
        #        $displayName.="?";
        #    } else {
        #        $displayName.=$subst;      
        #    }
        #}
    }
    $db_entry[4]=$displayName;

    my $len=-s $filename;
    open(Z80,"<:raw",$filename);
    read Z80, $bytes, $len;
    $digest = md5_hex($bytes);
    close(Z80);
    $db_entry[5]=$digest;
    $db_entry_list{$filename}=[@db_entry];
}

sub do_index_html($)
{
    my $filename=shift;
    my $dir=dirname($filename);
    my @en=@{$db_entry_list{$filename}};

    my $kurz="";
    if (-f "$dir/info.txt") {
        my $len=-s "$dir/info.txt";    
        open(INFO,"<","$dir/info.txt");
        binmode(INFO, ":utf8");
        read(INFO,my $info,$len);
        if ($info=~/<kurz src=\"(.*?)\"\/>/sgi) {
            $kurz=$1;
        }
        close(INFO);
    }

    %screen_shot=(
        "jkcemu_screen_01.txt"=>"screenshot_01.jpg",
        "jkcemu_screen_02.txt"=>"screenshot_02.jpg",
        "jkcemu_screen_03.txt"=>"screenshot_03.jpg",
        "jkcemu_screen_04.txt"=>"screenshot_04.jpg"
    );

    for (keys(%screen_shot)) {
        if( -f "$dir/$_") {
            my $timestamp_src=stat("$dir/$_")->mtime;
            my $timestamp_dst=0;
            my $file_dst="$dir/$screen_shot{$_}";
            
            if( -f $file_dst) {
                $timestamp_dst=stat($file_dst)->mtime;
            }

            if ($timestamp_dst<$timestamp_src) {
                $ret=system("java -jar ".get_tools_root()."/screen2png.jar 32X32 ".get_database_folder()."/db/ccef2fbe5ee7ff090c380119c78ca4e9-zg_1013_orig/zg_1013_orig.z80 \"$dir/$_\" \"$dir/tmp.png\"" );
                if ($ret) {
                    printf("error.");
                    exit($ret);
                }
                $ret=system("convert \"$dir/tmp.png\" -virtual-pixel black -distort Barrel '0.0 0.0 0.04 0.96' -attenuate 0.3 +noise gaussian -motion-blur 1x6+45 -normalize -quality 70% \"$file_dst\"" );
                if ($ret) {
                    printf("error.");
                    exit($ret);
                }
                system("rm \"$dir/tmp.png\"");
            }
        }
    }

    my $has_video="no";    
    my $file_src="$dir/jkcemu_video_text.txt";
    if( -f $file_src) {
        $has_video="rendered_video";
        my $timestamp_src=stat($file_src)->mtime;
        my $timestamp_dst=0;
        my $file_dst="$dir/animation.mp4";
        if( -f $file_dst) {
            $timestamp_dst=stat($file_dst)->mtime;
        }
        if ($timestamp_dst<$timestamp_src) {
            $ret=0; 
            $ret=system("java -jar ".get_tools_root()."/screen2png.jar 32X32 ".get_database_folder()."/db/ccef2fbe5ee7ff090c380119c78ca4e9-zg_1013_orig/zg_1013_orig.z80 \"$file_src\"" ); #\"$file_dst\"" );
            if ($ret) {
                printf("error.");
                exit($ret);
            }
        	$ret=system("find \"$dir\" -name \"tmp*.png\" | sort -n | xargs -P 2 -t -I '{}' convert '{}' -virtual-pixel black -distort Barrel '0.0 0.0 0.04 0.96' -motion-blur 1x6+45 -normalize -quality 70% '{}'.jpg");
            if ($ret) {
                printf("error.");
                exit($ret);
            }
        	$ret=system("ffmpeg -r 10 -s 512x512 -i \"$dir/tmp%04d.png.jpg\"  -s 512x512 -pix_fmt yuv420p -crf 28 \"$dir/animation.mp4\" -y");
            if ($ret) {
                printf("error.");
                exit($ret);
            }
  	        system("find \"$dir\" -name \"tmp*.jpg\" -exec rm {} \\;");
  	        system("find \"$dir\" -name \"tmp*.png\" -exec rm {} \\;");
        }
    }

    my $item_content="";
    $item_content.="<div>";
    if (-f "$dir/animation.mp4") {
        if ($has_video eq "no") {
            $has_video="pixel_video";
        }
        $item_content.='<video height="400" controls autoplay loop>'."\n";
        $item_content.='<source src="animation.mp4" type="video/mp4">'."\n";
        $item_content.='</video>'."\n";
    } elsif (-f "$dir/jkcemu.gif") {
        $item_content.="<img src=\"jkcemu.gif\"/>"; 
    }
    

    if (-f "$dir/screenshot_01.jpg") {
        $item_content.="<img src=\"screenshot_01.jpg\" alt=\"Screenshot 1\" height=\"384\"  >\n"; 
    } elsif (-f "$dir/screenshot_01.png") {
        $item_content.="<img src=\"screenshot_01.png\" alt=\"Screenshot 1\" height=\"384\"  />\n"; 
    }

    if (-f "$dir/screenshot_02.jpg") {
        $item_content.="<img src=\"screenshot_02.jpg\" alt=\"Screenshot 2\" height=\"384\"  >\n"; 
    }elsif (-f "$dir/screenshot_02.png") {
        $item_content.="<img src=\"screenshot_02.png\" alt=\"Screenshot 2\" height=\"384\"  >\n"; 
    }
     if (-f "$dir/screenshot_03.jpg") {
        $item_content.="<img src=\"screenshot_03.jpg\" alt=\"Screenshot 3\" height=\"384\"  >\n"; 
    } elsif (-f "$dir/screenshot_03.png") {
        $item_content.="<img src=\"screenshot_03.png\" alt=\"Screenshot 3\" height=\"384\"  />\n"; 
    }
    if (-f "$dir/screenshot_04.jpg") {
        $item_content.="<img src=\"screenshot_04.jpg\" alt=\"Screenshot 4\" height=\"384\"  >\n"; 
    } elsif (-f "$dir/screenshot_04.png") {
        $item_content.="<img src=\"screenshot_04.png\" alt=\"Screenshot 4\" height=\"384\" />\n"; 
    }
    $item_content.="</div>\n";
    $item_content.=sprintf "<div class=\"filelist\">%04x %04x %04x %s ... <a href=\"%s\">%s</a></div>\n",$en[0],$en[1],$en[2],$en[3],html_encode(basename($filename)),$en[4];
    
    if (-f "$dir/info.txt") {
        #printf STDERR "i: info.txt existiert $filename\n";
        my $len=-s "$dir/info.txt";    
        open(INFO,"<","$dir/info.txt");
        binmode(INFO, ":utf8");
        read(INFO,my $info,$len);
        if ($info=~/<lang>(.*)<\/lang>/sgi) {
            #print STDERR $1;
            my $lang=$1;
            $item_content.="<div class=\"text\">".resolve_links($dir,$lang)."</div>";        
        }
        close(INFO);
    }
    
    my $template=get_database_folder()."/db/item.templ";
    $len=-s $template;
    open(FILE,"<",$template);
    binmode(FILE, ":utf8");
    read(FILE,my $content,$len);
    $content=~s/__BODY__/$item_content/s;
    close(FILE);
    
    open(FILE,">","$dir/index.html");
    binmode(FILE, ":utf8");
    print FILE $content;
    close(FILE);
        
    return ($kurz,$has_video);
}

sub print_entry2($ $) {
    my $filename=shift;
    my $row=shift;
    
    my $xml_entry="<file "; 

    my @en=@{$db_entry_list{$filename}};

    my $link_base=basename(dirname($filename));
    my ($srcmd5,$tag)=split(/-/,$link_base);

    if ($en[5] ne $srcmd5) {
        printf STDERR "w: md5 stimmt nicht überein \"%s\" => \"%s-%s\"\n",$link_base,$en[5],$tag;
    }

    my $link=$link_base."/index.html";
    my ($kurz,$has_video)=do_index_html($filename);
    if ($row%2) {
        $row_class="even";
    } else {
        $row_class="odd";
    }
    if ($has_video eq "rendered_video") {
        $has_video='<a href="'.html_encode($link_base."/animation.mp4").'"><img src="../img/video_capture.png" width="12" height="12" alt="Clip anzeigen"/></a>'."\n";
    } elsif ($has_video eq "pixel_video") {
        $has_video='<a href="'.html_encode($link_base."/animation.mp4").'"><img src="../img/if_theaters_326711.png" width="12" height="12" alt="Clip anzeigen"/></a>'."\n";
    } else {
        $has_video='<img src="../img/1x1.png" width="12" height="12" alt="leer"/>'."\n";
    }

    my $remove_space=$en[4];
    $remove_space=~s/ /&nbsp;/sgi;
    my $entry=sprintf "<div class=".$row_class.">%s %04x %04x %04x&nbsp;%s&nbsp;... <a href=\"%s\">%s</a> %s %s</div>\n",$en[5],$en[0],$en[1],$en[2],$en[3],html_encode($link),$remove_space,$has_video,$kurz;
    my $url=$filename;
    $url=~s/^.*?\/db\///sgi;
    $xml_entry.=sprintf("aadr=\"%04x\" eadr=\"%04x\" sadr=\"%04x\" typ=\"%s\" link=\"%s\" name=\"%s\" kurz=\"%s\" ",$en[0],$en[1],$en[2],$en[3],html_encode($url),$en[4],xml_encode($kurz)); 

    $xml_entry.="/>\n"; 
    return ($entry,$xml_entry);  
}

@file_list=();

sub file_search($ $);

sub file_search($ $) {
    my $root=shift;
    my $base_directory=shift;

    opendir(my $dh, $root) || die "Can't open \".\": $!";
    while (readdir $dh) {
        $handle="$root/$_";
        if (-l $handle) {
            #no checksum for links - ignore that
            #TODO may check if destination still exists
            #print "SYM: $_\n";
        } elsif (-d $handle) {
            if ($_ ne "." && $_ ne "..") {
                #print "DIR: $root/$_\n";            
                file_search($handle,$base_directory);
            }
        } elsif (-f $handle) {
            #print "FIL: $handle\n";
            if ($handle=~m/\.z80$/i) {
                if (index($handle, $base_directory."/db") == 0) {
                    #print "Z80: $base_directory $handle\n";
                    $db_entry_list{$handle}=1;
                }
                if (index($handle, $base_directory."/fail") == 0) {
                    #print "Z80: $base_directory $handle\n";
                    $fail_entry_list{$handle}=1;
                }
                if (index($handle, $base_directory."/sonst") == 0) {
                    #print "Z80: $base_directory $handle\n";
                    $sonst_entry_list{$handle}=1;
                }
                push(@file_list,$handle);
            }
        } else{
            print "e: unbekannter Dateityp für $handle\n";
            print "Script Ende...\n";        
        }
    }
    closedir $dh;
}

my $db_root=get_database_folder()."/db";
my $index_html=get_database_folder()."/db/index.html";
my $index_templ=get_database_folder()."/db/index.templ";
my $xml_file=get_database_folder()."/db/list.xml";
my $file_root=get_database_folder();

file_search(get_database_folder(),get_database_folder());

my $ret="";

my $len_total=scalar @file_list;
my $len_fail=scalar (keys %fail_entry_list);
my $len_sonst=scalar (keys %sonst_entry_list);
my $len_db=scalar (keys %db_entry_list);

my $len_checked=$len_fail+$len_sonst+$len_db;

$ret.="<p>Es wurden $len_total verschiedene Dateien mit der Endung .z80 oder .bin in den verschiedenen Z1013 Softwarearchiven gefunden, davon sind:</p>";
$ret.="<ul>";
$ret.="<li>$len_checked insgesamt getestet worden (".sprintf("%.1f",$len_checked*100.0/$len_total)."%).</li>\n";
$ret.="<li>$len_db hier aufgelistet.</li>\n";
$ret.="<li>und ".($len_fail+$len_sonst)." wurden als fehlerhaft oder mit gleichem Inhalt aussortiert.</li>\n";
$ret.="</ul>";

$ret.= "<div class=\"filelist\">\n";

for $db_entry (keys %db_entry_list) {
    resolve_entry($db_entry);
}

my $xml="<filelist>\n";
my $row=0;
for $db_entry (sort { lc $db_entry_list{$a}[4] cmp lc $db_entry_list{$b}[4] } keys %db_entry_list) {
    
    ($html_entry,$xml_entry)=print_entry2($db_entry,$row);
    $ret.=$html_entry;
    $xml.=$xml_entry;
    $row++;
}
$xml.="</filelist>\n";

open(UTF,">", $xml_file);
binmode(UTF, ":utf8");
print UTF $xml;
close(UTF);

$ret.="</div>";

my $len=-s "$index_templ";
open(FILE,"<", $index_templ);
binmode(FILE, ":utf8");
read(FILE,my $content,$len);
$content=~s/__BODY__/$ret/s;

open(FILE,">",$index_html);
binmode(FILE, ":utf8");
print FILE $content;
close(FILE);


