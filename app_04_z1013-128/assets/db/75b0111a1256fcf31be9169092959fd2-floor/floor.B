Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

    1!----------------------------
    2!Copyright by   M.Augsten
    3!               8028 Dresden
    4!               Clara-Zetkin                    -Str.45
    5!----------------------------
    6!
    7! geaendert fuer Z1013 von      R.Riedel Suhl Lauterkopfstr.35
    8! Y43RK & D.Hartung
   10 CLS
   13 ANF=20481:MOM=20676:ZX=10:POKE 48,ZX
   20 GOSUB 10000:!UMRANDUNG
   30 WINDOW 1,19,1,30:PRINT AT(0,0);"":PAPER 1:INK 2:CLS
   35 POKE(ANF+26),15:LE=15:DOKE ANF+29,0:!LEBEN,PKT 
   40 CR=-4509:E1=-5051:E2=-5037:BF=112:HC=32:KW=2000:MA=10 
   41 GOSUB 5000
   50 PRINT "R.Riedel  **Y43RK**    Suhl"
   60 PRINT:PRINT
   80 PRINT "HHHH  HH    HHH   HHH  HHHHH"
   90 PRINT "HH    HH   HH HH HH HH HH  HH" 
  100 PRINT "HHHHHHHHHHHHHHHH" 
  110 PRINT "HH    HH   HH HH HH HH HH  HH"
  120 PRINT "FFFF  LL   OO OO OO OO RRRRR"
  130 PRINT "HH    HH   HH HH HH HH HHHH"
  140 PRINT "HHHHHHHHHHHHHHHH"
  150 PRINT "HH    HHHH HH HH HH HH HH  HH"
  160 PRINT "HH    HHHH  HHH   HHH  HH   HH"
  164 PRINT
  170 PRINT "  ";
  172 PRINT
  175 PRINT "" 
  176 PRINT
  178 PRINT "*";
  240 GOSUB 10320:!AUSGABEFELD 
  245 POKE 48,ZX:DOKE(ANF+4),E2
  250 CALL*5430
  260 J=J+1:ZX=ZX-1:IF ZX<1 THEN ZX=10
  265 E2=E2+1:IF E2=-5026 THEN E2=-5055
  270 IF J>=200 THEN PRINT PAPER 1;AT(22,16);"<ENTER>"
  280 IF INKEY$=""THEN 245
  290 PAPER 1:INK 8:CLS
  300 PRINT AT(21,1);" Spielanleitung gewuenscht J/N"
  310 A$=INKEY$
  320 IF A$="J"OR A$="j"THEN 1000
  330 IF A$="N"OR A$="n"THEN 2000
  335 IF A$=CHR$(13)THEN 2000
  340 GOTO 310
 1000 WINDOW 1,19,1,30:CLS
 1010 PRINT:PRINT "      Spielanleitung"
 1020 PRINT "      --------------"
 1030 PRINT
 1040 PRINT
 1050 PRINT "  Steuerung der Spielfigur:"
 1060 PRINT 
 1070 PRINT "     Taste -> rechts"
 1080 PRINT:PRINT "           <- links"
 1090 PRINT:PRINT "           U  hoch"
 1100 PRINT:PRINT "        Space runter"
 1110 PRINT:PRINT "        ENTER Sprung"
 1120 PRINT:PRINT "           B  Stop"
 1130 PRINT
 1140 WINDOW 4,19,1,30:PAUSE 150:CLS 
 1150 PRINT:PRINT "  Hindernisse und Gegner :"
 1160 PRINT 
 1180 PRINT "         o  Gegner "
 1190 PRINT:PRINT "           Moor"
 1200 PRINT:PRINT "           Springpunkt
 1210 PRINT 
 1220 PRINT "           Kraftkeks "
 1230 PRINT:PRINT "           Ausgang der Etage"
 1240 PRINT
 1250 PRINT "              u.a.
 1260!
 1270!
 1280!
 1290!
 1300!
 1310!
 1320!
 1330 PAUSE 150:CLS
 1400 GOTO 2000
 2000!STEUERUNG BILDAUSWAHL
 2010 B=1:BR=1:FOR I=1 TO 5:MK(I)=2:NEXT
 2020 FOR BI=BR TO B
 2025 PK=DEEK(ANF+29)
 2030 ON BI GOSUB 10100,10400,10700,11000,11300:!,11600 
 2035 WINDOW 21,30,1,30:CLS:GOSUB 4000
 2040 MA=MK(BI):GOSUB 3000
 2045 IF MK(BI)<15 THEN MK(BI)=MK(BI)+2
 2050 NEXT:IF B=1 THEN BR=2:ELSE BR=1
 2060 B=B+1
 2070 IF B=6 THEN B=1
 2080 GOTO 2020
 3000!STEUERUNG BILD
 3010 GOSUB 5000:!POKE-ROUTINE
 3020 MI=1:POKE(30),0:POKE(31),0:POKE CR,196:P=INT(DEEK(ANF+29)/100)
 3030 MT=0:SE=0: GOSUB 4100
 3050 CALL*50D8
 3060 GOSUB 4200:IF PEEK(30)>=MI THEN 3300
 3070 IF PEEK(MOM+3)=0 THEN 3050
 3080 F=PEEK(MOM+3):DOKE ANF+15,12000: CALL*55B4
 3090 IF F<>ASC("")THEN 3200
 3095 IF PK+30>DEEK(ANF+29)THEN 3200
 3100!ZEITGUTSCHRIFT
 3105 MT=PEEK(30):SE=PEEK(31)
 3110 ZE=MT*60+SE:POKE(ANF+26),PEEK(ANF+26)+1:!KORREKTUR LEBEN
 3120 ZE=MI*60-ZE
 3130 FOR I=1 TO ZE
 3140 DOKE ANF+29,DEEK(ANF+29)+1:P1=INT(DEEK(ANF+29)/100)
 3150 IF P1>P THEN POKE ANF+26,PEEK(ANF+26)+1:P=P1:!LEBEN+1
 3155 SE=SE+1:IF SE=60 THEN SE=0:MT=MT+1
 3160 GOSUB 4100
 3170 NEXT
 3180 RETURN
 3200 WINDOW 21,30,1,30:CLS
 3201 IF PEEK(ANF+26)=0 THEN 30000
 3205 IF F=ASC("")THEN PRINT " Sie sind ins Moor gefallen !"
 3206 IF F=ASC("o")THEN PRINT " Sie wurden soeben gefressen !"
 3208 IF F=ASC("")THEN PRINT " Sie haben zu wenige           Kraftkekse () !!"
 3209 PAUSE 10:BEEP:BEEP:BEEP:BEEP
 3210 PAUSE 120:GOSUB 4000:GOTO 3010
 3300 WINDOW 21,30,1,30:CLS:PRINT "Zeitueberschreitung dies kostet"
 3301 POKE DEEK(ANF),PEEK(ANF+12)
 3302 PRINT "        ein Leben !";:POKE ANF+26,PEEK(ANF+26)-1 
 3305 IF PEEK(ANF+26)<1 THEN 30000
 3310 DOKE ANF+15,1200:CALL*55B4:PAUSE 60:GOSUB 4000: GOTO 3010
 4000 CLS:PRINT AT(21,1);" Punkte:"
 4010 PRINT AT(21,14);" max.Zeit:"
 4020 PRINT AT(22,2);"Leben :",LE
 4030 PRINT AT(22,19);"Zeit:"
 4040 RETURN
 4100 PRINT AT(21,9);DEEK(ANF+29)
 4110 PRINT AT(21,24);MI,": 0"
 4120 PRINT AT(22,9);PEEK(ANF+26)
 4130 PRINT AT(22,24);MT,":",SE
 4140 BEEP:RETURN
 4180!      ZEITANZEIGE
 4200 PRINT AT(21,9);DEEK(ANF+29):PRINT AT(22,24);PEEK(30),":",PEEK(31)
 4205 ZK=ZK-1:IF ZK<0 THEN ZK= 6 :ELSE RETURN
 4210 SC=PEEK(31):SC=SC+1:IF SC=60 THEN SC=0:POKE 30,PEEK(30)+1
 4220 POKE 31,SC
 4230 ZX=PEEK(48):ZX=ZX-1:IF ZX<1 THEN ZX=10
 4240 POKE 48,ZX
 4299 RETURN 
 5000!POKE-ANFANGSWERTE
 5010 DOKE(ANF),CR:!CURSOR-SPIELE
 5020 DOKE (ANF+2),E1:!EINWURF1
 5030 DOKE (ANF+4),E2:!EINWURF2
 5040 POKE (ANF+10),BF:!BALLFARBE
 5050 POKE (ANF+11),BH:!BALLFARBENHINT.
 5060 POKE (ANF+12),HC:!HINTGR.CUR.
 5070 DOKE (ANF+15),KW:!WAIT-KONST
 5080 POKE (ANF+31),MA:!MAX.BALLANZ.
 5090 POKE (MOM),0:!MOM.ANZ.BAELLE
 5095 POKE (ANF+13),66:!RIHTG."B"
 5100 POKE (MOM+3),0:!FEHLER-KEINE
 5110 RETURN
 6000 INPUT X,A,B,C 
 6010 M=X*16^3+ A*16^2+B*16+C:N=M-65536
 6020 PRINT M,N: GOTO 6000
