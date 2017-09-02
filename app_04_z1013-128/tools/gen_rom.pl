#!/usr/bin/perl -w

print "erstellt die 32K-Images für den Z1013-128\n";
print "Annahme: Bereich 0x8000-0xEC00 für 32K ROM nutzbar\n";
print "suche in \"assets/rom*\" \n";

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
