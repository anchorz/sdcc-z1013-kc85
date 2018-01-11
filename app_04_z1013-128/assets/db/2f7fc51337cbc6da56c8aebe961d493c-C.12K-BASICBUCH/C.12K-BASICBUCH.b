Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

    1 O.12
    2 TAB(96);P."STANDARD-BASIC-INTERPRETER";GOS.90
    3 P."Mit diesem Programm erlernen Sie"
    4 P."die Befehle des 12 kbyte-BASIC  "
    5 P."fuer den Z 1013 kennen.";P.;P.
    6 P."Sie koennen wie in einem Buch   "
    7 P."blaettern: <- eine Seite zurueck"
    8 TAB(11);P."-> eine Seite vor";P.
    9 TAB(11);P."__ zurueck zum Menue";P.;P.
   10 TAB(28);P."Ent!";F=INC.
   11 O.12;P."WAEHLEN SIE:";P.
   12 P." 1 Allgemeine Informationen"
   13 P." 2 Zugelassene Zeichen, Syntax"
   14 P." 3 Steuerzeichen"
   15 P." 4 ABS           5 ASC"
   16 P." 6 AUTO          7 CALL"
   17 P." 8 CHR$          9 CLEAR"
   18 P."10 CONT         11 COPY"
   19 P."12 DATA         13 DEF FN"
   20 P."14 DELETE       15 DIM"
   21 P."16 EDIT         17 EXCHANGE"
   22 P."18 EXP          19 FOR TO NEXT"
   23 P."20 FRE          21 GOSUB"
   24 P."22 GOTO         23 INP"
   25 P."24 IF THEN ELSE 25 INPUT"
   26 P."26 INSTR        27 INT"
   27 P."28 KILL         29 LEFT$"
   28 P."30 LEN          31 LET"
   29 P."32 LIST         33 LOAD"
   30 P."34 LOAD GO      35 LOAD?"
   31 P.;P."Im Teil 2 sind weitere 38 Befeh-le erklaert. Ausserdem erhalten⇘
       Sie dort Tips zum Programmauf-  bau.";P.;P.
   39 P.;INPUT"Ihre Wahl "W
   40 G=W
   45 O.12;TAB(64);GOSUBG*100
   47 X=PEEK(43);Y=PEEK(44);PO.((Y-256)*256+X),32
   50 F=INC.
   55 IFF=8G=G-1;GOTO70
   60 IFF=9G=G+1;GOTO70
   65 GOTO11
   70 IFG<1GOTO11
   75 IFG>35GOTO11
   80 GOTO45
   90 FORI=1TO32;P."*",;N.I;P.;RE.
  100 P."INFORMATIONEN";GOS.90
  105 P."Der Standard-BASIC-INTERPRETER  wird mit HEADER-SAVE geladen.";
      P.
  110 P."Er wurde an den Z 1013 ange-    passt und laeuft ohne Aenderung."
  125 P."Auf Memory End muss mit Ent     (oder &3FFF) geantwortet werden."
  130 P."Rechengenauigkeit: 11 (!) Digit."
  150 P."Der Interpreter kennt noch eini-ge Befehle mehr als hier be-    sc⇘
      hrieben. Sie sind aber  beim"
  160 P."Z 1013 nicht nutzbar!"
  170 P.;P."Alle Schluesselworte muessen    ausgeschrieben werden. Sie wer-⇘
       den jedoch kodiert (je 1Byte)   abgespeichert."
  180 P."Dadurch genuegen die freien 3k  Speicherplatz auch vielen An-   sp⇘
      ruechen. Eine RAM-Erweiterung ab 4000 waere sinnvoll.";RE.
  200 P."ZEICHEN, SYNTAX";GOSUB90
  205 P."Als Zeichen sind zugelassen:";P.
  207 P."alle Buchstaben    A - Z";P.
  210 P."alle Ziffern       0 - 9";P.
  215 P."+ Plus     - Minus    * Multipl."
  220 P."/ Division ^ Potenz   = Gleich  "
  225 P."$ Strings  & Hexzahl  ? PRINT   "
  230 P.". Dezimalpunkt  : Trennzeichen  "
  235 P.", druckt tabelliert";P.
  240 P."; druckt mit min. Abstand";P.
  242 P."# Druckformat festlegen (USING) "
  244 P."! wie #, siehe USING";P.
  247 P."( )  Klammern, bel. schachtelb. "
  248 P."<,>,=,<=,>=,<> Vergleichszeich. "
  298 RE.
  300 P."STEUERZEICHEN";GOS.90
  305 P."Folgende Codes beeinflussen den Interpreter:";P.;P.
  310 P."* bei Eingabe eines Programmes  "
  312 P."S4 B  gibt Zeile ohne Loeschzei-      chen neu aus (Uebersicht) "
  314 P."S4 E  loescht eingegebene Zeile       (vor Enter)";P.
  316 P."S4 L  geht in Monitor";P.
  318 P.
  320 P."* waehrend des Programmlaufs";P.
  330 P."S4 A  Programm geht weiter";P.
  333 P."S4 C  stoppt Programm (S4 A)";P.
  334 P."S4 J  BREAK (weiter mit CONT)";P.
  340 P."S4 M  unterdrueckt Ausgabe";P.
  350 P."S4 O  gibt gerade bearbeitete         Zeilennummer aus";
      RE.
  400 P."ABS";GOS.90
  410 P."Absolutwert";P.;P.
  420 P."ABS(-4.5)  -> 4.5";P.
  430 P."ABS(4.5)   -> 4.5"
  440 RE.
  500 P."ASC";GOS.90
  510 P."Zeichencode des ersten Zeichens eines $";P.
  520 P."B$=ABC";P.
  530 P."ASC(B$)    ->65"
  540 RE.
  600 P."AUTO";GOS.90
  610 P."autom. Zeilennummervorgabe";P.;P.
  620 P."AUTO          ab 10, 10er Schr. "
  625 P."AUTO80        ab 80, 10er  ''   "
  630 P."AUTO50,20     ab 50, 20er  ''";RE.
  700 P."CALL";GOS.90
  710 P."Maschinencodeunterprogrammaufruf";P.
  720 P."CALL&F130    ruft UP auf, kehrt "
  730 TAB(13);P."bei C9 zurueck.";P.;P.
  740 P."& als Vorsatz bei Hexzahlen !";RE.
  800 P."CHR$";GOS.90
  810 P."wandelt Zeichencode in Zeichen  "
  820 P.;P."CHR$(66)    -> B";P.
  830 P."?CHR$(12)   -> Bildschirm"
  835 TAB(15);P."loeschen";RE.
  900 P."CLEAR";GOS.90
  910 P."Loeschen aller Variablen";P.
  920 P.;P."CLEAR      wie oben";P.
  930 P."CLEAR200   wie oben, setzt Platz"
  940 TAB(11);P."fuer $ zusaetzl. auf  "
  950 TAB(11);P."200 Byte."
  960 RE.
 1000 P."CONT";GOS.90
 1010 P."setzt Programmlauf fort (nach   "
 1020 P."BREAK oder STOP), wenn nichts   "
 1030 P."am Programm geaendert wurde";P.;P.
 1040 RE.
 1100 P."COPY";GOS.90
 1110 P."Vervielfaeltigen von Programm-  zeilen";P.;P.
 1120 P."COPY100,5=10-28";P.;P.
 1130 P."Kopiert ab Zeile 100, in 5er    "
 1140 P."Schritten, die Zeilen 10 bis 28."
 1145 P.;P.
 1150 P."COPY1000=40    fuer eine Zeile";RE.
 1200 P."DATA";GOS.90
 1210 P."Konstantenablage";P.;P.
 1220 P."DATA234,1E-5,tpe,667";P.
 1230 P."die in DATA-Zeilen lagernden    "
 1240 P."Konstanten werden mit READ bei  "
 1250 P."Bedarf 'geholt'."
 1260 RE.
 1300 P."DEF FN";GOS.90
 1310 P."Definieren einer Funktion";P.;P.
 1320 P."DEF FN A(X)=X^2+C";P.;P.
 1330 P."Die Funktion A wird z.B. mit";P.
 1340 P."K=FNA(6) aufgerufen. C ist die  "
 1350 P."Variable C, waehrend X nur ein  "
 1360 P."Parameter ist.";P.
 1370 P."In diesem Fall wird fuer X 6";P.;P."eingesetzt.";RE.
 1400 P."DELETE";GOS.90
 1410 P."Zeilen loeschen";P.;P.
 1430 P."DELETE10-35   loescht alle Zei- "
 1440 TAB(14);P."len von 10 bis 35";RE.
 1500 P."DIM";GOS.90
 1510 P."Reserviert Speicherplatz fuer   ";P."Felder";P.;P.
 1520 P."DIMA(6)    num. Feld, 6  Elemen-";TAB(11);P."te";P.
 1530 P."DIMB(3,6)  num. Feld, 3*6 Elem. "
 1540 P."DIMC$(4)   Stringfeld, 4 Elem.  ";P.;P.
 1550 P."Felder koennen max. 255 Dimen-  sionen haben."
 1560 RE.
 1600 P."EDIT";GOS.90
 1610 P."Korrekturmodus";P.;P.
 1620 P."EDIT30   holt Zeile 30 in Kor-";TAB(9);P."rekturmodus";P.
 1630 P."Die folgenden Zeichen helfen den"
 1640 P."Kursor zu steuern bzw. zu korri-"
 1650 P."gieren. Sie erscheinen nicht !  ";P.
 1660 P."A   laedt EDIT-Buffer neu"
 1670 P."L   listet die Zeile"
 1680 P."nD  loescht ab Kursor n Zeichen"
 1690 P."nFm rueckt Kursor auf ntes Z. m"
 1691 P."H   loescht alles ab Kursor"
 1692 P."I   fuegt Zeichen ein bis Enter"
 1693 P."nKm loescht ab Kursor bis n.Z.m"
 1694 P."Q   ohne Korrektur zurueck"
 1695 P."nR  ueberschreibt n Zeichen"
 1696 P."X   Kursor an letzte Stelle ->I"
 1697 P.
 1698 P."Das Ueberschreiben von Zeilen   ist nat. auch mgl.";RE.
 1700 P."EXCHANGE";GOS.90
 1710 P."schneller Variablentausch";P.;P.
 1720 P."EXCHANGE A,B";P.
 1730 P."EXCHANGE A$,B$";P.
 1740 P."EXCHANGE C,D(4,6)";RE.
 1800 P."EXP";GOS.90
 1810 P."Exponentialfunktion Basis e";P.;P.
 1820 P."EXP(1)  -> 2.71828 = e"
 1830 RE.
 1900 P."FOR TO NEXT STEP";GOS.90
 1910 P."Schleifenzaehler";P.;P.
 1920 P."FOR I=0 TO 10 STEP 2";P.
 1930 P."Die Variable I nimmt zuerst den WERT 0 an, durchlaeuft die Zei- le⇘
      n vor NEXT, erhoeht sich dann"
 1940 P."um 2 (STEP), sooft bis 10 er-   reicht ist. Dann wird mit den   Be⇘
      fehlen nach NEXT fortgesetzt. "
 1950 P.;P."SYNTAX:";P.
 1960 P."FOR I=X TO Y STEP Z"
 1970 P."...";P."...";P."..."
 1976 P.
 1980 P."NEXT I";RE.
 2000 P."FRE";GOS.90
 2010 P."Speicherfreiraum";P.;P.
 2020 P."?FRE(Q)   ergibt gesamten frei-";TAB(10);P."en RAM";P.
 2030 P."?FRE(Q$)  ergibt freien String-";TAB(10);P."platz (CLEAR)";
      RE.
 2100 P."GOSUB";GOS.90
 2110 P."BASIC-Unterprogrammaufruf";P.;P.
 2120 P."GOSUB 2000";P.;P.
 2130 P."Ruft ein UP ab Zeile 2000 auf.  Dieses muss mit RETURN enden.   Da⇘
      s Programm  wird dann nach demGOSUB-Befehl fortgesetzt."
 2140 RE.
 2200 P."GOTO";GOS.90
 2211 P."Unbedingter Sprung";P.;P.
 2222 P."GOTO 100";P.;P.
 2233 P."Setzt den Programmlauf ab Zei-  le 100 fort.";RE.
 2300 P."INP";GOS.90
 2310 P."liest Systemport";P.;P.
 2321 P."INP(2)   uebergibt dezimalen             Wert aus Port mit der    ⇘
             hexadez. Adresse 2.";P.;P.
 2333 P."SYNTAX:";P.
 2344 P."A=INP(2)";P."IF INP(0)>B THEN...";RE.
 2400 P."IF THEN ELSE";GOS.90
 2410 P."wenn...dann...sonst";P."Bedingte Ausfuehrung von Befeh- len";
      P.;P.
 2420 P."IF A=5 THEN D=5 ELSE 200";P.;P.
 2430 P."Wenn die Bedingung zutrifft,    dann wird der Teil nach THEN    au⇘
      sgefuehrt, wenn nicht, der    nach ELSE.";P.
 2440 P."THEN 330   ->  GOTO 330";P.
 2444 P."ELSE kann weggelassen werden.   Trifft die Bedingung nicht zu,  wi⇘
      rd mit der naechsten Zeile    fortgesetzt.";RE.
 2500 P."INPUT";GOS.90
 2510 P."Eingabe von Daten ueber Tasta-  tur";P.;P.
 2520 P."INPUTM    fuer Zahlen";P.
 2530 P."INPUTM$   fuer Strings";P.
 2541 P."INPUT",;O.34;P."WERT 1",;O.34;P.";W1";P.
 2550 P."INPUT",;O.34;P."NAME",;O.34;P.";NA$";P.
 2565 P."LINE INPUT",;O.34;P."TEXT",;O.34;P.";F$  fuer Zeilen";P.
 2566 P.;P."Der Text zwischen ",;O.34;O.34;P." und ein ?  werden mit ausgeg⇘
      eben."
 2577 RE.
 2600 P."INSTR";GOS.90
 2610 P."sucht String im String und gibt Position an, ab der der Such-   st⇘
      ring gefunden wurde";P.;P.
 2620 P."A$=ABCDEFG";P.
 2631 P."B$=CD";P.;P.
 2634 P."INSTR(A$,B$)   -> 3";P.
 2635 P."INSTR(B$,A$)   -> 0 (nicht gef.)";RE.
 2700 P."INT";GOS.90
 2710 P."ermittelt naechst kleinere      ganze Zahl";P.;P.
 2720 P."INT(2.345)   -> 2";P.
 2740 P."INT(-1.34)   ->-2";RE.
 2800 P."KILL";GOS.90
 2810 P."gewinnt Speicherplatz zurueck,  der mit DIM fuer Felder reser-  vi⇘
      ert wurde.";P.;P.
 2820 P."KILL A     nimmt DIMA(...) zur. "
 2831 P."KILLA,C,E";RE.
 2900 P."LEFT$";GOS.90
 2910 P."ermittelt Teilstring eines      Strings von ganz links ab";
      P.;P.
 2915 P."LEFT$(A$,5)";P.
 2920 P."uebergibt die ersten 5 Zeichen  aus A$";RE.
 3000 P."LEN";GOS.90
 3011 P."ermittelt Laenge eines Strings  ";P.
 3012 P.;P."A$=ABCDEFG";P.
 3031 P."LEN(A$)   -> 7";RE.
 3100 P."LET";GOS.90
 3110 P."Wertzuweisung";P.;P.
 3120 P."LET A=5.569";P.
 3130 P."LET A$=",;O.34;P."tpe",;O.34;P.;P.
 3140 P.;P."'LET' kann weggelassen werden.";P.
 3150 P."A=5:A$=",;O.34;P."ABC",;O.34;RE.
 3200 P."LIST";GOS.90
 3210 P."Programmauflisten";P.;P.
 3220 P."LIST         zeigt ges. Programm"
 3222 P.">Unterbrechen mit S4O, weiter O<";P.;P.
 3230 P."LIST 20      eine Zeile";P.
 3240 P."LIST -50     ab Anfang bis 50   "
 3250 P."LIST 70-     ab 70 bis Ende     "
 3260 P."LIST 20-300  von 20 bis 300";RE.
 3300 P."LOAD";GOS.90
 3310 P."Magnetband lesen";P.;P.
 3321 P."LOAD A  laedt das Programm, wel-ches mit SAVE A gespeichert wur-de⇘
      .";P.;P.
 3333 P."Es ist nur ein Buchstabe moeg-  lich und gleichzeitig notwendig."
 3344 P."LOAD fuehrt selbst vorm Laden   NEW durch."
 3355 RE.
 3400 P."LOAD GO";GOS.90
 3410 P."LOADGOA   wie LOAD A, jedoch mitautomatischem RUN";P.;P.
 3420 P."LOADGOA,100   Start ab 100"
 3440 RE.
 3500 P."LOAD?";GOS.90
 3510 P."Prueflesen";P.;P.
 3520 P."LOAD?A  vergleicht Magnetband-          aufzeichnung mit Spei-    ⇘
            cherinhalt.";P.
 3540 P."        (SAVEA)";P.
 3550 P."Bei fehlerhafter Aufzeichnung:";P.;P."FILES DIFFERENT"
 3566 RE.
17996 