Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

    1 WINDOW:CLS
    2 PRINT "                                ";
    6 PRINT "           G R A F I K          ";
   10 PRINT "                                ";
   14 PRINT "Mit diesem Programm koennen     ";
   18 PRINT "Bilder gezeichnet werden, die   ";
   22 PRINT "nach Eingabe des Zeichens  @    ";
   26 PRINT "in die Programmzeilen 2 - 122   ";
   30 PRINT "gepokt werden.                  ";
   34 PRINT "Diese BILD-programmzeilen       ";
   38 PRINT "koennen fuer jedes Programm     ";
   42 PRINT "verwendet werden.               ";
   46 PRINT "KURSOR: <---  = LINKS           ";
   50 PRINT "        --->  = RECHTS          ";
   54 PRINT "        Sh4 S = AUF             ";
   58 PRINT "        Sh4 R = AB              ";
   62 PRINT "                                ";
   66 PRINT "AUF und AB funktionieren  NICHT ";
   70 PRINT "im Grafikmodus !!!              ";
   74 PRINT "Es muss also in den Alpha-Modus ";
   78 PRINT "fuer AUF geschaltet werden!!!   ";
   82 PRINT "AB geht mit ENTER .             ";
   86 PRINT "                                ";
   90 PRINT "GOTO 250 = Dezimalanzeige des   ";
   94 PRINT "Programmspeicherbereiches.      " 
   98 PRINT "                                ";
  102 PRINT "Am Ende ist die Auswahl:        ";
  106 PRINT "AENDERN - NEUES BILD - ENDE -   ";
  110 PRINT "und Loeschen des Programms, nur ";
  114 PRINT "das BILD-programm bleibt.       ";
  118 PRINT "                      <ENTER>   ";
  122 PRINT "                                ";
  126 I$=INKEY$:IF I$=""THEN 126
  130 IF I$=CHR$(13)THEN 150
  150 FOR L=0 TO 1024:POKE-5120+L,32:NEXT L
  160 WINDOW:CLS
  170 PRINT AT(20,1);"BEGINNE ZU ZEICHNEN!":PAUSE 20
  180 PRINT AT(20,1);"                    "
  185 PRINT AT(31,0);"ZEILE NICHT VERWENDEN !!!!      "
  190 T$="":T$=INKEY$:IF T$=""OR T$=CHR$(34)THEN 190:ELSE PRINT T$;
  200 IF T$="@"THEN 210:ELSE 190
  210 PRINT CHR$(8);CHR$(32);:A=11279:B=-5120
  220 FOR I=0 TO 31:POKE A+I,PEEK(B+I):NEXT I
  230 A=A+41:B=B+32:J=J+1:IF J=31 THEN 240:ELSE 220
  240 GOTO 270
  245 END
  250 FOR Q=11000 TO 15000:PRINT Q;" ";PEEK(Q),:NEXT Q
  255 END
  260 DELETE 126,340     
  270 PRINT AT(31,0);"Aendern=A Neu=N Bild=B Ende=E"
  280 I$=INKEY$:IF I$=""THEN 280
  290 IF I$="A"THEN 330
  300 IF I$="N"THEN 325
  310 IF I$="B"THEN 260
  315 IF I$="E"THEN END
  320 IF I$<>"A"OR I$<>"N"OR I$<>"B"OR I$<>"E"THEN 280
  325 J=0:GOTO 150
  330 J=0:GOTO 185
  340 END
