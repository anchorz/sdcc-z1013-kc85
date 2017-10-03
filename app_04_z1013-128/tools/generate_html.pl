#!/usr/bin/perl -w

use Digest::MD5 qw(md5_hex);

sub resolve_links($ $)
{
    my $dir=shift;
    my $content=shift;
    while($content=~s/&lt;link&gt;(.*?)&lt;\/link&gt;/<a href="$1">$1<\/a>/si)
    {
    }
    while($content=~m/&lt;include&gt;(.*?)&lt;\/include&gt;/si)
    {
        $str=$1;
        if (-e "$dir/$str"){
        my $len=-s "$dir/$str";
        open(LNK,"<:raw","$dir/$str");
        read LNK, $ldata, $len;
        close(LNK);
        } else {
            printf STDERR "e: link file not found \"$dir/%s\"\n",$str;
            $ldata="e: include-file not found $str";
        }        
        $content=~s/&lt;include&gt;(.*?)&lt;\/include&gt;/$ldata/si;
    }
    $content=~s/&/&amp;>/sgi;
    $content=~s/</&lt;/sgi;
    $content=~s/>/&gt;/sgi;
            
    return $content;
}

sub print_entry($) {
    my $dir=shift;
    
    my @z80=();
    opendir(my $dh, "$dir") || die "Can't open \"$dir\": $!";
    my $srcmd5=(split(/-/,$dir))[0];
    while (readdir $dh) {
        if (-f "$dir/$_" && /\.z80$/) {
                push(@z80,$_);
        }
    }
    closedir $dh;
    
    if ($#z80==-1) {
        my $error="e: Verzeichnis \"$dir\" enthält keine .Z80 Datei\n";
        print STDERR "$error";
        return "$error";
    }
    if ($#z80!=0) {
        my $error="e: $dir hat mehr als eine .Z80 Datei\n";
        foreach ( @z80 )
        {
            print STDERR "  $_\n";
        }        
        print STDERR "$error";
        return "$error";
    }
    
    my $filename="$dir/$z80[0]";
    open(FILE,"<:raw","$filename");
    read FILE, my $bytes, 2;
    my $aadr=unpack("v",$bytes);
    read FILE, $bytes, 2;
    my $eadr=unpack("v",$bytes);
    read FILE, $bytes, 2;
    my $sadr=unpack("v",$bytes);
    read FILE, $bytes, 6;
    read FILE, $bytes, 1;
    my $typ=unpack("a",$bytes);
    
    my %knownFileTypes=('C'=>1,'T'=>1,'I'=>1,'E'=>1,'s'=>1);
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
    
    my %zeichenMap=("\xff"=>"\xE2\x96\x88","<"=>"&lt;",">"=>"&gt;","&"=>"&amp;");
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
    
    my $len=-s $filename;
    open(Z80,"<",$filename);
    read Z80, $bytes, $len;
    $digest = md5_hex($bytes);
    close(Z80);
    if ($digest ne $srcmd5) {
        printf STDERR "w: md5 stimmt nicht überein %s:%s\n",$digest,$filename;
    }
    
    my $kurz="";
    if (-f "$dir/info.txt") {
        my $len=-s "$dir/info.txt";    
        open(INFO,"<","$dir/info.txt");
        read(INFO,my $info,$len);
        if ($info=~/<kurz>(.*)<\/kurz>/sgi) {
            #print STDERR $1;
            my $txt=$1;
    
            $txt=~s/&/&amp;>/sgi;
            $txt=~s/</&lt;/sgi;
            $txt=~s/>/&gt;/sgi;
            $txt=~s/\n/<br\/>\n/sgi;
            $kurz=$txt; 
        }
        close(INFO);
    }
    
    $displayName=~s/[\s]/&nbsp;/sgi;
    my $entry=sprintf "<div>%s %04x %04x %04x %s ... <a href=\"$dir/index.html\">%s</a> %s</div>",$digest,$aadr,$eadr,$sadr,$typ,$displayName,$kurz;
    close(FILE);
    
    
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
    $item_content.=sprintf "<div class=\"filelist\">%04x %04x %04x %s ... <a href=\"%s\">%s</a></div>\n",$aadr,$eadr,$sadr,$typ,$z80[0],$displayName;
    
    if (-f "$dir/info.txt") {
        #printf STDERR "i: info.txt existiert $filename\n";
        my $len=-s "$dir/info.txt";    
        open(INFO,"<","$dir/info.txt");
        read(INFO,my $info,$len);
        if ($info=~/<lang>(.*)<\/lang>/sgi) {
            #print STDERR $1;
            my $lang=$1;
    
            $lang=~s/&/&amp;>/sgi;
            $lang=~s/</&lt;/sgi;
            $lang=~s/>/&gt;/sgi;
            #bei <pre> nicht notwendig  $lang=~s/\n/<br\/>\n/sgi;
            $item_content.="<pre>".resolve_links($dir,$lang)."</pre>";        
        }
        close(INFO);
    }
    
    $len=-s "item.templ";
    open(FILE,"<","item.templ");
    read(FILE,my $content,$len);
    $content=~s/__BODY__/$item_content/s;
    close(FILE);
    
    open(FILE,">","$dir/index.html");
    print FILE $content;
    close(FILE);
        
    my $ret="$entry\n";
    return $ret;
}


my $ret= "<div class=\"filelist\">\n";

opendir(my $dh, ".") || die "Can't open \".\": $!";
    while (readdir $dh) {
        if (-d $_ && $_ ne '.' && $_ ne '..') {
        $ret.=print_entry($_);
    }
}
closedir $dh;

$ret.="</div>";

my $len=-s "index.templ";
open(FILE,"<","index.templ");
read(FILE,my $content,$len);
$content=~s/__BODY__/$ret/s;
close(FILE);

open(FILE,">","index.html");
print FILE $content;
close(FILE);


