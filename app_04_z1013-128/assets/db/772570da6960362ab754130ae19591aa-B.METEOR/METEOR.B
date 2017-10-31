Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 PRINT:PRINT
   10 WINDOW:CLS:GOSUB 340:GOSUB 910
   20 CLS:WINDOW 26,31,0,31:FOR X=0 TO 31:PRINT AT(0,X);CHR$(197):MZ=3:MS=8:ZZ=1
   30 PRINT AT(20,X);CHR$(197):NEXT
   40 FOR X=1 TO 19:PRINT AT(X,0);CHR$(197):PRINT AT(X,31);CHR$(197):NEXT
   50 FOR X=1 TO 30:A=1+INT(RND(1)*19):B=1+INT(RND(1)*29)
   60 PRINT AT(A,B);CHR$(42):NEXT
   70 RZ=12:RS=16:PRINT AT(23,2);"SONDE : 1":PRINT AT(23,17);"METEORIT"
   80 Z=(PEEK(-5120+32*RZ+RS)):IF Z><32 THEN GOSUB 710
   90 VS=VS-1:IF VS<0 THEN GOSUB 200
  100 POKE(-5120+32*RZ+RS),201
  110 X$=INKEY$
  120 IF X$=""THEN:PAUSE 1:GOTO 80
  130 POKE(-5120+32*RZ+RS),32
  140 IF X$=" "THEN RZ=RZ+1
  150 IF X$="E"THEN 800
  160 IF X$="J"THEN RZ=RZ-1
  170 IF X$=CHR$(9)THEN RS=RS+1
  180 IF X$=CHR$(8)THEN RS=RS-1
  190 GOTO 80
  200 VS=V:POKE(-5120+32*MZ+MS),32:IF MP=0 THEN 210:ELSE GOTO 220
  210 B=INT(RND(1)*8):MZ=INT(RND(1)*17+2):MS=INT(RND(1)*28+2)
  220 IF B=1 THEN MZ=MZ-1:MS=MS-1
  230 MP=1
  240 IF B=0 THEN MZ=MZ-1
  250 IF B=2 THEN MZ=MZ-1:MS=MS+1
  260 IF B=3 THEN MZ=MZ+1
  270 IF B=4 THEN MZ=MZ+1:MS=MS-1
  280 IF B=5 THEN MZ=MZ+1:MS=MS+1
  290 IF B=6 THEN MS=MS-1
  300 IF B=7 THEN MS=MS+1
  310 IF PEEK(-5120+MZ*32+MS)=197 THEN 210
  320 POKE(-5120+32*MZ+MS),214
  330 RETURN
  340!!!!!!!!!!!!!!!!!!!!!!!!!!!
  350!! METEORITENJAGD********!!
  360!!^^^^^^^^^^^^^^^^^^^^^^^!!
  370!! copright by :         !!
  380!!    Mario Lippert      !!
  390!!    Niederviebig 54    !!
  400!!    EBERSDORF          !!
  410!!    8701               !!
  420!!    Tel.: 3592         !!
  430!!                       !!
  440!!^^^^^^^^^^^^^^^^^^^^^^^!!
  450!!  ICH WUENSCHE IHNEN   !!
  460!!  VIEL  SPASS  BEIM    !!
  470!!  SPIELEN !            !!
  480!!                       !!
  490!!^^^^^^^^^^^^^^^^^^^^^^^!!
  500 PRINT " S P I E L E R K L A E R U N G   ":PRINT STRING$(32,""):PRINT
  510 PRINT "Sie muessen versuchen , so viel "
  520 PRINT "wie  moeglich  Meteoriten abzu- "
  530 PRINT "schiessen !  Dabei  duerfen Sie "
  540 PRINT "keine Sterne  treffen  oder den "
  550 PRINT "Rand ueberschreiten !           "
  560 PRINT "Sie koennen die  Sonde  mit den "
  570 PRINT "Tasten : << , >> , J und SPACE  "
  580 PRINT "nach links , rechts , oben  und "
  590 PRINT "unten steuern.":PRINT
  600 PRINT "Mit der Taste > E < koennen Sie "
  610 PRINT "das Spiel abbrechen.
  620 PRINT:PRINT "So , nun  kann  es   eigendlich "
  630 PRINT "losgehen !"
  640 PRINT AT(31,19);"> ENTER <":PRINT AT(30,0);" "
  650 X$=INKEY$:IF X$=""THEN 650:ELSE CLS
  660 BEEP
  670 PRINT:PRINT "WAEHLEN SIE DIE GESCHWINDIGKEIT ":PRINT "DER SONDE (1 bis 6)
  680 I$=INKEY$:IF I$=""THEN 680
  690 V=VAL(I$):IF V<1 OR V>6 THEN 680:ELSE PRINT:PRINT "GESCHWINDIGKEIT :";V
  700 BEEP:PAUSE 10:CLS:RETURN
  710 IF Z=42 THEN ZZ=ZZ+1:PRINT "SONDE ZERSTOERT !!":BEEP:PAUSE 20:CLS:GOTO 780
  720 IF Z=197 THEN PRINT "PRIMA ! DAS WAR EIN > EIGENTOR <":BEEP
  730 IF Z=197 THEN PRINT "SIE HABEN IHR EIGENES RAUMSCHIFF":PRINT "ZERSTOERT !!"
  740 IF Z=197 THEN 790
  750 IF Z=214 THEN MM=MM+1:PRINT AT(23,17);"METEORIT :",MM:POKE-5120+32*MZ+MS,32 
  760 IF Z=214 THEN MP=0:BEEP:RETURN
  770 RETURN
  780 PRINT AT(23,2);"SONDE :",ZZ:RZ=12:RS=15:IF V>2 AND ZZ=3 THEN 870:ELSE RETURN
  790 PAUSE 55
  800 WINDOW 22,31,0,31:CLS:PRINT "SIE HABEN MIT";ZZ;"SONDEN";MM
  810 PRINT:PRINT "METEORITEN ABGEFANGEN.":PRINT
  820 PP=INT(MM*24/(ZZ*22)*10/V*10)
  830 PRINT "DAS SIND";PP/10;"PUNKTE.":PRINT
  840 PRINT "WUENSCHEN SIE NOCH EIN SPIEL ?":PRINT:PRINT " ( J/N )"
  850 X$=INKEY$:IF X$=""THEN 850
  860 IF X$="N"THEN WINDOW:CLS:END:ELSE RUN
  870 PRINT:PRINT "BEI IHREN STEUERKUENSTEN DUERFEN":V=1
  880 PRINT "SIE JETZT MAL EINE WEILE LANGSAM"
  890 PRINT "FLIEGEN !!":BEEP:PAUSE 10:BEEP:PAUSE 10:BEEP:PAUSE 10:BEEP:PAUSE 40
  900 CLS:RETURN
  910 PRINT ""
  920 PRINT "          "   
  930 PRINT "                 "
  940 PRINT "               ";
  950 PRINT "                 " 
  960 PRINT "              "
  970 PRINT:PRINT:PRINT
  980 PRINT "        "
  990 PRINT "                   "
 1000 PRINT "                    "
 1010 PRINT "             "
 1020 PRINT "                   "
 1030 PRINT "                  "
 1040 PRINT "            "
 1050 PRINT
 1060 PRINT ""
 1070 PRINT "           "
 1080 PRINT "           "
 1090 PRINT "          "
 1100 PRINT "       "
 1110 PRINT "       "
 1120 PRINT "       "
 1130 PRINT "            "   
 1140 PRINT AT(22,18);"  COUNTDOWN  "
 1150 PRINT AT(29,0);" ":FOR X=1 TO 10:PRINT AT(23,12);"":BEEP:PAUSE 2 
 1160 PRINT AT(24,23);10-X:IF(10-X)=<0 THEN PRINT AT(24,22);"START"
 1170 PRINT AT(22,18);"  COUNTDOWN  "
 1180 PRINT AT(23,12);" ":PRINT AT(23,11);"":PAUSE 2:PRINT AT(23,11);""
 1190 PRINT AT(23,10);"":PAUSE 2:PRINT AT(23,10);" "
 1200 PRINT AT(22,18);" COUNTDOWN "
 1210 PRINT AT(23,11);"":PAUSE 2:PRINT AT(23,11);""
 1220 NEXT:PRINT AT(23,12);"":PAUSE 10:BEEP
 1230 RETURN
