Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 RESTORE 4300
   20 WINDOW:CLS
   30 FOR I=4 TO 18:READ HH$
   40 FOR J=31 TO 0 STEP-1
   50 PRINT AT(I,J);MID$(HH$,J+1,1) 
   60 NEXT J,I:PAUSE 100
   70 CLS 
   80 FOR I=3 TO 30 STEP 3
   90 READ HH$
  100 FOR J=0 TO 15
  110 PRINT AT(I,J*2+1);MID$(HH$,J+1,1)
  120 NEXT J,I
  130 PAUSE 100
  140 RESTORE
  150 DIM M(10,13),S(5,4),D1(5),S1(5)
  160 DATA 1,"ATAIR STARWAYS"
  170 DATA 2,"BETEIGEUZE UNLTD."
  180 DATA 3,"CAPELLA FREIGHT CO."
  190 DATA 4,"DENEB SHIPPERS INC."
  200 DATA 5,"ERIDIANI EXPEDITERS"
  210 CLS
  220 FOR I=1 TO 5
  230 S1(I)=100:KO(I)=6000
  240 NEXT I
  250 L$=" +*ABCDE" 
  260 M$="ABCDEFGHIJKL"
  270 PRINT:PRINT:PRINT " * * S T A R  T R A D E R S * *":PRINT:PRINT:PRINT
  280 PRINT "Benoetigt jemand Spielregeln ":PRINT:PRINT
  290 X$(1)=INKEY$:IF X$(1)="N" OR X$(1)="n"THEN PAUSE 2:GOTO 310
  300 IF X$(1)<>"J"AND X$(1)<>"j"THEN 290:ELSE GOSUB 3730
  310 PRINT "Anzahl der Spielzuege (<=50 ) ";:INPUT " ";KM:PRINT:PRINT
  320 IF KM>50 THEN PRINT "Bitte noch  eimal !":ELSE 340
  330 PRINT:GOTO 310
  340 PRINT "Geben Sie eine 3-stellige       Zahl ein !";:INPUT R1:PRINT
  350 R1=RND(-R1/1000)
  360 FOR I=1 TO 9
  370 FOR J=1 TO 12
  380 IF INT(20*RND(R1)+1)<>10 THEN M(I,J)=1:ELSE M(I,J)=3
  390 NEXT J
  400 NEXT I
  410 PRINT "Wieviel Spieler (2-4) ";:INPUT P1:PRINT
  420 IF P1>4 THEN PRINT "Bitte noch einmal !":ELSE 440
  430 PRINT:GOTO 410
  440 FOR I=1 TO P1
  450 PRINT "Spieler";I;"wie heissen Sie ":PRINT:INPUT P$:P$=MID$(P$,1,14)
  460 PRINT
  470 IF I=1 THEN P1$=P$
  480 IF I=2 THEN P2$=P$
  490 IF I=3 THEN P3$=P$
  500 IF I=4 THEN P4$=P$
  510 NEXT I
  520 PRINT:PRINT "Ich entscheide jetzt,           wer anfaengt !"
  530 PRINT
  540 I=INT(10*RND(R1)+1):IF I>P1 THEN 540
  550 GOSUB 570
  560 GOTO 620
  570 ON I GOTO 580,590,600,610
  580 PRINT P1$:P5$=P1$:RETURN
  590 PRINT P2$:P5$=P2$:RETURN
  600 PRINT P3$:P5$=P3$:RETURN
  610 PRINT P4$:P5$=P4$:RETURN
  620 PRINT:PRINT "faengt an !"
  630 PAUSE 30:CLS
  640 K=0
  650 P=I:GOTO 680
  660 K=K+1:IF K>KM THEN 3270
  670 P=P+1:IF P>P1 THEN P=1
  680 FOR I=1 TO 5
  690 ZE(I)=INT(9*RND(R1)+1)
  700 SP(I)=INT(12*RND(R1)+1)
  710 I1=I-1
  720 IF ZE(I)=R(I1)AND SP(I)=C(I1)THEN 690
  730 I1=I1-1:IF I1>=0 THEN 720
  740 IF M(ZE(I),SP(I))>1 THEN 690
  750 I1=1
  760 IF Q(I1)=0 THEN 940
  770 I1=I1+1:IF I1<=5 THEN 760
  780 IF M(ZE(I),SP(I)+1)>3 THEN 940
  790 IF M(ZE(I),SP(I)-1)>3 THEN 940
  800 IF M(ZE(I)+1,SP(I))>3 THEN 940
  810 IF M(ZE(I)-1,SP(I))>3 THEN 940
  820 A1=M(ZE(I),SP(I)+1)
  830 A2=M(ZE(I),SP(I)-1)
  840 A3=M(ZE(I)+1,SP(I))
  850 A4=M(ZE(I)-1,SP(I))
  860 IF A1=2 AND A2<4 AND A3<4 AND A4<4 THEN 690
  870 IF A2=2 AND A1<4 AND A3<4 AND A4<4 THEN 690
  880 IF A3=2 AND A1<4 AND A2<4 AND A4<4 THEN 690
  890 IF A4=2 AND A1<4 AND A2<4 AND A3<4 THEN 690
  900 IF A1=3 AND A2<4 AND A3<4 AND A4<4 THEN 690
  910 IF A2=3 AND A1<4 AND A3<4 AND A4<4 THEN 690
  920 IF A3=3 AND A1<4 AND A2<4 AND A4<4 THEN 690
  930 IF A4=3 AND A1<4 AND A2<4 AND A3<4 THEN 690
  940 NEXT I
  950 I=INT(10*RND(R1)+1):IF I>5 THEN 950
  960 A=I
  970 IF RND(1)>.95 AND Q(I)<>0 THEN 1010
  980 I=I+1:IF I>5 THEN I=1
  990 IF I=A THEN 1030:ELSE 970
 1000 GOTO 1030
 1010 GOSUB 3250
 1020 GOSUB 3430
 1030 GOSUB 2050
 1040 IF K>0 THEN GOSUB 3130
 1050 I=P
 1060 WINDOW 0,15,17,31:CLS:PRINT "Zug NR.:";K+1:PRINT:GOSUB 570:PRINT
 1070 PRINT "Erlaubte Zuege "
 1080 FOR I=1 TO 5
 1090 X$=STR$(ZE(I))+MID$(M$,SP(I),1)
 1100 PRINT;X$;",";
 1110 NEXT I:PRINT
 1120 PRINT:PRINT "Wie lautet ihr Zug ";:INPUT R$:PRINT
 1130 IF LEN(R$)=0 THEN 1050
 1140 IF LEN(R$)<>2 THEN 1170
 1150 IF ASC(MID$(R$,2,1))-64<1 THEN 1170
 1160 IF ASC(MID$(R$,2,1))-64>12 THEN 1170:ELSE 1190
 1170 PRINT "Das verstehe   ich nicht        "
 1180 PRINT "Bitte noch     einmal         ":PAUSE 15:GOTO 1060
 1190 R=VAL(LEFT$(R$,1))
 1200 C=ASC(RIGHT$(R$,1))-64
 1210 I=1
 1220 IF R=ZE(I)AND C=SP(I)THEN 1260
 1230 I=I+1:IF I<=5 THEN 1220
 1240 PRINT "Ungueltiger Zug"
 1250 GOTO 1120
 1260 A1=M(R-1,C)
 1270 A2=M(R+1,C)
 1280 A3=M(R,C+1)
 1290 A4=M(R,C-1)
 1300 IF A1<=1 AND A2<=1 AND A3<=1 AND A4<=1 THEN M(R,C)=2:ELSE 1320
 1310 GOTO 1810
 1320 IF A1>3 AND A2>3 AND A2<>A1 THEN GOSUB 2200
 1330 IF A1>3 AND A3>3 AND A3<>A1 THEN GOSUB 2200
 1340 IF A1>3 AND A4>3 AND A4<>A1 THEN GOSUB 2200
 1350 IF A2>3 AND A3>3 AND A3<>A2 THEN GOSUB 2200
 1360 IF A2>3 AND A4>3 AND A4<>A2 THEN GOSUB 2200
 1370 IF A3>3 AND A4>3 AND A4<>A3 THEN GOSUB 2200
 1380 IF A1<4 AND A2<4 AND A3<4 AND A4<4 THEN 1470
 1390 IF A1>3 THEN I=A1-3
 1400 IF A2>3 THEN I=A2-3
 1410 IF A3>3 THEN I=A3-3
 1420 IF A4>3 THEN I=A4-3
 1430 Q(I)=Q(I)+1
 1440 S1(I)=S1(I)+100
 1450 M(R,C)=I+3
 1460 GOTO 1620
 1470 I=1
 1480 IF Q(I)=0 THEN 1520
 1490 I=I+1:IF I<=5 THEN 1480
 1500 IF M(R,C)<3 THEN M(R,C)=2
 1510 GOTO 1810
 1520 GOSUB 3250
 1530 PRINT "Eine neue Ge-  sellschaft ist":PRINT "gegruendet     worden!":
 1540 PRINT "Sie heisst :"
 1550 RESTORE
 1560 READ N,C$
 1570 IF I<>N THEN 1560
 1580 PRINT LEFT$(C$,14)
 1590 S(I,P)=S(I,P)+5
 1600 Q(I)=1
 1610 PRINT:PAUSE 30
 1620 IF A1=3 THEN S1(I)=S1(I)+500
 1630 IF A2=3 THEN S1(I)=S1(I)+500
 1640 IF A3=3 THEN S1(I)=S1(I)+500
 1650 IF A4=3 THEN S1(I)=S1(I)+500
 1660 IF A1=2 THEN S1(I)=S1(I)+100:ELSE 1690
 1670 Q(I)=Q(I)+1
 1680 M((R-1),C)=I+3
 1690 IF A2=2 THEN S1(I)=S1(I)+100:ELSE 1720
 1700 Q(I)=Q(I)+1
 1710 M(R+1,C)=I+3
 1720 IF A3=2 THEN S1(I)=S1(I)+100:ELSE 1750
 1730 Q(I)=Q(I)+1
 1740 M(R,C+1)=I+3
 1750 IF A4=2 THEN S1(I)=S1(I)+100:ELSE 1780
 1760 Q(I)=Q(I)+1
 1770 M(R,C-1)=I+3
 1780 IF S1(I)>=3000 THEN T1=I:ELSE 1800
 1790 GOSUB 3020
 1800 M(R,C)=I+3
 1810 FOR I=1 TO 5
 1820 KO(P)=KO(P)+INT(.05*S(I,P)*S1(I))
 1830 NEXT I
 1840 FOR I=1 TO 5
 1850 IF Q(I)=0 THEN 2030:ELSE GOSUB 3130
 1860 WINDOW 0,15,17,31:CLS:PRINT "Ihr Kontostand":PRINT;KO(P)
 1870 PRINT "Wie viele      Aktien von"
 1880 RESTORE
 1890 READ N,C$
 1900 IF I<>N THEN 1890
 1910 PRINT LEFT$(C$,14) 
 1920 PRINT "wollen Sie     handeln ?"
 1930 X1=INT(KO(P)/S1(I))
 1940 PRINT "Sie haben";S(I,P):PRINT "Sie koennen    maximal";X1
 1950 PRINT "kaufen ";:R3=0:INPUT R3
 1960 IF R3*S1(I)<=KO(P)THEN 2000
 1970 PRINT "Sie haben nur (DM)":PRINT KO(P)
 1980 PRINT "Bitte nocheinmal !"
 1990 PAUSE 10:GOTO 1870
 2000 IF R3=0 THEN 2030
 2010 S(I,P)=S(I,P)+R3
 2020 KO(P)=KO(P)-(R3*S1(I))
 2030 NEXT I
 2040 GOTO 660
 2050 WINDOW 0,15,0,16
 2060 PRINT "  STERNENKARTE":PRINT
 2070 PRINT "  ABCDEFGHIJKL":PRINT
 2080 X$="123456789"
 2090 FOR R2=1 TO 9
 2100 PRINT MID$(X$,R2,1);" ";
 2110 FOR C2=1 TO 12
 2120 Z2=M(R2,C2)
 2130 IF Z2=0 THEN Z2=Z2+1
 2140 PRINT MID$(L$,Z2,1);
 2150 NEXT C2
 2160 PRINT " ";MID$(X$,R2,1)
 2170 NEXT R2
 2180 PRINT:PRINT "  ABCDEFGHIJKL"
 2190 RETURN
 2200 REM
 2210 F1=A1-3:IF F1<0 THEN F1=0
 2220 F2=A2-3:IF F2<0 THEN F2=0
 2230 F3=A3-3:IF F3<0 THEN F3=0
 2240 F4=A4-3:IF F4<0 THEN F4=0
 2250 T=Q(F1)
 2260 T1=F1
 2270 IF Q(F2)>Q(F1)THEN T=Q(F2):ELSE 2290
 2280 T1=F2
 2290 IF Q(F3)>T THEN T=Q(F3):ELSE 2310
 2300 T1=F3
 2310 IF Q(F4)>T THEN T=Q(F4):ELSE 2330
 2320 T1=F4
 2330 IF F1=T1 OR A1<4 THEN 2360
 2340 X=F1
 2350 GOSUB 2460
 2360 IF F2=T1 OR A2<4 THEN 2390
 2370 X=F2
 2380 GOSUB 2460
 2390 IF F3=T1 OR A3<4 THEN 2420
 2400 X=F3
 2410 GOSUB 2460
 2420 IF F4=T1 OR A4<4 THEN 2450
 2430 X=F4
 2440 GOSUB 2460
 2450 RETURN
 2460 GOSUB 3250
 2470 RESTORE 160
 2480 READ N,C$
 2490 IF X<>N THEN 2480
 2500 C1$=C$:PRINT:PRINT LEFT$(C1$,14):PRINT "ist aufgeloest"
 2510 PRINT "worden in :":RESTORE 160
 2520 READ N,C$
 2530 IF T1<>N THEN 2520
 2540 C2$=C$:PRINT LEFT$(C2$,14):PAUSE 15:WINDOW 16,31,0,31:CLS
 2550 PRINT "Bitte beachten Sie              die Tranaktionen !"
 2560 PRINT:PRINT "Spieler                         Alter  Neuer  Gesamtbe- Gut-
 2570 PRINT      "Anteil Anteil teiligung schrift"
 2580 FOR I=1 TO P1
 2590 ZW=0
 2600 GOSUB 570
 2610 ZW=S(X,I):ZW=ZW/2:ZW=ZW+.5:ZW=INT(ZW)
 2620 PRINT TAB(0);S(X,I);TAB(7);ZW;TAB(16);S(T1,I)+ZW;
 2630 X1=0
 2640 FOR I1=1 TO P1
 2650 X1=X1+S(X,I1)
 2660 NEXT I1
 2670 IF X1=0 THEN 2690
 2680 PRINT TAB(24);INT(10*((S(X,I)/X1)*S1(X)))
 2690 NEXT I
 2700 FOR I=1 TO P1
 2710 S(T1,I)=S(T1,I)+INT((.5*S(X,I))+.5)
 2720 IF X1=0 THEN 2740
 2730 KO(I)=KO(I)+INT(10*((S(X,I)/X1)*S1(X)))
 2740 NEXT I
 2750 FOR I=1 TO 9
 2760 FOR J=1 TO 12
 2770 IF M(I,J)=X+3 THEN M(I,J)=T1+3
 2780 NEXT J
 2790 NEXT I
 2800 A1=M(R-1,C)
 2810 A2=M(R+1,C)
 2820 A3=M(R,C+1)
 2830 A4=M(R,C-1)
 2840 F1=A1-3
 2850 IF F1<0 THEN F1=0
 2860 F2=A2-3
 2870 IF F2<0 THEN F2=0
 2880 Q(T1)=Q(T1)+Q(X)
 2890 S1(T1)=S1(T1)+S1(X)
 2900 IF S1(T1)>=3000 THEN GOSUB 3020
 2910 F3=A3-1
 2920 IF F3<0 THEN F3=0
 2930 F4=A4-3
 2940 IF F4<0 THEN F4=0
 2950 S1(X)=100
 2960 Q(X)=0
 2970 FOR I=1 TO P1
 2980 S(X,I)=0
 2990 NEXT I
 3000 M(R,C)=T1+3
 3010 PAUSE 100:RETURN
 3020 GOSUB 3250
 3030 PRINT "Das Kapital von":PRINT:RESTORE
 3040 READ N,C$
 3050 IF T1<>N THEN 3040
 3060 PRINT C$:PRINT:PRINT "ist im Ver-    haeltnis 2:1 "
 3070 PRINT "geteilt worden":PRINT
 3080 S1(T1)=INT(S1(T1)/2):PAUSE 80
 3090 FOR I1=1 TO P1
 3100 S(T1,I1)=2*S(T1,I1)
 3110 NEXT I1
 3120 RETURN
 3130 WINDOW 16,31,0,31:CLS
 3140 PRINT "GESELLSCHAFT                    PREIS JE AKTIE IHRE ANTEILE":PRINT
 3150 FOR I3=1 TO 5
 3160 IF S1(I3)=100 THEN 3220
 3170 RESTORE
 3180 READ N,C$
 3190 IF I3<>N THEN 3180
 3200 PRINT C$:PRINT SPC(14-LEN(STR$(S1(I3))));S1(I3);
 3210 PRINT SPC(12-LEN(STR$(S(I3,P))));S(I3,P):PRINT
 3220 NEXT I3
 3230 RESTORE
 3240 RETURN
 3250 WINDOW 0,15,17,31:CLS
 3260 PRINT "SONDERMELDUNG":PRINT:RETURN
 3270 WINDOW:CLS:PRINT "Das Spiel ist vorbei- Hier das  Ergebnis":PRINT:PRINT
 3280 PRINT "Spieler                         Werte in     Bargeld  Gesamtwert";
 3290 PRINT "Aktien   "
 3300 FOR I=1 TO P1
 3310 FOR J=1 TO 5
 3320 D1(I)=D1(I)+(S1(J)*S(J,I))
 3330 NEXT J
 3340 NEXT I
 3350 PRINT
 3360 FOR I=1 TO P1
 3370 GOSUB 570
 3380 HH$=MID$(STR$(D1(I)),2,11):PRINT SPC(11-LEN(HH$));HH$;
 3390 HH$=MID$(STR$(KO(I)),2,11):PRINT SPC(10-LEN(HH$));HH$;
 3400 HH$=MID$(STR$(KO(I)+D1(I)),2,11):PRINT SPC(11-LEN(HH$));HH$
 3410 NEXT I
 3420 PRINT:PRINT:GOTO 4730
 3430 WINDOW 16,31,0,31:CLS:RESTORE
 3440 READ N,C$
 3450 IF I<>N THEN 3440
 3460 PRINT "Wie uns soeben von der Nach-    richtenagentur REUTER STAR NEWS"
 3470 PRINT "gemeldet wird,ist der groesste  Teil der Handelsflotte"
 3480 PRINT
 3490 PRINT "VON ";C$:PRINT:RU=RND(1)
 3500 IF RU<=.33 THEN RESTORE 3700
 3510 IF RU>.33 AND RU<=.66 THEN RESTORE 3710
 3520 IF RU>.66 THEN RESTORE 3720
 3530 READ HI$,HH$:PRINT HI$:PRINT HH$;:PAUSE 100
 3540 CLS:PRINT "Die Boerse reagiert mit         empfindlichen Kursschwankungen
 3550 PRINT:PRINT "Wir veroeffentlichen die augen- blicklichen Notierungen !"
 3560 PAUSE 150
 3570 S1(I)=INT(S1(I)/4)
 3580 FOR J=1 TO 5
 3590 IF J<>I AND Q(J)<>0 THEN S1(J)=S1(J)+INT(100*RND(R1))
 3600 NEXT J
 3610 CLS:PRINT "   Der'BOERSENKURIER'meldet":PRINT
 3620 PRINT "Gesellschaft        Aktienkurs";:RESTORE
 3630 FOR J=1 TO 5
 3640 READ N,C$
 3650 IF Q(J)=0 THEN 3670
 3660 PRINT:PRINT C$;TAB(20)S1(J);"DM";
 3670 NEXT J
 3680 PAUSE 100
 3690 RETURN
 3700 DATA "Durch einen Meteoritenschwarm","vernichtet worden."
 3710 DATA "Interstellaren Piraten","zum Opfergefallen."
 3720 DATA "In einem intergalaktischen","Kraftfeld verschollen."
 3730 WINDOW 0,31,0,31:OUT 136,4:CLS
 3740 PRINT "STAR TRADERS ist ein Weltraum-  Handels-Spiel.Ziel ist es,"
 3750 PRINT "Moeglichst viel Kapital zu er-  wirtschaften.Dies wird erreicht"
 3760 PRINT "durch das errichten interstella-rer  Handelslinien und durch den";
 3770 PRINT "Ankauf von Aktien der Gesell-  "
 3780 PRINT "schaften,die diese Linien       besitzen. Im Laufe des Spiels"
 3790 PRINT "steigt der Wert der Aktien in   dem Mass,indem die Gesell-"
 3800 PRINT "schaften groesser werden.Kleine Gesellschaften koennen in"
 3810 PRINT "groessere umgewandelt werden,   wodei das Kapital der kleineren" 
 3820 PRINT "Firma in das der groesseren wie nachstehend erlaeutert" 
 3830 PRINT "ueberfuehrt wird."
 3840 PRINT "In jeder Spielrunde bieter der  Computer dem Spieler fuenf"
 3850 PRINT "Plaetze an. Der Spieler ant-    wortet,nachdem er sich auf der"
 3860 PRINT "Sternenkarte angesehen hat,     welchen Platz er wuenscht.Jeder"
 3870 PRINT "Spieler kann dabei einen der    vier grundsaetzlichen Zuege "  
 3880 PRINT "machen:"  
 3890 GOSUB 4280
 3900 PRINT "1.Einen unabhaengigen Aussen-   posten gruenden.Wenn ein Spieler";
 3910 PRINT "einen Platz besetzt,der nicht aneinen Stern,einen anderen "
 3920 PRINT "Aussenposten oder eine Handels- linie grenzt,wird dieser Platz"
 3930 PRINT "mit einem '+' gekennzeichnet.
 3940 PRINT "Der Spieler kann dann weiter    handeln,wie unten beschrieben."
 3950 PRINT:PRINT
 3960 PRINT "2.Eine bestehende Handelslinie  erweitern.Wird ein Platz belegt,";
 3970 PRINT "der an eine einzige Linie grenztso wird dieser Platz in diese"
 3980 PRINT "Linie aufgenommen und und durch den ersten Buchstaben der"
 3990 PRINT "Gesellschaft markiert.Falls Sterne oder Aussenposten diesen"
 4000 PRINT "Platz beruehren,werden sie eden-falls in die Linie aufgenommen."
 4010 PRINT "Jedes Feld neben einem Stern r-hoeht den Marktwert der Gesell-"
 4020 PRINT "schaft um 500.- je Aktie,jeder  Aussenposten bringt wietere  "  
 4030 PRINT "100.- je Aktie.":GOSUB 4280
 4040 PRINT "3.Eine neue Handelslinie        gruenden.Belegt ein Spieler"
 4050 PRINT "einen Platz der an einen Stern"
 4060 PRINT "oder einen unabhaengigen Aussen-posten grenzt,aber keine be-
 4070 PRINT "stehende Linie beruehrt,wird    eine neue Handelslinie eroeffnet";
 4080 PRINT "Der Spieler bekommt automatisch fuenf Aktien der neuen Linie als";
 4090 PRINT "Anerkennung.Er kann dann weiter-hin Aktien aller aktiven Gesell-";
 4100 PRINT "schaften handeln.":PRINT:PRINT
 4110 PRINT "4.Zwei bestehende Gesellschaftenvermischen.Wird ein Platz direkt";
 4120 PRINT "neben bestehende Linien belegt, werden diese vermischt.Dabei "
 4130 PRINT "uebernimmt die groessere die    kleinere Firma.Das kapital"
 4140 PRINT "der vermischten Linie wird im   Wert entsprechend den belegten"
 4150 PRINT "Plaetzen und Sternen neu festge-legt.Die Anteile der Spieler an"
 4160 PRINT "der Aufgeloesten Linie werden imVerhaeltnis 2:1 durch Aktien der";
 4170 PRINT "neuen Linie ersetzt.Weiterhin   bekommt jeder Spieler eine Bar"
 4180 PRINT "verguetung entsprechend der     prozentualen Anteile an der auf"
 4190 PRINT "geloesten Linie.":GOSUB 4280
 4200 PRINT "Der Computer zahlt jedem Spielereine Dividende (5% des Wertes"
 4210 PRINT "der Aktien in seinem Besitz) undermoeglicht den Handel mit"
 4220 PRINT "Aktien aller bestehenden Gesell-schaften.Uebersteigt der Markt-"
 4230 PRINT "Wert einer Aktie 3000.-DM wird  diese im Verhaeltnis 2:1 ge-"
 4240 PRINT "splittet."
 4250 PRINT "Gewinner ist der Spieler mit demgroesstem Geldbestand am Schluss"
 4260 GOSUB 4280
 4270 OUT 136,0:WINDOW:CLS:RETURN
 4280 PRINT AT(31,20);">ENTER<":A$(1)=INKEY$:IF A$(1)<>CHR$(13)THEN 4280
 4290 CLS:RETURN
 4300 DATA "          -- |                 "
 4310 DATA "         /  ---                " 
 4320 DATA "         \-\ | /-| | /         "
 4330 DATA "           / | | | |/          "
 4340 DATA "         --  | \-\ |           "
 4350 DATA "                               "
 4360 DATA "                               "
 4370 DATA "                               "
 4380 DATA "   ---          |              "
 4390 DATA "    |           |              "
 4400 DATA "    | | / /-| /-| /-\ | / /--  "
 4410 DATA "    | |/  | | | | |-/ |/  \-\  "
 4420 DATA "    | |   \-\ \-\ \-/ |   --/  "
 4430 DATA "                               "  
 4440 DATA "   The best of universe games  "
 4450 DATA "Von<<scharsoft>>"  
 4460 DATA "fuer   Z 1013    "
 4470 DATA "                 "
 4480 DATA "Jens Scharsig    "
 4490 DATA "Beethovenstr. 12 "
 4500 DATA "Riesa            "
 4510 DATA "8400             "
 4520 DATA "                 "
 4530 DATA "                 "
 4540 DATA "          C 1988"
 4550 DATA " __           |    |           "
 4560 DATA "/             |    |           "
 4570 DATA "| \ /-\ /-\ /-|    |-\ \ / /-\ "
 4580 DATA "| | | | | | | |    | |  |  |-/ "
 4590 DATA "\-/ \-/ \-/ \-\    |-/  |  \-/ "
 4600 DATA 
 4610 DATA
 4620 DATA "                    /          "
 4630 DATA "        /-- /-| \ /  /--       "
 4640 DATA "        \-\ | |  |   \-\       "
 4650 DATA "        --/ \-\  |   --/       "
 4660 DATA
 4670 DATA
 4680 DATA "       |                   / | "
 4690 DATA "       |                  -----"
 4700 DATA "/-- /- |/\ /-| | / /-- /-\ | | "
 4710 DATA "\-\ |  | | | | |/  \-\ | | | | "
 4720 DATA "--/ \- | | \-\ |   --/ \-/ | | "
 4730 GOSUB 4280
 4740 PRINT AT(15,0);"Nochmal ein Spiel mit"  
 4750 PRINT AT(17,0);"den Aktien ((J)/N) ?"
 4760 HH$=INKEY$:IF HH$="J"OR HH$="j"OR HH$=CHR$(13) THEN 160
 4770 IF HH$<>"N"AND HH$<>"n" THEN 4760
 4780 CLS:RESTORE 4300
 4790 FOR I=10 TO 24:READ HH$
 4800 FOR J=0 TO 31
 4810 PRINT AT(I,J);MID$(HH$,J+1,1)
 4820 NEXT J,I:PAUSE 100
 4830 CLS:RESTORE 4550
 4840 FOR I=5 TO 22:READ HH$
 4850 FOR J=31 TO 0 STEP-1
 4860 PRINT AT(I,J);MID$(HH$,J+1,1)
 4870 NEXT J,I:PAUSE 75:CLS:END
