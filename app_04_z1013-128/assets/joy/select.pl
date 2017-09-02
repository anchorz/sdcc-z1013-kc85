#!/usr/bin/perl -w

$total_size=32768;

$rom_header= -s "../../obj/z1013/rom_boot.header.bin";
$total_size-=$rom_header;
$total_size-=2; #end-of-list marker
$total_size-=4096; #ROM F000
$total_size-=1024; #BWS EC00

@files=glob("*.z80");
%selection=();

print "traveling salesman: select files that matches given filesize\n";
printf "free: %d\n", $total_size ;

$try=1;
foreach $file(@files)
{
	printf ("%s %d %d\n",$file,-s $file,length($file)-3);
	$len=-s $file;
	$len+=length($file)-length(".z80")+1; #plus null byte
	$len+=6; #aadr len sadr 
	$selection{$file}=$len;
	$try*=2;
}

$best_guess=0;
printf("total combinations: %d\n",$try);
for ($i=0; $i<$try;$i++)
{
	if ($i%1000==0)
	{
		printf("..%d\n",$i);
	}
	$j=$i;
	$index=0;
	$sum=0;
	while($j)
	{
		if ($j&1)
		{
			$sum+=$selection{$files[$index]};
			#printf("%s\n",$files[$index]);
		}
		$j/=2;
		$index++;
	}
	if($sum>$best_guess && $sum<$total_size)
	{
		$best_guess=$sum;
		printf("try: %0x\n",$i);
		printf("sum: %0d\n",$sum);
		$index=0;
		$j=$i;
		while($j)
		{
			if ($j&1)
			{
				printf("%s ",$files[$index]);
			}
			$j/=2;
			$index++;
		}
	}	
} 



