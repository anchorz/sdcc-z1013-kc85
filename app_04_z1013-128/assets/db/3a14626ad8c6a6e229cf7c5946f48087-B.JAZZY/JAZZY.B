Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

  350 DIM Z$(32),A(6),NA$(4),AU(4,23)
  360 Z$(3)=" "
  370 Z$(4)=" 1 I  :         J A Z Z Y"
  380 Z$(5)=" 2 II :       *************"
  390 Z$(6)=" 3 III:"
  400 Z$(7)=" 4 IV :"
  410 Z$(8)=" 5 V  :"
  420 Z$(9)=" 6 VI :"
  430 Z$(10)=" 7 SUM:   "
  440 Z$(11)=" 8 BON:                  "
  450 Z$(12)=" 9 1X2:                  "
  460 Z$(13)="10 2X2:                  "
  470 Z$(14)="11 3X2:                  "
  480 Z$(15)="12 3er:                  "
  490 Z$(16)="13 4er:   "
  500 Z$(17)="14 5er:"
  510 Z$(18)="15 Jaz:      1      2      3"
  520 Z$(19)="16 2X3:"
  530 Z$(20)="17 klW:   "
  540 Z$(21)="18 grW:                  "
  550 Z$(22)="19 Str:                  "
  560 Z$(23)="20 klH:                  "
  570 Z$(24)="21 grH:                  "
  580 Z$(25)="22 Cha:                  "
  590 Z$(26)="23 Jok:   "
  600 Z$(27)=" " 
  610 Z$(28)="             4      5      6"
  620 Z$(29)=" "
  630 Z$(30)=" "
  640 WINDOW:CLS
  650 PRINT
  660 PRINT "    Willkommen beim Jazzy !":PRINT
  670 INPUT "ANZAHL DER SPIELER(max=4):";SP
  680 FOR I=1 TO SP
  690 PRINT
  700 INPUT "SPIELER:";NA$(I)
  710 NEXT I
  720 R=0
  730 FOR K=1 TO 4
  740 FOR I=1 TO 23
  750 AU(K,I)=-1
  760 NEXT I:AU(K,7)=0:AU(K,8)=0
  770 NEXT K
  780 FOR R=1 TO 21
  790 FOR SI=1 TO SP
  800 FOR I=1 TO 6
  810 A(I)=0
  820 NEXT I
  830 V=0
  840 WINDOW:CLS
  850 FOR I=2 TO 30
  860 PRINT Z$(I)
  870 NEXT I
  880 ZE=1:FOR I=1 TO 23
  890 ZE=ZE+1
  900 IF AU(SI,I)>-1 THEN PRINT AT(ZE,6);AU(SI,I)
  910 NEXT I
  920 PRINT AT(5,10);NA$(SI)
  930 PRINT AT(5,20);V+1,".VERSUCH"
  940 PRINT AT(6,20);R,".RUNDE"
  950 FOR I=1 TO 6
  960 IF A(I)=0 THEN A(I)=INT(6*RND(1)+1) 
  970 NEXT I
  980 V=V+1
  990 FOR I=1 TO 6
 1000 IF A(I)=1 THEN RESTORE 1170
 1010 IF A(I)=2 THEN RESTORE 1180
 1020 IF A(I)=3 THEN RESTORE 1190
 1030 IF A(I)=4 THEN RESTORE 1200
 1040 IF A(I)=5 THEN RESTORE 1210
 1050 IF A(I)=6 THEN RESTORE 1220
 1060 IF I=1 THEN X1=11:Y1=13
 1070 IF I=2 THEN X1=11:Y1=20
 1080 IF I=3 THEN X1=11:Y1=27
 1090 IF I=4 THEN X1=21:Y1=13
 1100 IF I=5 THEN X1=21:Y1=20
 1110 IF I=6 THEN X1=21:Y1=27
 1120 FOR L=1 TO A(I)
 1130 READ X,Y,Z
 1140 PRINT AT(X1+X,Y1+Y);CHR$(Z)
 1150 NEXT L
 1160 NEXT I
 1170 DATA 0,0,255  
 1180 DATA 2,-2,255,-2,2,255  
 1190 DATA 2,-2,255,0,0,255,-2,2,255    
 1200 DATA -2,-2,255,-2,2,255,2,-2,255,2,2,255
 1210 DATA -2,-2,255,-2,2,255,2,-2,255,2,2,255,0,0,255
 1220 DATA -2,-2,255,-2,2,255,0,-2,255,0,2,255,2,-2,255,2,2,255
 1230 IF V=3 THEN GOTO 1360
 1240 PRINT AT(28,0);"Welche Wuerfel loeschen?(0=ENDE)"   
 1250 INPUT "EINGABE";W$
 1260 L=LEN (W$)
 1270 FOR I=1 TO L:S$=MID$(W$,I,1)
 1280 K=VAL(S$) 
 1290 IF K>6 THEN GOTO 1250
 1300 NEXT I
 1310 FOR I=1 TO L:S$=MID$(W$,I,1)
 1320 K=VAL(S$)
 1330 IF K=0 THEN GOTO 1360
 1340 A(K)=0:NEXT I
 1350 GOTO 840
 1360 PRINT "EINGABE ZEILE,WERT" 
 1370 INPUT "EINGABE:";ZE,WE 
 1380 IF AU(SI,ZE)>-1 THEN GOTO 1370
 1390 AU(SI,ZE)=WE
 1400 NEXT SI
 1410 NEXT R
 1420 WINDOW:CLS
 1430 PRINT:PRINT
 1440 PRINT "    AUSWERTUNG DES SPIELES"
 1450 PRINT "  **************************"
 1460 PRINT
 1470 K=4
 1480 FOR SI=1 TO SP
 1490 FOR I=1 TO 6:AU(SI,7)=AU(SI,7)+AU(SI,I)
 1500 NEXT I
 1510 IF AU(SI,7)>83 THEN AU(SI,8)=50
 1520 SU=0:FOR I=7 TO 23
 1530 SU=SU+AU(SI,I)
 1540 NEXT I
 1550 K=K+1
 1560 PRINT AT(K,3);NA$(SI)
 1570 PRINT AT(K,18);SU," PUNKTE"
 1580 NEXT SI
 1585 PRINT AT(16,7);"BISHERIGER REKORD"
 1590 PRINT AT(18,13);"491"
 1595 WINDOW 28,31,0,31
 1600 END
