#!/usr/bin/perl -w

use Data::Dumper;
use Switch;
use utf8;

%epson_map=("{"=>"ä"   ,"|"=>"ö"   ,"}"=>"ü"   ,"~"=>"ß"   ,"["=>"Ä"   ,"\\"=>"Ö"  ,"]"=>"Ü");
%ibm_map=  ("\xe4"=>"ä","\xf6"=>"ö","\xfc"=>"ü","\xdf"=>"ß","\xc4"=>"Ä","\xd6"=>"Ö","\xdc"=>"Ü");

%no_umlaut=(
"O|S"=>1,
"1\\S"=>1,
" { "=>1,
"{  "=>1,
"  }"=>1,
" }\x1e" =>1,
" } "=>1,
" {a"=>1,

"'\\'"=>1,
"=| "=>1,
" |-"=>1,

"t] "=>1,
" [B"=>1,
"k}{"=>1,
"s[]"=>1,
"[] "=>1,
"([{"=>1,
" [1"=>1,
 "[{ "=>1,
" }]"=>1,
"}])"=>1,
" ~ "=>1,
" | "=>1,
"a[I"=>1,
"I])"=>1,
" {\$"=>1,
"-}."=>1,
"\x1e[ "=>1,
"\x1e['"=>1,
"\x1e[C"=>1,
" [C"=>1,
" ['"=>1,

" ]\x1e"=>1,
"'] "=>1,
"E] "=>1,
"\x1e] "=>1,

"\x1e\\ "=>1,
" \\ "=>1,
"\x1e\\S"=>1,

);

%is_umlaut=( 
".{."=>1,
" {n"=>1,
" [n"=>1,
"e{n"=>1,
"F{h"=>1,"f{h"=>1,
"f{l"=>1,
"g{n"=>1,
"G{r"=>1,
"h{l"=>1,
"h{n"=>1,
"L{n"=>1,"l{u"=>1,
"n{c"=>1,
"n{h"=>1,
"r{g"=>1,
"r{n"=>1,
"r{t"=>1,
"r{u"=>1,
"t{n"=>1,
"t{d"=>1,
"t{t"=>1,
"W{h"=>1,"w{h"=>1,
"w{r"=>1,
"z{h"=>1,

" \\f"=>1," |f"=>1,
"b|r"=>1,
"f|r"=>1,
"h|h"=>1,
"h|r"=>1,
"K|h"=>1,"k|n"=>1,
"L|c"=>1,
"L|s"=>1,"l|s"=>1,
"M|g"=>1,"m|g"=>1,
"n|t"=>1,
"r|f"=>1,
"r|~"=>1,
"w|l"=>1,

"/]b"=>1," }b"=>1," ]b"=>1,"(}b"=>1,"@}b"=>1,
"\x1e}b"=>1,
"d}r"=>1,
"f}g"=>1,
"f}h"=>1,
"F}r"=>1,"f}r"=>1,
"g}l"=>1,
"g}n"=>1,
"M}l"=>1,
"m}s"=>1,
"R}c"=>1,"r}c"=>1,
"r}f"=>1,
"r}h"=>1,
"r}n"=>1,
"t}t"=>1,
"w}n"=>1,

"a~e"=>1,
"e~,"=>1,
"e~b"=>1,
"e~e"=>1,
"e~t"=>1,
"o~/"=>1,
"u~ "=>1,"u~,"=>1,
"u~e"=>1,
"u~t"=>1,
"i~e"=>1,
"|~e"=>1,

);

our $has_umlaut=0;
our $has_no_umlaut=0;
our $total_umlaut=0;
#our $prev_char="";
our $i=0;
our $cursor_x=0;

sub print_char($) {
    my $c=shift;
    
    my $mapped=$c;
   
    if ($encoding eq "S3004") {
        if($c eq "\\") {
            $c="ß";
            utf8::encode($c);
            printf(OUT "$c");
            return;
        } elsif(ord($c)==0x06) {
            $c="[ON_OFF]";
        } elsif(ord($c)==0x0e) {
            $c=substr($content,$i+1,1);
            $i++;
            if($c eq "u") { $c="ü"; }
            elsif ($c eq "a") { $c="ä"; }
            elsif ($c eq "o") { $c="ö"; }
            elsif ($c eq "A") { $c="Ä"; }
            elsif ($c eq "O") { $c="Ö"; }
            elsif ($c eq "U") { $c="Ü"; }
            else { printf("nicht konvertiert '%s'\n",$c); $c="SPC"; }
            utf8::encode($c);
            printf(OUT "$c");
            return;
        }
    }

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
        if ($no_umlaut{$umlaut_text}) {
            $has_no_umlaut++;
        } 

        if ($encoding ne "UML") {
            if ($is_umlaut{$umlaut_text}) {
                $mymap=$epson_map{$c};
                utf8::encode($mymap);
                $umlaut_text=",eventuell '".$mymap."'";
            } elsif ($no_umlaut{$umlaut_text}) {
                $umlaut_text="";
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
    
    $cursor_x++;
    if ($cursor_x==32) {
        $cursor_x=0;
        if ($encoding eq "32") {
            printf(OUT "\n");
        }
    }
}

if (!defined $ARGV[0] || !$ARGV[1]) {
    print(STDERR "recode_from_z1013.pl (IBM|UML|Z|S3004|32) <file.z80>\n");
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
            printf(OUT "\n");
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
    printf("%6.1f%% der Ersetzungen sind wahrscheinlich Umlaute (%d/%d)\n",$has_umlaut*100.0/$total_umlaut,$has_umlaut,$total_umlaut);
    printf("%6.1f%% der Ersetzungen sind keine Umlaute          (%d/%d)\n",$has_no_umlaut*100.0/$total_umlaut,$has_no_umlaut,$total_umlaut);
    printf("%6.1f%% der Ersetzungen sind unsicher               (%d/%d)\n",($total_umlaut-$has_no_umlaut-$has_umlaut)*100.0/$total_umlaut,($total_umlaut-$has_no_umlaut-$has_umlaut),$total_umlaut);
} else {
    printf("i: keine Umlaute gefunden\n");
}

printf("output \"%s\"\n",$output);
system("gedit \"$output\" &");
