#!/usr/bin/perl -w

use Data::Dumper;
use Digest::MD5 qw(md5_hex);
use File::Basename;
use Cwd 'abs_path';
use Switch;
use utf8;

binmode(STDOUT,":utf8");

our $map_ctrl=1;

sub read_word() {
    #printf("read idx=%x ",$index);
    my $ret=unpack("v",substr($content,$index,2));
    $index+=2;
    $line_index+=2;
    #printf("val=%04x\n",$ret);
    return $ret;
}

sub read_byte() {
    my $ret=ord(substr($content,$index,1));
    $index+=1;
    $line_index+=1;
    return $ret;
}

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

sub read_str() {
    my $ret="";
    
    while (1) {    
        my $c=substr($content,$index,1);
        $index++;
        if ($c eq "\0" ) {
            return $ret;
        }
        if (ord($c)<15) {
            $ret.=" "x ord($c);
        } else {
            $ret.=map_char($c);
        }
    }
}

if (!defined $ARGV[0]  ) {
    print "convert KC-BASIC to text:\n";
    print "Z1013 maps special Z1013 characters to UTF-Font starting from U+f100\n";
    print basename($0)." edas.z80 >edas.s\n";
    exit 1;
}

$file=$ARGV[0];
my $out=$file;

$out=~s/^A\.//i;
$out=~s/\.z80//i;
$out.=".A";

$len=-s "$file";
open(FILE,"<:raw", $file);
read(FILE,$content,$len);
close(FILE);

$index=0;
#$aadr=read_word();
#$eadr=read_word();

$index=32;

open(OUT,">", $out);
binmode(OUT, ":utf8");
print(OUT "Zeichensatz UTF-8+Z1013()");
if ($map_ctrl) {
    print(OUT "+CTRL()");
} else {
    print(OUT "-CTRL()");
}
print(OUT "-ohne Umlaute(äöüß)\n\n");

$src_len=read_word();
$len=$src_len+32-1;

read_word(); #ende?
read_byte(); #ende?

while($index<$len) {
    $line_no=read_word();
    $cmd=read_str();
    printf(OUT "%04x %s\n",$line_no,$cmd);
}
printf("OK. \"%s\" erstellt.\n",$out);
close(OUT);

