Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 REM ZINSEN
   20 WINDOW:CLS
   30 LET ZS=3.25
   35 PRINT:PRINT:PRINT:PRINT
   40 INPUT "Einzahlung in Mark=";EZ
   50 INPUT "Einzahlungsjahr=";EJ
   60 INPUT "Auszahlungsjahr=";AJ
   70 IF AJ<=EJ THEN PRINT "Eingabefehler":PAUSE 20:GOTO 50
   80 LET GH=EZ*(1+ZS/100)^(AJ-EJ)
   90 LET GH=INT(GH*100+0.5)/100
   95 PRINT:PRINT:PRINT
  100 PRINT "Das Guthaben"
  110 PRINT "betraegt     =";GH;" Mark"
  115 PRINT "               ================"
  117 PRINT:PRINT:PRINT
  120 INPUT "Weitere Berechnungen (J/N)?";A$
  130 IF A$="J" THEN PRINT:GOTO 40
  140 CLS:END
