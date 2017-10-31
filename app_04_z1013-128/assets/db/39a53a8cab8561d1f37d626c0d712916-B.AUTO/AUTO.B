Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 CLS
   20 OUT 1,207
   30 OUT 1,15
   40 C$=CHR$(158)
   50 C1$=CHR$(145)
   60 C2$=CHR$(144)
   70 C3$=CHR$(191)
   80 C4$=CHR$(142)
   90 C5$=CHR$(255)
  100 C6$=CHR$(190)
  110 C7$=CHR$(143)
  120 PRINT "    A U T O R E N N E N"
  130 PRINT:PRINT "    SPIELPLAN"
  140 PRINT:PRINT "Ziel des Spieles ist es, mit"
  150 PRINT "eiem Auto eine Kurvenreiche"
  160 PRINT "Strasse zu durchfahren. Das"
  170 PRINT "Auto wird mit dem Spielhebel"
  180 PRINT "gesteuert."
  190 PRINT:PRINT "     ro  ru -> 1*RECHTS"
  200 PRINT "          r -> 2*RECHTS"
  210 PRINT:PRINT "     lo  lu -> 1*LINKS"
  220 PRINT "          l -> 2*LINKS"
  230 PRINT:PRINT "Kommt das Auto von der Strasse"
  240 PRINT "ab,wird ein Sarg gebaut.Ist der"
  250 PRINT "Sarg vollstaendig fertig, ist"
  260 PRINT "das Spiel beendet."
  270 PRINT "Wird das Ziel erreicht, giebt's"
  280 PRINT "100 Punkte dazu."
  290 PRINT:PRINT "ACHTUNG DAS SPIEL WIRD MIT"
  300 PRINT "SPIELHEBEL 1 NACH practic 1/88"
  310 PRINT "GESTEUERT ! !":PRINT:PRINT
  320 PRINT "Weiter? Druecke die ENTER Taste" 
  330 IF INKEY$="" THEN 330
  340 CLS
  350 PRINT "      A U T O R E N N E N"
  360 PRINT:PRINT:PRINT:INPUT "Anzahl der Mitspieler";MS
  370 IF MS<1 OR MS>20 THEN 340
  380 VZ=1
  390 PRINT:PRINT:PRINT "Mit welcher Geschwindigkeit soll"
  400 PRINT "gefahren werden ?":PRINT
  410 PRINT "     100 km/h = 1"
  420 PRINT "      75 km/h = 2"
  430 PRINT "      50 km/h = 3"
  440 PRINT "      25 km/h = 4"
  450 PRINT "      10 km/h = 5":PRINT
  460 INPUT "Eingabe der Kennzahl";KZ
  470 IF KZ<1 OR KZ>5 THEN CLS:GOTO 390
  480 ON KZ GOTO 530,520,510,500,490
  490 VZ=VZ+15
  500 VZ=VZ+25
  510 VZ=VZ+25
  520 VZ=VZ+25
  530 VZ=VZ
  540 DIM PY(20)
  550 FOR NS=1 TO MS
  560 SA=0:B=0:C=0
  570 CLS
  580 E=100
  590 GOTO 710
  600 POKE A-32,199
  605 OUT 0,32
  610 U=INP(0)
  620 IF U=45 THEN A=A+2
  630 IF U=37 OR U=41 THEN A=A+1
  640 IF U=46 THEN A=A-2
  650 IF U=42 OR U=38 THEN A=A-1
  660 F=PEEK(A)
  670 IF F=42 OR F=32 THEN B=B+.3:G=INT(B):GOSUB 1260
  680 POKE A,206
  690 C=C+1
  700 RETURN
  710 B$(1)=""
  720 B$(2)=""
  730 B$(3)=""
  740 B$(4)=""
  750 B$(5)=""
  760 B$(6)=""
  770 B$(7)=""
  780 B$(8)=""
  790 B$(9)=""
  800 WINDOW 5,20,1,31
  810 X1=12
  820 FOR I=1 TO 2
  830 PRINT TAB(X1);"**";B$(1);"**"
  840 NEXT I
  850 PRINT TAB(8);""
  860 PRINT TAB(8);"   S T A R T   "
  870 PRINT TAB(8);""
  880 FOR I=1 TO 6
  890 PRINT TAB(8);"   **";B$(1);"**   "
  900 NEXT I
  910 FOR I=1 TO 3
  920 PRINT TAB(X1);"**";B$(1);"**"
  930 NEXT I
  940 A=-4623
  950 POKE A,206
  960 PRINT AT(1,6);"A U T O R E N N E N"
  970 PRINT AT(3,1);"Anzahl der Mitspieler :",MS 
  980 PRINT AT(4,1);"Spielernummer         :",NS
  990 VA=101-VZ
 1000 PRINT AT(21,1);"Geschwindigkeit     :",VA,"km/h"
 1010 PRINT AT(30,0);"Start ? Druck auf Aktionstaste"
 1020 OUT 0,32:IF INP(0)<>32 THEN 1020
 1030 PRINT AT(30,0);"                                "
 1040 XX=INT(RND(4)*6)+10
 1050 X=INT(RND(XX)*10)
 1060 FOR I=1 TO XX
 1070!PRINTAT(0,1);B:PRINTAT(0,10);C
 1080 E=E+2
 1090 D=INT(E/100)
 1100 IF D>9 THEN 1510
 1110 B$=B$(D)
 1120 ON X GOTO 1130,1130,1150,1150,1150,1150,1170,1170,1170
 1130 X1=X1
 1140 GOTO 1180
 1150 X1=X1+1
 1160 GOTO 1180
 1170 X1=X1-1
 1180 IF X1<2 THEN X=5
 1190 IF X1>15 THEN X=9
 1200 GOSUB 600
 1210 FOR VE=1 TO VZ:NEXT VE
 1220 PRINT TAB(X1);"**";B$;"**"
 1230 NEXT I
 1240 IF SA=1 THEN 1480
 1250 GOTO 1040
 1260 ON B GOTO 1280,1300,1320,1340,1360,1380,1400,1420,1440
 1270! SARG
 1280 PRINT AT(31,21);C$,C$,C$,C$,C$,C$,C$
 1290 RETURN
 1300 PRINT AT(30,20);C1$
 1310 RETURN
 1320 PRINT AT(30,28);C2$
 1330 RETURN
 1340 PRINT AT(30,20);C3$,C5$,C5$,C5$,C5$,C5$,C5$,C5$,C4$
 1350 RETURN
 1360 PRINT AT(29,20);C2$
 1370 RETURN
 1380 PRINT AT(29,28);C1$
 1390 RETURN
 1400 PRINT AT(29,20);C6$,C5$,C5$,C5$,C5$,C5$,C5$,C5$,C7$
 1410 RETURN
 1420 PRINT AT(28,26);""
 1430 RETURN
 1440 PRINT AT(27,26);""
 1450 I=XX
 1460 SA=1
 1470 RETURN
 1480 WINDOW
 1490 PS=0
 1500 GOTO 1730
 1510 IF X1<12 THEN J=1:GOTO 1530
 1520 J=2
 1530 ON J GOTO 1540,1560
 1540 X1=X1+1
 1550 GOTO 1570
 1560 X1=X1-1
 1570 GOSUB 600
 1580 PRINT TAB(X1);"**";B$;"**"
 1590 IF X1<>12 THEN 1530
 1600 IF C<460 THEN 1570
 1610 GOSUB 600
 1620 PRINT TAB(6);""
 1630 GOSUB 600
 1640 PRINT TAB(6);"   Z I E L   "
 1650 GOSUB 600
 1660 PRINT TAB(6);""
 1670 GOSUB 600
 1680 PRINT TAB(6);"     ****    "
 1690 GOSUB 600
 1700 PRINT TAB(6);"     ****    "
 1710 WINDOW
 1720 PS=100
 1730 PRINT AT(21,0);"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
 1740 PY(NS)=INT(C/B)+PS
 1750 PRINT AT(23,1);"Sie haben ",PY(NS)," Punkte !!"
 1760 PRINT AT(25,0);"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
 1770 PRINT AT(27,0);"Bitte 10s warten !"
 1780 PAUSE 100
 1790 NEXT NS
 1800 CLS
 1810 PRINT:PRINT:PRINT "  A U S W E R T U N G"
 1820 FOR I=1 TO MS
 1830 PRINT "Spieler ";I;" hat ";PY(I);"erreicht"
 1840 NEXT I
 1850 PAUSE 200
 1860 CLS
 1870 END
