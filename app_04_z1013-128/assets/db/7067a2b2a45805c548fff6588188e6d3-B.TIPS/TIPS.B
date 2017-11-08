Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 CLS:POKE 8291,29
  100 PRINT
  110 PRINT
  120 PRINT "           "
  130 PRINT "                        "
  140 PRINT "                        "
  150 PRINT "              "
  160 PRINT "                        "
  170 PRINT "                  "
  180 PRINT "           "
  190 PRINT
  200 PRINT
  210 PRINT "                    "
  220 PRINT "               "
  230 PRINT "            "
  240 PRINT "                             "
  250 PRINT
  260 PRINT
  270 PRINT "    II. Z1013-Tagung der DDR   "
  280 PRINT "     DRESDEN   Februar 1888    "
  290 PRINT
  295 PRINT
  300 PRINT
  310 PRINT
  320 PRINT "";
  330 PRINT "                   V.Pohlers  ";
  340 PRINT "        Lomonossow-";
  350 PRINT "         Allee 41/81";
  360 PRINT "  soft       Greifswald ";
  370 PRINT "                   2200       ";
  380 PRINT "";
  390 PRINT
  400 PRINT "                              ";
  500 INPUT "";A$
  510 BEEP:CLS:LINES 1:WIDTH 0:RESTORE 520
  520 DOKE 11103,DEEK(DEEK(11229)+1):LIST:END
   10!HC-BASIC TIPS+KNIFFE
   11!
   12!V.Pohlers, Lomonossowallee 41/81, Greifswald, 2200
   13!fuer die zweite Z1013-Tagung Dresden Febr. 1988
   14!
   15!
   16!
   17!Programmname fuer CSAVE/CLOAD in Stringvariable
   18!
   19!  CSAVE""+A$
   20!
   21!INPUT AT(X,Y) -Funktion
   22!
   23!  DOKE 112,256*X+Y:INPUT" text";T$
   24!                         ^ Leerzeichen noetig, erscheint nicht im Text
   25!
   26!RANDOMIZE -Funktion
   27!
   28!  10 PRINT "zum Start bel. Taste druecken!":I=0
   29!  20 I=I-1:A=RND(I)
   30!  30 IF INKEY$="" GOTO 20
   31!
   32!Runden einer Zahl
   33!
   34!  DEF FNRS(X)=INT(10^S*X+.5)/10^S  auf S Nachkommastellen runden
   35!
   36!rechtsbuendige Ausgabe von Zahlen
   37!
   38!  DEF FNP(X)=8-LEN(STR$(INT(X)))
   39!  PRINT TAB(20+FNP(Z));Z           Ausgabe Dezimalpunkt an Position 28 
   40!
   41!Programmschutz fuer LIST/CSAVE/EDIT
   42!
   43!  POKE 11101,1:CSAVE"pgm"          Abspeichern, bei erneutem Einlesen
   44!                                   Progamm geschuetzt
   45!  DOKE 11101,0 bzw. POKE 11102,0   Aufheben Schutz
   46!
   47!  LINES 0                          LIST-Tod
   48!
   49!<ENTER>-Abfrage bei Bildschirmende innerhalb FOR...NEXT
   50!
   51! IF PEEK(113)>31 THEN PRINT TAB(22) "<ENTER>" :INPUT"";ET$:CLS
   52!
   53!Cursorzeichen veraendern
   54!
   55!  POKE 10846,neuer Cursor          bei HC-BASIC H   392
   56!
   57!BASIC-RAM-Ende bei Neustart bis max. 0EBFFH
   58!
   59!  DOKE 834,-5121                   bei HC-BASIC H   836
   60!
   61!selbststartende BASIC-Programme
   62!
   63!  * vor Programm schreiben
   64!    0 RESTORE 10: DOKE 11103,DEEK(11229)+1: RUN
   65!    10 hier beginnt das Programm
   66!  * POKE 8291,29: CSAVE"name"    
   67!  * bei erneutem Einlesen mit CLOAD Selbststart
   68!    Zeile 0 erscheint nicht bei LIST usw. !
   69!
  100!CLIST fuer HC-Routinen-gespeicherte BASIC-Programme 
  101!
  102 PRINT "CLIST":PRINT:PRINT
  103 DA=128
  104 DOKE 45,DA:POKE 124,1
  105 CALL*1FC                          :!CALL*28A beim HC-BASIC H
  106 IF PEEK(123)<>1 THEN 105
  107 FOR I=DA+3 TO DA+10
  108 PRINT CHR$(PEEK(I));:NEXT
  109 I=PEEK(DA)-211
  110 IF I=0 OR I=4 THEN PRINT "  Progr. ";
  111 IF I=1 OR I=5 THEN PRINT "  Datei  ";
  112 IF I=2 OR I=6 THEN PRINT "  ASCII  ";
  113 IF I>3 THEN PRINT " G"; :ELSE PRINT "  ";
  114 PRINT DEEK(DA+11)
  115 GOTO 104
  116!
  117!  "G" :Pgm/Daten mittels POKE 11101,1 gschuetzt  
  118!
  200!LVAR fuer HC-BASIC
  201!
  202! * eigenes Pgm einladen, danach LVAR (60000-60190) einladen
  203! * im eigenen Pgm an die zu ueberprufenden Stellen GOSUB60000 schreiben
  204!
  205! LVAR listet direkt den Variablenspeicher:
  206! einf. Var. :   Adresse Name akt. Wert
  207! Strings    :   Adresse Name Stringadr. Stringlaenge String
  208! Funktionsnamen haben vorm Namen ein "f"
  209!
  210! Felder     :   Adresse Name (Dimensionen ...)
  211!
  212!
60000 VI=0:VJ=0:FOR VI=DEEK(11223)TO DEEK(11225)-1 STEP 6
60010 PRINT VI;TAB(7)CHR$(SGN(128 AND PEEK(VI+1))*102);
60020 PRINT TAB(8)CHR$(127 AND PEEK(VI+1));CHR$(127 AND PEEK(VI));
60030 PRINT CHR$(SGN(128 AND PEEK(VI))*36);
60040 IF PEEK(VI)<128 THEN PRINT TAB(12);:GOTO 60060
60050 PRINT TAB(12)DEEK(VI+4);TAB(19)PEEK(VI+2);TAB(24);
60060 RESTORE 60100:VJ=DEEK(11229)+6
60070 POKE VJ,PEEK(VI+1)AND 127
60080 POKE VJ+1,PEEK(VI)AND 127:IF PEEK(VJ+1)=0 THEN POKE VJ+1,32
60090 IF PEEK(VI)>127 THEN POKE VJ+2,36:ELSE POKE VJ+2,32
60100 PRINT...:!
60110 NEXT
60115 IF DEEK(11227)=DEEK(11225)THEN 60190
60120 PRINT:FOR VI=DEEK(11225)TO DEEK(11227)-1
60130 PRINT VI;TAB(8)DEEK(VI+2)-1;TAB(15)CHR$(PEEK(VI+1));CHR$(127 AND PEEK(VI));
60140 PRINT CHR$(SGN(128 AND PEEK(VI))*36);
60150 PRINT "(";:FOR VJ=PEEK(VI+4)-1 TO 0 STEP-1
60160 PRINT DEEK(2*VJ+VI+5)-1;CHR$(8);",";:NEXT VJ
60170 PRINT CHR$(8);")"
60180 VI=VI+DEEK(VI+2)+3:NEXT
60190 PRINT VI:RETURN
