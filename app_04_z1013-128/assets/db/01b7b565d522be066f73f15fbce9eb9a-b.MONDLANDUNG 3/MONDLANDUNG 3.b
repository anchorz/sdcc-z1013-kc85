Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 REM SPIELERKLAERUNG
   15 OUTCHAR 12
   16 P.;P.;P.;P.;P.;P.
   20 PRINT"    M O N D L A N D U N G !"
   30 P.;P.;P.
   40 PRINT"Sie sitzen jetzt in einem Raum-"
   45 PRINT"schiff und fliegen auf den Mond zu."
   47 PRINT"Die Geschwindigkeit betraegt    100 m/s."
   48 PRINT"Die Anfangshoehe betraegt       3000 m."
   50 PRINT"Durch Eingabe der Bremskraft            (0-9)"
   53 PRINT"koennen Sie das Raumschiff"
   55 PRINT"abbremsen."
   57 PRINT"Die Menge des verbrauchten "
   58 PRINT"Treibstoffs entspricht dem"
   59 PRINT"10-fachen der Bremskraft."
   60 PRINT"Entsprechend dem gewaehlten"
   63 PRINT"Schwierigkeitsgrad haben Sie"
   65 PRINT"bis zu 10s Zeit zur Eingabe."
   67 PRINT"Sonst wird die Bremskraft "
   69 PRINT"uebernommen!"
   70 PRINT;PRINT"                     (ENTER)
   73 I=INCHAR
   74 IF I=13 GOTO 80
   75 GOTO 73
   80 OUTCHAR 12
   83 P.;P.;P.;P.;P.;P.;P.;P.;P.;P.
   85 PRINT"Schwierigkeitsgrad (1-9)?"
   87 I=INCHAR
   88 IF I<49 GOTO 87
   89 IF I>57 GOTO 87
   90 S=10-(I-47)
  100 REM ANFANGSWERTE
  110 H=3000
  120 V=100
  130 T=2000
  140 M=12000
  150 E=48
  155 U=HEX(ECEF)
  160 Z=48
  165 Y=HEX(ECF0)
  170 D=48
  175 W=HEX(ED7A)
  180 P=20
  183 F=0
  185 X=HEX(ECC5)
  190 POKE HEX(F0),HEX(CD)
  200 POKE HEX(F1),HEX(30)
  210 POKE HEX(F2),HEX(F1)
  220 POKE HEX(F3),HEX(32)
  230 POKE HEX(F4),HEX(E0)
  240 POKE HEX(F5),HEX(00)
  250 POKE HEX(F6),HEX(C9)
  300 REM BILDAUFBAU
  305 OUTCHAR 12
  310 PRINT;PRINT;PRINT;PRINT;PRINT
  320 P." h[m]                   V [m/s]"
  330 P."3000                   200"
  340 FOR I=1 TO 4
  342 GOSUB 500
  344 NEXT I
  350 P."                         100"
  360 GOSUB 500
  370 P."2000                      "
  380 GOSUB 500;GOSUB 500
  390 P."                           0"
  400 FOR I=1 TO 3
  402 GOSUB 500
  404 NEXT I
  410 P."1000                      "
  420 P."                          100"
  430 FOR I=1 TO 4
  432 GOSUB 500
  434 NEXT I
  440 P."                          200"
  450 P."  0             "
  460 P."                 "
  470 P."                       "
  490 GOTO 520
  500 P."                          "
  510 RETURN
  520 POKE HEX(1B),0
  530 POKE HEX(1C),HEX(EC)
  540 POKE HEX(1D),HEX(9F)
  550 POKE HEX(1E),HEX(EC)
  560 CALLH.(F6D1)
  570 OUTCHAR 12
  580 POKE HEX(ECAF),153
  590 POKE HEX(ECB0),155
  600 PRINT"Flughoehe          :",H,"m"
  610 PRINT"Sinkgeschwindigkeit:",V,"m/s"
  620 PRINT"Tankinhalt         :",T,"l"
  630 PRINT"Ihr Einsatz bitte !!      (",#1,S,")",
  640 POKE HEX(EC7D),32
 1000 REM TASTATURABFRAGE
 1010 GOSUB 1200
 1020 IF A<48 GOTO 1400
 1030 IF A>57 GOTO 1400
 1040 Z=A
 1050 GOTO 1400
 1200 L=S+49
 1210 FOR J=1 TO (S+1)
 1220 FOR I=1 TO 20
 1230 CALL HEX(F0)
 1240 A=PEEK(HEX(E0))
 1250 IF A#0 GOTO 1300
 1260 NEXT I
 1270 L=L-1
 1280 POKE HEX(EC7B),L
 1290 NEXT J
 1300 RETURN
 1400 REM BERECHNUNGEN
 1410 C=10*(Z-48)
 1415 B=C/10*578/(M/100)
 1420 M=M-C
 1425 T=T-C
 1430 G=P-B
 1440 V=V+G
 1450 H=H-V-G/2
 1455 IF C<1 GOTO 1540
 1460 FOR I=1 TO 50
 1470 POKE U,153
 1480 POKE Y,155
 1490 POKE U,152
 1500 POKE Y,156
 1510 NEXT I
 1520 POKE U,32
 1530 POKE Y,32
 1540 POKE X,32
 1550 X=HEX(EF45)-(H/143*HEX(20))
 1555 IF X<HEX(ECC5) GOTO 1570
 1560 POKE X,148
 1570 POKE (U-HEX(20)),32
 1580 POKE (U-HEX(40)),32
 1590 POKE (Y-HEX(20)),32
 1600 POKE (Y-HEX(40)),32
 1610 U=X+HEX(2A)
 1620 Y=X+HEX(2B)
 1630 POKE (U-HEX(20)),166
 1640 POKE (Y-HEX(20)),166
 1650 POKE (U-HEX(40)),153
 1660 POKE (Y-HEX(40)),155
 1665 IF W=HEX(ECBA) GOTO 1680
 1670 POKE W,32
 1680 W=HEX(EE1A)-(V/20*HEX(20))
 1685 IF W<HEX(ECDA) GOTO 1700
 1690 POKE W,151
 1700 IF H<1 GOTO 2500
 1710 IF T<1 GOTO 2100
 1720 C=0
 1730 OUTCHAR 12
 1770 GOTO 600
 2000 OUTCHAR 12
 2010 PRINT"Ein wenig viel! Wir genehmigen  Ihnen  nur   100 l"
 2020 C=100
 2030 RETURN
 2100 REM ABSTURZ
 2110 OUTCHAR 12
 2120 PRINT"Ihr Treibstoff ist verbraucht."
 2130 PRINT"Sie koennen Ihren Absturz live  erleben!"
 2135 FOR I=1 TO 2000
 2136 NEXT I
 2138 F=1
 2140 E=48 
 2150 Z=48
 2160 D=48
 2170 GOTO 1400
 2500 REM AUSWERTUNG
 2510 POKE HEX(1B),0
 2520 POKE HEX(1C),HEX(EC)
 2530 POKE HEX(1D),HEX(FF)
 2540 POKE HEX(1E),HEX(EF)
 2550 CALL HEX(F6D1)
 2560 OUTCHAR 12
 3000 OUTCHAR 12
 3010 IF V>2 GOTO 3100
 3020 P.;P.;P.;P.;P.;P.
 3030 PRINT"S U P E R !"
 3040 P.;P.;P.;P.
 3050 PRINT"Sie sind weich gelandet!"
 3060 P.;P.;P.
 3070 PRINT"Ihre Aufsetzgeschwindigkeit     betrug:",V,"m/s"
 3080 PRINT"Gratuliere !!"
 3090 GOTO 4000
 3100 IF V>6 GOTO 3200
 3110 P.;P.;P.;P.;P.;P.
 3120 PRINT"Glueck gehabt !!"
 3130 P.;P.;P.
 3140 PRINT"Hat gerade noch geklappt."
 3150 PRINT"Sie sind mit",V,"m/s gelandet."
 3160 PRINT"Ein paar leichte Beulen sind    geworden."
 3170 GOTO 4000
 3200 IF V>30 GOTO 3300
 3210 P.;P.;P.;P.;P.;P.
 3220 PRINT"B R U C H L A N D U N G !"
 3230 P.;P.;P.
 3240 PRINT"Sie haben den Mond um einen"
 3250 PRINT"Krater bereichert!"
 3260 Y=M/10000*V
 3270 X=Y*10
 3280 P.;P.;P.;P.
 3290 PRINT"Der Krater ist",Y,"m tief."
 3293 PRINT"Kraterdurchmesser:",X,"m !!"
 3295 GOTO 4000
 3300 P.;P.;P.;P.;P.;P.
 3310 PRINT"A B S T U R Z !"
 3320 P.;P.;P.
 3330 PRINT"Sie sind wie ein Stein herunter-gefallen."
 3340 PRINT"Ein neues Mondmeer ist entstan- den."
 3350 IF V>40 V=40
 3360 Y=M/10000*V
 3370 X=Y*50
 3380 P.;P.;PRINT"Durchmesser:",X,"m"
 3390 PRINT"Tiefe:",Y,"m"
 3400 P.;P.;PRINT"Zukuenftige Mondforscher werden"
 3410 PRINT"einen riesigen Meteoriten"
 3420 PRINT"vermuten."
 3430 GOTO 4000
 4000 FOR I=1 TO 12000
 4010 NEXT I
 4020 OUTCHAR 12
 4030 P.;P.;P.;P.;P.;P.;P.;P.
 4040 PRINT"Wollen Sie noch einmal ?"
 4050 PRINT"                     (SPACE)"
 4060 I=INCHAR
 4070 IF I=32 GOTO 80
 4080 OUTCHAR 12
 4090 P.;P.;P.;P.;P.;P.;P.
 4100 PRINT"    Auf Wiedersehen !!"
 4110 FOR I=1 TO 2000
 4120 NEXT I
 4130 OUTCHAR 12
 4140 STOP
