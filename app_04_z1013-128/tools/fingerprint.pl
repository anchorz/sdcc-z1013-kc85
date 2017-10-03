#!/usr/bin/perl -w
#find . -type f -exec ../tools/fingerprint.pl file.z80 {} \; | tee hawo
    
use Data::Dumper;

$file1=$ARGV[0];
$file2=$ARGV[1];

sub hist($)
{
    $file=shift;
    $len=-s $file;
    open(INFO, $file) or die("Could not open file.");
    read(INFO,$content,$len);
close(INFO);


@hist=();
for $i (0 .. 255)
{
  $hist[$i]=0;
}

for $i (0..length($content)-1) {
    $c=ord(substr($content, $i, 1));
    $hist[$c]++;
}

  return @hist;
}

@h1=hist($file1);
@h2=hist($file2);

$sum=0;
for $i (0 .. $#h1)
{
   $v=($h1[$i]-$h2[$i])*($h1[$i]-$h2[$i]);
   $sum+=$v;
   #printf("q: %d\n",$v);
}

printf("%d ",sqrt($sum));
print "- Abstand der Datei \"$file1\" und \"$file2\"  \n";


