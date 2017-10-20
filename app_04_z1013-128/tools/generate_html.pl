#!/usr/bin/perl -w

use Data::Dumper;
use Digest::MD5 qw(md5_hex);
use File::Basename;
use Cwd 'abs_path';

sub get_git_base() {
    return abs_path(dirname(abs_path($0))."/..");
}

sub get_database_folder() {
    return get_git_base()."/assets";
}

sub resolve_links($ $)
{
    my $dir=shift;
    my $content=shift;
    #print "$dir\n";
    while($content=~s/&lt;link&gt;(.*?)&lt;\/link&gt;/<a href="$1">$1<\/a>/si)
    {
    }
    while($content=~m/<include src="(.*?)"\/>/sgi)
    {
        $str=$1;

        if (-e "$dir/$str") {
            my $len=-s "$dir/$str";
            open(LNK,"<:raw","$dir/$str");
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
    
    my %zeichenMap=("\xff"=>"\xE2\x96\x88","<"=>"&lt;",">"=>"&gt;","&"=>"&amp;"," "=>"&nbsp;");
    my $displayName="";
    for ($i=0;$i<16;$i++)
    {
        read FILE, $bytes, 1;
        my $chr=ord($bytes);
        if ($chr>=0x20 && $chr<=0x7e) {
            my $subst=$zeichenMap{$bytes};
            if (!$subst){
                $subst=$bytes;
            }
            $displayName.=$subst;
        } else {
            my $subst=$zeichenMap{$bytes};
            if (!$subst){
                printf STDERR "w: Zeichenkonvertierung '\\x%02x' %s\n",$chr,$filename;
                $displayName.="?";
            } else {
                $displayName.=$subst;      
            }
        }
    }
    $db_entry[4]=$displayName;

    my $len=-s $filename;
    open(Z80,"<",$filename);
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
        read(INFO,my $info,$len);
        if ($info=~/<kurz src=\"(.*?)\"\/>/sgi) {
        #if ($info=~/<kurz/>(.*)<\/kurz>/sgi) {
            $kurz=$1;
        }
        close(INFO);
    }


     my $item_content="";
    
    $item_content.="<div>";
    if (-f "$dir/jkcemu.gif") {
        $item_content.="<img src=\"jkcemu.gif\"/>"; 
    }
    if (-f "$dir/screenshot_01.png") {
        $item_content.="<img src=\"screenshot_01.png\"/>"; 
    }
    if (-f "$dir/screenshot_02.png") {
        $item_content.="<img src=\"screenshot_02.png\"/>"; 
    }
    if (-f "$dir/screenshot_03.png") {
        $item_content.="<img src=\"screenshot_03.png\"/>"; 
    }
    if (-f "$dir/screenshot_04.png") {
        $item_content.="<img src=\"screenshot_04.png\"/>"; 
    }
    $item_content.="</div>";
    $item_content.=sprintf "<div class=\"filelist\">%04x %04x %04x %s ... <a href=\"%s\">%s</a></div>\n",$en[0],$en[1],$en[2],$en[3],basename($filename),$en[4];
    
    if (-f "$dir/info.txt") {
        #printf STDERR "i: info.txt existiert $filename\n";
        my $len=-s "$dir/info.txt";    
        open(INFO,"<","$dir/info.txt");
        read(INFO,my $info,$len);
        if ($info=~/<lang>(.*)<\/lang>/sgi) {
            #print STDERR $1;
            my $lang=$1;
            $item_content.="<pre>".resolve_links($dir,$lang)."</pre>";        
        }
        close(INFO);
    }
    
    my $template=get_database_folder()."/db/item.templ";
    $len=-s $template;
    open(FILE,"<",$template);
    read(FILE,my $content,$len);
    $content=~s/__BODY__/$item_content/s;
    close(FILE);
    
    open(FILE,">","$dir/index.html");
    print FILE $content;
    close(FILE);
        
    return $kurz;
}

sub print_entry2($ $) {
    my $filename=shift;
    my $row=shift;

    my @en=@{$db_entry_list{$filename}};

    my $link=basename(dirname($filename));
    my ($srcmd5,$tag)=split(/-/,$link);

    if ($en[5] ne $srcmd5) {
        printf STDERR "w: md5 stimmt nicht überein \"%s\" => \"%s-%s\"\n",$link,$en[5],$tag;
    }

    $link.="/index.html";
    my $kurz=do_index_html($filename);
    if ($row%2) {
        $row_class="even";
    } else {
        $row_class="odd";
    }
    my $entry=sprintf "<div class=".$row_class.">%s %04x %04x %04x&nbsp;%s&nbsp;... <a href=\"%s\">%s</a> %s</div>\n",$en[5],$en[0],$en[1],$en[2],$en[3],$link,$en[4],$kurz;
    return $entry;  
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
my $file_root=get_database_folder();

file_search(get_database_folder(),get_database_folder());

my $ret="";

my $len_total=scalar @file_list;
my $len_fail=scalar (keys %fail_entry_list);
my $len_sonst=scalar (keys %sonst_entry_list);
my $len_db=scalar (keys %db_entry_list);

my $len_checked=$len_fail+$len_sonst+$len_db;

$ret.="<div>Es wurden $len_total verschiedene Dateien mit der Endung .z80 in den verschiedenen Z1013 Softwarearchiven gefunden</div>";
$ret.="<div>$len_checked sind insgesamt getestet worden (".sprintf("%.1f",$len_checked*100.0/$len_total)."%).</div>\n";
$ret.="<div>$len_db sind hier aufgelistet.</div>\n";
$ret.="<div>".($len_fail+$len_sonst)." wurden als fehlerhaft oder mit gleichem Inhalt aussortiert.</div>\n";

$ret.= "<div class=\"filelist\">\n";

for $db_entry (keys %db_entry_list) {
    resolve_entry($db_entry);
}

my $row=0;
for $db_entry (sort { lc $db_entry_list{$a}[4] cmp lc $db_entry_list{$b}[4] } keys %db_entry_list) {
    $ret.=print_entry2($db_entry,$row);
    $row++;
}

$ret.="</div>";

my $len=-s "$index_templ";
open(FILE,"<", $index_templ);
read(FILE,my $content,$len);
$content=~s/__BODY__/$ret/s;
close(FILE);

open(FILE,">",$index_html);
print FILE $content;
close(FILE);


