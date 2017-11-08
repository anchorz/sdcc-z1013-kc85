#!/usr/bin/perl -w

use Data::Dumper;

$origin=$ARGV[0];
$folder=$ARGV[1];
$result=$ARGV[2];

$file="$folder/list.txt";

@files=();

sub write_directory($ $)
{
    my $origin=shift;
    my $result=shift;
  
    open(INFO, "+>", $result) or die("Could not open file: ".$result);

    my $len= -s $origin;
    open(IN, $origin) or die("Could not open file: ".$origin);
    binmode(IN);
    read(IN,my $content,$len);
    close(IN);
    
    print INFO $content;
    my $aadr=unpack('v',$content);
    my $offset=$aadr+$len-32;
    #printf("end of image [%x]\n",$offset);
    
    print INFO pack('c',$#files+2);#einer extra für den ...EXIT Eintrag am Schluss
    $offset++;
    
    $steps=8192;
    #$steps=32768;
    $entrySize=16+3+2+2;
    $filepos=$offset+($#files+1)*$entrySize+16;#extra für den ...EXIT Eintrag am Schluss
    my $bankStart=0;
    foreach my $line (@files) {
        my @dirent=@{$line};
        printf("dirent: %s[%x->%02x+%05x len=%5d(%04x)]\n",$dirent[0],$offset,$bankStart,$filepos,$dirent[1],$dirent[1]);
        print INFO pack('A16',$dirent[0]);
        print INFO pack('a','C'); #typ: executable 
        print INFO pack('c',0x00); #keine Angabe zur verwendeten HW 
        print INFO pack('c',$bankStart); #bankStart
        #printf("filepos: %x\n",$filepos);
        print INFO pack('v',$filepos);#bankOffset
        print INFO pack('v',$dirent[1]);#length
        $offset+=$entrySize;
        $filepos+=$dirent[1];
        if ($filepos>0xffff) {
            $filepos-=$aadr;
            $bankStart+=($aadr/$steps); #8k Schritte
        }
    }
    print INFO pack('A16',"...EXIT");
    $offset+=16;
    
    foreach my $line (@files) {
        my @dirent=@{$line};
        printf("entry:  %s[%5x %d=%x]\n",$dirent[0],$offset-$aadr,$dirent[1],$dirent[1]);
        print INFO $dirent[2];
        $offset+=$dirent[1];
    }


    
    seek(INFO,2,0);
    read(INFO,$content,2);
    my $eadr=unpack('v',$content);
    $eadr=$offset-1;
    my $used=($offset-$aadr)/1024.0;
    my $free=(512*1024-($offset-$aadr))/1024.0;
    printf("Ende: 0x%x (%.2f KiB) %.2f%%\n",$offset-$aadr-1,$used,$used*100/(512));
    printf("Frei:  %6d (%.2f KiB) %.2f%%\n",512*1024-($offset-$aadr),$free,100-$used*100/(512));
    
    
    seek(INFO,2,0);
    print INFO pack('v',$eadr);#new length
    close(INFO);
}

sub check($)
{
    my $file=shift;
    
    
    #(my $file,my $menu)=split(/=/,$line);
    #printf("check: \"%s\"\n", $file);
    my $len=-s $file;
    open(my $FILE, $file) or die $!." \"$file\"";
    binmode($FILE);
    read($FILE,my $content,$len);
    close $FILE;

    my $aadr=ord(substr($content,0,1));
    $aadr+=ord(substr($content,1,1))*256;
    
    my $eadr=ord(substr($content,2,1));
    $eadr+=ord(substr($content,3,1))*256;
    
    my $imageSize=$eadr-$aadr+1;

    my $sadr=ord(substr($content,4,1));
    $sadr+=ord(substr($content,5,1))*256;
    
    
    
    
    my $typ=substr($content,12,1);
    my $name="";
    printf ("check [%04x %04x %04x %s...",$aadr,$eadr,$sadr,$typ);  
    
    for (my $cnt=0; $cnt<16; $cnt++)
    {
        my $ch=substr($content,$cnt+16,1);
        #if ($ch eq "\n" || $ch eq "\t" || $ch eq "\r")
        #{
        #    $ch="\x00";
        #}
        my $pr=$ch;
        if (ord($ch)<0x20)
        {
           $pr="?";
        }
        $name.=$ch;
        printf ("%s",$pr);  
    }
    printf ("]");
    
    if ($len%32==0) {
        if ($len-$imageSize-32!=0) 
        { 
            printf(" %2d Bytes unbenutzt",$len-$imageSize-32);
        }
    } else {
        printf("\n  Warnung: \"%s\" Dateilänge muss vielfaches von 32 (%d Bytes fehlen) sein.",$file,32-$len%32);
    }
    
    if ($imageSize>$len-32)
    {
        printf("\n  Warnung %s: Dateilänge ist %d Byte kleiner als im Header angegeben",$file,$imageSize-$len+32);
        printf ("        len=%d image+32=%d\n",$len,$imageSize+32);  
    }
    
    printf("\n");
    push(@files,[$name,$len,$content]);
}


print "erstellt das ROM-Images für den Z1013-128 aus \"$origin\"\n";
print "und den Dateien aus \"".$file."\" \n";
print "Ergebnis ist \"".$result."\" \n";

open(INFO, $file) or die("Could not open file.");


my @files=();

foreach $line (<INFO>)  {   
    chomp $line;
    if (substr($line, 0, 1) ne "#" && $line ne "")
    {
        check($folder."/".$line);
    }
}
close(INFO);

write_directory($origin,$result);

