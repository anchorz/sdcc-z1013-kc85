Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10!***************************
   20!*                         *
   30!* PRAEZISIONSWIDERSTAENDE *
   40!*                         *
   50!***************************
   60!
   70! SCHUETZ,GREIFSWALD
   80!
   90 WINDOW :CLS
  100 WINDOW 9,31,0,31
  110 PRINT AT(0,0);STRING$(32,"=")
  120 PRINT AT(2,8);"Berechnung von"
  130 PRINT AT(4,4);"Praezisionswiderstaenden"
  140 PRINT AT(6,0);STRING$(32,"=")
  150!
  160!  Initialisierung
  170!
  180 DIM NW(96),VNW(96)
  190 DIM PL(8),RI(8),RJ(8),ZW(8)
  200 FOR I=0 TO 95               :   NW(I)=INT(100*10^(I/96)+0.5):   NEXT I
  210 GOTO 1120
  220!
  230!Berechnen des benoetigten  :   !       Normwertes
  240!
  250 POT=0.001
  260 IF POT<=REST/10 THEN        :   POT=POT*10  :GOTO 260
  270 J=0
  280 IF VNW(J)*POT<REST THEN     :   J=J+1 : GOSUB 350: GOTO 280
  290 OBW=VNW(J)*POT  : J=J-1
  300 IF J<0 THEN                 :   J=E-1 :POT=POT/10
  310 UNW=VNW(J)*POT
  320 RETURN
  330!
  340!
  350 IF J=E THEN                 :   POT=POT*10 :J=0
  360 RETURN
  370!
  380!    Messwert-Eingabe
  390!
  400 PRINT: PRINT: PRINT             "Rechenwert   R";I;"=       ";
  410 Y=RI(I) :GOSUB 500:          :   PRINT X;X$: X$="": PRINT
  420 INPUT "Messwert :  ";X$
  430 IF X$="" THEN MW=ZW(I) :ELSE:   GOSUB 570:     ZW(I)=X  :MW=X
  440 Y=MW :GOSUB 500
  450 PRINT AT(11+I,0);STRING$(19," "):PRINT AT(11+I,0);"R",I,"=",X,X$
  460 RETURN
  470!
  480!   Umwandlung d. Wid.
  490!
  500 IF Y<1E3  THEN              :   X =Y/1E0 :X$="Ohm"  :RETURN
  510 IF Y<1E6  THEN              :   X =Y/1E3 :X$="kOhm" :RETURN
  520 IF Y<1E9  THEN              :   X =Y/1E6 :X$="MOhm" :RETURN
  530 X =Y/1E9 :X$="GOhm" :RETURN
  540!
  550!   Umwandlung d. Eingabe
  560!
  570 X=VAL(X$)
  580 IF INSTR("K",X$)<>0 THEN    :   X=X*1E3          :RETURN
  590 IF INSTR("k",X$)<>0 THEN    :   X=X*1E3          :RETURN
  600 IF INSTR("M",X$)<>0 THEN    :   X=X*1E6          :RETURN
  610 IF INSTR("G",X$)<>0 THEN    :   X=X*1E9
  620 RETURN
  630!
  640!
  650 IF RJ(I)<0 THEN             :   RGES=1/(1/RGES+1/ABS(RJ(I))):   RETURN
  660 RGES=RGES+RJ(I)             :   RETURN
  670!
  680!     Eingabeschleife
  690!
  700 IF INKEY$<>"" THEN 700
  710 X$=INKEY$                   :   IF     X$ ="" THEN 710
  720 RETURN
  730!
  740!     Grafik
  750!
  760 PRINT AT(24,0);""
  770 PRINT AT(29,0);""
  780 PRINT AT(31,0);"R"
  790 X=TYP :Z=2 :W=1
  800 Y=1+2*(X/2-INT(X/2))
  810 X=INT(X/2)
  820 PRINT AT(31,Z-1);W   :W=W+1
  830 ON Y GOSUB 880,920
  840 IF X>0 THEN 800
  850 PRINT AT(24,Z-2);" "
  860 PRINT AT(29,Z-2);" "
  870 RETURN
  880 PRINT AT(24,Z);""
  890 PRINT AT(29,Z);""
  900 Z=Z+3
  910 RETURN
  920 PRINT AT(24,Z);""
  930 PRINT AT(25,Z);""
  940 PRINT AT(26,Z);""
  950 PRINT AT(27,Z);""
  960 PRINT AT(28,Z);""
  970 PRINT AT(29,Z);""
  980 Z=Z+2
  990 RETURN
 1000!
 1010!
 1020 DOKE 27,-4384 :DOKE 29,-4096:   POKE 35,32    :CALL*F50B    :   RETURN
 1030!
 1040!
 1050 PRINT: PRINT "Neue Berech- nung ((J)/N) ";
 1060 GOSUB 700
 1070 IF X$="N" THEN :WINDOW :END
 1080 TYP=T1:   E=E1
 1090 PRINT :PRINT :PRINT             "Die alten    Werte ((J)/N)";
 1100 GOSUB 700
 1110 IF X$<>"N" THEN            :    GOSUB 760: GOTO 1330
 1120 FOR I=0 TO 8 :ZW(I)=0 :NEXT
 1130 WINDOW 9,31,0,31 :CLS       :   WINDOW 9,22,0,31
 1140 PRINT "Normreihe :" :PRINT
 1150 PRINT " * E6  ........ 1"
 1160 PRINT " * E12 ........ 2"
 1170 PRINT " * E24 ........ 3"
 1180 PRINT " * E48 ........ 4"
 1190 PRINT " * E96 ........ 5"
 1200 GOSUB 700: X=VAL(X$) :X$="" :    IF X<1 OR X>5 THEN 1200
 1210 E=2^X*3 :E1=E :PRINT
 1220 PRINT AT(9,13);"E",E
 1230 INPUT "Zielwert (Ohm):";X$
 1240 IF X$="" THEN WID=W1 :ELSE :    GOSUB 570: WID=X :W1=X
 1250 PRINT
 1260 INPUT "Toleranz ( % ):";TLR
 1270 PRINT
 1280 INPUT "Netzwerktyp   :";TYP:    T1=TYP
 1290 IF TYP<1 OR TYP>63 THEN 1280
 1300 GOSUB 760
 1310 PRINT :PRINT "In Ordnung ((J)/N) ?";: GOSUB 700: PRINT
 1320 IF X$="N" THEN             :    GOSUB 1020: GOTO 1270
 1330 J=0
 1340 FOR I=0 TO 95 STEP 96/E    :    VNW(J)=NW(I)/100 :J=J+1    :    NEXT I
 1350 CLS :WINDOW 9,31,19,31
 1360 PRINT AT( 9,0);"Stueckliste":   PRINT AT(10,0);"-----------"
 1370 REST=WID :I=0
 1380 IF WID*TLR/100>=REST THEN  :    GOTO 1690
 1390 I=I+1
 1400 PAR=TYP/2-INT(TYP/2)       :    TYP=INT(TYP/2)
 1410 IF TYP =0 THEN 1540
 1420 IF PAR<>0 THEN 1480
 1430 GOSUB 250
 1440 RI(I)=UNW
 1450 GOSUB 400
 1460 IF MW>=REST THEN :PRINT    :    PRINT "Widerstand   zu gross":   GOTO 1440
 1470 RI(I)=MW   :REST=REST-RI(I):    RJ(I)=RI(I):GOTO 1380
 1480 GOSUB 250
 1490 RI(I)=OBW  :GOSUB 400
 1500 IF MW<=REST THEN :PRINT    :    PRINT "Widerstand   zu klein":   GOTO 1490
 1510 RI(I)=MW :X=1/REST-1/RI(I) :    IF X=0 THEN 1690
 1520 REST=1/X
 1530 RJ(I)=-RI(I)     :GOTO 1380
 1540 GOSUB 250
 1550 IF OBW-REST<REST-UNW THEN  :    RI(I)=OBW        :   ELSE  :    RI(I)=UN
 1560 GOSUB 400
 1570 RI(I)=MW   :RGES=RI(I)
 1580 IF I-1>0 THEN  I=I-1       :    GOSUB 650: GOTO 1580
 1590 CLS
 1600 PRINT "Rsoll      :";      :    Y=WID :GOSUB 500: PRINT X;X$:    PRINT
 1610 PRINT "Rist       :";      :    Y=RGES:GOSUB 500: PRINT X;X$:    PRINT
 1620 ABF=RGES-WID               :    PRINT "Abs. Fehler: ";
 1630 Y=ABF :GOSUB 500: PRINT X;X$:    PRINT
 1640 REL=(RGES/WID-1)*100       :    PRINT "Rel. Fehler: ";
 1650 PRINT STR$(REL); "%"       :    PRINT
 1660 IF ABS(REL)<TLR THEN PRINT      "Toleranz     eingehalten" :    GOTO 1050
 1670 PRINT "Ausserhalb   der Toleranz" :PRINT
 1680 GOTO 1050
 1690 PRINT :PRINT "Genauigkeit bereits erreicht"
 1700 PRINT :PRINT "Evt. einfachere NW ueberpruefen!"
 1710 PRINT :PAUSE 30 :GOTO 1570