10000!UMRANDUNG
10010 WINDOW:PAPER 2:CLS
10020 PRINT AT(0,0);"":FOR I=1 TO 30:PRINT AT(0,I);"":NEXT
10030 PRINT AT(0,31);""
10040 FOR I=1 TO 30:PRINT AT(I,0);"":PRINT AT(I,31);"":NEXT
10050 PRINT AT(20,0);"":PRINT AT(20,31);""
10060 FOR I=1 TO 30:PRINT AT(20,I);"":NEXT
10070 PRINT AT(31,0);"":PRINT AT(31,31);""
10080 FOR I=1 TO 30:PRINT AT(31,I);"":NEXT
10090 RETURN
10100 WINDOW 1,19,1,30:CLS
10110 CR=-4510:E1=-5046:E2=-5035:RI=66
10120 BF=112:HC=32 :KW=4000 
10130 PRINT "                   "
10140 PRINT "                       " 
10142 PRINT ""
10145 PRINT "                 H        "
10150 PRINT "      H  "  
10160 PRINT "                  H"
10170 PRINT "                  H"
10180 PRINT "                  H"
10190 PRINT "                  H"
10210 PRINT "                  H"
10220 PRINT "              H"
10230 PRINT "      H                   H ";
10240 PRINT "     H         H";
10250 PRINT "       H                   H" 
10260 PRINT "       H                   H"  
10270 PRINT "  H                     H ";
10280 PRINT "H        H";
10290 PRINT "   H                       H" 
10300 PRINT "         *             *";
10310 RETURN
10320 WINDOW 21,30,1,30:PAPER 5:CLS:RETURN
10400 WINDOW 1,19,1,30:PAPER 2:INK 7:CLS
10410 CR=-4542:E1=-5035:E2=-5046:RI=66
10420 BF=65 :HC=32:KW=4000
10430 PRINT "                   "
10440 PRINT "                 "
10450 PRINT "  H                   H H" 
10460 PRINT "H  HH" 
10470 PRINT "    H                   H H" 
10480 PRINT "                        "
10490 PRINT " H          H       H H"
10500 PRINT "HH   H H";
10510 PRINT " H           H           "
10520 PRINT " H           H     H"
10530 PRINT " H           H     H"
10540 PRINT " H        H H  ";
10550 PRINT " H           H"
10560 PRINT " H"
10570 PRINT " H    H           H   H  "
10580 PRINT "HHHH  ";
10590 PRINT " H    H           H   H"
10600 PRINT "                            ";
10610 PRINT "*            *              *"; 
10620 PRINT AT(29,30);" ":RETURN
10700 WINDOW 1,19,1,30:PAPER 3:INK 6:CLS
10710 CR=-4998:E1=-5030:E2=-5044:RI=66
10720 BF=82:HC=32:KW=4000
10730 PRINT "                  " 
10740 PRINT "                "
10745 PRINT "                 "
10750 PRINT "             H"
10760 PRINT "  H   " 
10790 PRINT "              H"
10800 PRINT "             H         "
10810 PRINT "                      "
10812 PRINT "                          H"
10830 PRINT "     H           H";
10840 PRINT "    H     H           H " 
10850 PRINT "     H      H "
10860 PRINT "     H        H            H"
10870 PRINT "                      H";
10880 PRINT "        H                  H"
10890 PRINT "   H            H"
10900 PRINT "       H        H"
10910 PRINT "    H                H"
10920 PRINT "                      ";
10930 RETURN
11000 WINDOW 1,19,1,30:PAPER 4:INK 5:CLS
11010 CR=-4501:E1=-5021:E2=-5050:RI=66
11020 BF=3:HC=32:KW=4000
11030 PRINT "                 "
11035 PRINT
11040 PRINT "                      H   "
11050 PRINT "    H"
11060 PRINT "                      H"
11070 PRINT "               H      H"
11080 PRINT "             H    H"
11090 PRINT "           H   H      H   H "
11100 PRINT "         H    HH     H"
11110 PRINT "H     H   H    HH      H" 
11120 PRINT "H    H         HH     H" 
11130 PRINT "H   H          HH   H" 
11140 PRINT "H                 HH      H" 
11150 PRINT "   H          HH   H"
11160 PRINT "H   HH  H";
11170 PRINT "   H              HH      H"
11180 PRINT "   H              H"
11190 PRINT "   H                  H"
11200 PRINT "         *            *";
11220 RETURN
11300 WINDOW 1,19,1,30:CLS
11310 CR=-4509:E1=-5031:E2=-5045:RI=66
11320 BF=3:HC=32:KW=4000
11330 PRINT "                   "
11340 PRINT 
11345 PRINT " " 
11350 PRINT "        H            H  "
11370 PRINT "        H  H"
11380 PRINT "           H            H" 
11382 PRINT "           H          H"
11390 PRINT "                 "
11392 PRINT "           H            H" 
11400 PRINT "        H         H "
11410 PRINT "    H  H"
11420 PRINT "           H            H"
11424 PRINT "           H            H"
11425 PRINT " H         H            H"
11430 PRINT "H    H           H  
11440 PRINT " H         "
11450 PRINT " H                  ";
11460 PRINT " H    "
11470 PRINT " H    ";
11480 RETURN
19996:
19997:
19998:
19999:
20000 PRINT(14*16*16*16+14*16*16+15*16+10)-65536
30000 WINDOW 21,30,1,30:CLS
30010 WINDOW 1,19,1,30:CLS:PRINT " A b s c h l u s z s t a n d"
30020 PRINT:PRINT:PRINT
30030 PRINT "  Sie erreichten :":PRINT:PRINT
30040 PRINT "                  ";DEEK(ANF+29);"Punkte"
30050 PRINT:PRINT:PRINT
30070 PRINT " Wollen Sie noch einmal ?"
30080 A$=INKEY$
30090 IF A$="J"THEN RUN
30100 IF A$<>"N"THEN 30080
30110 WINDOW:CLS:OUT 128,3
30120 PRINT AT(10,5);"Hoffentlich sind Sie":PRINT AT(12,5);"naechstes mal besser
30130 PAUSE 50:CLS:END
