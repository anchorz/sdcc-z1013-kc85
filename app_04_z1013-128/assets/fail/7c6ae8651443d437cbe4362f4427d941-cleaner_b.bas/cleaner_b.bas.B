Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
   11!    SPACE-CLEANER        !
   12!!!!!!!!!!!!!!!!!!!!!!!!!!!
   13! TH.RICHTER,6900 JENA    !
   14!       ZIEGELMUEHLENWEG 8!
   15!!!!!!!!!!!!!!!!!!!!!!!!!!!
   30 CLS:PRINT "RECHNERTYP: Z 9001 => 1"
   31 PRINT "            Z 1013 => 2"
   32 PRINT:PRINT "TYP EINGEBEN (1/2) !"
   33 I$=INKEY$:IF I$=""THEN 33
   34 IF I$="1"THEN NY=40:GOTO 50
   35 IF I$="2"THEN NY=32:GOTO 50
   36 PAUSE 3:PRINT:PRINT "... 1 ODER 2 ... ?":GOTO 33
   50 CLS
   51 PRINT AT(0,0);STRING$(32,""):PRINT AT(23,0);STRING$(32,"")
   52 FOR I=1 TO 22:PRINT AT(I,0);"":NEXT I
   55 FOR I=0 TO 10:FOR J=-I TO I:PRINT AT(11-I,16+J);" ":NEXT J:FOR J=-I TO I
   57 PRINT AT(12+J,16+I);" ":NEXT J:FOR J=-I TO I:PRINT AT(12+I,15-J);" "
   59 NEXT J:FOR J=-I TO I:PRINT AT(11-J,15-I);" ":NEXT J:NEXT I
   60 PRINT AT(5,9);"Z 9001 - Z1013"
   62 PRINT AT(7,9);"SPIELPROGRAMM"
   63 PRINT AT(10,6);"":PRINT AT(14,6);""
   64 PRINT AT(12,6);"  SPACE-CLEANER  "
   65 PRINT AT(11,6);"                 ":PRINT AT(13,6);"                 "
   66 PRINT AT(20,12);"TH.RICHTER"
   68 PRINT AT(22,20);">TASTE<":PAUSE 5
   70 IF INKEY$=""THEN PRINT AT(22,20);">     <":PAUSE 5:GOTO 68
   80 CLS:PRINT "Sie fliegen ein Raumschiff der":PRINT
   82 PRINT "kosmischen Muellabfuhr und sol-":PRINT
   84 PRINT "len Planetoidentruemmer * weg-":PRINT
   86 PRINT "raeumen. Dabei duerfen Sie nicht":PRINT 
   88 PRINT "zu oft mit Planeten  zusammen-":PRINT 
   90 PRINT "stossen und nicht in den radio-":PRINT
   92 PRINT "aktiven Abgasschweif Ihres ":PRINT   
   94 PRINT "Raumschiffes kommen. Ihr Raum-":PRINT
   96 PRINT "schiff haelt nur 20 solcher":PRINT
   98 PRINT "Zusammenstoesse aus !":PRINT
   99 PRINT "Steuern Sie mit Joystick oder":PRINT:PRINT "den Kursortasten !"
  100 PRINT AT(23,20);">TASTE<":PAUSE 5
  102 IF INKEY$=""THEN PRINT AT(23,21);"     ":PAUSE 3:GOTO 100
  135 ST=10:P=0:F=0:T=2
  140 CLS:PRINT AT(0,0);" "
  150 PRINT AT(22,0);STRING$(32,CHR$(160))
  160 PRINT AT(23,0);"Punkte:     HI:     Fehler:    "         
  170 PRINT AT(23,15);HI:PRINT AT(23,7);P:PRINT AT(23,27);F
  190 PL=20
  210 FOR I=0 TO ST+10*RND(1)
  220 PRINT AT(22*RND(1),32*RND(1));""
  230 NEXT I
  240 FOR I=0 TO PL
  250 PRINT AT(22*RND(1),32*RND(1));"*"
  260 NEXT I
  270 Y=INT(22*RND(1)):X=INT(32*RND(1))
  272 PAUSE 1:PRINT AT(Y,X);""
  273 YA=Y:XA=X
  274 E$=INKEY$:IF E$<CHR$(8)OR E$>CHR$(11)THEN PRINT AT(Y,X);CHR$(201):GOTO 272
  276 E=ASC(E$)
  280 PRINT AT(Y,X);"":PRINT AT(YA,XA);"":YA=Y:XA=X
  285 PAUSE T
  290 E$=INKEY$:IF E$<>""THEN E=ASC(E$)
  300 IF E=8 THEN X=X-1:IF X<0 THEN X=0:E=9:GOTO 800
  310 IF E=9 THEN X=X+1:IF X>31 THEN X=31:E=8:GOTO 800
  320 IF E=11 THEN Y=Y-1:IF Y<0 THEN Y=0:E=10:GOTO 900
  330 IF E=10 THEN Y=Y+1:IF Y>21 THEN Y=21:E=11:GOTO 900
  340 S=PEEK(-5120+NY*Y+X)
  350 IF S=140 OR S=213 THEN 1000
  360 IF S=42 THEN 2000
  370 GOTO 280
  380 PAUSE 5:FOR J=0 TO 5:FOR I=0 TO 5:BEEP:NEXT I:PAUSE 5:NEXT J
  390 CLS
  400 PRINT AT(5,0);"Nach",F,"Zusammenstoessen"
  410 PRINT AT(7,0);"hat Ihr Raumschiff den Geist"
  420 PRINT AT(9,0);"aufgegeben."
  430 PRINT AT(11,0);"Sie haben",P,"Meteoritentruemmer"
  440 PRINT AT(13,0);"beseitigt !"
  450 IF P>=HI THEN PRINT AT(16,0);"Das ist neuer Rekord !"
  455 PAUSE 30
  460 PRINT AT(18,2);"Noch einmal? (Ja='')"
  470 I$=INKEY$:IF I$=""THEN 470
  480 IF I$=CHR$(11)THEN 135
  490 CLS
  500 END
  800 IF Y<10 THEN Y=Y+1:ELSE Y=Y-1
  801 GOTO 340
  900 IF X<15 THEN X=X+1:ELSE X=X-1
  901 GOTO 340
 1000 F=F+1:FOR I=0 TO 5:BEEP:PRINT AT(Y,X);CHR$(138):BEEP
 1010 PRINT AT(Y,X);CHR$(201):NEXT I
 1020 PRINT AT(23,27);F
 1030 IF F<20 THEN 280:ELSE 380
 2000 BEEP:PL=PL-1:P=P+1:PRINT AT(23,7);P
 2010 IF P>HI THEN HI=P:PRINT AT(23,15);HI
 2012 IF P>30 THEN T=1
 2014 IF P>50 THEN T=0
 2020 IF PL=0 THEN ST=ST+20:GOTO 140:ELSE GOTO 280 
