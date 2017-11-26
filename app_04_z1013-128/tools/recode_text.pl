#!/usr/bin/perl -w

use Data::Dumper;
use utf8;

%epson_map=("{"=>"ä"   ,"|"=>"ö"   ,"}"=>"ü"   ,"~"=>"ß"   ,"["=>"Ä"   ,"\\"=>"Ö"  ,"]"=>"Ü");
%ibm_map=  ("\xe4"=>"ä","\xf6"=>"ö","\xfc"=>"ü","\xdf"=>"ß","\xc4"=>"Ä","\xd6"=>"Ö","\xdc"=>"Ü");

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
   
    if ($epson_map{$c}) {
        printf("[0x%04x]=%02x Ersetze '%s' durch '%s'\n",$i,ord($c),$c,$mapped);
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
    printf("w: es folgen noch %d Zeichen nach dem Ende-Kennzeichen [%04x]\n",$char_after_eot_cnt,$char_after_eot);
}
printf("output \"%s\"\n",$output);
