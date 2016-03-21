#!/usr/bin/perl -w

if (!defined $ARGV[0])
{
  print "<filename> missing\n";
  exit 1;
}

open my $fh, '<', "$ARGV[0]";
read $fh, my $string, -s $fh;
close $fh;

$string=~s/(\.dw[\s]+([\w]+)[\r\n]+)([\s]*\.dw[\s]+)([\w]+)(.*?)([\n\r]+)/$1$3BANK_OF_$2$5$6/sgi;

open (FH, ">$ARGV[0]");
print FH "  .include \"bank.inc\"\n";
print FH $string;
close (FH);
