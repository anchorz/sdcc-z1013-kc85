#!/usr/bin/perl -w

use Data::Dumper;
use Digest::MD5 qw(md5_hex);
use File::Basename;
use Cwd 'abs_path';
use Switch;
use utf8;

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
    #TODO check encoding
    my $ret="";
    
    while (1) {    
        my $c=substr($content,$index,1);
        $line_index+=1;
        $index+=1;
        if ($c eq "\0" ) {
            return $ret;
        }
        #if (ord($c)>=0x80) {
        #    $c=chr(0xf100+ord($c));
        #}
        #utf8::encode(map_char($c));
        $ret.=map_char($c);
        if ($line_index==$line_length) {
            return $ret;
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

$out=~s/^s\.//i;
$out=~s/\.z80//i;
$out.=".s";

$len=-s "$file";
open(FILE,"<:raw", $file);
read(FILE,$content,$len);
close(FILE);

$index=0;
$aadr=read_word();
$eadr=read_word();
$src_end_ptr=$eadr-$aadr+32;

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

while(1) {
    $line_index=0; 
    #printf("INFO: line_index=%d\n",$line_index);
    $line_no=read_word();
    #printf("INFO: line_index=%d\n",$line_index);
    $line_length=read_byte();
    #printf("INFO: line_index=%d\n",$line_index);
    #$opcode_adr=$index;
    #$opcode=read_word();
    read_word();
    #printf("INFO: line_index=%d\n",$line_index);
    #$param16=read_word();
    read_word();
    #printf("INFO: line_index=%d\n",$line_index);
    
    $p1=read_str();
    if(length($p1)>0) {
        $p1.=":";
    }


    #if ($opcode==0x67 || $opcode==0x117 || $opcode==0x164|| $opcode==0x265 || $opcode==0x2064 || $opcode==0x1f64 || $opcode==0x0864) {
        my $p2=read_str();
        my $p3="";
        if ($line_index!=$line_length) {
            $p3=read_str();
        }
        my $p4="";        
        if ($line_index!=$line_length) {
            $p4=",".read_str();
        }
        printf(OUT "%5s %-6s %-5s%s%s\n",$line_no,$p1,$p2,$p3,$p4);

    if ($index>=$src_end_ptr)    {
        last;
    }    
}
printf("OK. \"%s\" erstellt.\n",$out);
close(OUT);

