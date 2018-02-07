#!/usr/bin/perl -w

use Data::Dumper;
use Digest::MD5 qw(md5_hex);
use File::Basename;
use File::Glob ':glob';
use Cwd 'abs_path';
use Switch;
use utf8;

our $map_ctrl=1;#maps ASCII 0x00..0x1f to CTRL-Characters U+f120..U+f13f
#our $map_ctrl=0; #maps ASCII 0x00..0x1f,0x7f to FULL-CURSOR and CHESS FIGURES

sub pr($) {
    print OUT $token;
    $token="";
    if ($token_space==1) {
        print OUT " ";
    }
    $token=shift;
    $token_space=1;    
}

sub pq($) {
    print OUT $token;
    $token="";
    my $txt=shift;
    print OUT $txt;
    $token_space=0;    
}

sub map_char($) {
    my $c=shift;
    
    my $mapped=$c;
   
    if (ord($c)>=0x00 && ord($c)<=0x1f) {
        if ($map_ctrl) {
            return chr(0xf120+ord($c));
        }
        if (ord($c)>=0x0e && ord($c)<=0x1f) {
            return chr(0xf100+ord($c));
        }
        return chr(0xf1ff);
    } elsif (ord($c)>=0x20 && ord($c)<=0x7e){
        return $c;
    } else {
        if ($map_ctrl==0 && ord($c)==0x7f) {
            return chr(0xf1ff);
        }
        return chr(0xf100+ord($c));
    }
    return $c;
}

if (!defined $ARGV[0]) {
    my @list = bsd_glob ("*.z80");
    $file=$list[0];
} else {


    if ($ARGV[0] eq "-h") {
        print "konvertiert KC-BASIC Progamm wieder in Quelltext:\n";
        print "Sonderzeichen werden in UTF-Zeichen ab U+f100 umgewandet\n";
        print "-CTRL verwendet anstatt ^A..^Z die eingebauten Schachfiguren\n";
        print basename($0)." basic.z80 [-CTRL]\n";
        exit 1;
    }
    $file=$ARGV[0];
}

if (defined $ARGV[1] ) {
    my $encoding=$ARGV[1];
    if ($encoding=~m/-CTRL/) {
        $map_ctrl=0; 
    }
}

$out=$file;

$out=~s/^B\.//i;
$out=~s/\.z80//i;
$out.=".B";

my $len=-s "$file";
open(FILE,"<:raw", $file);
read(FILE,my $content,$len);
close(FILE);

$index=32;
$aadr=unpack("v",substr($content,0,2));
#TODO When do we have to stop parsing
#$eadr=unpack("v",substr($content,2,2));
#$max_index=$eadr-$aadr+32;
#printf("%04x %04x maxindex=[%04x]%02x\n",$aadr,$eadr,$max_index,ord(substr($content,$max_index,1)));

$eadr=unpack("v",substr($content,2,2));


$ofs=0x2c01-0x2bc0+32;
#offset im programm code, nicht der im Emulatorspeicher
#$ofs=0x2a21; #hcb
#$ofs=0x2e21; #hbc41
#$ofs=32;

printf ("i: EADR(nach Z80 Header)=0x%04x     \@FILE-POS[0x%04x]\n",$eadr,$eadr-$aadr+32);

if ($ofs==97) {
    $basic_end=unpack("v",substr($content,55,2));
    printf ("i: PRGM(          \@2BD7)=0x%04x     \@FILE-POS[0x%04x]\n",$basic_end,$basic_end-$aadr+32);
    if ($eadr<$basic_end) {
        printf ("r:  Hier fehlt das Ende. Im Header steht das Ende EADR=%04x,\n",$eadr);
        printf ("    aber der BASIC-Speicher meint das Ende sei bei=%04x\n",$basic_end);
    }

    if ($eadr!=$basic_end) {
        printf (":  Im Header steht das Ende EADR=%04x,\n",$eadr);
        printf ("   aber der BASIC-Speicher meint das Ende sei bei=%04x\n",$basic_end);
    }
}

$index=$ofs;

use constant {
        GENERIC => 0,
        REM     => 1,
        NUMBER  => 2,
        SYMBOL  => 3,
        STRING  => 4,
};

open(OUT,">", $out);
binmode(OUT, ":utf8");
print(OUT "Zeichensatz UTF-8+Z1013()");
if ($map_ctrl) {
    print(OUT "+CTRL()");
} else {
    print(OUT "-CTRL()");
}
print(OUT "-ohne Umlaute(äöüß)\n\n");

