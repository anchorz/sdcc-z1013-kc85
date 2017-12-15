Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 REM KNECHT FER 9 BAD SUELZE
   20 REM-------------------------
   30 WINDOW:CLS:P$="   D A T A G E N E R A T O R ":PRINT:PRINT P$
   40 N$="    (C) ROLAND KNECHT y56ya":PRINT:PRINT N$:PRINT
   50 PRINT "Das Programm erwartet die Ein-"
   60 PRINT:PRINT "gaben von Mc-Anfang, Mc-Ende"
   70 PRINT:PRINT "sowie Standort fuer die "
   80 PRINT:PRINT "DATA-Zeilen und deren Zeilen-" 
   90 PRINT:PRINT "nummer. Nach dem Start wird das"
  100 PRINT:PRINT "Mc-Programm dezimal in DATA"
  110 PRINT:PRINT "gewandelt und mit LIST#1 auf"       
  120 PRINT:PRINT "Kassette gerettet. Es erfolgt"
  130 PRINT:PRINT "eine Vorankuendigung. Recorder"
  140 PRINT:PRINT "auf Aufnahme stellen und Geduld"
  150 PRINT:PRINT "haben. Gelesen wird das Pro-"
  160 PRINT:PRINT "gramm mit LOAD#1'data'. Beim "
  170 PRINT:PRINT "Uebergang von Adr. 7FFFH auf"
  180 PRINT:PRINT "8000H gibt es einen Fehler !!!";
  190 PAUSE 100:CLS
  200 PRINT:PRINT P$:PRINT:PRINT N$
  210 PRINT:PRINT:INPUT " Mc-Anfang";H$:GOSUB 560:M=D
  220 IF M>32768 THEN M=M-65536
  230 PRINT:INPUT " Mc-Ende  ";H$:GOSUB 560:EA=D:IF EA>32768 THEN EA=EA-65536
  240 PRINT:INPUT " DATA-Adr.";H$:GOSUB 560:BA=D
  250 IF BA>32768 THEN BA=BA-65536
  260 PA=BA
  270 VA=BA:Z=0:REM Variable Adresse
  280 REM-------------------------
  290 PRINT:INPUT " Zeilennr.";NR
  300 PRINT:PRINT " Adresse "
  310 BA=VA:Z=0:VA=VA+2:DOKE VA,NR:VA=VA+2:NR=NR+10 :Z=Z+4
  320 POKE VA,131:REM Token DATA 83H
  330 VA=VA+1:Z=Z+1
  340 D=M:GOSUB 460:PRINT AT(14,10);H$
  350 D=PEEK(M):GOSUB 460:M=M+1
  360 H$=STR$(D)
  370 FOR I=2 TO LEN(H$)
  380 A=ASC(MID$(H$,I,1))
  390 POKE VA,A:VA=VA+1:Z=Z+1
  400 NEXT
  410 POKE VA,44:VA=VA+1:Z=Z+1
  420 IF M=EA THEN VA=VA-1:POKE VA,0:DOKE VA+1,0:DOKE BA,(BA+Z):GOTO 610
  430 IF Z<64 GOTO 340:ELSE VA=VA-1:POKE VA,0:VA=VA+1:DOKE BA,(BA+Z):GOTO 310
  440 END 
  450 REM------------------------
  460 REM DEZ-HEX WANDLUNG
  470 REM D/H$
  480 H$=" ":B=INT(D/256):GOSUB 500
  490 B=D-B*256
  500 L=(B AND 15)+48:H=(B AND 240)/16+48
  510 IF H>57 THEN H=H+7
  520 IF L>57 THEN L=L+7
  530 H$=H$+CHR$(H)+CHR$(L) 
  540 RETURN
  550 REM ------------------------
  560 REM HEX-DEZ WANDLUNG H$/D
  570 J=1:D=0:FOR I=LEN(H$) TO 1 STEP -1
  580 N=ASC(MID$(H$,I,1))-48
  590 IF N>9 THEN N=N-7
  600 D=D+J*N:J=J*16:NEXT:RETURN
  610 REM-----------------------
  620 REM---LIST#1"DATA"--------
  630 H$="2B5F":GOSUB 560:DOKE D,PA
  640 PRINT:PRINT "DATA wird mit NAMEN 'data' "
  650 PRINT:PRINT "gesaved. Danach wird auf 2B5FH"
  660 PRINT:PRINT "die neue Programmadresse ge-"
  670 PRINT:PRINT "pokt und die SAVE-Routine auf-"
  680 PRINT:PRINT "gerufen. Nach dem Save die Pro-"
  690 PRINT:PRINT "grammadresse des Interpreters"
  700 PRINT:PRINT "mit DOKE 11103,11265 wieder "
  710 PRINT:INPUT "einstellen !! Start Tape -->";A
  720 LIST#1 "data"1
