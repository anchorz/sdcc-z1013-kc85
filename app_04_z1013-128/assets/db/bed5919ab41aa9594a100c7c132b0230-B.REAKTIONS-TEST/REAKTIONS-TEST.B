Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

    1! REAKTIONS-TEST
    2!
    3! (C) by Ingolf Koehler
    4!
    5! Gera,  den 21.12.1988
    6!
   10 WINDOW:CLS:GOSUB 120
   20 A=INT(RND(1)*500+800)
   30 FOR I=1 TO A:NEXT:Z=0
   40 PRINT "                         jetzt                         
   50 PRINT
   70 Z=Z+1:IF INKEY$=""THEN 70
   80 PRINT "-> ";INT(0.862034*Z+.5);"Millisekunden"
   90 PRINT:INPUT "WEITER? (J)/N";A$
  100 IF A$="N"THEN CLS:END
  110 PRINT:PRINT:GOTO 20
  120 PRINT "  R E A K T I O N S - T E S T   
  130 PRINT:PRINT "Der Computer  testet  Ihre Reak-
  140 PRINT "tionsschnelligkeit.  Sie muessen
  150 PRINT "nur bei  >>> jetzt <<<  eine be-
  160 PRINT "liebige Taste druecken.         
  170 PRINT "Alles klar ?  Dann geht es los !
  180 PRINT:PAUSE 20:RETURN
