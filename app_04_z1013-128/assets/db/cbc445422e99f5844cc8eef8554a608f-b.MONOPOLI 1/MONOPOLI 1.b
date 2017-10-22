Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

    9 O.12
   20 TAB(128)
   30 P."* M O N O P O L Y - C A G  1 *"
   40 TAB(128)
   70 P."Dieses Spiel soll das komplexe"
   75 P."Denken foerdern und natuerlich"
   80 P."Spass machen."
   90 P."Es existieren die verschie-"
   95 P."densten Zahlungsmittel,welche"
  100 P."im Zusammenhang ein Wirtschafts-"
  110 P."system ergeben."
  120 P."Es kommt darauf an,zur rechten"
  125 P."Zeit das richtige zu verkaufen"
  130 P."oder zu kaufen."
  140 P."Je Spielrunde werden die Kurse"
  145 P."und der Kontostand angezeigt."
  160 P."ENTER";X=INCHAR
  161 G=20000;H=1;Q=0;R=0;S=0;T=0;U=0;V=0;W=0;Z=0;Y=0
  162 PO.(HEX(00A0)),0;PO.(HEX(00A1)),0
  163 PO.(HEX(00A2)),0;PO.(HEX(00A3)),0
  170 O.12
  171 O=RND(10)+20;L=RND(29)+30;M=RND(25)+100
  172 N=RND(200)*5+5000;P=RND(200)*10+30000
  173 J=RND(200)*10+20000;F=RND(200)*10+25000
  180 P." OELPREIS   LANDPREIS   MIETE"
  190 P.
  200 P.O,"M/L    ",L," M",M,"M"
  210 P.
  220 FOR I=1 TO 32
  230 P."*",
  240 NEXT I
  241 K=P/50;E=RND(30)+50
  250 P.
  260 P."Kraftwerkaktie",K," M bei 2 %"
  270 P.
  280 P."Eisenbahnaktie",E," Mark"
  281 P.
  290 GOSUB 6200
  300 P."Wollen Sie kaufen,J/N ?"
  310 X=INCHAR
  320 IF X=74 GOTO 1000
  321 P."Wollen Sie verkaufen,J/N ?";X=INCHAR
  322 IF X=74 GOTO 2000
  323 IF Z=0 GOTO 360
  324 P."Kredit zurueckzahlen,J/N ?";X=INCHAR
  325 IF X=74 GOTO 7100
  360 P.;INPUT"Oelkauf in L  ",A
  361 Q=Q+A;A=A*O;GOSUB 6100
  370 P.;INPUT"Landkauf in m^2   ",B
  371 R=R+B;A=B*L;GOSUB 6100
  390 P.;P."Bei",
  400 IF H=1 GOTO 450
  410 P.H," Haeusern ",
  420 GOTO 460
  450 P.H," Haus ",
  460 P."betraegt"
  465 P."die Miete",H*M," Mark."
  470 P.
  480 GOSUB5000;P."Kraftwerkaktien";GOSUB 5020
  490 INPUT C
  491 IF S+C>25 GOTO 515
  492 S=S+C;A=C*K;GOSUB 6100
  500 GOSUB 5000;P."Eisenbahnaktien";GOSUB 5020
  510 INPUT D
  511 IF T+D>10 GOTO 515
  512 T=T+D;A=D*E;GOSUB 6100
  513 GOTO 520
  515 P."zu viele Anteile !"
  516 FOR A=0 TO 3000;NEXT A
  520 O.12
  530 A=H*M
  540 GOSUB 6100
  541 IF A=0 GOTO 170
  550 P."Ihre Grundstueckanlagen werden"
  560 P."belegt."
  570 H=H-1;C=A;A=N;GOSUB 6000
  580 A=C;GOSUB 6100
  590 FOR I=0 TO 2000;NEXT I
  600 GOTO 170
 1000 O.12;TAB(128)
 1010 P." UNSER ANGEBOT"
 1020 FOR I=1 TO 32 
 1030 P."=",
 1040 NEXT I
 1050 P.;P.
 1060 P." 1  Mietshaus ",N," Mark"
 1070 P." 2  Kraftwerk ",P," Mark"
 1080 P." 3  Bahnhof   ",F," Mark"
 1090 P." 4  Supermarkt",J," Mark"
 1100 P.;P."Bitte waehlen Sie"
 1110 INPUT A
 1120 IF A=1 GOTO 1200
 1130 IF A=2 GOTO 1300
 1140 IF A=3 GOTO 1400
 1150 IF A=4 GOTO 1500
 1160 GOTO 1060
 1200 C=N;GOSUB 5040;H=H+X;GOTO 360
 1300 C=P;GOSUB 5040
 1320 B=PEEK(HEX(00A2));B=B+X
 1330 PO.(HEX(00A2)),B;GOTO 360
 1400 C=F;GOSUB 5040
 1420 B=PEEK(HEX(00A0));B=B+X
 1430 PO.(HEX(00A0)),B;GOTO 360
 1500 C=J;GOSUB 5040
 1520 B=PEEK(HEX(00A1));B=B+X
 1530 PO.(HEX(00A1)),B;GOTO 360
 2000 O.12;P."Was wollen Sie verkaufen"
 2001 IF H=0 GOTO 2003
 2002 P." 1 Mietshaus"
 2003 A=PEEK(HEX(00A2));IF A=0 GOTO 2005
 2004 P." 2 Kraftwerk"
 2005 A=PEEK(HEX(00A0));IF A=0 GOTO 2007
 2006 P." 3 Bahnhof"
 2007 A=PEEK(HEX(00A1));IF A=0 GOTO 2009
 2008 P." 4 Supermarkt"
 2009 IF S>0 GOTO 2011
 2010 IF T=0 GOTO 2012
 2011 P." 5 Aktien"
 2012 IF R=0 GOTO 2014
 2013 P." 6 Grundstueck"
 2014 IF Q=0 GOTO 2016
 2015 P." 7 Oel"
 2016 INPUT"Ihre Wahl     ",A
 2017 IF A=1 GOTO 2030
 2018 IF A=2 GOTO 2035
 2019 IF A=3 GOTO 2040
 2020 IF A=4 GOTO 2045
 2021 IF A=5 GOTO 2050
 2022 IF A=6 GOTO 2055
 2023 IF A=7 GOTO 2060
 2030 IF H=0 GOTO 2070
 2031 GOTO 2100
 2035 A=PEEK(HEX(00A2));IF A=0 GOTO 2070
 2037 GOTO 2200
 2040 A=PEEK(HEX(00A0));IF A=0 GOTO 2070
 2042 GOTO 2300
 2045 A=PEEK(HEX(00A1));IF A=0 GOTO 2070
 2047 GOTO 2400
 2050 IF S>0 GOTO 2500
 2051 IF T=0 GOTO 2070
 2052 GOTO 2500
 2055 IF R=0 GOTO 2070
 2056 GOTO 2600
 2060 IF Q=0 GOTO 2070
 2061 GOTO 2700
 2070 P.;P."Schummler"
 2071 FOR A=0 TO 3000;NEXT A
 2072 GOTO 170
 2100 A=N;GOSUB 6000;H=H-1;GOTO 170
 2200 A=P;GOSUB 6000;A=PEEK(HEX(00A2));A=A-1
 2202 PO.(HEX(00A2)),A;GOTO 170
 2300 A=F;GOSUB 6000;A=PEEK(HEX(00A0));A=A-1
 2302 PO.(HEX(00A0)),A;GOTO 170
 2400 A=J;GOSUB 6000;A=PEEK(HEX(00A1));A=A-1
 2402 PO.(HEX(00A1)),A;GOTO 170
 2500 P." 1 Kraftwerkaktien",S
 2501 P." 2 Eisenbahnaktien",T
 2502 INPUT"Ihre Wahl   ",A
 2503 IF A=1 GOTO 2510
 2504 IF A=2 GOTO 2520
 2505 GOTO 2500
 2510 P."Sie haben",S," Aktien";INPUT"Anzahl  ",A
 2511 IF A>S GOTO 2070
 2512 IF A*(K/10)>3200 GOTO 2517
 2513 S=S-A;A=A*K;GOSUB 6000;GOTO 170
 2517 B=A;A=(A/2)*K;GOSUB 6000;A=B/2
 2518 GOTO 2512
 2520 P."Sie haben",T," Aktien";INPUT"Anzahl  ",A
 2521 IF A>T GOTO 2070
 2522 IF A*(E/10)>3200 GOTO 2525
 2523 T=T-A;A=A*E;GOSUB 6000;GOTO 170
 2525 B=A;A=(A/2)*E;GOSUB 6000;A=B/2
 2526 GOTO 2521
 2600 GOSUB 2610
 2601 IF A>R GOTO 2070
 2602 IF A*(L/10)>3200 GOTO 2607
 2603 R=R-A;A=A*L;GOSUB 6000;GOTO 170
 2607 V=A;A=(A/2)*L;GOSUB 6000;A=V/2
 2608 GOTO 2602
 2610 P."Sie haben",R," Quadratmeter"
 2611 INPUT"Wieviele wollen Sie verkaufen   ",A
 2612 RETURN
 2700 GOSUB 2710
 2701 IF A>Q GOTO 2070
 2702 IF A*(O/10)>3200 GOTO 2705
 2703 Q=Q-A;A=A*O;GOSUB 6000;GOTO 170
 2705 V=A;A=(A/2)*O;GOSUB 6000;A=V/2
 2706 GOTO 2702
 2710 P."Sie haben",Q," Liter gelagert"
 2711 INPUT"Wieviele Liter wollen Sie verkaufen   ",A
 2712 RETURN
 5000 P."Wieviele ",
 5010 RETURN
 5020 P."wollen Sie kaufen ?"
 5030 RETURN
 5040 O.12;TAB(128)
 5050 P." Wie wollen Sie zahlen ?"
 5060 P.;P." 1  Bargeld";P.
 5070 P." 2  Kredit";P.
 5080 P." 3  Grundstueck";P.
 5090 P." 4  Aktien oder Rohstoff"
 5091 INPUT A
 5100 IF A=1 GOTO 5200
 5110 IF A=2 GOTO 5300
 5120 IF A=3 GOTO 5400
 5130 IF A=4 GOTO 5500
 5200 GOSUB 6200
 5210 INPUT"Anzahl   ",D
 5220 FOR I=1 TO D
 5221 A=C;GOSUB 6100
 5222 NEXT I
 5223 X=D
 5230 IF A>0 X=0
 5240 RETURN
 5300 IF (O/10)*Q>3200 GOTO 5350
 5301 IF (L/10)*R>3200 GOTO 5350
 5302 IF (O*Q)/10+(L*R)/10>3200 GOTO 5350
 5310 A=O*Q+L*R
 5330 GOTO 5351
 5350 A=32000
 5351 P."Bei Ihrer Kapitallage ist"
 5352 P."ein Kredit von",A," Mark"
 5353 P."moeglich."
 5354 IF Z=0 GOTO 5360
 5355 P."Aber Sie haben schon einen"
 5356 P."Kredit.Es tut uns leid."
 5357 X=0;RETURN
 5360 INPUT"Wieviel Kredit:",B
 5361 IF B>A X=0;A=0;RETURN
 5370 A=B;Y=B;Z=1;GOSUB 6000
 5380 GOTO 5200
 5400 P.;P."Sie haben:"
 5401 P."Nr.    Art    Anzahl"
 5402 P."1     Haus ",H
 5403 P."2     Land ",R,"m^2"
 5404 A=PEEK(HEX(00A0))
 5405 P."3  Bahnhof ",A
 5406 A=PEEK(HEX(00A1))
 5407 P."4Supermarkt",A
 5408 A=PEEK(HEX(00A2))
 5409 P."5 Kraftwerk",A;P.
 5410 INPUT"Ihre Wahl   ",A
 5411 IF A=1 GOTO 5420
 5412 IF A=2 GOTO 5430
 5413 IF A=3 GOTO 5445
 5414 IF A=4 GOTO 5450
 5415 IF A=5 GOTO 5490
 5416 GOTO 5410
 5420 A=N;H=H-1
 5421 IF H<0 X=0;RETURN
 5422 GOSUB 6000
 5423 GOTO 5200
 5430 INPUT"Wieviel Quadratmeter  ",A
 5431 IF A*(L/10)>3200 GOTO 5437
 5432 R=R-A;A=A*L
 5433 IF R<0 X=0;RETURN
 5434 GOSUB 6000;GOTO 5200
 5437 IF A/2*(L/10)>3200 GOTO 5440
 5438 R=R-A/2;B=A/2;A=(A/2)*L;GOSUB 6000;A=B
 5439 GOTO 5431
 5440 R=R-A/4;B=A/4;A=(A/4)*L;GOSUB 6000;A=B
 5441 GOTO 5431
 5445 A=F;B=PEEK(HEX(00A0));B=B-1
 5446 IF B<0 X=0;RETURN
 5447 PO.(HEX(00A0)),B;GOSUB 6000
 5448 GOTO 5200
 5450 A=J;B=PEEK(HEX(00A1));B=B-1
 5451 IF B<0 X=0;RETURN
 5452 PO.(HEX(00A1)),B;GOSUB 6000
 5453 GOTO 5200
 5490 A=P;B=PEEK(HEX(00A2));B=B-1
 5491 IF B<0 X=0;RETURN
 5492 PO.(HEX(00A2)),B;GOSUB 6000
 5493 GOTO 5200
 5500 P."Sie haben"
 5501 IF S=0 GOTO 5503
 5502 P.S," Kraftwerkaktien Kenn-Nr.1"
 5503 IF T=0 GOTO 5510
 5504 P.T," Eisenbahnaktien Kenn-Nr.2"
 5505 INPUT"Welche verkaufen Sie  ",A
 5506 IF A=1 GOTO 5520
 5507 IF A=2 GOTO 5530
 5508 GOTO 5505
 5510 P."keine Aktien.   ENTER"
 5511 A=INCHAR;X=0;RETURN
 5520 INPUT"Anzahl  ",A
 5521 IF A*(K/10)>3200 P."zu viele";GOTO 5520
 5522 IF A>S GOTO 2070
 5523 S=S-A;A=A*K;GOSUB 6000
 5524 GOTO 5200
 5530 INPUT"Anzahl   ",A
 5531 IF A*(E/10)>3200 P."zu viele";GOTO 5530
 5532 IF A>T GOTO 2070
 5533 T=T-A;A=A*E;GOSUB 6000
 5534 GOTO 5200
 6000 B=G;GOSUB 7000
 6001 IF B=0 GOTO 6010
 6002 G=B
 6010 B=U;GOSUB 7000
 6011 IF B=0 GOTO 6020
 6012 U=B
 6020 B=V;GOSUB 7000
 6021 IF B=0 GOTO 6030
 6022 V=B
 6030 B=W;GOSUB 7000
 6031 IF B=0 GOTO 6040
 6032 W=B
 6040 IF A>0 GOTO 6060
 6050 RETURN
 6060 P."Konto-Ueberlauf";RETURN
 6100 B=G;GOSUB 7040
 6101 IF B=0 GOTO 6110
 6102 G=B
 6110 B=U;GOSUB 7040
 6111 IF B=0 GOTO 6120
 6112 U=B
 6120 B=V;GOSUB 7040
 6121 IF B=0 GOTO 6130
 6122 V=B
 6130 B=W;GOSUB 7040
 6131 IF B=0 GOTO 6140
 6132 W=B
 6140 IF A>0 GOTO 6160
 6150 RETURN
 6160 P."Konto ueberzogen";RETURN
 6200 P.;P."Ihr Kontostand ist:"
 6210 IF G=0 GOTO 6230
 6220 P.G," Mark"
 6230 IF U=0 GOTO 6250
 6240 P.U," Mark"
 6250 IF V=0 GOTO 6270
 6260 P.V," Mark"
 6270 IF W=0 RETURN
 6280 P.W," Mark";RETURN
 7000 IF B/10+A/10>3200 GOTO 7010
 7001 B=B+A;A=0;RETURN
 7010 IF B/10+A/20>3200 GOTO 7020
 7011 B=B+A/2;A=A-(A/2);RETURN
 7020 IF B/10+A/40>3200 GOTO 7030
 7021 B=B+A/4;A=A-(A/4);RETURN
 7030 B=0;RETURN
 7040 IF B-A<0 GOTO 7050
 7041 B=B-A;A=0;RETURN
 7050 IF B-A/2<0 GOTO 7060
 7051 B=B-A/2;A=A-A/2;RETURN
 7060 IF B-A/4<0 GOTO 7070
 7061 B=B-A/4;A=A-A/4;RETURN
 7070 B=0;RETURN
 7100 P."Sie haben einen Kredit von"
 7101 P.Y
 7102 P."aufgenommen."
 7103 INPUT"Wieviel zahlen Sie zurueck  ",A
 7104 V=Y/10;Y=Y-A;IF Y>0 GOTO 7106
 7105 Z=0
 7106 GOSUB 6100;P."Die Zinsen betragen"
 7107 P.V," Mark";A=V;GOSUB 6100
 7109 GOTO 360
 3341 
    0 ⇘
      ⇘
      C."MONOPOLI 1"
    0 ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      ⇘
      