#!/usr/bin/perl -w

use Data::Dumper;
use utf8;

our $i=0;

if (!defined $ARGV[0] ) {
    printf("Parse IC-Datenbank\n");
    printf("%s <file.z80>\n",$0);
    exit 1;
}

sub read_char() {
    my $c=substr($content,$i,1);
    #printf("[%04x]%02x (%s)\n",$i,ord($c),$c);
    $i++;
    return $c;
}

sub print_entry() {
    my $name="";
    while (($c=read_char()) ne "\x00") {
        $name.=$c;
    }
    my $type=ord(read_char());
    my $pin="";
    for(my $m=0; $m<2*$type;) {
        $c=read_char();
        if (ord($c)<0x80) {
            $pin.=$c;
        } else {
            #printf("  %2s[%02x]\n",$pin,ord($c));
            $pin="";
            $m++;
        }
    }    
    printf(OUT "%-5s[%2dP]: ",$name,$type*2);
    my $entry="";
    while (($c=read_char()) ne "\x00") {
        $entry.=$c;
    }
    #my @list=split(/:/,$entry);
    #my $found=$entry;
    printf(OUT "[%s]\n",$entry);    
}

$file=$ARGV[0];

$output=$file;
$output =~ s/\.z80$//g;
$output .= ".txt";

open(OUT,">",$output);
binmode(OUT,":utf8");
open(IN,"<:raw",$file);

$len= -s $file;

read(IN,$content,$len);

close(IN);

$i=0x820;
$i=0x8f0;

#$cnt=0;
while($i<length $content) {
    $c=read_char();
    if ($c eq "\xff") {
        #printf("%-3d %s\n",$cnt++,read_char());
        print_entry();
    }
}

print "output:\"$output\"\n";
