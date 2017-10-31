Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

    1 REM UFO-Jagd
    2 GOS.2000;P=-4933;Q=-4165
    3 E=HEX(ECAF);Y=200;Q=-4165
    4 X=15;G.100
    5 REM UFO SCHUSS
    6 F.R=E+32 TO Q STEP32
    7 PO.R,198;N.R
    8 F.R=E+32 TO Q STEP32
    9 PO.R,32;N.R
   10 Y=Y-10;IF Y<1 Q=Q+64
   11 GOS.180
   12 RET.
   15 REM SCHUSS
   16 F.Z=S TO P-31 STEP -32
   17 IF Z=E X=X-1;G.1300
   18 PO.Z,161;N.Z
   19 F.Z=S TO P-32 STEP-32
   20 PO.Z,32;N.Z;RET.
   25 REM UFO BEWEGUNG
   26 IF A<-4928 G.330
   27 IF A>-4257 G.330
   28 PO.HEX(EC8F),32
   29 F.E=C TO A STEP H
   30 PO.E,162
   35 IF Y=0 G.50
   40 CALLHEX(F130);O=PE.(4)
   42 IF O='@' G.900
   44 IFO='F'G.1100
   46 IFO='A'G.1000
   48 IFO='G'G.1200
   50 IF157=PE.(E+800)GOS.5
   51 IF157=PE.(E+736)GOS.5
   53 IF157=PE.(E+640)GOS.5
   54 IF157=PE.(E+544)GOS.5
   55 IF157=PE.(E+320)GOS.5
   92 PO.E,32;N.E;PO.E,162
   95 G.300
  100 REM BILD
  101 O.12;U=HEX(EFE2)
  102 PO.U-30,157;PO.U+7,65
  103 PO.U+9,24;PO.U-23,157
  104 PO.U+20,70;PO.U+18,24
  105 PO.U-14,157;PO.U-7,157
  106 PO.U,64;PO.U+2,24
  110 PO.U+27,71;PO.U+25,24
  120 GOS.180
  130 G.300
  140 REM AUSWERTUNG ABSCHUSS
  145 V=U+2;W=U+9
  150 IF32=PE.(V)IF32=PE.(W)IF32=PE.(W+9)IF32=PE.(W+16)G.3000
  170 RET.
  180 REMEAUSWERTUNG
  181 PO.43,0;PO.44,236
  190 IF X<1 G.3000
  195 IF Y<1 Y=0
  196 IF Y<1 GOS.140
  200 P.
  205 P."Energievorrat   ",
  210 IF Y>0 P.#3,Y
  215 IF Y=0 P."Alle ! ALARM !!"
  217 P.
  218 IF X=1 G.225
  220 F.T=1 TO X-1;O.32;O.162;N.T
  225 P.
  230 P." ",
  235 IF E=HEX(ECAF) O.162
  236 IF E#HEX(ECAF) O.32
  240 P." "
  250 PO.HEX(ECA0),32
  260 RET.
  300 REM
  320 C=E
  330 B=RND(4)
  339 IF B=1 H=1
  340 IF B=1 A=C+RND(30);G.25
  344 IF B=2 H=-1
  345 IF B=2 A=C-RND(30);G.25
  350 IF B=3 H=30+RND(3)
  351 IF B=3 A=C+(H*RND(20));G.25
  355 IFB=4H=-(30+RND(3))
  356 IFB=4A=C+(H*RND(20));G.25
  360 STOP
  800 /32
  900 REM SCHUSS VON @
  910 Y=Y-1
  920 S=Q-23
  950 GOS.15
  980 GOS.180
  990 G.300
 1000 REM SCHUSS VON C
 1010 Y=Y-1
 1020 S=Q-16
 1050 GOS.15
 1080 GOS.180
 1090 G.300
 1100 REM SCHUSS VON N
 1110 Y=Y-1
 1120 S=Q-7
 1150 GOS.15
 1180 GOS.180
 1190 G.300
 1200 REM SCHUSS VON M
 1210 Y=Y-1
 1220 S=Q
 1250 GOS.15
 1280 GOS.180
 1290 G.300
 1300 REM ABSCHUSS
 1309 PO.E,140;I=E-31
 1310 PO.I,135;J=E+33
 1320 PO.J,132;K=E+31
 1330 PO.K,133;L=E-33
 1340 PO.L,134
 1350 PO.E,32;M=E-32
 1360 PO.M,154;N=E+32
 1370 PO.J,32;PO.L,32
 1380 PO.F,148;R=E-1
 1390 PO.R,151
 1400 PO.I,32;PO.K,32
 1410 PO.J,32;PO.L,32
 1420 PO.I,173;PO.K,171
 1430 PO.J,172;PO.L,174
 1440 PO.M,32;PO.N,32
 1450 PO.F,32;PO.R,32
 1460 PO.I,32;PO.K,32
 1470 PO.J,32;PO.L,32
 1480 F.Z=STOESTEP-32
 1485 PO.Z,32;N.Z
 1486 E=HEX(ECAF)
 1490 RET.
 1500 STOP
 2000 REM VORSPANN
 2010 O.12
 2020 P."*******************************"
 2025 P."*       U F O - J A G D       *"
 2030 P."*******************************"
 2040 P.;P.;P.
 2050 P."  Du bist Schuetze in einer "
 2051 P.
 2055 P."  Raumbasis. Deine Basis wird   "
 2060 P."  von 15 UFO's angegriffen !!   "
 2065 P."  Du hast 4 LASER und Energie   "
 2070 P."  fuer gesamt 200 Schuss. Die   "
 2075 P."  Basis hat ein Automatisches   "
 2080 P."  Schutzschild, was aber  pro   "
 2081 P."  Aufbau des Feldes , Energie   "
 2082 P."  fuer 10 Schuss verbraucht .   "
 2085 P.;P.;P."  Alles klar ? (J/N)"
 2090 T=INC.;IF T='J' RET.
 2096 F.T=1TO32;P.
 2097 F.Z=1 TO 20;N.Z;N.T
 2900 G.2000
 3000 REM AUSWERTUNG
 3005 PO.43,0;PO.44,237
 3010 P.;P.
 3015 IF X<1 IF Y=0 P."Glueck gehabt !!!!";G.3050
 3018 IF X<1 G.3040
 3020 IF X=1 P."  Es ist noch ein UFO da .";G.3023
 3022 P."  Es sind noch",#3,X," UFO's da .  "
 3023 P.
 3025 P."  Durch Deine Schuld ist die    "
 3026 P."  Basis zerstoert !! Du musst   "
 3027 P."  mehr ueben.";G.3050
 3030 IF Y<20 P."  Das war keine besondere";P.
 3032 IF Y<20 P."  Leistung .Es waren nur noch   "
 3035 IF Y<20 P.#4,Y," Schuss uebrig.";G.3050
 3040 P."  Sie sind ein guter Schuetze ! "
 3045 P.;P."  G R A T U L I E R E !";P.;P.
 3046 P."  Sie hatten sogar noch Energie "
 3047 P."  fuer",#4,Y," Schuss ."
 3050 P.;P.;P."  Noch einmal ?"
 3060 I=INC.;IF I='J'G.3
 3070 F.T=1 TO 32;P.
 3080 F.Z=1 TO 20;N.Z;N.T
