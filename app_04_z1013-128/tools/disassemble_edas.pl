#!/usr/bin/perl -w

use Data::Dumper;
use Digest::MD5 qw(md5_hex);
use File::Basename;
use Cwd 'abs_path';
use Switch;
use utf8;

sub read_word() {
    #printf("read idx=%x ",$index);
    my $ret=unpack("v",substr($content,$index,2));
    $index+=2;
    $line_index+=2;
    #printf("val=%04x\n",$ret);
    return $ret;
}

sub read_byte() {
    my $ret=ord(substr($content,$index,1));
    $index+=1;
    $line_index+=1;
    return $ret;
}

sub read_str() {
    #TODO check encoding
    my $ret="";
    
    while (1) {    
        my $c=substr($content,$index,1);
        $line_index+=1;
        $index+=1;
        if ($c eq "\0" ) {
            return $ret;
        }
        if (ord($c)>=0x80) {
            $c=chr(0xf100+ord($c));
        }
        utf8::encode($c);
        $ret.=$c;
        if ($line_index==$line_length) {
            return $ret;
        }
    }
}

if (!defined $ARGV[0]  ) {
    print "convert KC-BASIC to text:\n";
    print "Z1013 maps special Z1013 characters to UTF-Font starting from U+f100\n";
    print basename($0)." [Z1013|DEFAULT] basic.z80 >basic.B\n";
    exit 1;
}

$mode=$ARGV[0];
$utf_shift=0;
if ($mode eq "Z1013" ) {
    $utf_shift=0xf100;
}

$file=$ARGV[1];

$len=-s "$file";
open(FILE,"<:raw", $file);
read(FILE,$content,$len);
close(FILE);

$index=0;
$aadr=read_word();
$eadr=read_word();
$src_end_ptr=$eadr-$aadr+32;

$index=32;

#$cnt=83;
while(1) {
    $line_index=0; 
    #printf("INFO: line_index=%d\n",$line_index);
    $line_no=read_word();
    #printf("INFO: line_index=%d\n",$line_index);
    $line_length=read_byte();
    #printf("INFO: line_index=%d\n",$line_index);
    #$opcode_adr=$index;
    #$opcode=read_word();
    read_word();
    #printf("INFO: line_index=%d\n",$line_index);
    #$param16=read_word();
    read_word();
    #printf("INFO: line_index=%d\n",$line_index);
    
    $p1=read_str();
    if(length($p1)>0) {
        $p1.=":";
    }


    #if ($opcode==0x67 || $opcode==0x117 || $opcode==0x164|| $opcode==0x265 || $opcode==0x2064 || $opcode==0x1f64 || $opcode==0x0864) {
        my $p2=read_str();
        my $p3="";
        if ($line_index!=$line_length) {
            $p3=read_str();
        }
        my $p4="";        
        if ($line_index!=$line_length) {
            $p4=",".read_str();
        }
#        printf("INFO: len=%d %x %x index=%d\n",$line_length,$opcode,$param16,$line_index);
#        printf("%05d %-6s %-5s%s%s\n",$line_no,$p1,$p2,$p3,$p4);
        printf("%-6s %-5s%s%s\n",$p1,$p2,$p3,$p4);

        #format lineno marke: arg1 arg2
    #} else {
    #    printf ("ERROR: unknown opcode [%04x]=%04x\n",$opcode_adr,$opcode);
    #    exit 1;
    #}
 #   printf("INFO: INDEX=%d LEN=%D\n",$index,$src_end_ptr);
#    if ($cnt--==0)    {
#        exit;
#    }
    if ($index>=$src_end_ptr)    {
        exit;
    }    
}

exit;

#$aadr=unpack("v",substr($content,0,2));
#TODO When do we have to stop parsing
#$eadr=unpack("v",substr($content,2,2));
#$max_index=$eadr-$aadr+32;
#printf("%04x %04x maxindex=[%04x]%02x\n",$aadr,$eadr,$max_index,ord(substr($content,$max_index,1)));

#$ofs=0x2c01-0x2bc0+32;
#$index=$ofs;

#use constant {
#        GENERIC => 0,
#        REM     => 1,
#        NUMBER  => 2,
#        SYMBOL  => 3,
#        STRING  => 4,
#};


