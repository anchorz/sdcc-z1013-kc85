Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10! Geaendert von Dirk Ambras
   20! am 17.6. u. 1.8.1990
   30 GOTO 150
   40 PRINT " ? ";
   50 A$=INKEY$:IF A$=""THEN 50:ELSE A$=CHR$(ASC(A$)AND 95)
   60 IF A$="J"THEN A2$="Ja.":ELSE IF A$="N"THEN A2$="Nein.":ELSE 50
   70 PRINT A2$:PRINT:PAUSE 5:RETURN
   80 PRINT "Geben Sie bitte zuerst ihr      Alter an:     Jahre.";
   90 PRINT STRING$(11,CHR$(8));:INPUT "";I:PRINT
  100 IF I>30 THEN Z=Z+2
  110 IF I>40 THEN Z=Z+1
  120 IF I>50 THEN Z=Z+1
  130 IF I>70 THEN Z=Z+1
  140 RETURN
  150 WINDOW:CLS:WINDOW 0,10,1,31
  160 PRINT "  LEBENSERWARTUNGSPROGNOSE":PRINT "  ";STRING$(24,"")
  170 PRINT "Nach Prof. Dr. Robert Allen":PRINT "vom human resources instituts"
  180 PRINT "Morristown (New Jersey, USA).":PRINT
  190 PRINT "Bitte beantworten Sie dazu     folgende Fragen mit J oder N.
  200 PRINT AT(9,0);STRING$(32,"")
  210 WINDOW 11,31,0,31:Z=71:GOSUB 80
  220 PRINT "Leben Sie in einer Groszstadt";:GOSUB 40
  230 IF A$="J"THEN Z=Z-2:GOTO 260
  240 PRINT "Leben Sie in einer Stadt unter"
  250 PRINT "10000 Einwohnern oder auf dem   Lande";:GOSUB 40:IF A$="J"THEN Z=Z+2
  260 PRINT "Wurde einer Ihrer Groszeltern ":PRINT "ueber 95 Jahre alt";
  270 GOSUB 40:IF A$="J"THEN Z=Z+2
  280 PRINT "Wurden alle vier Grosseltern    aelter als 80 Jahre";:GOSUB 40
  290 IF A$="J"THEN Z=Z+6
  300 PRINT "Starb ein Elternteil unter      50 Jahren an Herzinfarkt";
  310 GOSUB 40:IF A$="J"THEN Z=Z-4
  320 PRINT "Leiden Eltern oder Geschwister  unter 50 Jahren an Krebs, Herz-"
  330 PRINT "krankheit oder Diabetis";:GOSUB 40:IF A$="J"THEN Z=Z-3
  340 IF I<18 THEN 390:ELSE PRINT "Verdienen Sie ueber 2400 DM     monatlich";
  350 GOSUB 40:IF A$="J"THEN Z=Z-2
  360 PRINT "Haben Sie das Abitur";:GOSUB 40:IF A$="J"THEN Z=Z+1
  370 PRINT "Haben Sie studiert oder sind    Sie Meister";:GOSUB 40
  380 IF A$="J"THEN Z=Z+2
  390 IF I<60 THEN 410:ELSE PRINT "Arbeiten Sie noch";:GOSUB 40
  400 IF A$="J"THEN Z=Z+3
  410 IF I<25 THEN 450:ELSE PRINT "Sind Sie verheiratet oder leben Sie mit";
  420 PRINT "Jemandem";:GOSUB 40:IF A$="J"THEN Z=Z+5:ELSE Z=Z-INT((I-25)/10+1.5)
  430 PRINT "Arbeiten Sie im Buero";:GOSUB 40:IF A$="J"THEN Z=Z-3:GOTO 450
  440 PRINT "Arbeiten Sie koerperlich";:GOSUB 40:IF A$="J"THEN Z=Z+3
  450 PRINT "Treiben Sie aktiv Sport";:GOSUB 40:IF A$="J"THEN Z=Z+4:GOTO 480
  460 PRINT "Betaetigen Sie sich zweimal pro Woche sportlich";:GOSUB 40
  470 IF A$="J"THEN Z=Z+2
  480 PRINT "Schlafen Sie mehr als 10 Stundentaeglich";:GOSUB 40
  490 IF A$="J"THEN Z=Z-4
  500 PRINT "Werden Sie leicht wuetend";:GOSUB 40:IF A$="J"THEN Z=Z-3
  510 PRINT "Nehmen Sie das Leben leicht";:GOSUB 40:IF A$="J"THEN Z=Z+3
  520 PRINT "Sind Sie gluecklich";:GOSUB 40:IF A$="J"THEN Z=Z+1:GOTO 540
  530 PRINT "Sind Sie ungluecklich";:GOSUB 40:IF A$="J"THEN Z=Z-2
  540 IF I<14 THEN 660:ELSE PRINT "Sind Sie letztes Jahr beim
  550 PRINT "Schnellfahren erwischt worden";:GOSUB 40:IF A$="J"THEN Z=Z-1
  560 PRINT "Sind Sie Kettenraucher";:GOSUB 40:IF A$="J"THEN Z=Z-8:GOTO 600
  570 PRINT "Rauchen Sie taeglich eine       Packung Zigaretten";:GOSUB 40
  580 IF A$="J"THEN Z=Z-6:GOTO 600
  590 PRINT "Rauchen Sie am Tag 10 Zigaretten";:GOSUB 40:IF A$="J"THEN Z=Z-3
  600 PRINT "Trinken Sie mehr als zwei       Schnaepse oder Biere am Tag";
  610 GOSUB 40:IF A$="J"THEN Z=Z-1
  620 PRINT "Haben Sie ein Uebergewicht von  20 Kilo";:GOSUB 40
  630 IF A$="J"THEN Z=Z-8:GOTO 660
  640 PRINT "Oder sind es 15 Kilo";:GOSUB 40:IF A$="J"THEN Z=Z-4:GOTO 660
  650 PRINT "Aber doch bestimmt 5 Kilo";:GOSUB 40:IF A$="J"THEN Z=Z-2
  660 PRINT "Lassen Sie sich einmal im Jahr  vom Arzt untersuchen";
  670 GOSUB 40:IF A$="J"THEN Z=Z+2
  680 WINDOW 6,31,0,31:CLS:IF Z<=I THEN Z=I+1
  690 PRINT "Die Auswertung der Fragen ergibteine Lebenserwartung von"
  700 PRINT:PRINT "       *";MID$(STR$(Z),2);:PRINT "* Jahren.
  710 PRINT:PRINT "Anmerkung:":PRINT "Die Angaben ergeben sich aus"
  720 PRINT "den von Ihnen beantworteten"
  730 PRINT "Fragen. Individuelle Kriterien  konnten nicht beruecksichtigt
  740 PRINT "werden.":PRINT
  750 PRINT "Abweichungen vom Testergebnis   sind daher nicht ausgeschlossen."
  760 PRINT:PRINT TAB(14);"Noch einmal";:GOSUB 40:IF A$="J"THEN 150
  770 WINDOW:CLS:PRINT AT(12,8);"AUF WIEDERSEHEN !":PAUSE 30:CLS:END
