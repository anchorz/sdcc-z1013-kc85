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
    printf("offset: %x\n",$offset);
    
    print INFO pack('c',$#files+2);#einer extra für den ...EXIT Eintrag am Schluss
    $offset++;
    
    $entrySize=16+3+2+2;
    $filepos=$offset+($#files+1)*$entrySize+16;#extra für den ...EXIT Eintrag am Schluss
    foreach my $line (@files) {
        my @dirent=@{$line};
        printf("entry: %s[%x %d=%x]\n",$dirent[0],$offset,$dirent[1],$dirent[1]);
        print INFO pack('A16',$dirent[0]);
        print INFO pack('a','C'); #typ: executable 
        print INFO pack('c',0x00); #keine Angabe zur verwendeten HW 
        print INFO pack('c',0x00); #bankStart
        printf("filepos: %x\n",$filepos);
        print INFO pack('v',$filepos);#bankOffset
        print INFO pack('v',$dirent[1]);#length
        $offset+=$entrySize;
        $filepos+=$dirent[1];
    }
    print INFO pack('A16',"...EXIT");
    $offset+=16;
    
    foreach my $line (@files) {
        my @dirent=@{$line};
        printf("entry: %s[%x %d=%x]\n",$dirent[0],$offset,$dirent[1],$dirent[1]);
        print INFO $dirent[2];
        $offset+=$dirent[1];
    }


    
    seek(INFO,2,0);
    read(INFO,$content,2);
    my $eadr=unpack('v',$content);
    $eadr=$offset-1;
    printf("offset: %x\n",$offset);
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
    open(my $FILE, $file) or die $!;
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
    
    if ($imageSize>$len-32)
    {
        printf("Warnung %s: Dateilänge ist %d Byte kleiner als im Header angegeben\n",$file,$imageSize-$len+32);
        printf ("        len=%d image+32=%d\n",$len,$imageSize+32);  
    }
    # elsif ($imageSize!=$len-32)
    #{
    #    printf("Info %s: Dateilänge ist %d Byte größer als im Header angegeben\n",$file,$len-32-$imageSize);
    #}

    my $typ=substr($content,12,1);
    my $name="";
    printf ("[%04x %04x %04x %s...",$aadr,$eadr,$sadr,$typ);  
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
    printf ("]\n");
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

exit 0;
chdir("assets");
@dir=glob("rom*");
chdir("..");

$final_length=32768;

foreach $subdir ( @dir )
{
	printf("%s\n",$subdir);
	$out="obj/z1013/$subdir.bin";
	system("dd if=obj/z1013/rom_boot.bin of=\"$out\" 2>/dev/null");
	@files=glob("assets/$subdir/*.z80");
	foreach $in ( @files )
	{
		printf("%s\n",$in);
		system("dd bs=1 if=\"$in\" of=\"$out\" skip=0 count=2 oflag=append conv=notrunc 2>/dev/null");
		system("perl -e \"print pack('v',`stat -c %s \"$in\"`-32)\" | dd bs=1 of=\"$out\" count=2 oflag=append conv=notrunc 2>/dev/null");
		system("dd bs=1 if=\"$in\" of=\"$out\" skip=4 count=2 oflag=append conv=notrunc 2>/dev/null");
		system("basename -z -s .z80 \"$in\" | dd of=\"$out\" oflag=append conv=notrunc 2>/dev/null");
		system("dd bs=1 if=\"$in\" of=\"$out\" skip=32 oflag=append conv=notrunc 2>/dev/null");
		#printf("Ende: 0x%4X\n",0x8000+`stat -c %s \"$out\"`);
		#printf("Frei: %4d\n",32768-4096-1024-`stat -c %s \"$out\"`);
	}
	printf("*************\nEnde: 0x%4X\n",0x8000+`stat -c %s \"$out\"`);
	printf("Frei: %4d\n*************\n",32768-4096-1024-`stat -c %s \"$out\"`);
	$len=-s $out;
	$todo=$final_length-$len-2;
	print ("current $todo\n");
	open(FH, '>>', $out);
	print FH pack('v',0);
	for ($i=0;$i<$todo;$i++)
	{
		print FH pack('C',0xff);
	}
	close FH;
}