$token="";
$token_type=0; #0 general 1 rem 2 int float numbers 3 symbol 4 str
while(1) {
    $len=2;
    $eol=unpack("v",substr($content,$index,$len));
    #printf(STDERR "%04x ",$eol);
    if ($eol==0) {
        last;
    }
    $eol=$eol-$aadr+32;
    $index+=$len;
    $line_no=unpack("v",substr($content,$index,$len));
    $index+=$len;
    #printf("next_ptr=%x this_content=%x\n",$eol,$index);
    $token=sprintf("%5d",$line_no); 
    $token_space=1; #need space between tokens
    $token_type=GENERIC;
    $parse_line=1;

    while($parse_line) {
        #printf("index=%x eol=%x\n",$index,$eol);
        $byte=ord(substr($content,$index++,1));
        if ($index==$eol) {
            if ($byte==0) {
                print OUT $token;
                print OUT ("\n");
                $parse_line=0; #break reset scanner status variables outside the loop
            } else {
                printf("e: [0x%04x] - NON-NULL character 0x%02x found - that should be the end of the line marker - exit...\n", $index-1,$byte);
                print OUT "$token";
                print OUT ("\n");
                exit 1;
            }    
        } else {
REDO_CHARACTER:
            if ($token_type==STRING) {
                if ($byte==0x22) {
                    pq("\""); 
                    $token_type=GENERIC;
                } else {
                    $token.=map_char(chr($byte));
                }
            } elsif ($token_type==REM) {
                switch($byte) { 
                    $token.=map_char(chr($byte));
                }
            } elsif ($token_type==NUMBER) {
                switch($byte) { 
                    case [0x2e,0x30..0x39] { $token.=chr($byte); } #.
                    case [0x41..0x5a,0x61..0x7a] {
                        $token_space=0;
                        $token_type=GENERIC;
                        goto REDO_CHARACTER;
                    }
                    else {
                        $token_space=1;
                        $token_type=GENERIC;
                        goto REDO_CHARACTER;
                    }
                }
            } elsif ($token_type==SYMBOL) {
                switch($byte) { 
                    case [0x24,0x30..0x39,0x41..0x5a,0x61..0x7a] { $token.=chr($byte); }  #-$-sign is part of a symbol 
                    else {
                        #printf("sym[$token_space]\n");
                        $token_type=GENERIC;
                        goto REDO_CHARACTER;
                    }
                }
            } else {
                switch($byte)
                {
                    case 0x00 { print OUT $token;
                                print OUT ("\n");
                                $parse_line=0; $index=$eol; } #TODO WARNING of hidden bytes
                    case 0x22 { pr("\""); $token_type=STRING; }
                    case [0x30..0x39] { pr(chr($byte)); $token_type=NUMBER; }
                    case [0x2d..0x2e] { pq(chr($byte)); $token_type=NUMBER; }  # [-.] #JKCEMU did not add any SPACE on the output  
                    case 0x40 { pq("@"); }
                    case [0x41..0x5a,0x61..0x7a] { pr(chr($byte)); $token_type=SYMBOL; }
                    case [0x20..0x21,0x23,0x27..0x2c,0x2f,0x3a..0x3f] { pq(chr($byte)); } # [ '(),:*/]
                    case 0x80 { pr("END"); }
                    case 0x81 { pr("FOR"); }
                    case 0x82 { pr("NEXT"); }
                    case 0x83 { pr("DATA"); }

                    case 0x84 { pr("INPUT"); }
                    case 0x85 { pr("DIM"); }
                    case 0x86 { pr("READ"); }
                    case 0x87 { pr("LET"); }

                    case 0x88 { pr("GOTO"); }
                    case 0x89 { pr("RUN"); }
                    case 0x8a { pr("IF"); }
                    case 0x8b { pr("RESTORE"); }

                    case 0x8c { pr("GOSUB"); }
                    case 0x8d { pr("RETURN"); }
                    case 0x8e { pr("REM"); $token_type=REM; }
                    case 0x8f { pr("STOP"); }

                    case 0x90 { pr("OUT"); }
                    case 0x91 { pr("ON"); }
                    case 0x92 { pr("NULL"); }
                    case 0x93 { pr("WAIT"); }

                    case 0x94 { pr("DEF"); }
                    case 0x95 { pr("POKE"); }
                    case 0x96 { pr("DOKE"); }
                    case 0x97 { pr("AUTO"); }

                    case 0x98 { pr("LINES"); }
                    case 0x99 { pr("CLS"); }
                    case 0x9a { pr("WIDTH"); }
                    case 0x9b { pr("BYE"); }

                    case 0x9c { pq("!"); $token_type=REM;  }
                    case 0x9d { pr("CALL"); }
                    case 0x9e { pr("PRINT"); }
                    case 0x9f { pr("CONT"); }

                    case 0xa0 { pr("LIST"); }
                    case 0xa1 { pr("CLEAR"); }
                    case 0xa2 { pr("CLOAD"); }
                    case 0xa3 { pr("CSAVE"); }

                    case 0xa4 { pr("NEW"); }
                    case 0xa5 { pr("TAB("); $token_space=0; }
                    case 0xa6 { pr("TO"); }
                    case 0xa7 { pr("FN"); }

                    case 0xa8 { pr("SPC("); $token_space=0; }
                    case 0xa9 { pr("THEN"); }
                    case 0xaa { pr("NOT"); }
                    case 0xab { pr("STEP"); }

                    case 0xac { pq("+"); }
                    case 0xad { pq("-"); }
                    case 0xae { pq("*"); }
                    case 0xaf { pq("/"); }

                    case 0xb0 { pq("^"); }
                    case 0xb1 { pr("AND"); }
                    case 0xb2 { pr("OR"); }
                    case 0xb3 { pq(">"); }

                    case 0xb4 { pq("="); }
                    case 0xb5 { pq("<"); }
                    case 0xb6 { pr("SGN"); }
                    case 0xb7 { pr("INT"); }

                    case 0xb8 { pr("ABS"); }
                    case 0xb9 { pr("USR"); }
                    case 0xba { pr("FRE"); }
                    case 0xbb { pr("INP"); }

                    case 0xbc { pr("POS"); }
                    case 0xbd { pr("SQR"); }
                    case 0xbe { pr("RND"); }
                    case 0xbf { pr("LN"); }

                    case 0xc0 { pr("EXP"); }
                    case 0xc1 { pr("COS"); }
                    case 0xc2 { pr("SIN"); }
                    case 0xc3 { pr("TAN"); }

                    case 0xc4 { pr("ATN"); }
                    case 0xc5 { pr("PEEK"); }
                    case 0xc6 { pr("DEEK"); }
                    case 0xc7 { pr("PI"); }

                    case 0xc8 { pr("LEN"); }
                    case 0xc9 { pr("STR\$"); }
                    case 0xca { pr("VAL"); }
                    case 0xcb { pr("ASC"); }

                    case 0xcc { pr("CHR\$"); }
                    case 0xcd { pr("LEFT\$"); }
                    case 0xce { pr("RIGHT\$"); }
                    case 0xcf { pr("MID\$"); }

                    case 0xd0 { pr("LOAD"); }
                    case 0xd1 { pr("TRON"); }
                    case 0xd2 { pr("TROFF"); }
                    case 0xd3 { pr("EDIT"); }

                    case 0xd4 { pr("ELSE"); }
                    case 0xd5 { pr("INKEY\$"); }
                    case 0xd6 { pr("JOYST\$"); }
                    case 0xd7 { pr("STRING\$"); }
                    
                    case 0xd8 { pr("INSTR"); }
                    case 0xd9 { pr("RENUMBER"); }
                    case 0xda { pr("DELETE"); }
                    case 0xdb { pr("PAUSE"); }

                    case 0xdc { pr("BEEP"); }
                    case 0xdd { pr("WINDOW"); }
                    case 0xde { pr("BORDER"); }
                    case 0xdf { pr("INK"); }

                    case 0xe0 { pr("PAPER"); }                    
                    case 0xe1 { pr("AT"); }                    
                    case 0xe2 { pr("HSAVE"); }                    
                    case 0xe3 { pr("HLOAD"); }

                    case 0xe4 { pr("PSET"); }
                    case 0xe5 { pr("PRES"); }
                    
                    case 0xe9 { pr("LOCATE"); } #HCB only
                    case 0xf0 { pr("RANDOMIZE"); } #HCB only

                    case 0xf5 { pr("PRINT"); } #HCB CSRLIN
                    
                    else { printf("e: [0x%04x] - unknown character 0x%02x after '%s' found - ignored\n", $index,$byte,$token); pq(sprintf("<<TOKEN:%02x>>",$byte)); }
                }
            }
        }
    }
}

printf("OK. \"%s\" erstellt.\n",$out);
close(OUT);


