#!/usr/bin/perl -w

use warnings;
use strict;

use Data::Dumper;
use Digest::MD5 qw(md5_hex);
use File::Basename;
use Cwd 'abs_path';
use Switch;
use utf8;
use open ':std', ':encoding(UTF-8)';

our $content;
our $index;
our $max_index;
our $aadr;
our $header_size=32;    #in case of .z80 IMAGE

sub read_word() {
    my $ret=unpack("v",substr($content,$index,2));
    $index+=2;
    #printf("val=%04x\n",$ret);
    return $ret;
}

sub read_byte() {
    my $ret=ord(substr($content,$index,1));
    $index+=1;
    return $ret;
}

sub read_char() {
    my $ret=substr($content,$index,1);
    $index+=1;
    return $ret;
}

sub read_file($) {
    my $file=shift;
    my $len=-s "$file";
    $max_index=$len-1;
    open(FILE,"<:raw", $file);
    read(FILE,$content,$len);
    close(FILE);
}

sub map_char($) {
    my $c=shift;
    
    my $mapped=$c;
   
    if (ord($c)>=0x00 && ord($c)<=0x1f) {
        return chr(0xf120+ord($c));
    } elsif (ord($c)>=0x20 && ord($c)<=0x7e){
        return $c;
    } else {
        return chr(0xf100+ord($c));
    }
    return $c;
}

sub map_adr_to_index($) {
    my $adr=shift;
    
    return $adr-$aadr+$header_size;
}


if (!defined $ARGV[0] ) {
    print STDERR "convert a Tiny-BASIC programm back to a plain text file:\n";
    print STDERR "remark: maps special Z1013 characters 0x00-0x20 and 0x7f-0xff to\n";
    print STDERR "        UTF-8 font character starting from U+f100\n";
    print STDERR "        output stored as \"tiny-basic-file.b\"\n\n";
    print STDERR "usage: ".basename($0)." tiny-basic-file.z80\n";
    exit 1;
}

my $file=$ARGV[0];
my $out=$file;

$out=~s/^b\.//i;
$out=~s/\.z80//i;
$out.=".b";

read_file($file);

$index=0;
$aadr=read_word();
if ($aadr!=0x1000) {
    printf(STDERR "error: Does not looks like a Tiny-Basic program - Z80Header.AADR==0x%04x\n",$aadr);
    printf(STDERR "       It should start from 0x1000.\n");

    exit 1;
}
$index=12;
my $typ=read_char();
if ($typ ne 'b' ) {
    printf(STDERR "error: Does not looks like a Tiny-Basic program - Z80Header.TYP=='%s'\n",map_char($typ));
    printf(STDERR "       The character 'b' is expected instead.\n");

    exit 1;
}

$index=map_adr_to_index(0x101f);
my $start_of_data=0x1152; #default start of the program source code
my $end_of_data=read_word(); #actually end_of_data points to the byte AFTER the source code
#printf(STDERR "i: end_of_data[0x101f]=0x%04x\n",$end_of_data);
#printf(STDERR "i: start=0x%04x\n",map_adr_to_index(0x1152));

if ($end_of_data < $start_of_data ) {
    printf(STDERR "error: Does not looks like a Tiny-Basic program.\n");
    printf(STDERR "       end-of-text pointer(0x%04x) is before the actual start(0x1152)\n",$end_of_data);

    exit 1;
}

if (map_adr_to_index($end_of_data)-1>$max_index) {
    printf(STDERR "warning: end-of-text pointer(0x%04x) is outside the program image.\n",$end_of_data);
    printf(STDERR "         It may work, but input data seems corrupted and output\n");
    printf(STDERR "         will incomplete.\n");
}

open(OUT,">", $out);
binmode(OUT, ":utf8");
print(OUT "Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)\n\n");
$index=map_adr_to_index(0x1152);
while($index<map_adr_to_index($end_of_data)) {
    my $line_no=read_word();
    printf OUT "%d ",$line_no;
    my $c;
    do {
        if ($index<map_adr_to_index($end_of_data)) {
            $c=read_char();
            if ($c ne "\r") {
                printf OUT "%s",map_char($c);
                #printf "%x %x %x[%02x]%s\n",$index,map_adr_to_index($end_of_data),$max_index,ord($c),$c;
            }
        } else {
            last;
        }
    } while ($c ne "\r"); 
    printf OUT "\n";
}
printf("OK. \"%s\" erstellt.\n",$out);
close(OUT);

