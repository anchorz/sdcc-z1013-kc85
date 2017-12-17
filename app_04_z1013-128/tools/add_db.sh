#!/usr/bin/perl -w 

use Data::Dumper;
use Digest::MD5 qw(md5_hex);
use File::Basename;
use File::Copy;
use File::Glob ':glob';
use Cwd 'abs_path';
use File::stat;
use utf8;

binmode(STDERR, ":utf8");
binmode(STDOUT, ":utf8");

our $prefix_length=5;

sub get_git_base() {
    return abs_path(dirname(abs_path($0))."/..");
}

sub get_database_folder() {
    return get_git_base()."/assets";
}

sub get_tools_root() {
    return abs_path(dirname(abs_path($0)));
}

if (!defined $ARGV[0]) {
    printf("e: Parameter (.z80) fehlt\n");
    printf("Beispiel:\n  %s ./datei.z80\n",basename($0));
    exit 1;
}

my $file=$ARGV[0];

if (! -f $file) {
    printf("e: Datei (%s) existiert nicht.\n",$file);
    exit 1;
}

my $dbroot=get_database_folder()."/db";
print "bewege \"$file\" in die Datenbank\n";

my $len=-s $file;
open(Z80,"<:raw",$file);
read(Z80, my $bytes, $len);
$md5 = md5_hex($bytes);
close(Z80);

my $base=basename($file,".z80");
$base=~s/ /_/g; #I don't like spaces in filenames

my $dir_dest="$dbroot/$md5-$base";
if (-e $dir_dest) {
    printf("e: %s existiert bereits.\n",$dir_dest);
    exit 1;
}

mkdir("$dir_dest") || die("e: Fehler mkdir($dir_dest)");
print ("Ziel: $dir_dest\n");

system("mv \"$file\" \"$dir_dest/\"");

my $video=$ENV{"HOME"}."/jkcemu_video_text.txt";
if (-f $video) {
    move($video,"$dir_dest/");
}

@list = bsd_glob ("~/jkcemu_screen_*.txt");
for (@list) {
    move($_,"$dir_dest/");
}

copy("$dbroot/info.txt","$dbroot/$md5-$base/");
print "$md5-$base\n";

system("gedit \"$dbroot/$md5-$base/info.txt\" &");
system("generate_fingerprint_db.pl");

