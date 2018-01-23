Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

    5 CLS
   10 FOR I=0 TO 20
   20 PRINT AT(10,I+5);"*"
   30 PRINT AT(11,I+5);"-"
   40 PRINT AT(15,I+5);"-"
   50 PRINT AT(16,I+5);"*"
   60 NEXT I
   70 PRINT AT(13,6);"Gedaechtnistraining"
   80 PRINT AT(17,14);"by"
   90 PRINT AT(18,9);"Dieter Waldt"
  100 PRINT AT(19,12);"Y2 8OH"
  105 PAUSE 40
  110 WINDOW:CLS
  120 LET UE$="Testen Sie ihr Kurzzeit-        gedaechtnis"
  130 PRINT:PRINT:PRINT
  140 PRINT:PRINT UE$:PRINT STRING$((LEN(UE$)-11),"="):PRINT
  150 PRINT:PRINT:PRINT "Es werden 1 bis 5 Zeichen kurz"
  160 PRINT "eingeblendet, die Sie danach"
  170 PRINT "wieder eingeben"
  180 PRINT "Die Anzahl der Zeichen werden"
  190 PRINT "durch den gewaehlten Schwierig- keitsgrad bestimmt."
  200 PAUSE 120
  210 CLS
  220 A=26
  230 B=65
  240 CLS
  250 LET A$=CHR$(INT(B+RND(1)*A))
  260 LET B$=CHR$(INT(B+RND(1)*A))
  270 LET C$=CHR$(INT(B+RND(1)*A))
  280 LET E$=CHR$(INT(B+RND(1)*A))
  290 LET F$=CHR$(INT(B+RND(1)*A))
  300 PRINT:PRINT:PRINT:PRINT
  310 PRINT "Schwierigkeitsgrad: 1"
  320 PRINT "                    2"
  330 PRINT "                    3"
  340 PRINT "                    4"
  350 PRINT "                    5"
  360 PRINT:PRINT:PRINT:PRINT
  370 INPUT "Waehlen Sie den Schwierigkeits- grad";S$
  380 IF S$="1" THEN GOTO 430
  390 IF S$="2" THEN GOTO 440
  400 IF S$="3" THEN GOTO 450
  410 IF S$="4" THEN GOTO 460
  420 IF S$="5" THEN GOTO 470
  430 D$=A$:GOTO 480
  440 D$=A$+B$:GOTO 480
  450 D$=A$+B$+C$:GOTO 480
  460 D$=A$+B$+C$+E$:GOTO 480
  470 D$=A$+B$+C$+E$+F$:GOTO 480
  480 PRINT AT(20,10);"ACHTUNG !!":PAUSE 15
  490 PRINT AT(22,12);D$:PAUSE 5:CLS
  500 PRINT:PRINT:PRINT:PRINT
  510 PRINT "Geben Sie die richtige"
  520 INPUT "Zeichenfolge ein:";AN$
  530 IF AN$=D$ THEN CLS:GOTO 610
  540 PRINT:PRINT:PRINT:PRINT
  550 PRINT:PRINT "Sie haben falsch beobachtet!"
  560 PRINT "Ich zeige Ihnen die Zeichen"
  570 PRINT "nochmal:";D$
  580 PRINT:INPUT "Wollen Sie weiter ueben (J/N)?";J$
  590 IF J$="J" THEN GOTO 210
  592 CLS
  593 PRINT AT(10,4);"xxxxxxxxxxxxxxxxxxxxxxxx"
  594 PRINT AT(12,4);"Uebung macht den Mejster"
  595 PRINT AT(14,4);"xxxxxxxxxxxxxxxxxxxxxxxx"
  596 PRINT AT(20,10);"Bis bald !"
  597 PAUSE 20:CLS
  600 CLS:END
  610 PRINT:PRINT:PRINT:PRINT:PRINT "Sie haben richtig beobachtet!"
  620 PRINT "============================="
  630 PRINT:PRINT:PRINT:PRINT:PRINT
  640 GOTO 580
