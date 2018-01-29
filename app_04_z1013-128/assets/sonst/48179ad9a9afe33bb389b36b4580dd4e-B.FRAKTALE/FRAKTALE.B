Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 WINDOW 0,19,0,31:CLS:PRINT "> FRAKTALE 4/88 fuer Z1013 >":PRINT
   20 PRINT AT(5,0);"Erlaeuterung zum Programm J/N ?":PRINT
   30 GOSUB 1030
   40 IF I$="J"THEN 1070
   50 IF I$<>"J"THEN CLS:GOTO 1711
   55 GOTO 1660
   60!ORIGINAL "TEFRA" VON VOELZ; FUER Z 1013 TROG,BERLIN 4/1988
   70 CLEAR:PRINT:PRINT "Berechnungsformeln editieren J/N":PAUSE 10
   80 GOSUB 1030
   90 IF I$="J"THEN WINDOW 20,30,0,31:CLS:EDIT 1720:ELSE WINDOW 23,30,0,31:CLS
  100 DIM B$(300):B$="":WINDOW 10,19,0,31:CLS:B$="":INPUT "Formeln eingeben:";B$
  110 DIM S(1184):WINDOW:CLS
  120 PRINT:PRINT "ENDE   = E"
  130 PRINT:PRINT "WEITER = W"
  140 GOSUB 1030
  160 IF I$="W"THEN 190
  170 IF I$="E"THEN WINDOW:CLS:END
  180 IF I$<>"W"OR I$<>"E"THEN 140
  190 CLS:A=0:B=0:M=0:X=0:Y=0:Q=31:X1=-3:X2=3:Y1=-3:Y2=3
  200 H=0:T=0:U=0:Z=0:G=0:TI=0
  210 PRINT:PRINT "Alle Angaben dezimal:":PRINT
  220 PRINT:INPUT "GRUNDZEICHEN    (H ->  32) =";H:IF H=0 THEN H=32
  230 INPUT "GRAPHIKZEICHEN  (T ab 190) =";T:IF T=0 THEN T=190
  240 INPUT "2.GRAPHIKZEICHEN(U ab 137) =";U:IF U=0 THEN U=137
  250 INPUT "ZYKLEN          (Z ->  10) =";Z:PRINT:IF Z=0 THEN Z=10
  260 INPUT "GRENZWERT       (G ->  10) =";G:PRINT:IF G=0 THEN G=10
  270 PRINT "Wenn X1 u. Y1 = -3  und"
  280 PRINT "     X2 u. Y2 =  3" 
  290 PRINT "sein sollen, dann >ET<, sonst"
  300 PRINT "Werte eingeben !":PRINT
  310 INPUT "X1 , X2   =";X1,X2: XD=(X2-X1)/32: E=.01
  320 INPUT "Y1 , Y2   =";Y1,Y2: YD=(Y2-Y1)/Q: Y=Y2+YD
  330 PRINT:PRINT:INPUT "MIT SIGNALTON ([J=1] --> N )?";P:IF P<>1 THEN P=2
  340 UU=0:PRINT:PRINT:INPUT "Uhrzeit zur Erinnerung: ??.??";UU
  350 WINDOW 0,Q,0,31:CLS
  360 FOR I=0 TO Q-1: X=X1-XD: Y=Y-YD
  370 FOR J=0 TO 31: X=X+XD: A=.5: B=0: C=A: D=B: F=H
  380  FOR N=1 TO Z
  390 GOSUB 1720
  400 D=D+D-Y
  410   IF ABS(C-A)<E AND ABS(D-B)<E THEN F=N+U:N=Z
  420  A=C: B=D: IF ABS(A) + ABS(B) >G THEN F=N+T:N=Z
  430 NEXT
  440 IF F>255 THEN F=42
  450 PRINT CHR$(F);:NEXT:NEXT
  460 WINDOW 31,31,0,31:CLS
  470 PRINT AT(31,0);"> Es war",UU,"Uhr <"
  480 I=1:FOR E=-5120 TO-4129
  490 S(I)=PEEK(E):I=I+1
  500 NEXT
  510 PRINT AT(31,20);">ET<":GOSUB 520:GOTO 870
  520 IF P=2 THEN 530:ELSE 550
  530 GOSUB 1030
  540 IF I$<>CHR$(13)THEN 530:ELSE 560
  550 GOSUB 1050
  560 XX=(X2-X1)/32:YY=(Y2-Y1)/31:AX=INT(10^3*XX+0.5)/10^3
  570 BY=INT(10^3*YY+0.5)/10^3
  580 PRINT AT(5,0);Y2-(6*BY):PRINT AT(10,0);Y2-(11*BY):PRINT AT(20,0);Y2-(21*BY)
  590 PRINT AT(25,0);Y2-(26*BY):PRINT AT(15,0);Y2-(16*BY)
  600 PRINT AT(0,0);"                                ":PRINT AT(0,0);X1
  610 PRINT AT(0,9);X1+(10*AX):PRINT AT(0,19);X1+(20*AX)
  620 PRINT AT(0,25);X1+(26*AX)
  630 RETURN
  640 WINDOW 31,31,0,31:CLS:INPUT "SAVEN=1/NEU=2/LADEN=3/ENDE=4 ";W 
  650 ON W GOTO 660,680,655,680
  655 CLEAR:WINDOW:CLS:GOTO 1711
  660 INPUT "NAME";A$:CSAVE*""+A$;S
  670 CLS:PRINT "**Fertig**   >ET<":GOSUB 1030
  680 WINDOW:CLS:PRINT "H =";H:PRINT "T =";T:PRINT "U =";U
  690 PRINT "Z =";Z:PRINT "G =";G
  700 PRINT "X1=";X1:PRINT "X2=";X2
  710 PRINT "Y1=";Y1:PRINT "Y2=";Y2
  720 PRINT "ZEIT=";TI;"MIN."
  730 PRINT:PRINT B$
  740 PRINT:PRINT ">ET<"
  750 GOSUB 1030
  755 IF W=1 THEN 640:ELSE 760
  760 IF W=2 THEN WINDOW:CLS:GOTO 1670:ELSE 770
  770 IF W=4 THEN 780:ELSE WINDOW:CLS:GOTO 1711
  780 CLEAR:CLS:END
  790 INPUT "NAME";A$:WINDOW:CLS:CLOAD*""+A$;S
  800 CLS
  810 FOR I=1 TO 992:PRINT CHR$(S(I));:NEXT I
  820 PRINT AT(31,10);">ET<":GOSUB 1030
  830 CLS:PRINT "Bildwerte:":PRINT:FOR I=993 TO 1184:PRINT CHR$(S(I));:NEXT
  840 PRINT AT(31,10);">ET<":GOSUB 1030
  850 IF I$=CHR$(13)THEN 640
  860 IF I$<>CHR$(13)THEN 840
  870 GOSUB 1030
  880 WINDOW 31,31,0,31:CLS:INPUT "DAUER?";TI
  890 WINDOW 27,31,0,31:CLS
  900 PRINT "X1=";X1;"X2=";X2
  910 PRINT "Y1=";Y1;"Y2=";Y2
  920 PRINT "H=";H;"T=";T;"U=";U
  930 PRINT "Z=";Z;"G=";G;"Zeit=";TI;"MIN."
  940 I=993:FOR E=-4256 TO-4129
  950 S(I)=PEEK(E):I=I+1
  960 NEXT
  970 CLS:WINDOW 29,31,0,31:CLS:PRINT B$
  980 I=1121:FOR E=-4192 TO-4129
  990 S(I)=PEEK(E):I=I+1
 1000 NEXT E
 1010 CLS:PRINT "    >ET<":GOSUB 1050
 1020 CLS:GOTO 640
 1030 I$=INKEY$:IF I$=""THEN 1030
 1040 RETURN
 1050 I$=INKEY$:IF I$=""THEN BEEP:PAUSE 3:BEEP:BEEP:BEEP:BEEP:PAUSE 5:GOTO 1050
 1060 RETURN
 1070 WINDOW:CLS
 1080 PRINT "Die Bilder werden mit Pseudo-"
 1090 PRINT "graphik gezeichnet. Sie ent-"
 1100 PRINT "stehen durch Iteration.":PRINT
 1110 PRINT "Zu Beginn wird das Editieren"
 1120 PRINT "der Berechnungsformeln ermoeg-"
 1130 PRINT "licht. Weiter mit >ET<."
 1140 PRINT "Neustart mit >RUN<":PRINT
 1150 PRINT "Die Formeln muessen fuer das"
 1160 PRINT "Bildspeichern dann eingegeben"
 1170 PRINT "werden und werden gespeichert.  Sie koennen uebernommen werden." 
 1180 PRINT:PRINT:PRINT ">ENTER<":GOSUB 1030:CLS
 1190 PRINT "Zum Grundmenue:":PRINT
 1200 PRINT "Fuer alle Eingaben sind Werte"
 1210 PRINT "voreingestellt (s.Menue)"
 1220 PRINT "Sollen sie uebernommen werden,"
 1230 PRINT "dann nur >ET<. Sonst Werte "
 1240 PRINT "eingeben.":PRINT
 1250 PRINT "Grundzeichen = empfohlen 32":PRINT
 1260 PRINT "Graphikzeichen T = (190)"
 1270 PRINT "2.G.zeichen    U = (137)"
 1280 PRINT "Hiermit werden die Bilder ge-"
 1290 PRINT "bildet.":PRINT
 1300 PRINT "Zyklen Z empfehlen sich ab 30"
 1310 PRINT "Grenzwert G ab ca. 30."
 1320 PRINT "Je groesser Z und G desto "
 1330 PRINT "laenger die Berechnung.":PRINT
 1340 PRINT "X1,X2,Y1,Y2 = Werte der "
 1350 PRINT "X-Y-Achse. Sie sollten:"
 1360 PRINT "zwischen -5 und 5 liegen."
 1370 PRINT:PRINT:PRINT ">ENTER<"
 1380 GOSUB 1030
 1390 CLS
 1400 PRINT "Bei Signalton wird am Bild-"
 1410 PRINT "ende ueber das MBG ein Ton"
 1420 PRINT "erzeugt.":PRINT
 1430 PRINT "Die Uhrzeit ist zur Erinnerung"
 1440 PRINT "eingebbar. Bei Signal auf die"
 1450 PRINT "Uhr sehen und Zeit merken.":PRINT
 1460 PRINT "Nach Fertigstellung des Bil-"
 1470 PRINT "des wird es in ein Feld ge-"
 1480 PRINT "speichert, die Dauer abgefragt,"
 1490 PRINT "alle Werte angezeigt und "
 1500 PRINT "auch gespeichert."
 1510 PRINT "Die vewendeten Formeln werden"
 1520 PRINT "auch mit gespeichert."
 1530 PRINT "Die X- u. Y- Koordinaten"
 1540 PRINT "werden eingeblendet.":PRINT:PRINT:PRINT ">ENTER<":GOSUB 1030
 1550 CLS:PRINT "Nun kann das Bild gespeichert"
 1560 PRINT "werden oder ins Menue zurueck."
 1570 PRINT "Alle Daten werden nochmals"
 1580 PRINT "angezeigt."
 1590 PRINT "Wird ein Bild von Kassette"
 1600 PRINT "geladen, werden diese Daten "
 1610 PRINT "angezeigt. Es kann sofort"
 1620 PRINT "wieder auf Kassette ausge-"
 1630 PRINT "geben werden."
 1640 PRINT:PRINT:PRINT ">ENTER<":GOSUB 1030
 1650 CLS:GOTO 1711
 1660 CLS
 1670 PRINT "Alte Formeleingabe fuer das ":PRINT "Bildsaven uebernehmen? >J/N<" 
 1680 PRINT:PRINT "Bei >J< gilt fuer die anderen":PRINT "Werte STANDARDANNAHME!"
 1690 GOSUB 1030:IF I$="N"THEN CLS:GOTO 70
 1700 IF I$="J"THEN CLS:GOTO 120
 1710 IF I$<>"J"THEN CLS:GOTO 1670
 1711 PRINT:PRINT "Bild laden J/N ?":GOSUB 1030
 1712 IF I$<>"J"THEN 70
 1713 DIM S(1184):GOTO 790
 1720 C=A*A-B*B-X                       :D=A*B                                
 1730 RETURN:!**** ACHTUNG!! NUN  WIEDER MIT >RUN< STARTEN!****
