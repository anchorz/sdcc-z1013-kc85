#!/usr/bin/perl -w

#time find . -type f -exec md5sum -b {} \; | sort >md5sum_sorted.txt 
use Data::Dumper;

$file=$ARGV[0];

open(INFO, $file) or die("Could not open file.");

%found=();

while(<INFO>) {
    if (m/([0-9a-f]+) \*(.*)/) {
        $md5=$1;
        $name=$2;
        if ($found{$md5}) {
            $ino1 = (stat($found{$md5}))[1];
            $ino2 = (stat($name))[1];
            if ($ino1!=$ino2) {
                print "   md5 $md5:\n";
                print "rm \"".$found{$md5}."\"\n";
                print "rm \"$name\"\n";
            }
        } else {
            $found{$md5}=$name;
        }
    }
}