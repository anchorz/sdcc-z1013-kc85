Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 WINDOW :CLS:Z=0:A=0:Y=0
   20 INPUT "WIEVIEL POSITIONEN";X
   30 WINDOW 2,25,0,31
   40 FOR I=1 TO X:A=A+1
   50 PRINT "   ";A;"PREIS";:INPUT "=";Y:Z=Z+Y
   60 PRINT AT(27,3);"ZWISCHENSUMME = ",Z," M"
   70 PRINT AT(28,18);"=========":Y=0:NEXT I
   80 PRINT AT(27,0);"                               "
   90 PRINT AT(28,0);"                               "
  100 PRINT:PRINT " SUMME =";Z;" M":PRINT:PRINT "noch einmal j/n ?";
  110 X$=INKEY$ :IF X$=""THEN 110
  120 IF X$="J"GOTO 10
  130 IF X$="N"THEN WINDOW:CLS:END
  140 GOTO 110
