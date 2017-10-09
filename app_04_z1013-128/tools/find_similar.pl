#!/usr/bin/perl -w

use Data::Dumper;
#say Dumper \@words
use Digest::MD5 qw(md5_hex);
use File::Basename;
use Cwd 'abs_path';
use Storable;

sub get_git_base() {
    return abs_path(dirname(abs_path($0))."/..");
}

sub get_database_folder() {
    return get_git_base()."/assets";
}

sub hist($)
{
    $file=shift;
    $len=-s $file;
    
    open(INFO, $file) or die("Could not open file.");
    read(INFO,$content,$len);
    close(INFO);

    my @hist=();
    for $i (0 .. 255) {
      $hist[$i]=0;
    }

    for $i (0..length($content)-1) {
        $c=ord(substr($content, $i, 1));
        $hist[$c]++;
    }

    return @hist;
}

my $database=get_database_folder()."/fingerprints.db";
print "read fingerprint database: $database\n";

$hashref=retrieve($database);

$file1=$ARGV[0];
@h1=hist($file1);

%distance=();

for (keys %{$hashref}) {
    $file=$_;
    #$md5=$hashref->{$file}[0];
    $hist=$hashref->{$file}[1];
    #print scalar @{ $hist }."\n";
    #print $hashref->{$file}[1]."\n";
    
    @h2=@{ $hist };
    $sum=0;
    for $i (0 .. $#h1)
    {
       $v=($h1[$i]-$h2[$i])*($h1[$i]-$h2[$i]);
       $sum+=$v;
       #printf("q: %d\n",$v);
    }
    $distance{$file}=sqrt($sum);
#    printf("%d ",sqrt($sum));
#    print "- Abstand der Datei \"$file1\" und \"$file\"  \n";
}

$count=0;
for (sort { $distance{$a} <=> $distance{$b} } keys %distance) {
    $file=$_;
    $count++;
    printf("%d %s (%d.hex)\n",$distance{$file},get_database_folder()."/".$file,$count);
    system("hexdump -C \"".get_database_folder()."/$file\" >$count.hex");
    if ($count>4) {
        last;
    }
}
system("hexdump -C \"$file1\" >orig.hex");

