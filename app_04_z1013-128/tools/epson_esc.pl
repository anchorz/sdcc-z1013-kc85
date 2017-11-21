#!/usr/bin/perl -w

use Data::Dumper;
use Digest::MD5 qw(md5_hex);
use File::Basename;
use Cwd 'abs_path';
use Switch;
use GD::Simple;

our $index;
our $content;

our $img = GD::Simple->new(4100, 3900);
our $black = $img->colorAllocate(0,0,0);
$img->setAntiAliased($black);

our $left_margin=0;
our $line_spacing=0; #n/72 inch

sub get_byte()
{
    my $b=ord(substr($content,$index++,1));
    return $b;    
}

sub get_word()
{
    my $l=ord(substr($content,$index++,1));
    my $h=ord(substr($content,$index++,1));
    return $h*256+$l;    
}

our $scale=10;
our $x=$scale/2;
our $y=$scale/2;

sub paint($)
{
    my $val=shift;
    for($i=0;$i<8;$i++) {
        if ($val&0x80) {
            $img->filledEllipse($x,$y+$i*$scale,10,10,$black);
        }
        $val*=2;
    }
}

sub print_dots($ $)
{
    my $count=shift;
    my $x_inc=shift;
    while ($count) {
        my $b=get_byte();
        paint($b);
        $x+=$x_inc;
        $count--;
    }
}

$file=$ARGV[0];

my $len=-s "$file";
open(FILE,"<:raw", $file);
read(FILE,$content,$len);
close(FILE);

printf("len=%d\n",$len);
$index=0;

# create a new image (width, height)

while($index<$len) {
    $b=substr($content,$index,1);
    $index++;
    if ($b eq "\x1b") {
        printf("ESC+");
        $b=substr($content,$index,1);
        $index++;
        switch($b)
        {
            case "9" { print "PE detection enabled\n"; }
            case "@" { print "RESET\n"; }
            case "A" { $line_spaceing=get_byte(); printf ("line_spaceing=%d\n",$line_spaceing); }
            #double density 120dpi horizontal 60dpi vertical
            case "L" { $count=get_word(); printf ("L 960-dpl:%d\n",$count); print_dots($count,$scale); }
            case "O" { print "cancel bottom margin\n"; }
            case "l"    { $left_margin=get_byte(); printf ("left margin=%d\n",$left_margin); }
            else { printf("unhandled ESC+0x%02x'%s':[%04x]\n",ord($b),$b,$index-1); exit 1;}
        }
    } else {
        switch($b)
        {
            case "\x0" { print "NUL\n"; }
            case "\xa" { print "LF\n"; $y+=8*$scale;}
            case "\xd" { print "CR\n"; $x=$scale/2; }
            else {
                printf("unknown character [%04x]%02x\n",$index-1,ord($b));
                exit 1;
            }
        }
        
    }
}

open my $out, '>', 'img.png' or die;
binmode $out;
print $out $img->png;
printf("output: \"%s\"\n","img.png");
