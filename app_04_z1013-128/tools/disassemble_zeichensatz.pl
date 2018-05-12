#!/usr/bin/perl -w

use warnings;
use Data::Dumper;
use Digest::MD5 qw(md5_hex);
use File::Basename;
use Cwd 'abs_path';
use Switch;
use utf8;
use GD::Simple;

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

sub print_utf_line($ $ $) {
    my $start=shift;
    my $len=shift;
    my $line_break=shift;
    for ($j=0; $j<$len; $j++) {
        if ($j%$line_break==0) {
            if ($len!=1) {
                printf(FILE "U+%04x - U+%04x : ",$start+$j,$start+$j+$line_break-1);
            } else {
                printf(FILE "U+%04x          : ",$start+$j);
            }
        }
        printf(FILE "&#x%04x;",$start+$j);
        if ($j%$line_break==$line_break-1) {
            print(FILE "\n");
        }
    }

}


$filetype_bin=0;
$h=8;

$file=$ARGV[0];

if(!defined $file) {
    print("Argument missing: .z80 file that contain the Character-ROM content.\n");
    exit 1;
}

$len=-s "$file";
open(FILE,"<:raw", $file);
read(FILE,$content,$len);
close(FILE);

if ($filetype_bin==1) {
    $index=0;
} else {
    $index=32;
}
$cnt=0;
$scale=4;

for($y=0;$y<16;$y++) {
    for($x=0;$x<16;$x++) {
        my $img = GD::Simple->new(8*$scale, $h*$scale);
        $img->bgcolor('black');
        $img->fgcolor('black');
        for($j=0;$j<$h;$j++) {
            #if JKEMU CJJ Grafik
            #my $chr=(($cnt+0x20)&0xff);
            #my $ofs=256;
            #if ($cnt>=0xe0) {
            #    $ofs=512;
            #}
            #$index=256*$j+$chr+$ofs;
            printf (STDERR "c=%02x i=%04x\n",$cnt,$index);
            $line=read_byte();
            for($i=0;$i<8;$i++) {
                if (($line&0x80)==0x80) {
                    $img->rectangle($i*$scale, $j*$scale, $i*$scale+$scale-1, $j*$scale+$scale-1);
                    #print ("#");
                } #else {
                  #  print (".");
                #}
                $line*=2;
            }
            #print ("\n");
        }

        $name=sprintf("%02x.png",$cnt);
        open my $out, '>', $name or die;
        binmode $out;
        print $out $img->png;
        $cnt++;
    }
}

open(FILE,">zg.html");

$len=256;
$line_break=16;

print(FILE "<pre>\n");
for ($j=0; $j<$len; $j++) {
    if ($j%$line_break==0) {
         printf(FILE "0x%02x : ",$j);
    }
    printf(FILE "<img src=\"%02x.png\"/>",$j);
    if ($j%$line_break==$line_break-1) {
         print(FILE "\n");
    }
}
print(FILE "</pre>\n");

print(FILE "<pre>\n");
print(FILE "Hier unten noch einmal zum Vergleich der Zeichensatz der UTF-8 Erweiterung:\n");
print(FILE "</pre>\n");

print(FILE "<pre>\n");

print_utf_line(0xf10e,18,9);
print_utf_line(0xf120,32,16);
print_utf_line(0x20,127-32,16);
print(FILE "\n");
print_utf_line(0xc4,1,1);
print_utf_line(0xd6,1,1);
print_utf_line(0xdc,1,1);
print_utf_line(0xdf,1,1);

print_utf_line(0xe4,1,1);
print_utf_line(0xf6,1,1);
print_utf_line(0xfc,1,1);
print_utf_line(0xf180,128,16);



print(FILE "</pre>\n");


close(FILE);
