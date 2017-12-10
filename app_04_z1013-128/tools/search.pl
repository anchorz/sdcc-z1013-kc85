#!/usr/bin/perl -w

#.../app_04_z1013-128/assets$ find . \( -iname "*.bin" -o -name "*.z80" \) -type f -exec md5sum -b {} \; |sort >md5sum.txt

use Data::Dumper;
use Digest::MD5 qw(md5_hex);
use File::Basename;
use Cwd 'abs_path';

sub get_git_base() {
    return abs_path(dirname(abs_path($0))."/..");
}

sub get_database_folder() {
    return get_git_base()."/assets";
}

sub get_database_folder_rel() {
    my $db_rel=dirname($0);
    $db_rel=dirname($db_rel);
    $db_rel=dirname($db_rel);    
    return $db_rel;
}

sub md5_file($) {
    my $file=shift;

    my $len=-s $file;
    open(FILE,$file);
    binmode(FILE);
    read(FILE,my $content,$len);
    close(FILE);
    return md5_hex($content);
}

my $db_list=get_database_folder()."/md5sum.txt";
print "Sucht MD5 in Datenbankdatei \"$db_list\"\n";

if (! defined($ARGV[0])) {
    printf("e: Argument fehlt\n"); 
    exit 1;
}

$replace=0;
if (defined($ARGV[1])) {
    if ($ARGV[1]=~m/RE/) {
        $replace=1;
    }
}

$file=$ARGV[0];
$md5_src=md5_file($file);
print("$md5_src *$file\n");

open(INFO, $db_list) or die("Could not open file.");

my $found="";
my $link="";
my $print_info=0;

while(<INFO>) {
    if (m/$md5_src \*(.*)/) {
        $found=$1;
        if ($found=~m/^\.\/fail/) {
            $link=$found;
            $print_info=1;
        }
        if ($found=~m/^\.\/sonst/) {
            $link=$found;
            $print_info=1;
        }
        if ($found=~m/^\.\/db/) {
            $link=$found;
        }
        print("$found\n");
    }
}
close(INFO);

if ($found eq "") {
    print STDERR "e: nicht gefunden\n";
} 

if ($link ne "") {
    $link=~s/^.*?\///sgi;
    $link=get_database_folder_rel()."/".$link;

    print STDERR "i: LINK $link\n";
    if ($replace == 1 ) {
        system("rm \"$file\"");
        system("ln -s \"$link\" \"$file\"");
        print STDERR "i: gesetzt.\n";
    }
    if ($print_info==1) {
        my $info=dirname($link)."/info.txt";
        system("cat \"$info\"");
    }
}




