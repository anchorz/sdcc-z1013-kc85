#!/usr/bin/perl -w

use Data::Dumper;
use utf8;

%epson_map=("{"=>"ä"   ,"|"=>"ö"   ,"}"=>"ü"   ,"~"=>"ß"   ,"["=>"Ä"   ,"\\"=>"Ö"  ,"]"=>"Ü");
%ibm_map=  ("\xe4"=>"ä","\xf6"=>"ö","\xfc"=>"ü","\xdf"=>"ß","\xc4"=>"Ä","\xd6"=>"Ö","\xdc"=>"Ü");

%is_umlaut=( 
".{."=>1,
" {n"=>1,
" [n"=>1,
"e{n"=>1,
"F{h"=>1,"f{h"=>1,
"h{l"=>1,
"L{n"=>1,"l{u"=>1,
"n{c"=>1,
"n{h"=>1,
"r{g"=>1,
"r{n"=>1,
"r{t"=>1,
"t{n"=>1,
"t{t"=>1,
"W{h"=>1,
"w{r"=>1,
"z{h"=>1,

"h|h"=>1,
"K|h"=>1,"k|n"=>1,
"L|c"=>1,
"L|s"=>1,"l|s"=>1,
"M|g"=>1,"m|g"=>1,
"n|t"=>1,
"r|f"=>1,

"/]b"=>1," }b"=>1," ]b"=>1,"(}b"=>1,"@}b"=>1,
"d}r"=>1,
"f}g"=>1,
"f}h"=>1,
"F}r"=>1,"f}r"=>1,
"g}l"=>1,
"g}n"=>1,
"m}s"=>1,
"R}c"=>1,"r}c"=>1,
"r}f"=>1,
"r}h"=>1,
"r}n"=>1,
"w}n"=>1,

"e~b"=>1,
"e~e"=>1,
"o~/"=>1,
"u~ "=>1,"u~,"=>1,
"u~e"=>1,
"u~t"=>1,
"i~e"=>1,


);

our $has_umlaut=0;
our $total_umlaut=0;
our $prev_char="";
our $i=0;

sub print_char($) {
    my $c=shift;
    
    my $mapped=$c;
   
    if ($encoding eq "UML" && $epson_map{$c}) {
        $mapped=$epson_map{$c};
        utf8::encode($mapped);
    }
    if ($encoding eq "IBM" && $ibm_map{$c}) {
        $mapped=$ibm_map{$c};
        utf8::encode($mapped);
    }
   
    my $umlaut_text=substr($content,$i-1,3);

    if ($epson_map{$c}) {
        $total_umlaut++;
        if ($is_umlaut{$umlaut_text}) {
            $has_umlaut++;
        } 

        if ($encoding ne "UML") {
            if ($is_umlaut{$umlaut_text}) {
                $mymap=$epson_map{$c};
                utf8::encode($mymap);
                $umlaut_text=",eventuell '".$mymap."'";
            } else {
                $umlaut_text=" \"$umlaut_text\"=>1,";
            }
        } else {
            $umlaut_text="";
        }
        printf("[0x%04x]=%02x Ersetze '%s' durch '%s'%s\n",$i,ord($c),$c,$mapped,$umlaut_text);
    }
    if ($ibm_map{$c}) {
        printf("[0x%04x]=%02x '%s' Umlaut oder Klammer, verwende '%s'\n",$i,ord($c),$c,$c);
    }

    if ($encoding eq "UML" && $epson_map{$c}) {
        printf(OUT $mapped);       
    } elsif (ord($c)>=0x00 && ord($c)<=0x1f) {
        my $txt=chr(0xf120+ord($c));
        utf8::encode($txt);
        printf(OUT "$txt");
    } elsif (ord($c)>=0x20 && ord($c)<=0x7e){
        printf(OUT "%s", $c);
    } else {
        my $txt=chr(0xf100+ord($c));
        utf8::encode($txt);
        printf(OUT "$txt");
    }
    $prev_char
}

if (!defined $ARGV[0] || !$ARGV[1]) {
    print(STDERR "recode_from_z1013.pl (IBM|UML|Z) <file.z80>\n");
    exit 1;
}

$encoding=$ARGV[0];
$file=$ARGV[1];

$output=$file;
$output =~ s/\.z80$//g;
$output .= ".txt";

open(OUT,">",$output);
open(IN,"<:raw",$file);

$len= -s $file;

read(IN,$content,$len);

close(IN);

$eot=0;
$char_after_eot=0;
$char_after_eot_cnt=0;

for($i=32; $i<length $content; $i++)
{
#0e 14 breit an
#0f 15 komprimiert an
#   18 komprimiert aus
#14 20 breit aus

#http://lprng.sourceforge.net/DISTRIB/RESOURCES/PPD/epson.htm?cm_mc_uid=58037215166515057054208&cm_mc_sid_50200000=1505705420
    $c=substr($content,$i,1);

    if ($eot==1) {
        $char_after_eot=$i;
        $char_after_eot_cnt++;
    }
    if (ord($c)==0x03) {
        $eot=1;
    }

    if (ord($c)==0x0a || ord($c)==0x1e) {
        printf(OUT "\n");
    } elsif (ord($c)==0x0d) {
        $i++;
        $c=substr($content,$i,1);
        if (ord($c)==0x0a) {
            printf(OUT "\n");
        } else {
            print_char($c);
        }
    } elsif (ord($c)==0x09) {
        printf(OUT "\t");
    } else {
        print_char($c);
    }
}


close(OUT);
if ($char_after_eot >0 ) {
    printf("w: %d extra Zeichen nach dem Ende-Kennzeichen [%04x]\n",$char_after_eot_cnt,$char_after_eot);
}

if ($total_umlaut>0) {
    printf("%d/%d Ersetzungen sind wahrscheinlich Umlaute\n",$has_umlaut,$total_umlaut);
} else {
    printf("i: keine Umlaute gefunden\n");
}

printf("output \"%s\"\n",$output);
system("gedit \"$output\" &");
