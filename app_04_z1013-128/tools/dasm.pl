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

our $header_size=32;    #in case of .z80 IMAGE

if (!defined $ARGV[0] ) {
    print STDERR "disassemble Z1013 File\n";
    print STDERR "        output stored as \"file.asm\"\n\n";
    print STDERR "usage: ".basename($0)." file.z80\n";
    exit 1;
}

if (defined $ARGV[1] ) {
    my $encoding=$ARGV[1];
}

my $file=$ARGV[0];
my $out=$file;

open (FILE, '<:raw', $file);
read FILE, my $bytes, 6;
close(FILE);

my ($aadr, $eadr, $sadr) = unpack 'v v v', $bytes;

$out=~s/^C\.//i;
$out=~s/\.z80//i;
my $out_hex=$out.".hex";
my $out_asm=$out.".asm";

my $aadr_txt=sprintf("0x%04x",$aadr);

open (SYM, ">sym.hex");
printf(SYM "AADR: equ 0x%04x\n",$aadr);
printf(SYM "EADR_PLUS_1: equ 0x%04x\n",$eadr+1);
printf(SYM "SADR: equ 0x%04x\n",$sadr);
close(SYM);

open (SYM, ">block.hex");
printf(SYM "ENTRY: start 0x%04x end 0x%04x type code\n",$sadr,$sadr+3);
close(SYM);

system("dd if=\"$file\" of=\"$out_hex\" bs=1 skip=32");
system("z80dasm -b block.hex -S sym.hex -vvv -g $aadr_txt -l \"$out_hex\" -o \"$out_asm\"");
printf("%04x %04x %04x\n",$aadr,$eadr,$sadr);

#system("sed -i -e \"s/l[0-9a-f]*h/lxxxxh/\" \"$out_asm\"");
#system("sed -i -e \"s/sub_[0-9a-f]*h/sub_xxxxh/\" \"$out_asm\"");

print ("out: \"$out_asm\"\n");
