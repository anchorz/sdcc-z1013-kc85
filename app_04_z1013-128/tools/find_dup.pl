#!/usr/bin/perl -w

#time find . -type f -exec md5sum -b {} \; | sort >md5sum_sorted.txt 
use Data::Dumper;

print "Sucht aus der Datenbankdatei z.B. \"md5sum.txt\" die doppelten Dateien heraus\n";

#> find . -iname "*.bin" -o -iname "*.z80" -type f -exec md5sum -b {} \; >md5sum.txt
print "Erstellung der Datenbank: find . -iname \"*.z80\" -type f -exec md5sum -b {} \\;\n";

sub get_git_base() {
    return abs_path(dirname(abs_path($0))."/..");
}

sub get_database_folder() {
    return get_git_base()."/assets";
}

if (! defined($ARGV[0])) {
    printf("e: Argument fehlt, z.B. md5sum.txt\n"); 
    exit 1;
}

$file=$ARGV[0];


open(INFO, $file) or die("Could not open file.");

%found=();

while(<INFO>) {
    if (m/([0-9a-f]+) \*(.*)/) {
        $md5=$1;
        $name=$2;
        if ($found{$md5}) {

            if( -l $name ) { 
                #printf "symlink %s\n",$name;
            } else {
                push ( @{$found{$md5}},$name );
            }


            #my @entry=@{$found{$md5}};
            #$ino1 = (stat($entry[0]))[1];
            #my $f=$name;
            #$f=~s/\$/\\\$/sgi;
            #$ino2 = (stat($f))[1];
            
            #printf "1: %d %s\n",$ino1,$entry[0];
            #printf "2: %d %s\n",$ino2,$f;
                        
            #if ($ino1!=$ino2) {
            #push ( @{$found{$md5}},$name );
            #}
          


            #my @entry=@{$found{$md5}};
            #my $len=$#entry+1;
            #printf "%s\n",$md5;
            #printf "%d %s %s %s\n",$len,$md5,$found{$md5},$name;

            #push ( @{$found{'md5'}},$name );
            #if ($ino1!=$ino2) {
                #print "   md5 $md5:\n";
                #print "rm \"".$found{$md5}."\"\n";
                #print "rm \"$name\"\n";
            #}
        } else {
            if( ! -l $name ) { 
                push ( @{$found{$md5}},$name );
         #       printf "symlink2 %s\n",$name;
            }
        }
    }
}


foreach my $md5 (keys %found){
    my @entry=@{$found{$md5}};
    my $len=$#entry+1;
    if ($len>1) {
        printf "double %d s=%s\n",$len,$md5;
        $filesToDelete=0;
        foreach my $array (@{$found{$md5}}){
            if ($array=~/^.\/src.theoldcomputer/) { 
                $filesToDelete++;
                #printf "  del: %s\n", $array;
            }
        }
        if ($filesToDelete==$len) {
            printf "l=%d s=%s nicht alle loeschen:\n",$len,$md5;
            my $index=0;
            foreach my $array (@{$found{$md5}}){
                if ($index) {
                    $array=~s/\$/\\\$/sgi;
                    printf "#rm \"%s\"\n", $array;
                } else {
                    printf "#keep: %s\n", $array;
                }
                $index++;
            }
        } else {
            printf "l=%d s=%s mind. eine Datei nicht in src.the oldcomputer\n",$len,$md5;
            foreach my $array (@{$found{$md5}}){
                if ($array=~/^.\/src.theoldcomputer/) { 
                   $array=~s/\$/\\\$/sgi;
                   printf "rm \"%s\"\n", $array;
                } else {
                   printf " keep: %s\n", $array;
                }
            }
        }      
    }
}

