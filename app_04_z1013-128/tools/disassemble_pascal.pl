#!/usr/bin/perl -w

use Data::Dumper;
use Digest::MD5 qw(md5_hex);
use File::Basename;
use Cwd 'abs_path';
use Switch;

$file=$ARGV[0];

my $len=-s "$file";
open(FILE,"<:raw", $file);
read(FILE,my $content,$len);
close(FILE);

$index=32;

$aadr=unpack("v",substr($content,0,2));
$eadr=unpack("v",substr($content,2,2));
$max_index=$eadr-$aadr+32;
printf("%04x %04x maxindex=[%04x]%02x\n",$aadr,$eadr,$max_index,ord(substr($content,$max_index,1)));

$shift=0x43f3-$aadr;
$aadr+=$shift;
$eadr+=$shift;
printf("%04x %04x\n",$aadr,$eadr);

while(1) {
    $len=2;
    #printf("%x %x\n",$index,$max_index);
    $line=unpack("v",substr($content,$index,$len));
    if ($line==0) {
        last;
    }
    $index+=$len;

    $len=1;
    printf("%5d ",$line);

    $line=ord(substr($content,$index,$len));
    $index+=$len;
    for (;$line--;) {
        print (" ");
    }

    $parse_line=1;
    while($parse_line) {
        $line=ord(substr($content,$index,$len));
        $index+=$len;
        switch($line)
        {
            case [0x0d] { print "\n"; $parse_line=0; }
            case [0x20..0x7e] { print chr($line); }
            case 0x81 { print "PROGRAM"; }
            case 0x82 { print "DIV"; }
            case 0x83 { print "CONST"; }
            case 0x84 { print "PROCEDURE"; }
            case 0x85 { print "FUNCTION"; }
            case 0x86 { print "NOT"; }
            case 0x87 { print "OR"; }
            case 0x88 { print "AND"; }
            case 0x89 { print "MOD"; }
            case 0x8a { print "VAR"; }
            case 0x8b { print "OF"; }
            case 0x8c { print "TO"; }
            case 0x8d { print "DOWNTO"; }
            case 0x8e { print "THEN"; }
            case 0x8f { print "UNTIL"; }
            case 0x90 { print "END"; }
            case 0x91 { print "DO"; }
            case 0x92 { print "ELSE"; }
            case 0x93 { print "REPEAT"; }
            case 0x94 { print "CASE"; }
            case 0x95 { print "WHILE"; }
            case 0x96 { print "FOR"; }
            case 0x97 { print "IF"; }
            case 0x98 { print "BEGIN"; }
            case 0x99 { print "WITH"; }
            case 0x9a { print "GOTO"; }
            case 0x9b { print "SET"; }
            case 0x9c { print "ARRAY"; }
            case 0x9d { print "FORWARD"; }
            case 0x9e { print "RECORD"; }
            case 0x9f { print "TYPE"; }
            case 0xa0 { print "IN"; }
            case 0xa1 { print "LABEL"; }
            case 0xa2 { print "NIL"; }
            case 0xa3 { print "PACKED"; }

            else { printf(" <=\nError: [0x%04x] - unknown character 0x%02x~%02x '%s' found\n", $index,$line,$line-128,chr($line)); exit;}
        }
    }
    if ($index==$max_index) {
        last;
    }
}


