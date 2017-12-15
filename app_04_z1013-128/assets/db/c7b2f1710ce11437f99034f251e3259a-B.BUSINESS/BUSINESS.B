Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

    1 CLEAR 100:GOSUB 20000:GOSUB 10070
    5 GOSUB 5000:WINDOW 20,31,0,31:CLS:GOTO 3000
   10 WINDOW 7,31,0,31:CLS:PRINT "Spieler ";B$(L):PRINT "Sie haben";GV(L);"MARK."
   20 PRINT STRING$(31,"")
   30 PRINT:PRINT "ANGEBOT: ";
   40 FOR I=1 TO 27
   50 K=INT(RND(1)*27+1):IF WW(K)=0 THEN 70
   60 NEXT:PRINT " Nichts!":PAUSE 20:RETURN
   70 PRINT WW$(K):PRINT "  PREIS:" ;WP(K);"Mark"
   78 PRINT:PRINT:INPUT "---> Wollen Sie kaufen (J/N/H) ?";I$
   79 IF I$="H"THEN GOSUB 10500:GOTO 78
   80 IF I$="N"THEN 110
   90 IF I$="Y"THEN 80
  100 PRINT:PRINT "Okay!":PRINT "Sie kauften ";WW$(K):GV(L)=GV(L)-WP(K):WW(K)=L
  110 II$=INKEY$:PAUSE 20:RETURN
  120 WINDOW 7,31,0,31:CLS:PRINT "Spieler ";B$(L);" ,Sie haben:":II$=INKEY$
  130 PRINT "Nr.   Bezeichnung         Preis     "
  140 PRINT STRING$(31,""):K=11:FOR I=1 TO 27
  150 IF WW(I)<>L THEN 170
  160 PRINT AT(K,0);I:PRINT AT(K,7);WW$(I):PRINT AT(K,26);WP(I):K=K+1
  170 NEXT I
  180 FOR I=15 TO 21:IF PM(I,L)=0 THEN 200
  190 PRINT AT(K,0);I+13:PRINT AT(K,7);PN$(I):PRINT AT(K,23);PP(I),"/T"
  200 K=K+1:NEXT I
  210 WINDOW 28,31,0,31:PRINT "Was wollen Sie verkaufen?"
  220 INPUT "Bitte Nummer eingeben!";NN
  230 NN=INT(NN):IF NN<1 OR NN>34 THEN PRINT "Irrung!":GOTO 220
  240 IF NN>27 THEN 310
  250 IF WW(NN)<>L THEN PRINT "Das haben Sie nicht!":GOTO 280
  260 PRINT "Sie verkauften ";WW$(NN);"!"
  270 GV(L)=GV(L)+WP(NN):WW(NN)=0
  280 PRINT "Wollen Sie weiter verkaufen ?"
  290 INPUT "(Y/N)";Y$      
  295 IF Y$=CHR$(78)THEN RETURN
  300 CLS: GOTO 120
  310 NN=NN-13 
  320!GOTO280
  330 PRINT "Sie haben";PM(NN,L);"Tonnen ";PN$(NN);".      "
  340 PRINT "Wieviel wollen Sie verkaufen?":INPUT "(Max.50t)  -->";MM 
  350 IF MM<0 OR MM>50 THEN PRINT "Irrung!":PAUSE 20:CLS:GOTO 330
  360 IF MM>PM(NN,L)THEN PRINT "Soviel haben Sie nicht!":PAUSE 20:CLS:GOTO 330
  370 PRINT "Sie verkauften ";PN$(NN);"!"
  380 GV(L)=GV(L)+PP(NN)*MM:PM(NN,L)=PM(NN,L)-MM:PAUSE 15:RETURN
  390 WINDOW 7,31,0,31:CLS:PRINT "A b b a u :":PRINT "=========="
  400 PRINT:PRINT "Spieler ";B$(L):PRINT "  Was wollen Sie abbauen?" 
  410 FOR I=1 TO 7:PRINT I,PN$(I):NEXT:PRINT:PRINT "Eingabe der Nummer!"
  420 INPUT "";PE:IF PE<1 OR PE>7 THEN 420
  430 NN=PE:II$=INKEY$:PRINT "Aha, ";PN$(NN):PAUSE 25
  440 WINDOW 9,31,0,31:CLS 
  450 PRINT "Abbaubedingungen fuer ";PN$(NN);":"
  460 PRINT AT(11,1);"Verarbeitungspreis je Tonne"
  470 PRINT AT(12,0);"bei  <30    <80      >80  Tonnen"
  480 PRINT AT(13,5);WV(NN+2,1):PRINT AT(13,12);WV(NN+2,2)
  490 PRINT AT(13,21);WV(NN+2,3)
  510 PRINT AT(15,0);"Besitzer von ",WW$(NN+2)," ist "
  520 PRINT AT(16,0);B$(WW(NN+2))
  530 GOSUB 540:GOTO 570
  540 PRINT AT(18,0);"Der Preis fuer Energie ist konst"
  550 PRINT AT(19,0);WV(1,1),"/t der fuer Wasser",WV(2,1),"/t !"
  560 RETURN
  570 WINDOW 22,25,0,31
  575 PRINT "Wieviel soll abgebaut werden?":INPUT "(Max. 100):";MM
  580 IF MM<0 OR MM>100 THEN PRINT "Irrung!":PAUSE 20:CLS:GOTO 570
  585 GOSUB 590:GOTO 612
  590 J=3:IF MM<80 THEN J=2
  600 IF MM<30 THEN J=1
  610 GV(L)=GV(L)-WV(1,J)*MM-WV(2,J)*MM:RETURN
  612 GV(L)=GV(L)-WV(NN+2,J)*MM
  615 GV(WW(NN+2))=GV(WW(NN+2))+WV(NN+2,J)*MM
  616 GV(WW(1))=GV(WW(1))+WV(1,J)*MM
  617 GV(WW(2))=GV(WW(2))+WV(2,J)*MM
  620 PM(NN,L)=PM(NN,L)+MM
  625 PAUSE 35:CLS:RETURN 
  630 CLS:PRINT "A u f b e r e i t u n g"
  640 PRINT "=======================":PRINT:WINDOW 8,31,0,31
  650 PRINT "Spieler ";B$(L) :PRINT "Was soll produziert werden ?":S=0
  660 FOR I=1 TO 7:IF PM(I,L)=0 THEN 680
  670 PRINT I,PN$(I+7):S=1
  680 NEXT:PRINT "Bitte Nummer eingeben!"
  685 IF S=0 THEN PRINT "nicht moeglich !":PAUSE 20:WINDOW 4,31,0,31:RETURN
  690 PRINT:INPUT "";PE :IF PE<1 OR PE>7 THEN 690
  695 IF PM(PE,L)=0 THEN 690
  700 NN=PE+7:II$=INKEY$:PRINT "Aha, ";PN$(NN):PAUSE 25:WINDOW 7,31,0,31:CLS
  710 PRINT "Kosten fuer ";PN$(NN)
  715 GOSUB 720:GOTO 840
  720 PRINT AT(8,1);"Verarbeitungspreis je Tonne"
  730 PRINT AT(9,1);"bei  <30    <80      >80 Tonnen"
  740 PRINT AT(10,6);WV(NN+6,1):PRINT AT(10,13);WV(NN+6,2)
  750 PRINT AT(10,22);WV(NN+6,3)
  760 PRINT AT(12,1);"Besitzer von ",WW$(NN+6)," ist"
  770 PRINT AT(13,1);B$(WW(NN+6)):GOSUB 540
  775 PRINT AT(15,0);"Sie haben",PM(NN-7,L),"Tonnen ",PN$(NN-7),"."
  780 WINDOW 22,26,0,31:INPUT "Wieviel sind zu verarbeiten?";MM
  790 IF MM<0 OR MM>PM(NN-7,L)THEN PRINT "Irrung!":PAUSE 20:CLS:GOTO 780
  800 GOSUB 590:GV(L)=GV(L)-WV(NN+6,J)*MM
  810 GV(WW(NN+6))=GV(WW(NN+6))+WV(NN+6,J)*MM:GV(WW(1))=GV(WW(1))+WV(1,J)*MM
  820 GV(WW(2))=GV(WW(2))+WV(2,J)*MM:PM(NN,L)=PM(NN,L)+MM
  830 PM(NN-7,L)=PM(NN-7,L)-MM:PAUSE 20:WINDOW 5,31,0,31:CLS:RETURN
  840 CLS:PRINT "An die Aufbereitung ist ein"
  850 PRINT "Transport der Zwischenprodukte":PRINT "anzuschliessen."
  860 PRINT "Folgende Transportunternehmen"
  870 PRINT "stehen zur Verfuegung:":PRINT
  880 PRINT "Nr. Bezeichnung   Preis je Tonne"
  890 PRINT "                <30   <80   >80 Tonnen" 
  900 FOR I=11 TO 14:PRINT AT(I+5,0);I-1:PRINT AT(I+5,4);WW$(I-1)
  910 PRINT AT(I+5,15);WV(I-1,1):PRINT AT(I+5,21);WV(I-1,2)
  920 PRINT AT(I+5,27);WV(I-1,3):NEXT
  930 PRINT AT(21,0);"Zu transportierende Menge:",MM,"T"
  940 WINDOW 23,26,0,31:PRINT "Womit soll transportiet werden?"
  950 INPUT "Bitte Nummer eingeben!";NN
  960 IF NN<10 OR NN>13 THEN PRINT "Irrung!":PAUSE 20:CLS:GOTO 940
  970 PRINT "Aha, ";WW$(NN):GV(L)=GV(L)-WV(NN,J)*MM
  980 GV(WW(NN))=GV(WW(NN))+WV(NN,J)*MM
  990 PRINT "Besitzer ist ";B$(WW(NN))
 1000 PAUSE 20:WINDOW 4,31,0,31:CLS:RETURN
 1010 CLS:PRINT:PRINT "F i n a l p r o d u k t i o n"
 1020 PRINT "=============================":WINDOW 8,31,0,31
 1030 PRINT "Spieler";B$(L):PRINT " Was soll produziert werden?":S=0
 1040 FOR I=8 TO 14:IF PM(I,L)=0 THEN 1060
 1050 PRINT I-7,PN$(I+7):S=1
 1060 NEXT:IF S=0 THEN PRINT "nicht moeglich !":PAUSE 20:WINDOW 4,31,0,31:CLS:RETURN
 1070 PRINT "Bitte Nummer eingeben!"
 1080 INPUT "";PE:IF PE<1 OR PE>7 THEN 1080
 1090 IF PM(PE+7,L)=0 THEN 1080
 1200 NN=PE+14:PRINT "Aha, ";PN$(NN):PAUSE 20:CLS
 1210 II$=INKEY$:PRINT "Produktionskosten fuer ";PN$(NN)
 1220 GOSUB 720:RETURN
 1230 WINDOW 5,31,0,31:PRINT "        PREISSPEKULATION"      
 1240 PRINT:PRINT STRING$(31,"")
 1250 PRINT:GW=INT(RND(1)*20+1)*5:PRINT "Mit einer Wkt. von";GW;"%"
 1260 PRINT "steigt der Preis einer von Ihnen":PRINT "bestimmten Ware!"
 1270 PRINT: PRINT "Zur Wahl stehen:"
 1280 FOR I=15 TO 21:PRINT I-14,PN$(I):NEXT
 1290 PRINT:PRINT "Welche waehlen Sie?" 
 1300 PRINT "Bitte Nummer eingeben!"
 1305 PRINT:PRINT STRING$(31,"")
 1310 INPUT "";PE:IF PE<1 OR PE>7 THEN 1310
 1320 NN=PE+14:PRINT "Aha, ";PN$(NN)
 1330 PRINT AT(30,2);"Preis von ",PN$(NN),PP(NN)
 1340 G2=INT(RND(1)*100+1):IF G2<=GW THEN AA=1:ELSE AA=-1
 1350 BB=INT(RND(1)*10+1)*100
 1360 FOR I=10 TO BB STEP 10:PP(NN)=PP(NN)+AA*10:IF PP(NN)<1000 THEN PP(NN)=1000
 1370 PRINT AT(31,2);"Preis von ",PN$(NN),PP(NN):NEXT
 1380 PAUSE 35:CLS:RETURN
 1390 GW=INT(RND(1)*10+1)
 1400 IF GW<5 THEN II$=" faellt ":AA=-.1:ELSE II$=" steigt ":AA=.1
 1410 NN=INT(RND(1)*2+1)
 1420 PRINT "Der Preis fuer Leistungen des"
 1430 PRINT WW$(NN);II$:PRINT "um 10%."
 1440 FOR I=1 TO 3:WV(NN,I)=WV(NN,I)+AA*WV(NN,I):NEXT
 1450 PAUSE 35:RETURN
 1460 GW=INT(RND(1)*10+1)
 1470 IF GW<5 THEN II$=" faellt ":AA=-.2:ELSE II$=" steigt ":AA=.2
 1480 NN=INT(RND(1)*4+10)
 1490 PRINT "Der Preis fuer Leistungen des
 1500 PRINT "Verkehrsbetr. ";WW$(NN);II$:PRINT "um 20%."
 1510 FOR I=1 TO 3:WV(NN,I)=WV(NN,I)+AA*WV(NN,I):NEXT
 1520 PAUSE 25:RETURN
 1530 CLS:PRINT "       PREISMANIPULATION":PRINT
 1540 PRINT STRING$(31,"")
 1550 NN=INT(RND(1)*27+1)
 1560 PRINT:PRINT "Sollen die Preise des Betriebes"
 1570 PRINT "  ";WW$(NN):PRINT " fallen <1> oder steigen <2> ?"
 1580 PRINT:PRINT:PRINT STRING$(31,""):PRINT
 1590 INPUT "";PE    
 1600 IF PE=1 THEN AA=-1:GOTO 1620
 1610 IF PE=2 THEN AA=1:GOTO 1620
 1615 GOTO 1590
 1620 PRINT:PRINT "In Ordnung!":B=INT(RND(1)*8+1)/10 
 1630 PRINT "Die Aenderung wird";B*100;"% betragen" 
 1640 FOR I=1 TO 3:WV(NN,I)=WV(NN,I)+AA*B*WV(NN,I)
 1650 NEXT I:RETURN
 1660 PRINT "   K a f f e e p a u s e":RETURN
 1670 PRINT "S p i e l s a l o n"
 1680 PRINT "___________________":PRINT
 1690 PRINT "Es wird ein einfaches"
 1700 PRINT "L O T T O  - Game mit den Zahlen"
 1710 PRINT "1 bis 9 ueber 5 Runden gespielt"
 1720 PRINT "  Der Hoechsteinsatz betraegt":PRINT "          10000 Mark."
 1730 PRINT "     Gewinn ist dreifach." 
 1740 PRINT "   Wieviel wollen Sie wagen?":WINDOW 17,19,9,15:INPUT "";MM
 1745 WINDOW 20,31,0,31
 1750 IF MM<0 OR MM>10000 THEN CLS:PRINT "Irrung!":GOTO 1690
 1760 GV(L)=GV(L)-MM:PRINT AT(17,16);"Mark.   Okay!":PRINT AT(20,20);"<ENTER>"
 1770 FV=INT (RND(1)*9+1)
 1790 PRINT AT(18,11);STRING$(3,CHR$(248)):PRINT AT(21,11);STRING$(3,CHR$(158))
 1795 FOR I=19 TO 21:PRINT AT(I,10);CHR$(192):PRINT AT(I,14);CHR$(159):NEXT
 1800 PRINT AT(21,11);STRING$(3,CHR$(248)):PRINT AT(20,11);FV
 1810 FOR I=1 TO 5:SV=INT(RND(1)*9+1)     
 1820 SV=INT(RND(1)*9+1)
 1840 INPUT "";PE$:PE=VAL(PE$):PRINT AT(20,20);"         ":IF SV=FV THEN 1890
 1860 PRINT AT(24,4*I);SV
 1870 IF I<6 THEN PRINT AT(27,3);"Die",I,". Zahl! ---> <ENTER>"
 1880 NEXT I :IF SV<>FV THEN 1920
 1890 PRINT AT(24,4*I);SV:PRINT AT(30,0);"Gratulation, Sie haben gewonnen!    "
 1900 GV(L)=GV(L)+3*MM
 1910 WINDOW 4,31,0,31:PAUSE 20:CLS:RETURN
 1920 PRINT AT(30,0);"Schade, das Glueck war nicht       "
 1930 PRINT AT(31,0);"auf Ihrer Seite."
 1940 WINDOW 4,31,0,31:PAUSE 30:CLS:RETURN
 2000 CLS:WINDOW 7,31,0,31:CLS:PRINT "Spieler ";B$(L)
 2010 PRINT STRING$(31,""):PRINT "Sie besitzen";GV(L);"Mark."
 2015 IF VZ=0 THEN GOSUB 6000:RETURN
 2020 PRINT:PRINT "Was wollen Sie tun ?"
 2030 PRINT:PRINT
 2040 PRINT "Kaufen            -1"  
 2050 PRINT "Verkaufen         -2"
 2060 PRINT "Abbauen           -3"
 2070 PRINT "Aufbereiten       -4"
 2080 PRINT "Finalproduktion   -5"
 2090 WINDOW 7,7,27,31:INPUT "";PE:IF PE<1 OR PE>5 THEN 2090
 2100 WINDOW 4,31,0,31:ON PE GOSUB 10,120,390,630,1010 
 2110 RETURN
 2200 FOR L=1 TO OO:WINDOW 23,25,0,31
 2210 PRINT "Spieler";L;"wie heissen Sie?"
 2220 INPUT "-->";B$(L):CLS:NEXT L
 2230 B$(0)="Comtrust":RETURN
 3000 PRINT:PRINT "Dieses Spiel ist fuer maximal"
 3010 PRINT "vier Teilnehmer ausgelegt!"
 3020 INPUT "Wieviel nehmen teil ?";OO:PRINT:PRINT
 3030 IF OO<2 OR OO>4 THEN CLS:GOTO 3000
 3040 PRINT "Wieviel Runden werden gewuenscht"
 3050 INPUT "Maximal 50 sind moeglich!";QQ
 3060 IF QQ<1 OR QQ>50 THEN CLS:GOTO 3040
 3070 PRINT:PRINT:QQ=INT(QQ):OO=INT(OO):CLS:GOSUB 2200
 3080 FOR Z=1 TO QQ:FOR L=1 TO OO:IF GV(L)<0 THEN GV(L)=GV(L)+GV(L)/2
 3090 VZ=1:GOSUB 2000:VZ=0:GOSUB 2000:WINDOW 4,23,0,31
 3095 PE=INT(RND(1)*12+1)
 3100 ON PE GOSUB 1230,1390,1460,1530,1660,1670,4000,4100,4200,4200,4200,1530
 3110 PAUSE 50
 3120 NEXT L,Z
 3130 GOSUB 8000
 4000 PRINT " S t e u e r b e s c h e i d"
 4010 PRINT " "
 4020 ST=0:FOR I=1 TO 27:IF WW(I)=L THEN ST=ST+WP(I):NEXT:ELSE NEXT
 4030 ST=ST/4:GV(L)=GV(L)-ST
 4040 PRINT:PRINT "Werter Buerger!":PRINT
 4050 PRINT "Sie haben fuer die von Ihnen"
 4060 PRINT "betriebenen Einrichtungen und"
 4070 PRINT "Unternehmen einen Gesamtbetrag":PRINT "      von";ST;"Mark"
 4080 PRINT "als Steuern abzufuehren."
 4090 PRINT "Die Zahlung erfolgt automatisch.":PRINT:PRINT:PRINT STRING$(31,"")
 4095 PAUSE 50:RETURN
 4100 PRINT "       KRISENERSCHEINUNG"    
 4110 PRINT ""
 4120 PRINT:PRINT "Fuer die folg. Betriebe geht der" 
 4130 PRINT "Wert um einen Festbetrag zurueck"
 4140 FOR I=1 TO 3
 4150 J=INT(RND(1)*27+1)
 4160 PRINT AT(I+13,1);WW$(J):B=INT(RND(1)*10+1)*100
 4170 FOR A=10 TO B STEP 10:WP(J)=WP(J)-10:IF WP(J)<2000 THEN WP(J)=2000
 4180 PRINT AT(I+13,20);WP(J):NEXT A,I
 4190 RETURN
 4200 PRINT:PRINT:PRINT "   E r e i g n i s f a c h"
 4210 PRINT "   ^^^^^^^^^^^^^^^^^^^^^^^"
 4220 OT=INT(RND(1)*13+1)
 4230 ON OT GOTO 4240,4250,4260,4270,4280,4290,4300,4310,4320,4330,4340,4350,4360
 4240 PRINT "  Sie erbten 5000 Mark!":GV(L)=GV(L)+5000:RETURN
 4250 PRINT "Zahlen Sie Schulgeld! 3000 Mark":GV(L)=GV(L)-3000:RETURN
 4260 PRINT "Krankenhauskosten: 4000 Mark!":GV(L)=GV(L)-4000:RETURN
 4270 PRINT "Bankirrtum zu Ihren Gunsten!":GV(L)=GV(L)+4000:RETURN
 4280 PRINT "Sie gewannen beim Wetten 2000!":GV(L)=GV(L)+4000:RETURN
 4290 PRINT "Zur Boerse":PAUSE 10:CLS:GOTO 1230
 4300 PRINT "Zum Spielsalon":PAUSE 10:CLS:GOTO 1670
 4310 PRINT "Sie erben das Oelfeld !":WW(8)=L:RETURN
 4320 PRINT "Das E-Werk wird verstaatlicht!":WW(1)=0:RETURN
 4330 PRINT "Sie erbten die Reederei!":WW(11)=L:RETURN
 4340 PRINT "Steuerrueckzahlung:1500 Mark!":GV(L)=GV(L)+1500:RETURN
 4350 PRINT "Das Wasserwerk wird verstaatl.":WW(2)=0:RETURN
 4360 PRINT "Sie erbten das Silberbergwerk!":WW(3)=L:RETURN
 5000 DIM PM(21,4),WW$(27),WW(27),WP(27),WV(27,3),PN$(21),PP(21)
 5010 FOR I=1 TO 27:WW(I)=0:NEXT
 5020 FOR I=1 TO 21:FOR J=1 TO 4:PM(I,J)=0:GV(J)=50000:NEXT J,I
 5030 DATA "Silbererz",0,"Kupfererz",0,"Bauxit",0,"Kali",0,"Eisenerz",0
 5040 DATA "Oel",0,"Kohle",0,"Silber",0,"Kupfer",0,"Aluminium",0,"Kalisalz",0
 5050 DATA "Stahl",0,"Raffinat",0,"Briketts",0,"Silberblech",9000
 5060 DATA "Kupferdraht",8500,"Alublech",8000,"Duenger",7500,"Walzstahl",7000
 5070 DATA "Plaste",6500,"Koks",6000
 5080 FOR I=1 TO 21:READ PN$(I),PP(I):NEXT
 5090 DATA "E-Werk",20000,"Wasserwerk",20000,"Silberbergwerk",8000
 5100 DATA "Kupferbergwerk",7000,"Bauxitbergwerk",6000,"Kalischacht",5000
 5110 DATA "Eisenerzvorkommen",4500,"Oelfeld",4000,"Kohlezeche",3500
 5120 DATA "Fuhrpark",8000,"Reederei",10000,"Eisenbahn",12000,"Fluggesellschaft
 5130 DATA 15000,"Silberhuette",14000,"Kupferhuette",13000,"Aluminiumhuette"
 5140 DATA 12000,"Kaliveredlung",11000,"Stahlwerk",10000,"Raffinerie",9000
 5150 DATA "Brikettfabrik",8000,"Silberschmiede",10000,"Drahtzieherei",9500
 5160 DATA "Aluwalzwerk",9000,"Duengemittelwerk",8500,"Walzwerk",8000
 5170 DATA "Petrolchem. Betr.",7500,"Kokerei",7000
 5180 FOR I=1 TO 27:READ WW$(I),WP(I):NEXT
 5190 DATA 350,350,350,250,250,250,2000,1000,500,1800,900,450,1600,800,400
 5200 DATA 1400,700,350,1200,600,300,1100,550,275,1000,500,250,450,700,1200
 5210 DATA 1000,600,400,800,800,800,1500,350,1500,1500,1000,500,1350,900,450
 5220 DATA 1200,800,400,1050,700,350,900,600,300,750,500,250,600,400,200
 5230 DATA 2400,1800,1200,2200,1650,1100,2000,1500,1000,1800,1350,900,1600,1200
 5240 DATA 800,1400,1050,700,1200,900,600
 5250 FOR I=1 TO 27:FOR J=1 TO 3:READ WV(I,J):NEXT J,I:RETURN
 6000 PRINT:PRINT "Ausserdem verfuegen Sie ueber:":WZ=14
 6010 FOR I=1 TO 27:IF WW(I)<>L THEN 6030
 6020 PRINT AT(WZ,0);WW$(I):WZ=WZ+1
 6030 NEXT I
 6040 WZ=13:FOR I=1 TO 21:IF PM(I,L)=0 THEN 6060
 6050 PRINT AT(WZ,18);PN$(I):PRINT AT(WZ,27);PM(I,L),"t":WZ=WZ+1
 6060 NEXT I
 6070 WINDOW 7,7,27,31:PRINT AT(31,25);"<ENTER>"
 6080 I$=INKEY$:IF I$<>CHR$(13)THEN GOTO 6080
 6090 II$=INKEY$:WINDOW 5,31,0,31:CLS:RETURN
 8000 WINDOW:CLS
 8010 PRINT "A U S W E R T U N G"
 8020 PRINT ""
 8030 PRINT ""
 8040 FOR L=1 TO OO:INK L+1
 8050 FOR I=1 TO 27:IF WW(I)=L THEN GV(L)=GV(L)+WP(I):NEXT I:ELSE NEXT I
 8060 FOR I=15 TO 21:IF PM(I,L)=0 THEN 8080
 8070 GV(L)=GV(L)+PP(I)*PM(I,L)/4
 8080 NEXT I
 8090 PRINT AT(L+3,1);B$(L)
 8100 PRINT AT(L+3,20);GV(L)
 8110 NEXT L
 8120 PRINT AT(31,25);">ENTER<"
 8130 I$=INKEY$:IF I$<>CHR$(13)THEN 8130:ELSE CLS:CLEAR:END
