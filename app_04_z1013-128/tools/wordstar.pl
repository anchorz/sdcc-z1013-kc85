#!/usr/bin/perl -w

use Data::Dumper;
use utf8;
use Switch;

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
open(IN,"<:raw",$file);

binmode(OUT,":utf8");

$len= -s $file;

read(IN,$content,$len);

close(IN);

#Control characters
#http://justsolve.archiveteam.org/wiki/WordStar

for($i=32; $i<length $content; $i++)
{
    $c=substr($content,$i,1);
    $n=ord($c);
    # 8D soft CR (inserted, followed by normal linefeed 0A, to mark soft line break at word-wrap)
    if ($n>=128){
      $n=$n-128;
      $c=chr($n);
    }
    if ($n==0x0d) {
        $c="\n";
        my $lookahead=ord(substr($content,$i+1,1));
        if ($lookahead==0x0a || $lookahead==0x8a ) {
            $i++;
        }
    } elsif ($n<32) {
        switch ($n) {                                #wordstar code
            case 0x02 { $c=chr(0xf120+$n);  } #stx B toggle bold
            #bs braucht noch besondere Behandlung            
            #case 0x08 { $c=chr(0xf120+$n);  } #bs  H backspace, overwrite previous character
            case 0x11 { $c=chr(0xf120+$n);  } #dc1 Q custom print control - Bedeutung: ??
            case 0x13 { $c=chr(0xf120+$n);  } #dc3 S toggle underline
            case 0x1a { $c="";             }  #sub Z end of text
            case 0x1f { $c='-';             } #us  _ active soft hyphen
            else {
                printf("unbekanntes Sonderzeichen: 0x%02x [%04x] CTRL-%s\n",$n,$i,chr(0x40+$n));
                $c=chr(0xf120+$n);
            }
        }
    }
    if ($c eq "a" && substr($content,$i+1,2) eq "\x08\"") {
        $c="ä";
        $i+=2;
    }
    #printf("%02x ",ord($c));
    printf(OUT $c);
}

print "output:\"$output\"\n";
