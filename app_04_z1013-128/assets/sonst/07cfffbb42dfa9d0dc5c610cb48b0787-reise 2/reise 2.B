Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10! ########################
   20! # Weltreise ein Spiel  #
   30! # fuer KC 85/3         #
   40! # Ueberarbeitet fuer   #
   50! # Z 1013 von D.Hartung #
   60! # Ringbergstrasse 127  #
   70! # Suhl 6019            #
   80! ########################
   90 CLEAR 1500:GOSUB 6390:GOTO 530
  100 GOTO 3060:!   GRUNDMENUE
  110 GOTO 2120:!   BOERSE
  120 GOTO 2290:!   JOBS
  130 GOTO 2850:!   ANHALTER
  140 GOTO 3410:!UP SCHIFFE MENUE
  150 GOTO 4130:!   GRAFIK
  160 GOTO 4320:!WERTE DEFINIEREN
  170 GOTO 4760:!   REISEROUTE
  180 GOTO 5080:!   CHARTERFLUEGE
  190 GOTO 730:!    U-BAHN
  200 GOTO 5730:!   PKW MIETEN
  210 GOTO 6180:!UP AUTO KAPUTT
  220 GOTO 6390:!   VORSPANN
  230 GOTO 7140:!   LINIENFLUG
  240 GOTO 6980:!UM LINIENFLUEGE
  250 GOTO 7640:!   KNAST
  260 GOTO 820:!    KAMEL
  270 GOTO 1070:!ALLE STAEDTE
  280 GOTO 1150:!   ZEIT=0
  290 GOTO 1270:!   GELD=0
  300 GOTO 1420:!ENDE DURCH SIEG
  310 GOTO 1810:!UP ZIEL AUF KO
  320 GOTO 1960:!   FINANZEN
  330!
  340 REM ZEITVERLAUF
  350!
  360!
  370 FOR E=1 TO Z9:ZE=ZE-1:GOSUB 390:PAUSE 20:NEXT:RETURN
  380!
  390 REM ANZEIGE
  400!
  410!
  420 PRINT AT(25,20);ZE:IF ZE<0 THEN PAUSE 40:GOTO 1160
  430 PRINT AT(29,20);GE:PRINT AT(29,28);"$"
  440 BEEP:RETURN
  450!
  460 REM CLS 
  470!
  480!
  490 WINDOW 0,31,0,31
  500 FOR Z=1 TO 31:PRINT "";:NEXT
  510 PRINT "";
  520 RETURN 
  530 Y=1
  540 GOSUB 4140
  550 FOR A=1 TO C:PRINT AT(1+A*2,20);S$(A):NEXT A
  560 PRINT AT(4,4);AK$
  570 GOSUB 390
  580 IF Y=0 THEN GOSUB 3060
  590 IF ZE<0 THEN 1160
  600 IF GE<0 THEN 1280
  610 TYP=0
  620 IF AK$=S$(R+1) THEN R=R+1
  630 IF R>0 THEN PRINT AT(1+R*2,19);"":BEEP
  640 IF R=C AND ZE<6 AND AK$=S$(C)THEN 1420
  650 FOR A=1 TO 19
  660 IF AK$=ST$(A) THEN KO(0)=KO(A):GOTO 680
  670 NEXT
  680 Y=0
  690 IF PK=2 THEN PK=0
  700 IF AK$=ST$(18)THEN A=RND(1):IF A<.3 THEN Y=1:GOSUB 7650
  710 IF AK$=ST$(4)THEN A=RND(1):IF A<.3 THEN Y=1:GOSUB 770
  720 GOTO 560
  730!
  740! U-BAHN
  750!
  760!
  770 CLS:PRINT:PRINT "Sie wurden in der NEW YORKER U-Bahn ueberfallen und"
  780 PRINT "ausgeraubt. Sie   muessen5 Tage in  NEW YORK bleiben"
  790 PRINT "und sich einen    Reisepass besorgenIhr Geld wird"
  800 PRINT "Ihnen ersetzt !"
  810 Z9=5:GOSUB 340:RETURN
  820!
  830! KAMEL
  840!
  850!
  860 IF AK$=ST$(8)OR AK$=ST$(13)THEN TYP=1:ELSE RETURN
  870 CLS:PRINT:PRINT "Sie  haben  die   Moeglichkeit bei  einer Karawane"
  880 PRINT "nach"
  890 IF AK$=ST$(8)THEN PRINT ST$(13):ELSE PRINT ST$(8)
  900 PRINT "mitzureisen. Die  Reise fuehrt durchdie SAHARA und "
  910 PRINT "dauert 19 Tage":PRINT:PRINT "Teilnahme (Y) ?"
  920 Z$=INKEY$:IF Z$=""THEN 920
  930 IF Z$<>"Y"THEN ZE=ZE-1:GOSUB 390:BEEP:RETURN
  940 PRINT:PRINT "Die Reise beginnt sofort"
  950 PAUSE 50:CLS:PRINT "Sie reisen durch  die SAHARA. Ihnen ist heiss und"
  960 PRINT "schlecht durch dasSchaukeln":PAUSE 60:CLS
  970 PRINT "die Karawane machtin einer Oase einePause.":PAUSE 40:PRINT
  980 IF AK$=ST$(8)THEN AK$=ST$(13):ELSE AK$=ST$(8)
  990 Z9=19:GOSUB 340
 1000 PRINT "Die Reise geht    weiter Ankunft in"
 1010 PRINT AK$:PRINT "in 2 Tagen"
 1020 Z9=2:GOSUB 340
 1030 PAUSE 20:CLS:PRINT "Ankunft":PRINT AK$
 1040 PAUSE 30:PRINT:PRINT "Sie muessen sich  fuer 5 Tage "
 1050 PRINT "von dieser        Strapatze erholen"
 1060 Z9=5:GOSUB 340:RETURN
 1070!
 1080! ALLE STAEDTE
 1090!
 1100!
 1110 CLS
 1120 FOR A=1 TO 19
 1130 PRINT ST$(A)
 1140 NEXT:PAUSE 80:CLS:RETURN
 1150!
 1160! ZEIT=0
 1170!
 1180!
 1190 GOSUB 460
 1200 WINDOW 5,26,1,30:CLS:BEEP
 1210 PRINT "Sie haben Ihr Zeitlimit ueber-"
 1220 PRINT "schritten. Das Testament  wird"
 1230 PRINT "ohne  Sie eroeffnet. Sie erben"
 1240 PRINT "nichts. Sie waren  zu langsam."
 1250 PRINT:PRINT:PRINT:PRINT "PS: Ist das peinlich ! "
 1260 IF INKEY$=""THEN 1260:ELSE RUN
 1270!
 1280!    ENDE GELD=0
 1290!
 1300!
 1310 GOSUB 460:WINDOW 5,26,1,30:CLS:BEEP
 1320 PRINT:PRINT:PRINT "       *** BANKROTT ***"
 1330 PRINT:PRINT "Sie haben Ihr  Reiseziel nicht"
 1340 PRINT "erreicht ! Ihre letzte Station"
 1350 PRINT "war ";AK$:PRINT
 1360 PRINT "Sie muessen  noch  lernen  mit"
 1370 PRINT "Geld umzugehen.":PRINT
 1380 PRINT:PRINT "    Schwache Leistung !!!"  
 1390 PRINT:PRINT:PRINT:PRINT:PRINT " >>>> MONEY FOR NOTHING <<<<"
 1400 IF INKEY$=""THEN 1400:ELSE RUN
 1410 END
 1420!
 1430!  ENDE DURCH SIEG !
 1440!
 1450!
 1460 GOSUB 460:WINDOW 1,30,1,30:CLS:BEEP
 1470 PRINT "";
 1480 FOR A=1 TO 28:PRINT "                            ";:NEXT
 1490 PRINT "";
 1500 WINDOW 2,29,2,29
 1510 PRINT AT(30,30);CHR$(170)
 1520 PRINT AT(31,31);CHR$(199)
 1530 A=INT(RND(1)*2+1)
 1540 ON A GOTO 1550,1700,22400,22600
 1550 PRINT:PRINT:PRINT "        TESTAMENT"
 1560 PRINT "____________________________"
 1570 PRINT:PRINT "Mein letzter Wille :"
 1580 PRINT:PRINT "Mein gesamtes Vermoegen,von"
 1590 PRINT "189 Dollar,soll nach meinem"
 1600 PRINT "Ableben dem  Fond  fuer vom "
 1610 PRINT "    Aussterben bedrohter"
 1620 PRINT "     Pinguine im Kongo"
 1630 PRINT:PRINT "zugute kommen ."
 1640 PRINT:PRINT "Das  Haus  vererbe ich  dem"
 1650 PRINT "Gewinner dieses Spieles, es"
 1660 PRINT "hat allerdings   nur Grund-"
 1670 PRINT "stueckswert von  37 Dollar."
 1680 PRINT:PRINT " Dein lieber Verstorbener !"
 1690 IF INKEY$=""THEN 1690:ELSE RUN
 1700 PRINT:PRINT "**** MEIN LETZTER WILLE ****"
 1710 PRINT:PRINT "Mein gesamter Besitz soll"
 1720 PRINT "dem Gewinner vererbt werden:"
 1730 PRINT:PRINT "Mein Haus        (Wert 970$)"
 1740 PRINT "Mein Maultier     (Wert 12$)"
 1750 PRINT "Die alte Hauskatze (Wert 1$)"
 1760 PRINT "Das Auto         (Wert 540$)"
 1770 PRINT "Der Garten       (Wert 320$)"
 1780 PRINT:PRINT "Dein verblasster ":PRINT "  Verstorbener" 
 1790 IF INKEY$=""THEN 1790:ELSE RUN
 1800 END
 1810!
 1820! UP ZIEL AUF KO 
 1830!
 1840!
 1850 W$=W$+"         "
 1860 AK$=LEFT$(W$,11)
 1870 FOR A=1 TO 19
 1880 IF AK$=ST$(A) THEN 1920
 1890 NEXT
 1900 PRINT "Benennen Sie bitte ein anderes  Ziel!"
 1910 DF=1:RETURN
 1920 IF KO(0)<>KO(A) THEN DF=1:ELSE DF=0
 1930 IF DF=0 THEN RETURN
 1940 CLS:PRINT AK$:PRINT "ist mit einem PKW nicht erreichbar"
 1950 PRINT "Sie muessen  durchein Meer fahren !":RETURN
 1960!
 1970!   FINANZEN
 1980!
 1990!
 2000 IF AK$<>ST$(3) AND AK$<>ST$(4)THEN RETURN
 2010 CLS:TYP=1
 2020 PRINT "    FINANZEN      "
 2030 PRINT:PRINT "Ihr Vermoegen be- traegt";GE;"$"
 2040 PRINT:PRINT "Verdienstmoegl.:"
 2050 PRINT:PRINT "Boerse           BJobs             JSpielcasino      S"
 2060 PRINT:PRINT "Entscheidung ?"
 2070 Z$=INKEY$:IF Z$="" THEN 2070
 2080 IF Z$="B" THEN GOSUB 2130
 2090 IF Z$="J" THEN GOSUB 2300
 2100 IF Z$="S" THEN GOSUB 2660
 2110 RETURN
 2120!
 2130! BOERSE
 2140!
 2150 CLS
 2160 IF AK$=ST$(4) THEN PRINT "  WALLSTREET     "
 2170 PRINT "     Aktienmarkt "
 2180 PRINT:PRINT "Aktien kaufen  im Werte von :"
 2190 INPUT "$";F
 2200 IF F>GE THEN PRINT "Kapital zu schwach":GOTO 2180
 2210 GE=GE-F:ZE=ZE-1:GOSUB 390:BEEP
 2220 PAUSE 50:PRINT "Beim Verkauf er-  brachten sie"
 2230 F=INT(RND(1)*F*3)
 2240 PRINT F;"$":GE=GE+F:PRINT "Vermoegen:";GE;"$"
 2250 PRINT "Weiter kaufen(Y/N)":BEEP
 2260 Z$=INKEY$:IF Z$=""THEN 2260
 2270 IF Z$="Y" THEN 2180
 2280 RETURN
 2290!
 2300! JOBS
 2310!
 2320!
 2330 A=INT(RND(1)*3+1):IF AK$=ST$(3)THEN A=1
 2340 CLS
 2350 PRINT "  Arbeitsstellen "
 2360 ON A GOTO 2370,2400,2480
 2370 PRINT:PRINT "z.Z. liegen keine Angebote vor.     Es tut uns Leid"
 2380 ZE=ZE-1:GOSUB 390:PAUSE 50
 2390 RETURN
 2400 PRINT:PRINT "  uns  liegen     folgende Angebote vor:"
 2410 PRINT:PRINT "10 Tage Zeitungen austragen  fuer   'DAILY NEWS'"
 2420 PRINT "100$ pro Tag                        Job annehmen (Y) ?"
 2430 Z$=INKEY$:IF Z$="" THEN 2430
 2440 IF Z$<>"Y"THEN RETURN
 2450 CLS:PRINT " ++DAILY NEWS++"
 2460 PRINT:PRINT "Ihre   Arbeit     beginnt sofort":A=1000
 2470 B=10:GOTO 2580
 2480 PRINT:PRINT "Angebot:          20   Tage   Autos waschen bei"
 2490 PRINT "'GENERAL MOTORS'   90 $ pro Tag"
 2500 PRINT "24 Tage           "
 2510 PRINT "Job annehmen (Y) ?"
 2520 Z$=INKEY$:IF Z$="" THEN 2520
 2530 IF Z$<>"Y" THEN ZE=ZE-1:RETURN
 2540!
 2550 CLS:PRINT " >> GENERAL   <<        MOTORS":PRINT:PRINT
 2560 PRINT "Ihr  Job beginnt  sofort":A=24*90
 2570 B=14:GOTO 2580
 2580 FOR Q=1 TO B
 2590 ZE=ZE-1:GOSUB 390:PAUSE 10
 2600 NEXT
 2610 GE=GE+A
 2620 CLS:PRINT:PRINT "Die Firma bedankt sich fuer Ihre    Mitarbeit"
 2630 PRINT "das Geld wird     ueberwiesen       Auf Wiedersehen"
 2640 TYP=1:GOSUB 390
 2650 PAUSE 20:RETURN
 2660 CLS:PRINT " $ SPIELCASINO $"
 2670 PRINT " ..............." 
 2680 PRINT:INPUT "  Wieviel  Geld     moechten Sie      setzen ?";F
 2690 IF F>GE THEN PRINT "Kapital zu schwach":GOTO 2680
 2700 GE=GE-F:GOSUB 390
 2710 A=RND(1)
 2720 IF A<.5 THEN PRINT "Sie haben alles   verspielt!":GOTO 2750
 2730 F=INT(RND(1)*2*F):GE=GE+F:GOSUB 390
 2740 PAUSE 40:PRINT " Ihr  Gewinn  be- traegt";F;"$"
 2750 PRINT:PRINT "Beehren Sie uns   bald wieder !     VIELEN DANK !"
 2760 PAUSE 30
 2770 TYP=1
 2780 RETURN
 2790!
 2800! PKW KAUFEN
 2810 CLS:PRINT
 2820 PRINT " >> AUTOKAUF <<":PRINT:PRINT "Angebote:"
 2830 A=INT(RND*3+1)
 2840 ON A GOTO 27060,27100,27300
 2850!
 2860! ANHALTER
 2870!
 2880 CLS:A=INT(RND(1)*19+1)
 2890 IF KO(A)<>KO(0)THEN PRINT "Kein Auto in Sicht":ELSE 2920
 2900 PRINT "Weiter warten ?":Z9=1:GOSUB 340
 2910 Z1$=INKEY$:IF INKEY$="N"THEN RETURN:ELSE GOTO 2880
 2920 IF AK$=ST$(A)THEN 2880
 2930 Q=RND(1):PRINT:IF Q<.3 THEN PRINT "Ein Truck":ELSE PRINT "Ein PKW"
 2940 PRINT "faehrt nach":PRINT ST$(A):GOSUB 390
 2950 PRINT:PRINT "Mitfahren (Y) ?"
 2960 Z1$=INKEY$:IF Z1$=""THEN 2960
 2970 IF Z1$<>"Y"THEN 2880
 2980 CLS:PRINT "Die Fahrt dauert":PRINT "4 Tage"
 2990 Z9=4:GOSUB 340
 3000 PRINT:PRINT "Sie sind in 5 Stunden in ";ST$(A) 
 3010 PAUSE 10:AK$=ST$(A):CLS:PRINT "Sie  sind  in":PRINT AK$:PAUSE 30
 3020 TYP=1:IF Q>.3 THEN RETURN
 3030 PRINT:PRINT "Die Anstrengungen waren zu gross,Siemuessen sich ein"
 3040 PRINT "paar Tage ausruhen":PAUSE 10
 3050 Z9=2:GOSUB 340:RETURN
 3060!
 3070!   GRUNDMENU
 3080!
 3090!
 3100 CLS:PRINT:PRINT "GRUNDMENU":PRINT
 3110 FOR A=0 TO 40
 3120 IF LEFT$(FL$(A),11)=AK$ THEN 3150
 3130 NEXT
 3140 GOTO 3170
 3150 PRINT "Linienmaschine   L"
 3160 IF AK$<>"BERLIN     " THEN PRINT "Masch. chartern  C"
 3170 IF AK$<>ST$(3)AND AK$<>ST$(6)AND AK$<>ST$(17)THEN PRINT "PKW mieten       M"
 3180 IF AK$<>ST$(6)AND AK$<>ST$(3)AND AK$<>ST$(17)THEN PRINT "per Anhalter     A"
 3190 IF AK$=ST$(8) OR AK$=ST$(13) THEN GOSUB 4050
 3200 FOR A=1 TO 14
 3210 IF AK$=SR$(A) THEN GOSUB 4080:ELSE NEXT
 3220 PRINT "alle Staedte     S"
 3230 FOR A=1 TO 14
 3240 IF AK$=LEFT$(SR$(A),11) THEN 3260
 3250 NEXT :GOTO 3280
 3260 PRINT "Passagierschiff  P"
 3270 IF AK$=ST$(3) OR AK$=ST$(4) THEN GOSUB 4110
 3280 BEEP
 3290 IF INKEY$=""THEN 3290
 3300 A$=INKEY$
 3310 IF A$="L"THEN GOSUB 6990
 3320 IF A$="C"AND AK$<>"BERLIN     "THEN ZE=ZE-1:GOSUB 390:GOSUB 5080
 3330 IF A$="M"THEN GOSUB 5740
 3340 IF A$="P"THEN GOSUB 3420
 3350 IF A$="F"THEN GOSUB 1960
 3360 IF ST$(6)<>AK$ AND ST$(3)<>AK$ AND ST$(17)<>AK$ AND A$="A"THEN GOSUB 2860
 3370 IF A$="W"THEN GOSUB 860
 3380 IF A$="S"THEN GOSUB 1110
 3390 CLS
 3400 IF TYP=0 THEN 3060:ELSE RETURN
 3410!
 3420! UP  SCHIFFE MENU
 3430!
 3440!
 3450 CLS
 3460 Q=1
 3470 PRINT " ~~            ~~"
 3480 PRINT " ~~  SEA-LINE  ~~"
 3490 PRINT " ~~~~~~~~~~~~~~~~"
 3500 PRINT:FOR A=1 TO 14
 3510 IF AK$=LEFT$(SR$(A),11) THEN PRINT RIGHT$(SR$(A),11):PRINT " ";"Nr.";A;
 3520 IF AK$=LEFT$(SR$(A),11) THEN PRINT " ";SP(A);"$":PRINT :Z2(Q)=A:Q=Q+1
 3530 NEXT
 3540 IF Q=0 THEN RETURN
 3550 PRINT
 3560 PRINT:PRINT "Reise buchen (Y/N) ?"
 3570 Z1$=INKEY$ :IF Z1$="" THEN 3570
 3580 IF Z1$="N" THEN RETURN
 3590 IF Z1$="Y" THEN 3610
 3600 GOTO 3420
 3610 PRINT 
 3620 INPUT "Reise Nr.";Z1
 3630 FOR A=1 TO Q
 3640 IF Z1=Z2(A) THEN 3670
 3650 NEXT
 3660 GOTO 3560
 3670 PRINT:PRINT "Ihre Schiffsreise dauert";SZ(Z1);"Tage !"
 3680 TYP=1
 3690 AK$=RIGHT$(SR$(Z1),11)
 3700 GE=GE-SP(Z1):GOSUB 390
 3710 PAUSE 10
 3720 CLS:PRINT:PRINT "Willkommen an Bord"
 3730 A=INT(RND(1)*3+1)
 3740 PAUSE 30
 3750 ON A GOTO 3760,3820,3890
 3760 ZE=ZE-1:GOSUB 390:BEEP:PAUSE 20
 3770 PRINT:PRINT "Sie haben gutes   Wetter"
 3780 PRINT "es gibt keine Ver-zoegerung"
 3790 PRINT "Geniessen Sie die ruhige See !"
 3800 FOR E=2 TO SZ(Z1):ZE=ZE-1:GOSUB 390:PAUSE 20:NEXT
 3810 GOTO 4030
 3820 ZE=ZE-1:GOSUB 390:PAUSE 20:ZE=ZE-1:GOSUB 390:PAUSE 20
 3830 PRINT "Es wurde Sturm-   warnung gegeben !"
 3840 PRINT "Bleiben Sie bitte in den Kabinen !"
 3850 PRINT "Wir werden 2 Tage laenger unterwegs sein"
 3860 AK$=RIGHT$(SR$(Z1),11)
 3870 FOR E=1 TO SZ(Z1):ZE=ZE-1:GOSUB 390:PAUSE 20:NEXT
 3880 GOTO 4030
 3890 FOR E=1 TO 4:ZE=ZE-1:GOSUB 390:PAUSE 20:NEXT
 3900 PRINT "  Sturmwarnung":PRINT    
 3910 PRINT "Windstaerke 10 !"
 3920 A=RND(1) :IF A<.1 THEN 3970
 3930 PRINT "Es gibt Probleme  bei Steuerung":PRINT "10 Tage Spaeter ":PRINT "in"
 3940 PRINT AK$
 3950 FOR E=1 TO SZ(Z1)+5:ZE=ZE-1:GOSUB 390:PAUSE 20:NEXT
 3960 GOTO 4030
 3970 PAUSE 40:PRINT "Das Schiff ist    gesunken.":PRINT "Sie wurden von"
 3980 PRINT "einem Indischen   Frachter gerettet"
 3990 PRINT "und er bringt Sie nach SYDNEY"
 4000 AK$=ST$(9) :ZE=ZE-21
 4010 PRINT "Die Ereignisse    bedingen 25 Tage."
 4020 PAUSE 70:CLS:GOSUB 390
 4030 PAUSE 20:CLS:PRINT "Ankunft in":PRINT AK$
 4040 PAUSE 30:RETURN
 4050!UP STADTSPEZ. MENUELEMENTE
 4060 PRINT "Kamel            W"
 4070 RETURN
 4080 PRINT "Passagierschiff P"
 4090!PRINT"Frachter        F"
 4100 RETURN
 4110 PRINT "Finanzen         F"
 4120 RETURN
 4130!
 4140! GRAPHIK !
 4150!
 4160!
 4170 GOSUB 460
 4180 WINDOW 2,21,19,30
 4190 CLS:PRINT AT(31,31);CHR$(199):BEEP
 4200 WINDOW 23,29,19,30
 4210 CLS:BEEP
 4220 PRINT AT(23,23);"Zeit":PRINT AT(27,21);"Guthaben"
 4230 PRINT AT(25,25);"Tage"
 4240 WINDOW 1,5,3,15:CLS:BEEP
 4250 PRINT AT(2,4);"Standort:"
 4260 WINDOW 7,29,0,17:CLS
 4270 WINDOW 8,29,0,17:BEEP
 4280 FOR A=3 TO 19
 4290 PRINT AT(A,19);"":NEXT
 4300 PRINT AT(20,19);""
 4310 RETURN
 4320!
 4330!  WERTE DEFINIEREN 
 4340!
 4350!
 4360 DIM ST$(19)
 4370 DATA BERLIN     ,MOSKAU     ,LONDON     ,NEW YORK   ,LOS ANGELES
 4380 DATA SYDNEY     ,ROM        ,ALGIER     ,CHICAGO    ,MEXICO CITY
 4390 DATA PEKING     ,HONGKONG   ,KAIRO      ,PARIS      ,ATHEN      
 4400 DATA BOMBAY     ,TOKIO      ,BANGKOK    ,FRANKFURT/M
 4410 FOR A=1 TO 19
 4420 READ B$ : ST$(A)=B$ 
 4430 NEXT
 4440 ZE=INT(RND(1)*10+80)
 4450 GE=(INT(RND(1)*20+200))*100
 4460 DIM FL$(40)
 4470 FOR A=1 TO 40
 4480 A1=INT(RND(1)*19+1)
 4490 A2=INT(RND(1)*19+1)
 4500 IF A1=A2 THEN 4480
 4510 FL$(A)=ST$(A1)+"-"+ST$(A2)
 4520 NEXT
 4530 DIM SP(14)
 4540 DATA 2000,200,500,100,1500,1200 
 4550 DATA 600,800,200,1900,2100,300
 4560 DATA 700,200
 4570 FOR A=1 TO 14
 4580 READ B
 4590 SP(A)=B
 4600 NEXT
 4610 DIM SR$(14) 
 4620 SR$(1)=ST$(5)+"-"+ST$(17)
 4630 SR$(2)=ST$(18)+"-"+ST$(17)
 4640 SR$(3)=ST$(3)+"-"+ST$(4)
 4650 SR$(4)=ST$(17)+"-"+ST$(18)
 4660 SR$(5)=ST$(18)+"-"+ST$(16)
 4670 SR$(6)=ST$(4)+"-"+ST$(3)
 4680 SR$(7)=ST$(15)+"-"+ST$(8)
 4690 SR$(8)=ST$(8)+"-"+ST$(13)
 4700 SR$(9)=ST$(13)+"-"+ST$(15)
 4710 SR$(10)=ST$(6)+"-"+ST$(5)
 4720 SR$(11)=ST$(5)+"-"+ST$(6)
 4730 SR$(12)=ST$(17)+"-"+ST$(12)
 4740 SR$(13)=ST$(6)+"-"+ST$(12)
 4750 SR$(14)=ST$(12)+"-"+ST$(18)
 4760!
 4770!REISEROUTE
 4780!
 4790!
 4800 C=INT(RND(1)*4)+6
 4810 DIM S$(C+1)
 4820 FOR A=1 TO C
 4830 B=INT(RND(1)*18+2)
 4840 IF Q=B THEN 4830
 4850 Q=B
 4860 S$(A)=ST$(B)
 4870 NEXT A
 4880 AK$=ST$(1)
 4890 S$(0)=ST$(1)
 4900 DIM FP(40)
 4910 FOR A=1 TO 40
 4920 FP(A)=(INT(RND(1)*30+10))*100
 4930 NEXT
 4940 DIM Z2(40)
 4950 DIM SZ(14)
 4960 FOR A=1 TO 14
 4970 SZ(A)=INT(RND(1)*5+10)
 4980 NEXT
 4990 DIM KO(19)
 5000 DATA 1,2,7,11,12,14,15,16,18,19
 5010 FOR A=1 TO 10
 5020 READ B :KO(B)=1
 5030 NEXT
 5040 KO(4)=2:KO(5)=2:KO(10)=2
 5050 KO(9)=2:KO(13)=3:KO(8)=3
 5060 KO(6)=4:KO(3)=5:KO(17)=6
 5070 RETURN
 5080! 
 5090!    CHARTERFLUEGE
 5100!
 5110!
 5120 CLS: FOR A=1 TO 40
 5130 IF AK$=LEFT$(FL$(A),11) THEN 5190
 5140 NEXT
 5150 PRINT :PRINT
 5160 PRINT "In dieser Stadt":PRINT "gibt es keinen":PRINT "Charterservice !"
 5170 PAUSE 40
 5180 RETURN
 5190 CLS:PRINT:PRINT " ## Charter-   ##":PRINT " ##     fluege ##"
 5200 PRINT "           &CO.":PRINT "Bietet an:"
 5210 PRINT:PRINT "1Piper  4 sitzig";
 5220 PRINT "mit Spesen  4000$"
 5230 PRINT:PRINT "2Falcon 8 sitzig";
 5240 PRINT "mit Spesen  6500$"
 5250 PRINT:PRINT
 5260 PRINT "Chartern (1/2/N) ?"
 5270 Z$=INKEY$ :IF Z$="" THEN 5270
 5280 IF Z$="N" THEN RETURN
 5290 IF Z$="1" THEN G6=4000:GOTO 5320
 5300 IF Z$="2" THEN G6=6500:GOTO 5320
 5310 GOTO 5080
 5320 GOSUB 5940:IF E=1 THEN 5250
 5330 GE=GE-G6
 5340 PRINT:INPUT "Wohin";W$
 5350 W$=W$+"         "
 5360 W$=LEFT$(W$,11)
 5370 PRINT "Die Startvorbe-"
 5380 PRINT "reitungen dauern"
 5390 PRINT "2 Tage"
 5400 Z9=2:GOSUB 340:CLS
 5410 PAUSE 20
 5420 CLS
 5430 AK$=W$
 5440 TYP=1
 5450 A=RND(1)
 5460 IF A<.2 AND Z$="1" THEN 5570
 5470 PRINT:PRINT "Der Pilot meldet:"
 5480 PRINT:PRINT "Das Wetter ist OK"
 5490 PRINT "gute Sicht"
 5500 PRINT "Maschine OK"
 5510 PAUSE 10:Z9=1:GOSUB 340
 5520 PRINT:PRINT "Sie sind in zwei   Stunden"
 5530 PRINT "in ";AK$
 5540 PAUSE 30
 5550 CLS:PRINT
 5560 PRINT "Willkommen in":PRINT AK$:PAUSE 20:RETURN
 5570 CLS:PRINT "    ALARM!"
 5580 PRINT:PRINT:BEEP
 5590 PRINT "Notlandung in"
 5600 PRINT S$(4):BEEP
 5610 AK$=S$(4)
 5620 FOR E=1 TO 10
 5630 BEEP:BEEP
 5640 PAUSE 2
 5650 NEXT
 5660 Z9=1:GOSUB 340
 5670 CLS
 5680 PRINT "Sie sind nicht":PRINT "verletzt"
 5690 PRINT: PRINT "Vorschrift:":PRINT "Aerztl.Behandl."
 5700 PRINT "fuer 5 Tage !"
 5710 Z9=5:GOSUB 340
 5720 CLS :RETURN
 5730!
 5740! PKW MIETEN
 5750!
 5760!
 5770 IF AK$=ST$(3)OR AK$=ST$(6)OR AK$=ST$(17)THEN RETURN
 5780 CLS:TYP=1
 5790 PRINT " || CARS+BIKES ||" 
 5800 PRINT "  \    CORP.   /"
 5810 A=RND(1):IF A<.5 THEN 5830
 5820 PRINT:PRINT "Heute Geschlossen":PAUSE 40:CLS:ZE=ZE-1:RETURN
 5830 PRINT:PRINT "Angebote:"
 5840 PRINT:PRINT "-Porsche 256.....1  High Speed 1200$"
 5850 PRINT:PRINT "-Opel Kapitaen...2 Bauj.1956    230$"
 5860 PRINT:PRINT "-Land Rover......3 Allrad       600$"
 5870 PRINT:PRINT:PRINT "Leihen (1/2/3/N)?"
 5880 Z$=INKEY$:IF Z$="" THEN 5880
 5890 IF Z$="1" THEN G6=1200:GOSUB 5940:IF E=0 THEN 5970
 5900 IF Z$="2" THEN G6=230:GOSUB 5940:IF E=0 THEN 6050
 5910 IF Z$="3" THEN G6=600:GOSUB 5940:IF E=0 THEN 6120
 5920 IF Z$="N" THEN RETURN
 5930 GOTO 5880
 5940 IF GE>G6 THEN E=0:RETURN
 5950 PRINT "Das koennen Sie sich nicht mehr leisten !":PAUSE 20
 5960 E=1:ZE=ZE-1:RETURN
 5970 CLS: PRINT "Wir Beglueck-     wuenschen Sie zu  diesem Auto !"
 5980 GE=GE-1200:GOSUB 390
 5990 PRINT: INPUT "Wohin moechten Sie";W$
 6000 GOSUB 1820:IF DF=1 THEN 5990
 6010 PRINT "Mit diesem Wagen  dauert die Fahrt":PRINT "2 Tage"
 6020 ZE=ZE-1:GOSUB 390
 6030 A=RND(1) :IF A<.1 THEN Q=1 
 6040 Z9=1:GOTO 6320
 6050 CLS: PRINT "Vielen Dank fuer  Ihr Vertrauen !"
 6060 PRINT: INPUT "Wohin";W$
 6070 GOSUB 1820:IF DF=1 THEN 6060
 6080 PRINT "Gute Reise !      fuer 5 Tage":ZE=ZE-1
 6090 GE=GE-260:GOSUB 390
 6100 A=RND(1) :IF A<.7 THEN Q=1
 6110 GOTO 6310
 6120 CLS: PRINT "Mit diesem Wagen  werden Sie keine  Probleme haben !"
 6130 PRINT:INPUT "Ihr Reiseziel    ";W$
 6140 GOSUB 1820:IF DF=1 THEN 6130
 6150 PRINT "Sie werden 5 Tage unterwegs sein !"
 6160 ZE=ZE-1:GE=GE-600:GOSUB 390:A=RND(1):IF A<.3 THEN Q=1 
 6170 GOTO 6310
 6180!
 6190! UP AUTO KAPUTT
 6200!
 6210!
 6220 BEEP
 6230 PRINT "Ihr Wagen ist     kaputt !"
 6240 A=INT(RND(1)*700+200)
 6250 PRINT "Die Reparatur     kostet";A;"$"
 6260 GE=GE-A:ZE=ZE-1:GOSUB 390
 6270 PAUSE 40
 6280 PRINT "Reise kann weiter-gehen"
 6290 BEEP
 6300 A=RND(1):IF A<.5 AND Z$="2"THEN PAUSE 40:GOTO 6220:ELSE RETURN
 6310 Z9=4 
 6320 GOSUB 340
 6330 TYP=1
 6340 IF Q=1 THEN GOSUB 6190
 6350 PAUSE 30
 6360 CLS:PRINT "Willkommen in":PRINT AK$
 6370 PAUSE 20
 6380 BEEP:RETURN
 6390!
 6400!      VORSPANN
 6410!
 6420!
 6430 WINDOW 0,31,0,31:CLS
 6440 PRINT:PRINT:PRINT
 6450 PRINT "            "
 6460 PRINT "                   "
 6470 PRINT "                "
 6480 PRINT "                  "
 6490 PRINT "             "
 6500 PRINT:PRINT "       GAME BY J.HARNISCH y'86"
 6510 PRINT:PRINT "      fuer Z1013 von D.Hartung" 
 6520 PRINT:PRINT:PRINT:PRINT
 6530 PRINT "                         "
 6540 PRINT "                           " 
 6550 PRINT "                          " 
 6560 PRINT "                         "
 6570 PRINT "                        "
 6580 PRINT "           "
 6590 PRINT "     /"
 6600 PRINT ""
 6610 PRINT "\"
 6620 PRINT ""
 6630 PRINT "     "
 6640 PRINT "            "
 6650 PRINT "             "
 6660 PRINT AT(24,11);"HARNISCH AIRLINES"
 6670 GOSUB 4320:CLS:BEEP
 6680 PRINT:PRINT "         ***WELTREISE***":PRINT
 6690 PRINT "Sie muessen in einer Erbschafts-";
 6700 PRINT "angelegenheit    zu   einer  vom";
 6710 PRINT "Computer   festgelegten    Stadt";
 6720 PRINT "reisen. Dabei muessen  Sie  alle";
 6730 PRINT "Staedte   in   der  vorgegebenen";
 6740 PRINT "Reihenfolge besuchen.Ihnen steht";
 6750 PRINT "ein bestimmter Betrag  zur  Ver-";
 6760 PRINT "fuegung   und  Sie  duerfen  Ihr";
 6770 PRINT "Zeitlimit nicht  ueberschreiten.";
 6780 PRINT "Dies ist  nicht  immer  einfach,";
 6790 PRINT "denn es kann  zu schwierigkeiten";
 6800 PRINT "kommen.   Durch   Eingabe  einer";
 6810 PRINT "bestimmten Zahl bzw.  Buchstaben";
 6820 PRINT "ist die Wahl  der Verkehrsmittel";
 6830 PRINT "moeglich.  Um  Ihr  Konto  etwas";
 6840 PRINT "aufzufrischen   koennen  Sie  in";
 6850 PRINT "zwei Staedten  Geld   verdienen.";
 6860 PRINT "Am Tage 0 wird das Testament er-";
 6870 PRINT "oeffnet, sind  Sie  nicht am Be-";
 6880 PRINT "stimmungsort, koennen  Sie nicht";
 6890 PRINT "erben. Achten  Sie  darauf, dass";
 6900 PRINT "Sie  nicht  mehr  alsfuenf  Tage";
 6910 PRINT "frueher am Ziel sind,Sie koennen";
 6920 PRINT "in   keinem  Hotel  uebernachten";
 6930 PRINT:PRINT "    Sie haben keine Chance" 
 6940 PRINT "       also nutzen Sie Sie !";
 6950 PRINT AT(31,25);">ENTER>":BEEP
 6960 IF INKEY$=""THEN 6960
 6970 RETURN
 6980!
 6990! UNTERMENU LINIENFLUEGE
 7000!
 7010!
 7020 CLS:PRINT "Linienfluege nach:"
 7030 Q=1:PRINT:FOR G=1 TO 40
 7040 IF AK$=LEFT$(FL$(G),11) THEN PRINT RIGHT$(FL$(G),12):PRINT " ";"Nr.";G;
 7050 IF AK$=LEFT$(FL$(G),11) THEN PRINT "  ";FP(G);"$":Z2(Q)=G
 7060 IF AK$=LEFT$(FL$(G),11) THEN Q=Q+1:PRINT
 7070 NEXT
 7080 IF Q=1 THEN RETURN
 7090 PRINT
 7100 PRINT "Fliegen (Y/N) ?"
 7110 Z1$=INKEY$:IF Z1$="" THEN 7110
 7120 IF Z1$="Y" THEN GOSUB 7150
 7130 RETURN
 7140!
 7150!   LINIENFLUG
 7160!
 7170!
 7180 PRINT
 7190 INPUT "Flug Nr.";Z1
 7200 FOR A=1 TO Q
 7210 IF Z1=Z2(A) THEN GOTO 7240
 7220 NEXT
 7230 GOTO 7180
 7240 FZ=INT(RND(1)*4)+2
 7250 PRINT "Ihr Flug ist ge-  bucht"
 7260 PRINT "Abflug in";FZ-1;"Tagen
 7270 PRINT "Flugdauer: 1 Tag"
 7280 AK$=RIGHT$(FL$(Z1),11)
 7290 G6=FP(Z1):GOSUB 5940:IF E=1 THEN 7220
 7300 GE=GE-FP(Z1)
 7310 Z9=FZ-1:GOSUB 340
 7320 TYP=1
 7330 PAUSE 10
 7340 BEEP
 7350 PAUSE 20 :CLS
 7360 PRINT "Vorbereitung zum  Start"
 7370 PAUSE 30
 7380 PRINT:PRINT "Der Pilot be-     gruesst Sie an    Bord!"
 7390 A=RND(1)
 7400 PAUSE 10:Z9=1:GOSUB 340
 7410 IF A<.3 AND A>.1 THEN 7450
 7420 IF A<=.1 THEN 7500
 7430 PRINT:PRINT "Der Flug verlaeuftnormal ,ohne      Stoerungen"
 7440 GOTO 7550
 7450 PRINT:PRINT "Wir durchfliegen  ein Gewitter !":PRINT "keine Aufregung !"
 7460 PRINT:PRINT "Pilot meldet:     Flug verzoegert   sich"
 7470 ZE=ZE-1:GOSUB 390
 7480 PAUSE 20
 7490 GOTO 7550
 7500 PRINT:PRINT "Pilot meldet      Gewitter ueber":PRINT RIGHT$(FL$(Z1),11)
 7510 PAUSE 50:PRINT "Ausweichflughafen:"
 7520 IF Z1<2 THEN PRINT RIGHT$(FL$(Z1+1):AK$=RIGHT$(FL$(Z1+1),11)
 7530 IF Z1>=2 THEN PRINT RIGHT$(FL$(Z1-1),11):AK$=RIGHT$(FL$(Z1-1),11)
 7540 Z9=1:GOSUB 340:GOTO 7550
 7550 PAUSE 20
 7560 A=RND(1)
 7570 CLS :PRINT
 7580 IF A<.5 THEN PRINT "Willkommen in"
 7590 IF A=>.5 THEN PRINT "Ankunft"
 7600 PRINT AK$
 7610 PAUSE 20
 7620 BEEP
 7630 RETURN
 7640!
 7650! KNAST
 7660!
 7670!
 7680 CLS:PRINT
 7690 PRINT "Sie wurden von derThailaendischen   Polizei wegen "
 7700 PRINT "Klaerung Ihrer    Identitaet in Ge- wahrsam genommen"
 7710 PRINT "Ihre weiterreise  muss fuer 10 Tage verschoben werden"
 7720 Z9=10:GOSUB 340
 7730 PAUSE 20
 7740 CLS:RETURN
