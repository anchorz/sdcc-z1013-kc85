#!/usr/bin/perl -w

#use Data::Dumper;
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
    #my $ret="";
    #for  (my $i=0; $i<$#hist-1;$i++) {
    #    $ret.=sprintf("%0x,",$hist[$i]);
    #}
    #$ret.=sprintf("%0x",$hist[$#hist]);
    #return $ret;
}

%db=();

sub handle_file($$)
{
    #similar to: find . -type f -exec md5sum -b {} \; | sort >md5sum.txt
    my $filename=shift;
    my $base_directory=shift;
    
    my $len=-s $filename;
    open(Z80,"<:raw",$filename);
    read(Z80, my $bytes, $len);
    $digest = md5_hex($bytes);
    close(Z80);
    
    $short=$filename;
    $short=~s/$base_directory/./sgi;
    
    my @fingerprint=hist($filename);
    #$database{$short}=($digest,hist($filename));
    my @db_entry=($digest,\@fingerprint);
    $db{$short}=\@db_entry;
    
    #my $key="$digest *$short";
    #push(@found,($key));
    
    #print @found;
    #my @sorted=sort { $a cmp $b } @found;
    #print("$key\n");
    #print "len=".$#found;
    #return @sorted;
}

sub file_search($ $);

sub file_search($ $) {
    my $root=shift;
    my $base_directory=shift;

    opendir(my $dh, $root) || die "Can't open \".\": $!";
    while (readdir $dh) {
        $handle="$root/$_";
        if (-l $handle) {
            #no checksum for links - ignore that
            #TODO may check if destination still exists
            #print "SYM: $_\n";
        } elsif (-d $handle) {
            if ($_ ne "." && $_ ne "..") {
                #print "DIR: $root/$_\n";            
                file_search($handle,$base_directory);
            }
        } elsif (-f $handle) {
            #print "FIL: $handle\n";
            if ($handle=~m/z80/i) {
                handle_file($handle,$base_directory);
            }
        } else{
            print "e: unbekannter Dateityp für $handle\n";
            print "Script Ende...\n";        
        }
    }
    closedir $dh;
}
my $database=get_database_folder()."/fingerprints.db";
print "generate fingerprint database: $database\n";

#$found=();
file_search(get_database_folder(),get_database_folder());
store \%db, $database;

#@sorted=sort { $a cmp $b } @found;

#open(INFO, ">", $database) or die("Could not open file.");
#for(@sorted) {
#    print INFO "$_\n";
#}
#close(INFO);