10070 WINDOW 15,31,0,31:PRINT " Ein Spiel von : M. Siedentopf":PAUSE 10
10080 PRINT:PRINT "Version Z-1013 : K. Rothe"
10120 PRINT AT(31,24);">ENTER<":WINDOW 31,31,30,31
10130 I$=INKEY$:IF I$<>CHR$(13)THEN RN=RND(1):WINDOW:GOTO 10130
10140 II$=INKEY$:PRINT AT(25,18);"Bitte warten!"
10150 PRINT AT(26,18);""
10160 RETURN
10500 WINDOW:CLS:PRINT "     H E L P - M E N U E":PRINT:PRINT STRING$(31,"")  
10505 C=4:IF QA=0 THEN DA=4:ELSE DA=3
10510 FOR V=1 TO DA:PRINT AT(C,12);"BETRIEB":PRINT AT(C+2,2);"ABBAU:"   
10520 PRINT AT(C+3,0);"AUFBER.:":PRINT AT(C+4,0);"FINALP.:"       
10525 PRINT AT(C+5,0);"-------------------------------"
10530 PRINT AT(C,25);"PRODUKT":C=C+7:NEXT:C=6:S=9:IF QA=1 THEN GOTO 10700
10540 PRINT AT(C,S);"Silberbergw.    S.erz"
10550 PRINT AT(C+1,S);"Silberhuette    Silber"
10560 PRINT AT(C+2,S);"Silberschmiede  S.blech"
10570 PRINT AT(C+7,S);"Kupferbergwerk  K.erz"
10580 PRINT AT(C+8,S);"Kupferhuette    Kupfer"
10590 PRINT AT(C+9,S);"Drahtzieherei   K.Draht"
10600 PRINT AT(C+14,S);"Kalischacht    Kali"
10610 PRINT AT(C+15,S);"Kaliveredlung  Kalisalz"
10620 PRINT AT(C+16,S);"Duengemittelw. Duenger "
10630 PRINT AT(C+21,S);"Eisenerzvork.   E.erz  "
10640 PRINT AT(C+22,S);"Stahlwerk       Stahl  "
10650 PRINT AT(C+23,S);"Walzwerk      Walzstahl":PRINT AT(31,25);"<ENTER>"
10660 I$=INKEY$:IF I$<>CHR$(13)THEN GOTO 10660:ELSE CLS:QA=1:GOTO 10500
10700 PRINT AT(C,S);"Oelfeld             Oel"
10710 PRINT AT(C+1,S);"Raffinerie     Raffinat"
10720 PRINT AT(C+2,S);"Petrolchem.B.    Plaste"
10730 PRINT AT(C+7,S);"Kohlezeche        Kohle"
10740 PRINT AT(C+8,S);"Kokerei           Koks"
10750 PRINT AT(C+9,S);"Brikettfabr.    Brikett"
10760 PRINT AT(C+14,S);"Bauxitbergwerk   Bauxit"   
10770 PRINT AT(C+15,S);"Aluminiumhuette     Alu" 
10780 PRINT AT(C+16,S);"Aluminiumwalzw. A.blech"
10781 WINDOW 26,30,0,31:PRINT "E-WERK          FUHRPARK"
10782 PRINT "WASSERWERK      REEDEREI":PRINT AT(28,16);"EISENBAHN"  
10783 PRINT AT(29,16);"FLUGGESELLSCHAFT":WINDOW:PRINT AT(31,25);"<ENTER>"
10790 I$=INKEY$:IF I$<>CHR$(13)THEN 10790:ELSE DA=0:C=0:S=0:QA=0            
20000 WINDOW:CLS:FOR IK=0 TO 2:A2=2:PRINT AT(IK,1);CHR$(192)
20010 PRINT AT(IK,31);CHR$(159):NEXT:PRINT AT(0,2);STRING$(29,CHR$(158))
20020 PRINT AT(2,2);STRING$(29,CHR$(248)):PRINT AT(1,10);"BIG BUSINESS"   
20030 WINDOW 7,31,0,31:RETURN
