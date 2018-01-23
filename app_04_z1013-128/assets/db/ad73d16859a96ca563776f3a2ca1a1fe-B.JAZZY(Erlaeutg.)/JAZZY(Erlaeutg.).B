Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 WINDOW:CLS
   20 FOR I=1 TO 30
   30 PRINT AT(6,I);"+"
   40 PRINT AT(7,I);"*"
   50 PRINT AT(17,I);"*"
   60 PRINT AT(18,I);"+"
   70 NEXT I
   80 PRINT AT(12,9);"J  A  Z  Z  Y"
   90 PRINT AT(20,15);"by"
  100 PRINT AT(21,10);"Dieter Waldt"
  110 PRINT AT(22,10);"...Y2 8OH..."
  120 PAUSE 40
  130 CLS
  140 PRINT:PRINT:PRINT:INPUT "Spielregel J/N ?";X$
  150 IF X$="N" THEN GOTO 950
  160 CLS
  170 PRINT AT(12,2);"Spielregel:"
  180 PRINT AT(13,2);"***********"
  190 PRINT AT(15,2);"JAZZY - Ein Wuerfelspiel fuer"
  200 PRINT AT(16,2);"1 bis 4 Spieler"
  210 PRINT AT(18,2);"Folgende Werte sind zu "
  220 PRINT AT(19,2);"erreichen:"
  230 PRINT AT(30,20);">>ENTER<<"
  240 IF INKEY$<>CHR$(13) THEN GOTO 240
  250 CLS
  260 PRINT AT(6,2);"Die Pflichtwuerfe:"
  270 PRINT AT(7,2);"=================="
  280 PRINT AT(10,0);"  I.EINER   max. 6 Augen"
  290 PRINT AT(11,0);" II.Zweier  max.12 Augen"
  300 PRINT AT(12,0);"III.Dreier  max.18 Augen"
  310 PRINT AT(13,0);" IV.Vierer  max.24 Augen"
  320 PRINT AT(14,0);"  V.Fuenfer max.30 Augen"
  330 PRINT AT(15,0);" VI.Sechser max.36 Augen"
  340 PRINT AT(18,2);"Werden mit den Pflicht-"
  350 PRINT AT(19,1);"wuerfen mehr als 83 Augen"
  360 PRINT AT(20,1);"erreicht, erhaelt der"
  370 PRINT AT(21,1);"Spieler einen Bonus von 50."
  380 PRINT AT(30,20);">>ENTER<<"
  390 IF INKEY$<>CHR$(13) THEN GOTO 390
  400 CLS
  410 PRINT AT(5,2);"Stammwuerfe"
  420 PRINT AT(6,2);"============"
  430 PRINT AT(10,2);"Ein Zweier      max.12 Augen"
  440 PRINT AT(11,2);"Zwei Zweier     max.22 Augen"
  450 PRINT AT(12,2);"Drei Zweier     max.30 Augen"
  460 PRINT AT(13,2);"Ein Dreier      max.18 Augen"
  470 PRINT AT(14,2);"Ein Vierer      max.24 Augen"
  480 PRINT AT(15,2);"Ein Fuenfer     max.30 Augen"
  490 PRINT AT(16,2);"Jazzy               75 Augen"
  500 PRINT AT(17,2);"Zwei Dreier     max.33 Augen"
  510 PRINT AT(18,2);"kleiner Weg         15 Augen"
  520 PRINT AT(19,2);"grosser Weg         20 Augen"
  530 PRINT AT(20,2);"Strasse             25 Augen"
  540 PRINT AT(21,2);"kleines Haus    max.28 Augen"
  550 PRINT AT(22,2);"grosses Haus    max.34 Augen"
  560 PRINT AT(23,2);"Chance     Summe aller Augen"
  570 PRINT AT(24,2);"Joker    alles,ausser Chance"
  580 PRINT AT(30,20);">>ENTER<<"
  590 IF INKEY$<>CHR$(13) THEN GOTO 590
  600 CLS
  610 PRINT AT(6,2);"Erlaeuterungen"
  620 PRINT AT(7,2);"==============="
  630 PRINT AT(9,0);"- Bei den Pflichtwuerfen werden"
  640 PRINT AT(10,4);"die erreichten Augen eingtr."
  650 PRINT AT(12,0);"- Ein kleiner Weg besteht aus:"
  660 PRINT AT(13,4);"1-2-3-4-5"
  670 PRINT AT(15,0);"- Der grosse Weg:"
  680 PRINT AT(16,4);"2-3-4-5-6"
  690 PRINT AT(18,0);"- Eine Strasse besteht aus:"
  700 PRINT AT(19,4);"1-2-3-4-5-6"
  710 PRINT AT(21,0);"- Der Jazzy besteht aus"
  720 PRINT AT(22,2);"6 gleichen Augen-ein Sechser !"
  730 PRINT AT(24,0);"- Das kleine Haus:"
  740 PRINT AT(25,4);"einem Dreier u.einem Zweier"
  750 PRINT AT(27,0);"- Das grosse Haus aus einem"
  760 PRINT AT(28,4);"Vierer und einem Zweier"
  770 PRINT AT(31,20);">>ENTER<<"
  780 IF INKEY$<>CHR$(13) THEN GOTO 780
  790 CLS
  800 PRINT AT(10,0);"- Bei der Chance wird die"
  810 PRINT AT(11,2);"Summe aller Augen eingetragen,"
  820 PRINT AT(12,2);"ohne besonderem Bild"
  830 PRINT AT(14,0);"- Fuer den Joker kann jedes"
  840 PRINT AT(15,2);"Bild, ausser der Chance"
  850 PRINT AT(16,2);"eingetragen werden"
  860 PRINT AT(21,0);"Jeder Spieler kann 3 Wuerfe"
  870 PRINT AT(22,0);"ausfuehren."
  880 PRINT AT(23,0);"Die Wuerfel, mit denen nochmal"
  890 PRINT AT(24,0);"gewuerfelt werden soll, werden"
  900 PRINT AT(25,0);"geloescht"
  910 PRINT AT(27,0);"Das Ergebnis wird in die ent-"
  920 PRINT AT(28,0);"sprechende Zeile eingeschrieben"
  930 PRINT AT(30,20);">>ENTER<<"
  940 IF INKEY$<>CHR$(13) THEN GOTO 940
  950 CLS
