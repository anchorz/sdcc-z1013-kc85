Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 WINDOW:CLS
   20 PRINT:PRINT "    *** MUSIKTAST ***"
   30!(c) Dr.Trog, Berlin, Febr.89
   40 PRINT:PRINT "Programm zur Anzeige"
   50 PRINT "von gedrueckten Tasten mit"
   60 PRINT "Tonausgabe.":PRINT
   70 PRINT "Abbruch durch ^C":PRINT:PRINT
   80 I$=INKEY$:IF I$=""THEN 80
   90 A=ASC(I$)
  100 POKE 110,A
  110 BEEP
  120 GOSUB 160
  130 PRINT "Taste ";I$;"   Dez : ";A ;"  Hex: ";H$:PRINT
  140 PAUSE 5
  150 GOTO 80
  160 H$="":D=A
  170 R=D-INT(D/16)*16
  180 IF R<10 THEN H$=CHR$(48+R)+H$:ELSE H$=CHR$(55+R)+H$
  190 IF D>15 THEN D=INT(D/16):GOTO 170
  200 RETURN
  210 END
