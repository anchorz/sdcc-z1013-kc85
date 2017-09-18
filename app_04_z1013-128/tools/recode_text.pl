#!/usr/bin/perl -w

$file=$ARGV[0];

$output=$file;
$output =~ s/\.z80$/.txt/g;

open(OUT,">",$output);
open(IN,"$file");

$len= -s $file;

read(IN,$content,$len);

close(IN);

$flag=0;
$sonderzeichen=0;

#%umlaute=("m|g"=>1);
#%keine_umlaute=(" | "=>1," |\n"=>1);

%map=("{"=>"ä","|"=>"ö","}"=>"ü","~"=>"ß","["=>"Ä","\\"=>"Ö","]"=>"Ü");
$do_map=0;
#%map=();

for($i=32; $i<length $content; $i++)
{
#0e 14 breit an
#0f 15 komprimiert an
#   18 komprimiert aus
#14 20 breit aus

#http://lprng.sourceforge.net/DISTRIB/RESOURCES/PPD/epson.htm?cm_mc_uid=58037215166515057054208&cm_mc_sid_50200000=1505705420
  $c=substr($content,$i,1);
  if (ord($c)==0x03 || ord($c)==0 || ord($c)==0x1a )
  {
     printf(OUT "<<EOT>>");
  #end of text
  }  elsif (ord($c)==0x08)
  {
  #backspace
  }  elsif (ord($c)==0x0a)
  {
     printf(OUT "\n");
  }  elsif (ord($c)==0x0c)
  {
     printf(OUT "\n");
  }  elsif (ord($c)==0x0d)
  {
  }  elsif (ord($c)==0x1c)
  {
    #page break? FS -fett on sperrschrift
     printf(OUT "\n");
  }  elsif (ord($c)==0x1d)
  {
    #page break? GS fett off, sperrschrift
     printf(OUT "\n");
  }  elsif (ord($c)==0x09)
  {
     printf(OUT "\t");
  }  elsif (ord($c)==0x1b)
  {
    #ESC
    $i++;
    $c=substr($content,$i,1);
    if ($c eq "E" || $c eq "F" || $c eq "@"  || $c eq "l")
    {
        next;
    }
    $flag=$i;
    printf("[0x%x] ESC+$c\n",$i);
  } elsif (ord($c)==0x1e)
  {
     printf(OUT "\n");
  } elsif (ord($c)>=0x20 && ord($c)<0x7f)
  {
      if ((ord($c)>=0x7b && ord($c)<=0x7e) || (ord($c)>=0x5b && ord($c)<=0x5d))
      {
        $sonderzeichen=$i;
      }
      $mapped=$map{$c};
      if ($do_map && $mapped) {
        printf("[0x%0x] Umlaut\n",$i);
        $c=$mapped;
      }
      printf(OUT "%s",$c);
  } else
  {
     $flag=$i;
     printf("[0x%x] unbekanntes Zeichen: 0x%02x]\n",$i,ord($c));
  }
}

if ($flag !=0 )
{
    printf("Text enthält nicht konvertierte Zeichen\n");
}
if ($sonderzeichen != 0)
{
    printf("Text enthält wahrscheinlich Umlaute\n");
}

#TODO 
#check text after EOT

close(OUT);
