Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 CLS:!ANAKONDA AUF Z 1013 BY PIETSCH 24.01.88
   11 PRINT:PRINT:PRINT "    W U R M L A B Y R I N T"
   12 PRINT:PRINT "Sie koennen einen Wurm durch"
   13 PRINT "ein Labyrint steuern.Dabei muss"
   14 PRINT "der Wurm das Futter so schnell"
   15 PRINT "wie moeglich fressen, sonst"
   16 PRINT "verliert das Futter an wert.
   17 PRINT "Sind die 50 Futterbrocken ver-"
   18 PRINT "braucht, ist das Spiel beendet!"
   20 PRINT:PRINT "STEUERZEICHEN :"
   30 PRINT:PRINT "             ^"
   35 PRINT "hoch        =|"
   40 PRINT "runter      = 2"
   50 PRINT "rechts      =->"
   60 PRINT "links       =<-":PRINT:PRINT
   70 INPUT "druecke ENTER";A$
   80 HI=1
   90 F1=35
  100 S=140
  110 K=201
  120 K1=138
  130 GOTO 690
  140 PRINT ""
  150 GOSUB 900:R=197:E1=0
  160 PRINT "                         "
  170 PRINT "        "
  180 PRINT "                           "
  190 PRINT "            "
  200 PRINT "            "
  210 PRINT "                 "
  220 PRINT "          "
  230 PRINT "                           "
  240 PRINT "      "
  250 PRINT "                             "
  260 PRINT "      "
  270 PRINT "                           "
  280 PRINT "    "
  290 PRINT "                           "
  300 PRINT "          "
  310 PRINT "                     "
  320 PRINT "              "
  330 PRINT "           "
  340 PRINT "                          "
  350 PRINT ""
  360 RETURN
  370 PRINT ""
  380 GOSUB 900:R=198:E1=0
  390 FOR W=2 TO 18 STEP 2
  400 PRINT "                             "
  410 PRINT "               "
  420 NEXT W
  430 PRINT "                             "
  440 PRINT ""
  450 RETURN
  460 PRINT ""
  470 GOSUB 900:R=199:E1=0
  480 PRINT "                           "
  490 PRINT "             "
  500 PRINT "                       "
  510 PRINT "            "
  520 PRINT "                     "
  530 PRINT "            "
  540 PRINT "            "
  550 PRINT "                         "
  560 PRINT "        "
  570 PRINT "                           "
  580 PRINT "          "
  590 PRINT "          "
  600 PRINT "                   "
  610 PRINT "            "
  620 PRINT "                         "
  630 PRINT "          "
  640 PRINT "                        "
  650 PRINT "          "
  660 PRINT "                         "
  670 PRINT ""
  680 RETURN
  690!SPIEL
  700 CLS:PRINT:PRINT:PRINT:PRINT:PRINT
  710 PRINT AT(1,5);"Wurmlabyrint"
  720 PRINT AT(3,1);"Label:  Punkte:     Laenge:"
  730 ON HI GOSUB 140,370,460,1500
  740 PRINT AT(3,7);RIGHT$(STR$(HI),1)
  750 C=K:GOSUB 820:G=A:D=A
  760 C=F1:GOSUB 820
  770 GOSUB 1070
  780 HI=HI+1
  790 IF HI=5 THEN HI=1
  800 PAUSE (20)
  810 GOTO 700
  820!FUTTER U. WURMKOPF
  830 A=(INT(603*RND(2)))+1
  840 A=-4927+A
  842 IF C=F1 THEN FZ=FZ+1
  844 IF FZ>50 THEN 1610
  846 PRINT AT(28,1);"Ausgelegte Futterbrocken :",FZ
  850 IF A>-4323 THEN 830
  860 IF PEEK(A)=32 THEN POKE A,C:RETURN
  870 A=A+1
  880 GOTO 850
  890 RETURN
  900!BESCHREIBEN RANDZEILE
  910 B=-4929
  920 FOR I=1 TO 21
  930 POKE B,159
  940 B=B+32
  950 NEXT I
  960 RETURN
  970!SCHWANZ LOESCHEN
  980 F=F-.8
  990 IF F>0 THEN L=L+1:PU=PU+1:RETURN
 1000 POKE D,32
 1010 IF L<=1 THEN D=G:RETURN
 1020 IF PEEK(D+1)=S THEN D=D+1:RETURN
 1030 IF PEEK(D-1)=S THEN D=D-1:RETURN
 1040 IF PEEK(D+32)=S THEN D=D+32:RETURN
 1050 D=D-32
 1060 RETURN
 1070!KOPF SETZEN
 1080 PRINT AT(3,16);PU
 1090 PRINT AT(3,27);L
 1100 IF PEEK(4)=8 THEN E1=-1:GOTO 1140
 1110 IF PEEK(4)=9 THEN E1=1:GOTO 1140
 1120 IF PEEK(4)=10 THEN E1=-32:GOTO 1140
 1130 IF PEEK(4)=50 THEN E1=32
 1140 IF PEEK(G+E1)=R THEN 1160
 1145 IF ABS(E1)=ABS(E2)AND E1<>E2 THEN E1=E1*-1
 1150 E2=E1
 1160 E=G+E2
 1170 IF PEEK(E)=32 THEN 1210
 1180 IF PEEK(E)=S THEN 1390
 1190 IF PEEK(E)=F1 THEN F2=1:C=F1:GOSUB 820:GOTO 1210
 1200 GOTO 1100
 1210 POKE E,K
 1220 POKE G,S
 1230 G=E
 1240 IF F2=1 THEN 1310
 1250 GOSUB 970
 1260 IF L<101 THEN 1070
 1270 F2=0
 1280 F=0
 1290 L=1
 1300 RETURN
 1310 IF F<-29 THEN F=0:GOTO 1330
 1320 F=F+30
 1330 F2=0
 1340 FOR I=1 TO 20
 1350 POKE E,K1
 1355 FOR II=1 TO 10:NEXT II
 1360 POKE E,K
 1365 FOR II=1 TO 10:NEXT II
 1370 NEXT I
 1380 GOTO 1250
 1390 PRINT AT(30,1);"Der  Wurm  frisst  mindestens   den halben Schwanz"
 1400 L1=INT(L/2+.5)
 1410 L=L-L1:PU=PU-L1
 1420 F3=F
 1430 F=0
 1440 FOR I=1 TO L1
 1450 GOSUB 970
 1460 NEXT I
 1470 F=F3
 1480 PRINT AT(30,1);"                                                   "
 1490 GOTO 1100
 1500 PRINT ""
 1510 GOSUB 900:R=195:E1=1
 1520 FOR I=1 TO 6
 1530 PRINT "                      "
 1540 PRINT "                      "
 1550 PRINT "        "
 1560 NEXT I
 1570 PRINT "                             "
 1580 PRINT ""
 1590 PRINT AT(6,29);""
 1600 RETURN
 1610 CLS:PRINT:PRINT:PRINT:PRINT
 1620 PRINT "Sie haben mit 50 Futterbrockem"
 1630 PRINT "eine Wurmlaenge von ";PU
 1640 PRINT "gliedern erreicht !"
 1650 END
