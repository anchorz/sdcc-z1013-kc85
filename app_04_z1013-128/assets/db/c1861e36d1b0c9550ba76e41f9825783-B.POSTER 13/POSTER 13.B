Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

    2 WINDOW:CLS
   10 PRINT "                                ";
   20 PRINT "  N U T Z E R H I N W E I S E   ";
   30 PRINT "  ---------------------------   ";
   40 PRINT "                                ";
   50 PRINT "ZEICHNEN IM GRAPHIKMODUS NACHDEM";
   60 PRINT "                                ";
   70 PRINT "DER SCHIRM LEER IST. BEENDEN MIT";
   80 PRINT "                                ";
   90 PRINT ">E<. DANACH WIRD DAS BILD IN'S  ";
  100 PRINT "                                ";
  110 PRINT "PROGRAMM 'GEPOKT' UND KANN NACH ";
  120 PRINT "                                ";
  130 PRINT "DEM 'ABSAVEN' (LIST#1) MIT DEM  ";
  140 PRINT "                                ";
  150 PRINT "BEFEHL >LOAD#1< ZU JEDEM PRO-   ";
  160 PRINT "                                ";
  170 PRINT "GRAMM DAZUGELADEN WERDEN, DAS   ";
  180 PRINT "                                ";
  190 PRINT "DIE ZEILEN 10 BIS 330 NICHT BE- ";
  200 PRINT "                                ";
  210 PRINT "LEGT HAT.                       ";
  220 PRINT "                                ";
  230 PRINT "VOR DEM 'ABSAVEN' IST DIE ZEILE ";
  240 PRINT "                                ";
  250 PRINT "350 NOCH ZU 'KILLEN' ,DIE ZEILE ";
  260 PRINT "                                ";
  270 PRINT "320 UM 1 ZU KUERZEN UND ZEILE   ";
  280 PRINT "                                ";
  290 PRINT "330 IN 'GOTO330' ZU AENDERN !   ";
  300 PRINT "                                ";
  310 PRINT "                                ";
  320 PRINT "                  >ENTER<       ";
  330 GOTO 370
  350 DELETE 370,650:END
  370 T$=INKEY$:IF T$=""THEN 370:ELSE 390
  390 FOR I=-5120 TO-4097:POKE I,32:NEXT
  410 T$=INKEY$:IF T$=""OR T$=CHR$(34)OR T$=CHR$(12)THEN 410
  420 PAUSE 1
  430 IF T$=CHR$(11)THEN 450:ELSE 470
  450 IF PEEK(44)*256+PEEK(43)<60448 THEN 410
  470 IF T$=CHR$(10)THEN 490:ELSE 495
  490 IF PEEK(44)*256+PEEK(43)>61408 THEN 410
  495 IF T$=CHR$(8)THEN 498:ELSE 500
  498 IF PEEK(44)*256+PEEK(43)<60417 THEN 410
  500 IF T$=CHR$(9)THEN 505:ELSE 510
  505 IF PEEK(44)*256+PEEK(43)>61438 THEN 410
  510 IF T$="E"THEN 570
  530 PRINT T$;:GOTO 410
  570 A=11279:B=-5120
  590 FOR L=0 TO 31:POKE A+L,PEEK(B+L):NEXT
  610 A=A+41:B=B+32:J=J+1:IF J=32 THEN 630:ELSE 590
  630 GOTO 350
  650 FOR I=11265 TO 12000:PRINT I;" ";PEEK(I);:NEXT
