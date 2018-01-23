Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 GOTO 130
   20 POKE 16378,Z:POKE 16379,S:CALL 16224
   30 RETURN
   40 FOR L=0 TO 2*PI STEP .04:S=XA+INT(COS(L)*XE+.5):Z=YA+INT(SIN(L)*XE+.5)
   50 GOSUB 20
   60 NEXT L
   70 RETURN
   80 IF XE=XA THEN XE=XE+.1
   82 TS=XE-XA:T=(YE-YA)/TS:TS=ABS(TS/80)
   83 IF XA>XE THEN TS=-TS
   85 FOR L=XA TO XE STEP TS 
   90 Z=INT(T*(L-XA)+YA+.5):S=INT(L+.5)
  100 GOSUB 20
  110 NEXT L
  120 RETURN
  130 CLS
  140 PRINT:PRINT " DEMONSTRATION ZUM HC-BASIC+PSET"
  150 PRINT:PRINT "Dieses BASIC ist das normale":PRINT
  160 PRINT "robotron-HC-BASIC mit den Funk-":PRINT
  170 PRINT "tionstasten S4+":PRINT
  180 PRINT "A-AUTO":PRINT "C-CONTINUE":PRINT "D-DELETE":PRINT "I-INSERT":PRINT "J-CLEARLINE"
  190 PRINT "K-STOP":PRINT "L-LIST":PRINT "N-RENUMBER":PRINT "P-PAUSE"
  200 PRINT "R-RUN":PRINT "V-KURSOR an den Zeilenanfang"
  210 PRINT "W-KURSOR an das Zeilenende":PRINT:PRINT "-alles ohne Parameter."
  220 PRINT:PRINT:PRINT:PRINT TAB(15);:INPUT "<ENTER>";L:CLS
  230 PRINT:PRINT "An dieses BASIC wurden zwei":PRINT:PRINT "Routinen angehaengt,welche" 
  235 PRINT
  240 PRINT "im Textpuffer stehen und beim":PRINT:PRINT "ersten Kaltstart aktiviert"
  250 PRINT:PRINT "und dann abgehaengt werden.":PRINT
  255 PRINT "Die NMI-TASTE wird auf BRK pro-":PRINT
  260 PRINT "grammiert und das PSET-Programm":PRINT
  270 PRINT "am oberen RAM-Ende installiert.":PRINT
  280 PRINT "Das UP ist A0H lang woraus sich":PRINT
  290 PRINT "fuer 16k RAM ein MEMORYSIZE von":PRINT
  300 PRINT "16222 ergibt.Benutzt wird":PRINT
  310 PRINT "der 4. Quadrant,also 1,1 ist":PRINT
  320 PRINT "links oben (wie PRINTAT),die":PRINT
  330 PRINT "Aufteilung 63x63 Punkte.":PRINT
  340 PRINT TAB(15);:INPUT "<ENTER>";L:CLS
  350 PRINT:PRINT "Die Zeile wird in 16378 ge-":PRINT
  360 PRINT "pokt,die Spalte in 16379.":PRINT:PRINT "Aufruf dann mit CALL 16224.":PRINT
  370 PRINT "Fuer Erweiterte:Das UP steht":PRINT
  380 PRINT "dann in 3F60-3FFF,das NWT ist":PRINT
  390 PRINT "nicht aenderbar,das HWT ist in":PRINT
  400 PRINT "folgende Zellen einzutragen:":PRINT
  410 PRINT "(vor erstem BASIC-Kaltstart":PRINT:PRINT "nach dem Laden!)":PRINT
  420 PRINT "2B0D,-2B,-34,-76 .":PRINT
  430 PRINT "Die UPs in Basic sind":PRINT:PRINT "PSET (Z,S   Start Z.20)":PRINT
  435 PRINT "LINE  (XA,XE,YA,YE Start Z.40)":PRINT
  440 PRINT "CIRCLE (XA,YA,XE>r Start Z.80)":PRINT
  450 PRINT "Viel Erfolg  M.Voigt,Magdeburg":PRINT
