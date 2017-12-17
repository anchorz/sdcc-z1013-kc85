#!/usr/bin/perl -w

use Data::Dumper;
use utf8;

if (!defined $ARGV[0] || !$ARGV[1]) {
    print(STDERR "recode_from_z1013.pl (IBM|UML|Z) <file.z80>\n");
    exit 1;
}

$encoding=$ARGV[0];
$encoding="";#entferne Warnung fuer den Moment
$file=$ARGV[1];

$output=$file;
$output =~ s/\.z80$//g;
$output .= ".txt";

open(OUT,">",$output);
binmode(OUT,":utf8");
open(IN,"<:raw",$file);

$len= -s $file;

read(IN,$content,$len);

close(IN);

for($i=32; $i<length $content; $i++)
{
    $c=substr($content,$i,1);
    $n=ord($c);
    if ($n==0x0d) {
        $c="\n";
    } elsif ($n<32) {
        printf("Sonderzeichen: %02x\n",$n);
        $c=chr(0xf100+$n);
    } elsif ($n>=128) {
        $c=chr($n-128);
    }
    printf(OUT $c);
}

print "output:\"$output\"\n";
