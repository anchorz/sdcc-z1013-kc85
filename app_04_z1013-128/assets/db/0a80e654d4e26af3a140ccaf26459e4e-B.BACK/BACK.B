Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 CLEAR 512
   20 REM**************************
   30 REM* ZURUECK IN DIE ZUKUNFT *
   40 REM*                        *
   50 REM* Copyricht April 1988 by*
   60 REM*    Stefan BOLLER       *
   70 REM*                        *
   80 REM* for Z1013 by scharsoft *
   90 REM*      in 1989           *
  100 REM**************************
  110 GOSUB 5850
  120!
  130!
  140!
  150!
  160!
  170!
  180!
  190 AN=27:OT=3:WV=4:WG=4:PU=1:YE=1985:YE(2)=1955:CO=0:C=0:ZA=0:ZE=227:KI=0
  200 SC=0:SU=0
  210 DIM GA(38,6),OT$(38),VE$(9),G1$(AN),G2$(AN),GE(AN)
  220!
  230! TITELBILD
  240!
  250:
  260 PRINT AT(8,4);"Zurueck in die ZUKUNKT"
  270 PRINT AT(24,10);"BITTE WARTEN"
  280 FOR I=1 TO 38:READ OT$(I):FOR J=1 TO 6:READ GA(I,J):NEXT J,I
  290 FOR I=1 TO AN:READ G1$(I),G2$(I),GE(I):G2$(I)=LEFT$(G2$(I),WG):NEXT
  300 FOR I=1 TO 9:READ VE$(I):VE$(I)=LEFT$(VE$(I),WV):NEXT
  310 FOR I=1 TO 6:READ RI$(I):NEXT
  320 PRINT AT(24,6);"--------------------"
  330 PRINT AT(24,6);"BITTE TASTE DRUECKEN":IF INKEY$=""THEN 320:ELSE WINDOW
  340!
  350! ANLEITUNG
  360!
  370 FOR XX=0 TO 30:PRINT AT(XX+1,0);STRING$(32,"")
  380 PRINT AT(XX,0);STRING$(32," "):NEXT XX:PRINT AT(31,0);STRING$(32," ")
  390 PRINT:PRINT TAB(16)"1985"
  400 PRINT:PRINT "Wir schreiben das Jahr 1985,Dein";
  410 PRINT "Name ist Marty McFly, Du bist 17";
  420 PRINT "Jahre alt und wohnst in Hill "
  430 PRINT "Velley. Das Spiel beginnt in der";
  440 PRINT "Schule. Du willst gerade nach"
  450 PRINT "Hause gehen ..."
  460 PRINT:PRINT "Noch etwas zur Steuerung:"
  470 PRINT "Du bewegst Dich in Hill Velley"
  480 PRINT "mit Zweiwortbefehlen, wie z.B."
  490 PRINT "NIMM VIDEOKAMMERA oder"
  500 PRINT "UNTERSUCHE SCHILD"
  510 PRINT:PRINT "Durch Druecken der V-Taste er-"
  520 PRINT "haelt man einige Hinweise. Wenn"
  530 PRINT "man das Verb FRAGE eingibt, und"
  540 PRINT "als Gegenstang eine Person er-"
  550 PRINT "haelt man die Antword dieser "
  560 PRINT "Person."
  570 PRINT "                 Viel Spass ..."
  580 PRINT:PRINT "                  [TASTE]"
  590 IF INKEY$=""THEN 590
  600!
  610! BILDSCHIRM
  620!
  630 FOR XX=31 TO 1 STEP-1:PRINT AT(XX,0);STRING$(32," ")
  640 PRINT AT(XX-1,0);STRING$(32,""):NEXT:PRINT AT(0,0);STRING$(32," ")
  650 WINDOW 5,29,1,29:PRINT AT(0,20);">scharsoft<"
  660 PRINT AT(4,0);" "
  670 PRINT AT(30,0);""
  680 PRINT AT(31,0);" "
  690 FOR AA=5 TO 29:PRINT AT(AA,30);"":NEXT AA
  700 FOR AA=5 TO 29:PRINT AT(AA,0);CHR$(159):NEXT AA
  710 PRINT AT(2,12);YE 
  720 CLS:PRINT OT$(OT):PRINT
  730 PU=PU+1
  740 IF CU THEN C=C+1:IF C>8 THEN 750:ELSE 800
  750 FE$="Zu spaet! Der Blitz hal schon"
  760 FE$=FE$+"eingeschlagen und Du hast iHn" 
  770 FE$=FE$+"verpasst. Du musst wohl oder "
  780 FE$=FE$+"uebel hier bleiben. (1985)"
  790 GOTO 1890
  800 IF GE(5)=32 THEN GE(14)=32
  810 PRINT "DU SIEHST:":FOR I=1 TO AN 
  820 IF GE(I)=OT THEN PRINT G1$(I):QQ=1
  830 NEXT I
  840 IF QQ<>1 THEN PRINT " nichts Sehenswertes"
  850 QQ=0:PRINT:PRINT "DU KANNST NACH"
  860 FOR I=1 TO 6:IF GA(OT,I)<255 THEN PRINT RI$(I);",";:Q=1
  870 NEXT:PRINT CHR$(8);" gehen."
  880 IF Q<>1 THEN PRINT CHR$(11);STRING$(20," ")
  890 IF ZA>0 THEN IF ZA>4 THEN IF ZE=227 THEN 900:ELSE 940
  900 IF OT<>17 THEN 940
  910 PRINT "Ein Transporter kommt ange-"
  920 PRINT "fahren. Er ist mit Libyern "
  930 PRINT "besetzt."
  940 IF ZA>0 THEN IF ZA>7 THEN IF ZE=227 THEN IF OT=17 THEN 950:ELSE 980
  950 PRINT "Sie erschiessen Doc Brown,da" 
  960 PRINT "er ihnen nicht das lieferte," 
  970 PRINT "was sie wollten-eine Bombe." 
  980 IF ZA>0 THEN IF ZA>9 THEN IF ZE=227 THEN IF OT=17 THEN 990:ELSE 1020
  990 PRINT "Sie wollen Dich auch er-"
 1000 PRINT "schiessen, Marty. Mach dass" 
 1010 PRINT "Du weg kommst ..."
 1020 IF ZA>0 THEN IF ZA>11 THEN IF ZE=227 THEN IF OT=17 THEN 1030:ELSE 1070
 1030 FE$="Aarrrgh! Du hast zu lange ge-"
 1040 FE$=FE$+"wartet und wurdest auch  "
 1050 FE$=FE$+"erschossen."
 1060 GOTO 1890
 1070 IF GE(16)=18 AND GE(18)=85 THEN GE(15)=18:GE(14)=16
 1080 IF GE(18)=85 THEN IF OT<>18 THEN IF KI<>1 THEN PRINT "George folgt Dir."
 1090 IF OT=16 OR OT=17 THEN ZA=ZA+1
 1100 Q=0:IF INKEY$<>""THEN 1100:ELSE E$="":EI$="":PRINT:PRINT CHR$(ZE);
 1110 E$=INKEY$:IF E$=""THEN 1110
 1120 E=ASC(E$) 
 1130 IF E=8 AND LEN(EI$)>0 THEN 1140:ELSE 1150
 1140 PRINT CHR$(8)" "CHR$(8);:EI$=LEFT$(EI$,LEN(EI$)-1):GOTO 1110
 1150 IF E$=CHR$(13)AND LEN(E$)>0 THEN PRINT:GOTO 1180
 1160 IF LEN(EI$)>36 OR E<32 OR E>122 THEN 1110
 1170 EI$=EI$+E$:PRINT E$;:GOTO 1110
 1180 IF LEN(EI$)>6 THEN 1430
 1190 IF EI$="B"THEN 720
 1200 IF EI$<>"I"THEN 1240
 1210 PRINT "Du hast folgendes bei dir:"
 1220 TA=0:FOR I=1 TO AN:IF GE(I)=255 THEN PRINT G1$(I):TA=TA+1
 1230 NEXT I:IF TA=0 THEN PRINT:PRINT "nichts":GOTO 890:ELSE 890
 1240 IF EI$<>"V"THEN 1290
 1250 PRINT "Du kannst unter anderem diese":PRINT "Verben benutzen:"
 1260 RESTORE 5430:FOR I=1 TO 4:READ V$:PRINT V$;", ";:NEXT I
 1270 PRINT "I fuer INVENTUR, B fuer BILD-";
 1280 PRINT "SCHIRM, P fuer Punkte, ENDE":GOTO 890
 1290 IF EI$<>"P"THEN 1320
 1300 PRINT "Du hast"PU "Punkte erreicht.":GOTO 890
 1310!
 1320! RICHTUNGEN
 1330!
 1340 I=1:IF EI$="N"OR EI$=RI$(I)THEN 1400
 1350 I=2:IF EI$="S"OR EI$=RI$(I)THEN 1400
 1360 I=3:IF EI$="W"OR EI$=RI$(I)THEN 1400
 1370 I=4:IF EI$="O"OR EI$=RI$(I)THEN 1400
 1380 I=5:IF EI$="OB"OR EI$=RI$(I)THEN 1400
 1390 I=6:IF EI$="U"OR EI$=RI$(I)THEN 1400:ELSE 1430
 1400 IF GA(OT,I)=255 THEN PRINT "Dahin fuehrt kein Weg, Marty":GOTO 890
 1410 OT=GA(OT,I):PRINT "Ok.":GOTO 720
 1420!
 1430!
 1440!
 1450 GOTO 1570
 1460:
 1470:
 1480 GOTO 890
 1490!
 1500!
 1510!
 1520:
 1530:
 1540:
 1550 GOTO 890
 1560!
 1570! SPIELENDE
 1580!
 1590 IF EI$<>"ENDE"THEN 1680
 1600 INPUT "Gigst du schon auf Marty ?";A$:IF A$="J"THEN 1610:ELSE 890
 1610 CLS:PRINT AT(5,4);"Bis zum naechsten mal.":PRINT AT(7,4);PU
 1620 PRINT AT(7,7);"Punkte":PAUSE 100                                 
 1630 WINDOW:CLS:PRINT AT(15,12);"good bye":PRINT AT(17,9);"say >scharsoft<"
 1640 PRINT AT(20,7);"Copyricht by :":PRINT AT(22,10);"Uwe Sccharsig"
 1650 PRINT AT(23,10);"Beethovenstr.12":PRINT AT(24,10);"Riesa" 
 1660 PRINT AT(25,10);"8400":PAUSE 100:CLS:END
 1670!
 1680! EINGABE
 1690!
 1700 VE$=LEFT$(EI$,WV):FOR I=1 TO LEN(EI$):IF MID$(EI$,I,1)=" "THEN 1720
 1710 NEXT I:GOTO 1730
 1720 GE$=MID$(EI$,I+1,WG):GOTO 1730
 1730 FOR V=1 TO 9:IF VE$=VE$(V)THEN 1740:ELSE NEXT V:GOTO 1750
 1740 FOR G=1 TO AN:IF GE$=G2$(G)THEN 1950:ELSE NEXT G
 1750 A=INT(RND(1)*2)+1
 1760 IF A=1 THEN PRINT "Wie bitte?":GOTO 890
 1770 PRINT "Wie meinst Du das?":GOTO 890
 1780!
 1790! SIEG
 1800!
 1810 CLS:PRINT "HERZLICHEN GLUECKWUNSCH!":PRINT PU;"PUNKTE":PRINT
 1820 PRINT YE
 1830:
 1840 PRINT:PRINT "Du bist wieder zu Hause."
 1850 PRINT "Wieder im Jahre 1985 ."
 1860:
 1870 PRINT:PRINT " - ENDE - ":PAUSE 100:GOTO 1630
 1880!
 1890! TOD
 1900!
 1910 CLS:PRINT
 1920 PRINT FE$:PRINT:PRINT "ENDE DES SPIELES":PRINT
 1930 PRINT "Du hast"PU "Punkte."
 1940 PRINT:INPUT "nochmal? (J/N)";A$:IF A$="N"THEN 1610:ELSE RUN
 1950 ON V GOTO 1970,2170,2270,2880,3340,3490,3770,3840,4140
 1960!
 1970! NIMM
 1980!
 1990 IF G=1 AND OT=3 THEN 2000:ELSE 2010
 2000 PRINT "Tut mir leid, er ist an der  Wand festgeschraubt.":GOTO 890
 2010 IF G=2 AND OT=1 THEN 2020:ELSE 2030
 2020 PRINT "Das Telefon ist mit dem Kabelin der Wand befestigt.":GOTO 890
 2030 IF G=3 AND GE(3)=OT THEN PRINT "Ok.":GE(3)=255:GOTO 890
 2040 IF G=4 AND GE(4)=OT THEN PRINT "Ok.":GE(4)=255:GOTO 890
 2050 IF G=5 AND GE(5)=OT THEN 2060:ELSE 2080
 2060 PRINT "Der DeLorean ist zu schwer,  um ihn zu tragen. So ein Auto"
 2070 PRINT "wiegt mindestens eine Tonne.":GOTO 890
 2080 IF G=6 AND GE(6)=OT THEN PRINT "Ok.":GE(6)=255:ZA=ZA+1:GOTO 890
 2090 IF G=7 AND GE(7)=OT THEN PRINT "Ok.":GE(7)=255:GOTO 890
 2100 IF G=8 AND GE(8)=OT THEN 2110:ELSE 2120
 2110 PRINT "Was willst du mit dem Schild,Marty?":GOTO 890
 2120 IF G=9 AND GE(9)=OT THEN PRINT "Ok.":GE(9)=255:GOTO 890
 2130 IF G=10 AND GE(10)=OT THEN PRINT "Was willst du mit dem Spind?":GOTO 890
 2140 IF G=26 AND GE(26)=OT THEN PRINT "Ok.":GE(26)=255:GOTO 890
 2150 PRINT "Das geht nicht, Marty.":GOTO 890
 2160!
 2170! LEGE
 2180!
 2190 IF G=3 AND GE(3)=255 THEN PRINT "Ok.":GE(3)=OT:GOTO 890
 2200 IF G=4 AND GE(4)=255 THEN PRINT "Ok.":GE(4)=OT:GOTO 890
 2210 IF G=6 AND GE(6)=255 THEN PRINT "Ok.":GE(6)=OT:GOTO 890
 2220 IF G=7 AND GE(7)=255 THEN PRINT "OK.":GE(7)=OT:GOTO 890
 2230 IF G=9 AND GE(9)=255 THEN PRINT "Ok.":GE(9)=OT:GOTO 890
 2240 IF G=26 AND GE(26)=255 THEN PRINT "Ok.":GE(26)=OT:GOTO 890
 2250 PRINT "Das hast du nicht bei dir.":GOTO 890
 2260!
 2270! UNTERSUCHE
 2280!
 2290 IF G=19 AND GE(19)=OT THEN PRINT "Es ist eine Schellackplatte.":GOTO 890
 2300 IF G=20 AND GE(20)=OT THEN PRINT "Es sind sehr grosse Plakate.":GOTO 890
 2310 IF G=21 AND GE(21)=OT THEN PRINT "Es sind Hochglanzplakate.":GOTO 890
 2320 IF G=22 AND GE(22)=OT THEN 2330:ELSE 2350
 2330 PRINT "Sie ist etwa 1,50m hoch und  hat einen Durchmesser von 30m." 
 2340 GOTO 890
 2350 IF G=1 AND OT=3 THEN 2360:ELSE 2400
 2360 PRINT "Du hoerst eine Durchsage:"
 2370 PRINT "Marty McFly,bitte in die Ver-";
 2380 PRINT "waltung. Dringender Telefon-"  
 2390 PRINT "anruf fuer Marty McFly.":GOTO 890
 2400 IF G=23 AND OT=18 THEN PRINT:ELSE 2450
 2410 PRINT "Tanzverantstaltung unter dem"
 2420 PRINT "Thema: 'Verzauberung unter"
 2430 PRINT "        Wasser'  Heute 20Uhr"
 2440 PRINT "                 Eintritt 1$":GOTO 890
 2450 IF G=2 AND OT=1 THEN PRINT "Es ist ein schwarzes Telefon.":GOTO 890
 2460 IF G=25 AND OT=10 AND SC<>1 THEN 2470:ELSE 2500
 2470 PRINT "Es ist ein schoenes Modell,"
 2480 PRINT "ein Gelaendewagen. Im Hand-"
 2490 PRINT "schufach liegt etwas. > B <":GE(26)=OT:SC=1:GOTO 890
 2500 IF G=25 AND OT=10 AND SC=1 THEN 2510:ELSE 2530
 2510 PRINT "Es ist ein schoenes Modell,"
 2520 PRINT "ein Gelaendewagen."GOTO 890
 2530 IF G=3 AND GE(3)=255 OR G=3 AND GE(3)=OT THEN 2540:ELSE 2570
 2540 PRINT "Es besteht aus Recycling -"
 2550 PRINT "Papier und ist etwa 20x10cm"
 2560 PRINT "gross.":GOTO 890
 2570 IF G=4 AND GE(4)=255 OR G=4 AND GE(4)=OT THEN 2580:ELSE 2610
 2580 PRINT "Sie ist ein Fabrikat von SONY"
 2590 PRINT "mit Zoom und allem drum und"
 2600 PRINT "dran.":GOTO 890
 2610 IF G=5 AND GE(5)=OT THEN 2620:ELSE 2640
 2620 PRINT "Es ist eine Zeitmaschine,als"
 2630 PRINT "DeLorean getarnt.":GOTO 890
 2640 IF G=6 AND GE(6)=OT OR G=6 AND GE(6)=255 THEN 2650:ELSE 2680
 2650 PRINT "Er ist grellorange und hat "
 2660 PRINT "einen Helm mit 'Windschutz-"
 2670 PRINT "scheibe' aus Plexiglas.":GOTO 890
 2680 IF G=7 AND GE(7)=OT OR G=7 AND GE(7)=255 THEN 2690:ELSE 2710
 2690 PRINT "Er ist von SONY. Ein kleines"
 2700 PRINT "aber leistungsstarkes Modell.":GOTO 890
 2710 IF G=8 AND OT=27 THEN PRINT "Es ist etwa 1,50m hoch und 2m";:ELSE GOTO 2730
 2720 PRINT "breit und ist beschriftet.":GOTO 890
 2730 IF G=9 AND GE(9)=255 OR G=9 AND GE(9)=OT THEN 2740:ELSE GOTO 2770
 2740 PRINT "Es ist eine E-Gitarre,fuer"
 2750 PRINT "das Jahr 1955 gar nicht mal"
 2760 PRINT "so schlecht.":GOTO 890
 2770 IF G=10 AND OT=19 THEN PRINT "Es ist ein grauer Spind.":GOTO 890
 2780 IF G=24 AND OT=2 THEN PRINT "Es ist 2 x 3 m gross.":GOTO 890
 2790 IF G=11 AND OT=28 THEN 2800:ELSE 2820
 2800 PRINT "Sie ist etwa 2 x 3 m gross"
 2810 PRINT "Theke.":GOTO 890
 2820 IF G=26 AND GE(26)=O TO RG=26 AND GE(26)=255 THEN 2830:ELSE 2840
 2830 PRINT "Es ist ein schwerer Eisen-   schluessel.":GOTO 890
 2840 IF G=27 AND OT=35 THEN PRINT "Sie ist mannshoch und aus be-";:ELSE 2860
 2850 PRINT "steht aus Eisen.":GOTO 890
 2860 PRINT "Das geht nicht, Marty.":GOTO 890
 2870!
 2880! BENUTZE
 2890!
 2900 IF G=2 AND OT=1 THEN 2910:ELSE 2970
 2910 PRINT "Du hoerst folgendes:":PRINT
 2920 PRINT "Marty, ich bin's, Doc. Ich"
 2930 PRINT "muss Dich unbedingt sprechen"
 2940 PRINT "Komm' doch bitte so schnell"
 2950 PRINT "wie moeglich zu Twin Pines"
 2960 PRINT "Mall, dem Einkaufszentrum.":PRINT:GA(12,2)=16:GOTO 890
 2970 IF G=25 AND OT=10 THEN 2980:ELSE 3020
 2980 FE$="Du setzt Dich in den Wagen und  "
 2990 FE$=FE$+"braust durch die Schaufenster-  "
 3000 FE$=FE$+"scheibe. Du musst den Schaden   "
 3010 FE$=FE$+"bezahlen.":GOTO 1890
 3020 IF G=4 AND GE(4)=255 THEN PRINT "Ok.Sie zeichnet alles auf.":ELSE 3040
 3030 PU=PU+50:GOTO 890
 3040 IF G=5 AND GE(5)=32 THEN YE=1985:GOTO 1790
 3050 IF G=6 AND GE(6)=255 THEN PRINT "Ok.Du ziehst ihn an.":GOTO 890
 3060 IF G=7 AND GE(7)=255 THEN 3070:ELSE 3090
 3070 PRINT "Du hoerst  Huey Lewis' POWER" 
 3080 PRINT "OF LOVE.":PU=PU+10:GOTO 890
 3090 IF G=9 AND GE(9)=255 AND OT=18 AND GE(15)=18 THEN KI=1
 3100 IF G=9 AND GE(9)=255 AND OT=18 AND GE(15)=18 AND GE(16)=18 THEN 3110:ELSE 3170
 3110 PRINT "Du beginnst zu spielen und"  
 3120 PRINT "Deine zukuenftigen Eltern "
 3130 PRINT "kommen sich naeher.Vielleicht";
 3140 PRINT "solltest Du Dich besser be-"
 3150 PRINT "eilen, um zu Doc Brofwn zu "
 3160 PRINT "kommen.":CO=1:GE(5)=32:GOTO 890
 3170 IF G=5 AND OT=17 AND GE(6)=255 THEN 5510:ELSE IF G=5 AND OT=17 THEN 3180:ELSE 3220
 3180 PRINT "Du brauchst einen Strahlen-"
 3190 PRINT "schutzanzug, der DeLorean"
 3200 PRINT "wird mit Plutonium betrieben"
 3210 PRINT "welches radioaktiv ist.":GOTO 890
 3220 IF G=26 AND OT=35 AND GE(26)=255 THEN IF SU<>1 THEN 3240
 3230 GOTO 5140
 3240 PRINT "Sie schwingt auf.Dahinter ist";
 3250 PRINT "eine kleine Kammer, in der"
 3260 PRINT "etwas an einem Hacken haengt"
 3270 PRINT "Druecke > B <":GE(6)=35:SU=1:GOTO 890
 3280 IF G=26 AND OT=35 AND GE(26)=255 AND GE(6)=255 THEN IF SU<>0 THEN 3300
 3290 GOTO 3320
 3300 PRINT "Die Kammer hinter der Tuer"
 3310 PRINT "ist jetzt leer.":GOTO 890
 3320 PRINT "Das geht nicht.":GOTO 890
 3330!
 3340! OEFFNEN
 3350!
 3360 IF G=10 AND OT=19 THEN PRINT "Es ist etwas darin. > B <":PU=PU+10:GE(9)=OT
 3370 IF G=10 AND OT=19 THEN 890
 3380 IF G=27 AND OT=35 AND GE(26)=255 THEN IF SU<>1 THEN 3400
 3390 GOTO 3440
 3400 PRINT "Sie schwingt auf.Dahinter ist";
 3410 PRINT "eine kleine Kammer, in der"
 3420 PRINT "etwas an einem Hacken haengt.";
 3430 PRINT "Druecke > B <":GE(6)=35:SU=1:GOTO 890
 3440 IF G=27 AND OT=35 AND GE(26)=255 AND GE(6)=255 THEN IF SU<>0 THEN 3460
 3450 GOTO 3470
 3460 PRINT "Die Tuer steht bereits offen.";:GOTO 890
 3470 PRINT "Das funktioniert nicht,Marty.";:GOTO 890
 3480!
 3490! LIES
 3500!
 3510 IF G=20 AND OT=21 THEN PRINT "CATTLE QUEEN OF MONTANA":ELSE 3540
 3520 PRINT "Barbara Stanwyck and Ronald"
 3530 PRINT "Reagen":GOTO 890
 3540 IF G=21 AND OT=2 THEN PRINT "A  VEIWW  TO A KILL":ELSE 3560
 3550 PRINT "Roger Moore and Grace Jones":GOTO 890
 3560 IF G=24 AND OT=2 THEN PRINT "2010":ELSE 3590
 3570 PRINT "Starring:"
 3580 PRINT "Roy Schneider,John Lithgow,  Helen Mirren":GOTO 890
 3590 IF G=3 AND GE(3)=255 OR G=33 AND GE(3)=OT THEN 4190
 3600 IF G=22 AND OT=23 THEN PRINT "PREIS KRIEG - Die Gallone":ELSE 3620
 3610 PRINT "fuer nur 19 1/2 Cents.":GOTO 890
 3620 IF G=8 AND OT=27 THEN 3630:ELSE 3650
 3630 PRINT "WILLKOMMEN IN HILL VALLEY    EIN GUTER ORT FUER EIN GUTES"    
 3640 PRINT "LEBEN. BITTE FAHREN SIE VOR- SICHTIG.":GOTO 890
 3650 IF G=23 AND OT=18 THEN 3660:ELSE 3690
 3660 PRINT:PRINT "Tanzveranstaltung unter dem  Thema: 'Verzauberung unter"
 3670 PRINT "        Wasser'  Heute 20Uhr          Eintritt 1$"
 3680 GOTO 890
 3690 IF G=11 AND OT=28 THEN 3700:ELSE 3730
 3700 PRINT "LOU'S CAFE BIETET IHNEN:      Hamburger            23Cents";
 3710 PRINT " Schinken-Kase-Sandw. 30Cents Schokoladenbecher    15Cents"
 3720 GOTO 890
 3730 IF G=19 AND GE(19)=OT THEN PRINT "Die unvergesslichen Songs":ELSE 3750
 3740 PRINT "von:  Nat King Cole.":GOTO 890
 3750 PRINT "Das funktioniert nicht.":GOTO 890
 3760!
 3770! SCHLAGEN
 3780!
 3790 IF G=17 AND GE(17)=OT THEN 3800:ELSE 3820
 3800 PRINT "Gut gemacht. Biff liegt be-  nommen am Boden."
 3810 PU=PU+75:GE(17)=23:GOTO 890
 3820 PRINT "Warum?":GOTO 890
 3830!
 3840! FRAGE
 3850!
 3860 IF G=12 AND GE(12)=OT THEN PRINT "Hi, Marty":PU=PU+75:GOTO 890
 3870 IF G=13 AND GE(13)=OT THEN 3880:ELSE 3900
 3880 PRINT "Rettet den Uhrturm!Hier hadenSie ein Flugblatt, es enthaellt"
 3890 PRINT "Informationen ueber den Uhr- turm.":GE(3)=255:PU=PU+50:GOTO 890
 3900 IF G=14 AND OT=17 THEN 3910:ELSE 3950
 3910 PRINT "Sieh her,Marty. Das ist eine Zeitmaschine.Man kann mit ihr";
 3920 PRINT "uebeall hin reisen. Sie wird mit Plutonium angetrieben.Man";
 3930 PRINT "kommt legal niemals an Plu-  tonium,also habe ich's klauen";
 3940 PRINT "lassen - von Libyern.":GOTO 890
 3950 IF G=14 AND OT=32 THEN 3960:ELSE 3980
 3960 PRINT "Endlich, Marty. Mach schnell,wir muessen uns beeilen. Es"
 3970 PRINT "dauert nur noch ein paar Se- kunden.":GOTO 890
 3980 IF G=15 AND OT=28 THEN 3990:ELSE 4010
 3990 PRINT "Hallo. Kennst du Lorraine    Baines. Ich wuerde sie gern"
 4000 PRINT "kennenlernen.Koenntest Du mirdabei helfen?":PU=PU+25:GOTO 890
 4010 IF G=14 AND OT=38 THEN 4020:ELSE 4060
 4020 PRINT "Marty, ich weis, wie wir Dichzurueckschicken koennen:Heute";
 4030 PRINT "nacht schlaegt der Blitz in  den Uhrenturm. Er erzeugt die";
 4040 PRINT "noetige Energie. Komm heut'  abend in die Main Street,"
 4050 PRINT "suedlich vom Town Square.":GOTO 890
 4060 IF G=16 AND OT=21 THEN PRINT "Hallo.":IF PU>100 THEN PU=PU-100:GOTO 890
 4070 IF G=27 AND OT=35 AND GE(26)<>255 THEN PRINT "Sie ist verschlossen":GOTO 890
 4080 IF G=15 AND OT=18 THEN PRINT "Hi,Marty. Vielen Dank.":PU=PU+125:GOTO 890
 4090 IF G=16 AND OT=18 THEN PRINT "Hi,Marty. Alles O.k.":PU=PU+75:GOTO 890
 4100 IF G=17 AND GE(17)=OT THEN PRINT "Halts Maul,Eierkopf.":ELSE 4120
 4110 IF PU>10 THEN PU=PU-10:GOTO 890
 4120 PRINT "Nein, Marty.":GOTO 890
 4130!
 4140! RUFE
 4150!
 4160 IF G=15 AND OT=27 OR G=15 AND OT=28 THEN 4170:ELSE 4180
 4170 PRINT "O.k.":GE(15)=250:GE(18)=85:GE(16)=18:GOTO 890
 4180 PRINT "Das geht nicht, Marty.":GOTO 890
 4190 PRINT:PRINT "   DER UHRTURM DER STADT               HILL VELLEY"
 4200 PRINT "Eine Information der Hill    Valley  Preservation Society"
 4210 PRINT:PRINT "Am 12.11.1955 um 22.04 Uhr   schlug der Blitz in den Turm"  
 4220 PRINT "und seit dem steht die Uhr.  Wir von Hill Valley Preservation";
 4230 PRINT "Society glauben, dass er so  erhalten werden sollte, wie er"
 4240 PRINT "ist, als Zeuge unserer Ge-   schichte und unseres Erbes.":
 4250 GOTO 890
 4260!
 4270! ORTE
 4280!
 4290 DATA Du stehst im Verwaltungsraum der High School. "
 4300 DATA 255,4,255,255,255,255
 4310 DATA Du bist im Town Theater. Die Waende sind voller Filmplakate. 
 4320 DATA 255,5,255,255,255,255
 4330 DATA Du stehst in einem Gang der  Hill Valley High Scholl.
 4340 DATA  255,255,255,4,255,255
 4350 DATA Du bist vor der grossen Ein- gangspforte der Schule
 4360 DATA 1,255,3,5,255,255
 4370 DATA Du stehst nicht weit von TownSquare.Im Norden ein grosses Gebaeude.
 4380 DATA 2,7,4,255,255,255
 4390 DATA "Du bist im Gerichtsgebaeude, eine Treppe,die zurUhr fuehrt"
 4400 DATA 255,8,255,255,35,255
 4410 DATA "Du bist in Main Street, sie  fuehrt am Town Square vorbei."
 4420 DATA 5,9,255,8,255,255
 4430 DATA Du bist in Second Street. Im Norden ist das Gerichtsge-   baeude.
 4440 DATA 6,255,7,255,255,255
 4450 DATA Du bist auf dem Town Square. In Mitte ein Rasen(30m D.). 
 4460 DATA 7,12,255,10,255,255
 4470 DATA Du bist im Autogeschaeft. Es ist eine Toyota-Niederlassung
 4480 DATA 255,255,9,255,255,255
 4490 DATA Du bist in eurem Haus. Es istniemand zu Hause.
 4500 DATA 255,255,255,12,15,255
 4510 DATA Du bist auf einer Stasse die zum Town Square fuehrt
 4520 DATA 9,255,11,13,255,255      
 4530 DATA Du bist in Maple Street.
 4540 DATA 255,255,12,14,255,255
 4550 DATA Du bist auf dem J.F.Kennedy- Drive. Im Norden ist Doc's   Haus.
 4560 DATA 36,255,13,255,255,255
 4570 DATA Du bist in deinem Zimmer.
 4580 DATA 255,255,255,255,255,11
 4590 DATA "Du bist auf einer schmalen   Strasse, die aus der Staat   fuehrt." 
 4600 DATA 12,17,255,255,255,255
 4610 DATA "Du bist auf dem Parkplatz    Twin Pines Mall,dem Einkaufs-zentrum."
 4620 DATA 16,255,255,255,255,255
 4630 DATA "Du bist im Festsaal, in dem  'Verzauberung unter Wasser'  laeft."
 4640 DATA 255,255,255,19,255,255
 4650 DATA "Du stehst in einem schmalen, dunklen Gang der High School."
 4660 DATA 255,255,18,20,255,255
 4670 DATA "Du stehst auf einer Strasse. Links ist die Schule,rechts  das Kino.
 4680 DATA 255,24,19,21,255,255
 4690 DATA Du stehst im Foyer des Kinos.An den Waenden haengen Film- plakate.
 4700 DATA 255,255,20,255,255,255
 4710 DATA Du bist in der Vorhalle des  Gerichtes.In der Ecke eine   Treppe.
 4720 DATA 255,25,255,255,37,255
 4730 DATA Du stehst an der Texaco Tank-stelle.
 4740 DATA 255,255,255,24,255,255
 4750 DATA Du bist in der Main Street.
 4760 DATA 20,27,23,25,255,255
 4770 DATA Du bist in Second Street. DieStrasse sieht sehr saber aus.
 4780 DATA  22,255,24,255,255,255
 4790 DATA Du bist imSchallplattenladenDu hoerst Nat King Cole.
 4800 DATA 255,255,255,27,255,255
 4810 DATA Du stehst mitten auf dem TownSquare.
 4820 DATA 24,30,26,28,255,255
 4830 DATA Du bist in einer Eisdiele. Esriecht nach Hamburgern und   Coca Cola
 4840 DATA 255,255,27,255,255,255
 4850 DATA Du stehst in eurem kuenftigenWohnhaus. Alle(bis Eingans-) Tuer zu.
 4860 DATA 255,255,255,30,255,255
 4870 DATA Du bist auf einer Strasse dieaus der Stadt fuehr. Es ist  klarr.
 4880 DATA 27,32,29,31,255,255
 4890 DATA Du bist in Maple Street.
 4900 DATA 255,255,30,33,255,255
 4910 DATA "Du bist auf einer Strasse,dieaus der Stadt fuehrt. "
 4920 DATA 30,34,255,255,255,255
 4930 DATA Du bist auf dem Riverside    Drive. Noerdlich Doc Browns  Haus.
 4940 DATA 38,255,31,255,255,255
 4950 DATA Du bist auf Peabody Farm. DieFarm passt genau in diese    Gegend.
 4960 DATA 32,255,255,255,255,255
 4970 DATA "Du bist hinterm Ziffernblatt der Uhr,nur getrennt durch   Zahnraede
 4980 DATA 255,255,255,255,255,6
 4990 DATA Du bist in Doc Browns Wohnung 
 5000 DATA 255,14,255,255,255,255
 5010 DATA Du bist hinterm Ziffernblatt der Turmuhr.
 5020 DATA 255,255,255,255,255,22
 5030 DATA Du stehst in Doc Browns Haus.
 5040 DATA 255,33,255,255,255,255
 5050!
 5060! GEGENSTAENDE
 5070!
 5080 DATA "einen Lautsprecher","LAUTSPRECHER",3
 5090 DATA ein Telefon,TELEFON,1
 5100 DATA einen Zettel,ZETTEL,250
 5110 DATA eine Videokamera,VIDEOKAMERA,36
 5120 DATA den DeLorean,DELOREAN,17
 5130 DATA einen Strahlenschutzanzug,STRAHLENSCHUTZANZUG,250
 5140 DATA deinen Walkman,WALKMAN,15
 5150 DATA ein Schild,SCHILD,27
 5160 DATA eine Gitarre,GITARRE,250
 5170 DATA einen Spind,SPIND,19
 5180 DATA eine Tafel,TAFEL,28
 5190 DATA Jennifer,JENNIFER,5
 5200 DATA eine Frau,FRAU,8
 5210 DATA Doc Brown,DOC,17
 5220 DATA George McFly,GEORGE,28
 5230 DATA Lorraine Banes,LORRAINE,21
 5240 DATA Biff Tannen,BIFF,28
 5250 DATA George folgt Dir,GEORGE FOLGT DIR,250
 5260 DATA eine Schallplatte,SCHALLPLATTE,26
 5270 DATA Filmplakate,FILMPLAKATE,21  
 5280 DATA Kinoplakate,KINOPLAKATE,2
 5290 DATA eine Zapfsaeule,ZAPFSAEULE,23
 5300 DATA ein Plakat,PLAKAT,18
 5310 DATA ein Poster,POSTER,2
 5320 DATA einen Toyota,TOYOTA,10
 5330 DATA einen Schluessel,SCHLUESSEL,250
 5340 DATA eine Tuer,TUER,35
 5350!
 5360! VERBEN
 5370!
 5380 DATA NIMM
 5390 DATA LEGE
 5400 DATA UNTERSUCHE
 5410 DATA BENUTZE
 5420 DATA OEFFNE
 5430 DATA LIES
 5440 DATA SCHLAGE
 5450 DATA FRAGE
 5460 DATA RUFE
 5470!
 5480! RICHTUNGEN
 5490!
 5500 DATA NORDEN,SUEDEN,WESTEN,OSTEN,OBEN,UNTEN
 5510!
 5520! DELOREAN
 5530!
 5540 WINDOW:CLS
 5550 PRINT AT(5,6);"ZIELZEIT":PRINT AT(10,6);"JETZTZEIT" 
 5560 PRINT AT(15,6);"STARTZEIT"
 5570 PRINT AT(7,5);"12.11.":PRINT AT(7,11);YE(2)
 5580 PRINT AT(12,5);"26.10.":PRINT AT(12,11);YE
 5590 PRINT AT(17,5);"26.10.1985"
 5600 FOR Q=0 TO 1000:NEXT Q
 5610!
 5620 FOR A=1985 TO 1955 STEP-1:PRINT AT(12,11);A
 5630 FOR W=0 TO 100:NEXT W,A
 5640!
 5650 OT=34:GE(5)=34:GE(14)=38:YEAR=1955:ZE=233
 5660 WINDOW:CLS
 5670 PRINT "Du bist im Jahr 1955 angelangt."
 5680 PRINT:PRINT "Just in dem Augenblick,in dem Du";
 5690 PRINT "im Jahre 1955 mit einem ohrenbe-taeubenden Knall auftauchst,"
 5700 PRINT "sieht Dich George McFly, dein   spaeterer Vater."
 5710 PRINT "Es war jedoch vorausbestimmt,daser und Lorraine Baines (Deine"
 5720 PRINT "spaetere Mutter) sich in diesem Augenblick treffen sollten."
 5730 PRINT "Aus diesem Treffen waere spaeterFreundschaft und dann Liebe ge-"
 5740 PRINT "worden.Aber George schaut zu demEtwas, das da ploetzlich auf-"
 5750 PRINT "taucht und geht geradewwegs an  Lorriane vorbei."
 5760 PRINT "Deine Aufgabe ist es nun, die   beiden wieder zusammenbringen,da";
 5770 PRINT "sie sich nie mehr wieder so     treffen werden, wie es das"
 5780 PRINT "Schicksal fuer diesen Tag be-   stimmt hatte."
 5790 PRINT "Wenn Du sie nicht zusammen-     bringen kannst, verlieben sie"
 5800 PRINT "sich spaeter nicht ineinander   und Du existierst im Jahre 1985"
 5810 PRINT "nicht..."
 5820 PRINT "Du landest auf einer Farm..."
 5830 PRINT:PRINT "                       [TASTE]"
 5840 IF INKEY$=""THEN 5840:ELSE WINDOW:CLS:GOTO 650
 5850! 
 5860!
 5870!
 5880 WINDOW  
 5890 FOR XX=0 TO 15:PRINT AT(XX+1,0);STRING$(32,"")
 5900 PRINT AT(30-XX,0);STRING$(32,""):PRINT AT(XX,0);STRING$(32," ")
 5910 PRINT AT(31-XX,0);STRING$(32," "):NEXT XX 
 5920 WINDOW 6,24,0,31
 5930 PRINT AT(0,0);""
 5940 PRINT AT(1,0);"                          "
 5950 PRINT AT(2,0);"              "
 5960 PRINT AT(3,0);"                "
 5970 PRINT AT(4,0);"             "
 5980 PRINT AT(5,0);""
 5990 PRINT AT(26,0);""
 6000 PRINT AT(27,0);"                         "
 6010 PRINT AT(28,0);"            "
 6020 PRINT AT(29,0);"           "
 6030 PRINT AT(30,0);"          "
 6040 PRINT AT(31,0);""
 6050 PRINT:PRINT:PRINT:PRINT:PRINT:PRINT:PRINT:PRINT
 6060 RETURN
