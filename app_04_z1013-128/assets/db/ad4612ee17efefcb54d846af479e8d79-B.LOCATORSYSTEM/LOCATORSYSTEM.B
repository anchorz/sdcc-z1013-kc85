Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 WINDOW:CLS
   20 PRINT AT(10,2);"****************************"
   30 PRINT AT(12,6);"Beziehungen zwischen"
   40 PRINT AT(13,14);"den"
   50 PRINT AT(14,3);"geographischen Koordinaten"
   60 PRINT AT(15,12);"und  dem"
   70 PRINT AT(16,4);"weltweiten Locatorsystem"
   80 PRINT AT(18,2);"****************************"
   90 PRINT AT(22,14);"by"
  100 PRINT AT(23,9);"Dieter Waldt"
  110 PRINT AT(24,12);"Y2 8OH"
  120 PAUSE 60
  130 CLS
  140 GOTO 1240
  150 PRINT:PRINT
  160 PRINT "Erlauterung  des"
  170 PRINT "    Locator-Systems"
  180 PRINT ""
  190 PRINT:PRINT " Die Erdoberflache ist in"
  200 PRINT "18 X 18 Felder eingeteilt"
  210 PRINT "        "
  220 PRINT "Sie haben eine"
  230 PRINT "Ausdehnung von 20 Grad Laenge"
  240 PRINT "           und 10 Grad Breite"
  250 PRINT
  260 PRINT "Die Felder sind unterteilt"
  270 PRINT "in 10 X 10 Quadrate."
  280 PRINT "           "
  290 PRINT "Diese Quadrate haben eine"
  300 PRINT "Ausdehnung von 2 Grad Laenge"
  310 PRINT "           und 1 Grad Breite"
  320 PRINT
  330 PRINT "Die Quadrate werden wiederum"
  340 PRINT "in 24 X 24 Kleinquadrate"
  350 PRINT "           "
  360 PRINT "eingeteilt und haben eine"
  370 PRINT "Ausdehnung von 2,5 X 5,0"
  372 PRINT "Minuten,das sind in der DDR ca."
  374 PRINT "5,7 X 4,6 km"
  380 PRINT AT(30,25);">ENTER<"
  390 IF INKEY$<>CHR$(13) THEN 390
  400 CLS
  410 PRINT:PRINT "          Die Felder"
  420 PRINT "          "
  430 PRINT "Grad"
  440 PRINT "  90    "
  450 PRINT "N   ARBR   IRJR   QRRR"
  460 PRINT "o 80......"
  470 PRINT "r   AQBQ   IQJQ   QQRQ"
  480 PRINT "d 70      "
  490 PRINT "       .         .         ."
  500 PRINT "      .         .         .  "
  510 PRINT "       .         .         ."
  520 PRINT "  10      "
  530 PRINT "    AJBJ   IJJJ   QJRJ"
  540 PRINT "   0......"
  550 PRINT "    AIBI   IIJI   QIRI"
  560 PRINT "  10      "
  570 PRINT "       .         .         ."
  580 PRINT "      .         .         .  "
  590 PRINT "       .         .         ."
  600 PRINT "  70      "
  610 PRINT "S   ABBB   IBJB   QBRB" 
  620 PRINT "u 80......"
  630 PRINT "e   AABA   IAJA   QARA"
  640 PRINT "d 90    "
  650 PRINT "   180   140  20 0 20  140   180" 
  660 PRINT "    West                    Ost"
  670 PRINT AT(30,25);">ENTER<"
  680 IF INKEY$<>CHR$(13) THEN 680
  690 CLS
  700 PRINT:PRINT
  710 PRINT "        Die Quadrate"
  720 PRINT "        ":PRINT:PRINT
  730 PRINT " Grad"
  740 PRINT " 10  "
  750 PRINT "   091929    798999"
  760 PRINT "  9    "
  770 PRINT "   081828....788898"
  780 PRINT "  8    "
  790 PRINT "   071727    778797"
  800 PRINT "  7    "
  810 PRINT "       .             ,"
  820 PRINT "      .             .    "
  830 PRINT "      .             .    "
  840 PRINT "       .             ."
  850 PRINT "  3    "
  860 PRINT "   021222    728292"
  870 PRINT "  2    "
  880 PRINT "   011112....718191"
  890 PRINT "  1    "
  900 PRINT "   001020    708090"
  910 PRINT "  0  "
  920 PRINT "   0  2  4  6   14 16 18 20"
  930 PRINT "                       Grad"
  940 PRINT AT(30,25);">ENTER<"
  950 IF INKEY$<>CHR$(13) THEN 950
  960 CLS
  970 PRINT:PRINT
  980 PRINT "      Die Kleinquadrate"
  990 PRINT "      "
 1000 PRINT:PRINT
 1010 PRINT "  Min."
 1020 PRINT " 60,0  "
 1030 PRINT "     AXBXCX    VXWXXX"
 1040 PRINT " 57,5    "
 1050 PRINT "     AWBWCW....VWWWXW"
 1060 PRINT " 55,0    "
 1070 PRINT "     AVBVCV    VVWVXV"
 1080 PRINT " 52,5    "
 1090 PRINT "         .             ."
 1100 PRINT "        .             .    "
 1110 PRINT "        .             .    "
 1120 PRINT "         .             ."
 1130 PRINT "  7,5    "
 1140 PRINT "     ACBCCC    VCWCXC"
 1150 PRINT "  5,0    "
 1160 PRINT "     ABBBCB....VBWBXB"
 1170 PRINT "  2,5    "
 1180 PRINT "     AABACA    VAWAXA"
 1190 PRINT "  0,0  "
 1200 PRINT "     0  5 10 15   105   115 120"
 1210 PRINT AT(30,25);">ENTER<"
 1220 IF INKEY$<>CHR$(13) THEN 1220
 1230 CLS
 1230 CLS
 1240 PRINT:PRINT:PRINT
 1250 PRINT "Was soll dargestellt werden ?"
 1260 PRINT "":PRINT:PRINT
 1270 PRINT "Erlauterung des"
 1280 PRINT "Locatorsystems:  =0"
 1290 PRINT
 1300 PRINT "Ermitteln des"
 1310 PRINT "Locators         =1"
 1320 PRINT
 1330 PRINT "Ermitteln der"
 1340 PRINT "Koordinaten      =2"
 1350 PRINT:PRINT:PRINT
 1360 INPUT "Eingabe der Zahl:";FO
 1370 CLS
 1380 IF FO=1 THEN 1410
 1390 IF FO=2 THEN 1740
 1400 IF FO=0 THEN 150
 1410 PRINT:PRINT:PRINT:PRINT
 1420 PRINT "Bestimmen des Locators"
 1430 PRINT "aus den"
 1440 PRINT "geographischen Koordinaten"
 1450 PRINT "":PRINT:PRINT
 1460 PRINT
 1470 PRINT "Eingabe der Laenge:":PRINT "--------------------"
 1480 INPUT "Grad    :";T
 1490 INPUT "Minuten :";S
 1500 INPUT "Sekunden:";R
 1510 L=T+S/60+R/3600
 1520 PRINT:PRINT:PRINT
 1530 PRINT "Eingabe der Breite:":PRINT "--------------------"
 1540 INPUT "Grad    :";Q
 1550 INPUT "Minuten :";P
 1560 INPUT "Sekunden:";O
 1570 B=Q+P/60+O/3600
 1580 PRINT:PRINT
 1590 L=(L+180)/20
 1600 B=(B+90)/10
 1610 A=INT(L)
 1620 X=INT(B)
 1630 L=(L-A)*10
 1640 B=(B-X)*10
 1650 Y=INT(L)    
 1660 Z=INT(B)
 1670 A$=CHR$(A+65)+CHR$(X+65)+CHR$(Y+48)+CHR$(Z+48)
 1680 A$=A$+CHR$ (INT((L-Y)*24)+65)+CHR$(INT((B-Z)*24)+65)
 1690 PRINT
 1700 PRINT "LOCATOR:";A$
 1710 PRINT AT(30,25);">ENTER<"
 1720 IF INKEY$<>CHR$(13) THEN 1720
 1730 GOTO 1230
 1740 PRINT:PRINT:PRINT:PRINT
 1750 PRINT "Bestimmen der"
 1760 PRINT "geographischen Koordinaten"
 1770 PRINT "aus dem"
 1780 PRINT "Locator"
 1790 PRINT:PRINT:PRINT
 1800 PRINT
 1810 INPUT "LOCATOR";A$
 1820 FOR K=1 TO 6
 1830 A(K)=ASC(MID$(A$,K,1))
 1840 NEXT K
 1850 L= -180+(A(1)-65)*20+(A(3)-48)*2+(A(5)-64.5)/12
 1860 B= -90+(A(2)-65)*10+A(4)-48+(A(6)-64.5)/24
 1870 PRINT:PRINT
 1880 O=INT(L)
 1890 K=L-O
 1900 M=60*K
 1910 N=INT(M)
 1920 P=M-N
 1930 Q=INT(P*60)
 1940 PRINT:PRINT "Die Koordinaten sind:"
 1950 PRINT ""
 1960 PRINT:PRINT:PRINT
 1970 PRINT "Laenge:"
 1980 PRINT "--------"
 1990 PRINT O;"Grad";N;"Minuten";Q;"Sekunden"
 2000 PRINT:PRINT
 2010 C=INT(B)
 2020 D=B-C
 2030 E=60*D
 2040 F=INT(E)
 2050 G=E-F
 2060 H=INT(G*60)
 2070 PRINT "Breite:"
 2080 PRINT "--------"
 2090 PRINT C;"Grad";F;"Minuten";H;"Sekunden"
 2100 PRINT AT(30,25);">ENTER<"
 2110 IF INKEY$<>CHR$(13) THEN 2110
 2120 GOTO 1230
