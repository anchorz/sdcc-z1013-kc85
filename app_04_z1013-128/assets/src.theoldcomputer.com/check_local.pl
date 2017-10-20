#!/usr/bin/perl -w

use warnings;
use strict;
use utf8;

my $len=-s "list.html";

open(FILE,"list.html");
read(FILE,my $content,$len);
close(FILE);

while($content=~m/display_more_details\('Robotron\/Z1013\/Various\/(.*?).zip'\);">R/g) {
    my $test_file=$1.".z80";
    if (-e "$test_file"){
        print "OK";
    } else {
        print "--"
    }
    print " $test_file\n";
}