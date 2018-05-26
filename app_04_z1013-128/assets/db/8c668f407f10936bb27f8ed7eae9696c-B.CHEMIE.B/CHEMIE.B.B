Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

    5 WINDOW:CLS
   10!       VORTEIL
   20 INPUT "AUFGABENNUMMER:C";LL
   30 IF LL=1 THEN 100
   40 IF LL=2 THEN 1000
   50 IF LL=3 THEN 2000
   60 IF LL=4 THEN 3000
   70 IF LL=5 THEN 4000:ELSE RUN 
   80!
   90!
  100!             C1
  110 WINDOW:CLS:WINDOW 12,15,2,12
  120 PRINT AT(0,0);"Berechnung der reellen Loesungen einer"
  130 PRINT AT(2,0);"kubischen Gleichung in Normalform."
  140 PRINT AT(5,5);"x^3+r*x^2+s*x+t=0"
  150 PRINT AT(7,0);"---------------------------------------"
  160 PRINT AT(9,1);"Eingabe der Koeffizienten:"
  170 INPUT "r=";R
  180 WINDOW 12,15,14,26:INPUT "s=";S
  190 WINDOW 12,20,24,31:INPUT "t=";T
  200 P=((S-((R^2)/3))/3)^3:PRINT "P";P
  210 Q=((2*R*R*R)/27-R*S/3+T)/2:PRINT "Q";Q
  220 Q2=Q^2
  230 D=P+Q2:PRINT "D";D
  240 IF D<0 THEN 290
  244 UD=D^(1/2)-Q
  246 IF UD<0 THEN 248:ELSE 250
  248 UD=ABS(UD):UA=1
  250 U1=UD^(1/3)
  252 IF UA=1 THEN 254:ELSE 255
  254 U1=-U1
  255 VD=(D^(1/2)*(-1))-Q:UA=0
  260 IF VD<0 THEN 265:ELSE 270
  265 VD=ABS(VD):VA=1
  270 V1=VD^(1/3)
  275 IF VA=1 THEN 276:ELSE 280
  276 V1=-V1
  280 X1=U1+V1-R/3:WA=1:VA=0:GOTO 370 
  290 Z=(-P)^(1/2):PRINT "Z";Z
  300 CI=(Q/Z)*(-1):PRINT "CI";CI
  310 SI=(1-CI^2)^(1/2):PRINT "SI";SI
  320 TI=SI/CI:PRINT "TI";TI
  330 FB=(ATN(TI))
  332 FB=FB*180/PI:PRINT "FI";FB
  334 IF FB<0 THEN 335:ELSE 336
  335 FB=FB+180
  336 FB=FB/3:PRINT "FE";FB
  340 X1=2*Z^(1/3)*COS(FB*PI/180)-R/3
  350 X2=2*Z^(1/3)*COS((FB+120)*PI/180)-R/3
  360 X3=2*Z^(1/3)*COS((FB+240)*PI/180)-R/3:WA=2
  370 PRINT AT(18,1);"Ergebnisse:"
  380 PRINT AT(19,1);"-----------"
  390 IF WA=2 THEN 420
  400 PRINT AT(20,3);"x=",X1 
  410 PRINT AT(21,2);"und zwei konjugiert komplexe Loesungen":GOTO 450
  420 PRINT AT(20,3);"x1=",X1 
  430 PRINT AT(21,3);"x2=",X2
  440 PRINT AT(22,3);"x3=",X3
  450 WINDOW 23,23,15,31:INPUT "Neubeginn (J)/N:";NB$
  460 IF NB$="N"THEN 470:ELSE RUN 100
  470 WINDOW:CLS
  480 PRINT AT(10,10);"das war's!"
  490 PAUSE 30:WINDOW:CLS
  500!
  510!
  520!
  530!
  540!
  550!
  560!
  570!
 1000!         C2
 1010!
 1020 WINDOW:CLS:WINDOW 15,18,2,18 
 1030 PRINT AT(0,0);"Berechnung der kleinsten positiven"
 1040 PRINT AT(2,0);"Loesung mit beliebiger Genauigkeit nach"
 1050 PRINT AT(4,0);"dem NEWTONschen Veerfahren fuer eine"
 1060 PRINT AT(6,0);"Gleichung 5.Grades in Normalform."
 1070 PRINT AT(8,3);"x^5+a*x^4+b*x^3+c*x^2+d*x+e=0"
 1080 PRINT AT(9,0);"---------------------------------------"
 1090 PRINT AT(11,1);"Eingabewerte:"
 1100 PRINT AT(12,3);"Koeffizienten:"
 1110 INPUT "a=";A:INPUT "b=";B:INPUT "c=";C
 1120 WINDOW 15,18,22,31
 1130 INPUT "d=";D:INPUT "e=";E
 1140 WINDOW 18,20,3,31
 1150 INPUT "Rechengenauigkeit:";RG:ZA=1
 1160 INPUT "1.Naeherung:  n=";X
 1170 F0=X^5+A*X^4+B*X^3+C*X^2+D*X+E
 1180 F1=5*X^4+4*A*X^3+3*B*X^2+2*C*X+D
 1185 IF ZA=2 THEN 1250
 1190 F2=20*X^3+12*A*X^2+6*B*X+2*C
 1200 IF F1=0 THEN 1230
 1210 KK=(F0*F2)/(F1^2)
 1220 IF KK<1 THEN 1250:ELSE 1230
 1230 PRINT AT(17,0);"Konvergenzkriterium >1 neue 1.Naeherung"
 1240 PRINT AT(18,3);"eingeben:                              ":GOTO 1160
 1250 ZA=2
 1260 X=X-(F0/F1)
 1265 Y=X^5+A*X^4+B*X^3+C*X^2+D*X+E
 1270 IF Y<RG THEN 1280:ELSE 1170
 1280 PRINT AT(20,1);"Ergebnis:"
 1290 PRINT AT(21,3);"kleinste positive Nullstelle x=",X
 1300 WINDOW 23,23,10,31
 1310 INPUT "Neubeginn (J)/N:";NB$
 1320 IF NB$="N"THEN 1330:ELSE RUN 1000
 1330 WINDOW:CLS
 1340 PRINT AT(10,10);"das war's!"
 1350 PAUSE 30
 1360 WINDOW:CLS
 1370!
 1380!
 1390!
 1400!
 2000!          C3
 2010 WINDOW 23,23,30,30
 2020 PRINT AT(0,0);"Das Programm ermoeglicht die Berechnung"
 2030 PRINT AT(2,0);"der Fuellhoehe bestimmter Fuellkoerper."      
 2040 PRINT AT(4,0);"Diese Koerper aus Quwarzglas (Dichte"
 2050 PRINT AT(6,0);"2.2g/cm^3) haben die Form von Para-"
 2060 PRINT AT(8,0);"boloiden. Ihre Wandstaerke betraegt 2mm"
 2070 PRINT AT(10,0);"ihre Hoehe 100mm. Der obere aessere " 
 2080 PRINT AT(12,0);"Durchmeser ist variabel. Diese Koerper"
 2090 PRINT AT(14,0);"sollen mit einem Oel der Dichte 2g/cm^3"
 2100 PRINT AT(16,0);"so gefuellt werden, dass sie 50mm tief"
 2110 PRINT AT(18,0);"in eine Fluessigkeit mit variabler"
 2120 PRINT AT(20,0);"Dichte (Rho >2.5g/cm^3) eintauchen und"
 2130 PRINT AT(22,0);"schimmen."
 2140 PRINT AT(23,31);">ENTER<"
 2150 IF INKEY$=""THEN 2150
 2160 WINDOW:CLS:WINDOW 2,20,3,31
 2170 PRINT AT(0,1);"Eingabewerte:"
 2180 INPUT "oberer Aussendurchmesser in mm:";AD:PRINT
 2190 INPUT "Dichte der Fluessigkeit in g/cm^3:";DF
 2200 V1=((AD/20)^2)/.2
 2210 VH=(((AD/20)-(.2))^2)/9.8
 2220 V2=VH*50-VH*2-VH*.02+VH*.04
 2230 VK=V1-V2
 2240 VF=((AD/20)^2)*1.25
 2250 M=((DF*VF)-(2.2*VK))/2
 2260 HA=((VH*.02)-M)/(VH/2)
 2270 H=(.2+(.04-HA)^(1/2))*10
 2280!
 2290! 
 2300!
 2310!
 2320!
 2330!
 2340!
 2350!
 2360!
 2370!
 2380!
 2390!
 2400!
 2410!
 2420!
 2430!
 2440!
 2450!
 2460!
 2470!
 2480!!
 2490!
 2500 PRINT AT(18,1);"Ergebnis:"
 2510 PRINT AT(20,3);"Fuellhoehe h=",H,"mm"
 2520 WINDOW 23,23,5,31
 2530 INPUT "Neubeginn (J)/N:";NB$
 2540 IF NB$="N"THEN 2550:ELSE RUN 2000
 2550 WINDOW:CLS
 2560 PRINT AT(10,10);"das war's!"
 2570 PAUSE 30:WINDOW:CLS
 2580!
 2590!
 2600!
 2610!
 2620!
 2630!
 2640!
 3000!         C4
 3010!
 3020 WINDOW:CLS:WINDOW 9,10,3,18
 3030 PRINT AT(0,0);"Berechnung der speziellen Loesung einer"
 3040 PRINT AT(1,0);"linearen homogenen Differenzial-"
 3050 PRINT AT(2,0);"gleichung 2.Ordnung mit konstanten" 
 3060 PRINT AT(3,0);"Koeffizienten der Form:"
 3070 PRINT AT(4,5);"y''+a1*y'+a0*y=0"
 3080 PRINT AT(5,0);"---------------------------------------"
 3090 PRINT AT(7,1);"Eingabewerte:"
 3100 PRINT AT(8,3);"Koeffizienten:"
 3110 INPUT "a1=";A1
 3120 WINDOW 9,10,20,31:INPUT "a0=";A0
 3130 PRINT AT(11,3);"Konstanten:"
 3140 WINDOW 13,18,5,31
 3150 INPUT "y(0)=K1=";K1
 3160 INPUT "fuer y'(0) K2=";K2
 3170 INPUT "fuer y'(0) K3=";K3
 3180 K2=K2+K3
 3190 A=A1/(-2):B=(A0-((A)^2))^(1/2)
 3200 C1=K1
 3210 C2=(K2-(A*C1))/B
 3220!
 3230!
 3240!
 3250!
 3260!
 3270!
 3280!
 3290!
 3300!
 3310!
 3320!
 3330!
 3340!
 3350!
 3360 PRINT AT(18,1);"Ergebnisse:"
 3370 PRINT AT(20,3);"Groesse a=",A 
 3380 PRINT AT(20,20);"Groesse b=",B
 3390 PRINT AT(21,3);"Konstante C1=",C1
 3400 PRINT AT(21,20);"Konstante C2=",C2
 3410 WINDOW 23,23,5,31
 3420 INPUT "Neubeginn (J)/N:";NB$
 3430 IF NB$="N"THEN 3440:ELSE RUN 3000
 3440 WINDOW:CLS
 3450 PRINT AT(10,10);"das war's!"
 3460 PAUSE 30:WINDOW:CLS
 3470!
 3480!
 3490!
 3500!
 3510!
 3520!
 3530!
 3540!
 4000 WINDOW:CLS:PRINT AT(3,3);"Analyse und moegliche"
 4010 PRINT AT(5,3);"Stoffvarianten zum"
 4020 PRINT AT(7,3);"Versuch 3" 
 4030 IF INKEY$=""THEN 4030
 4040 S=0:R=0:P=0:FA=0:FH=0:FK=0:BR=0:KN=0:
 4050 WINDOW:CLS:WINDOW 5,23,0,31
 4060 PRINT AT(0,5);"Analyse der Anionen"
 4070 PRINT AT(1,5);""
 4080 PRINT "weisser Niederschlag mit Silbernitrat?"
 4090 G=1
 4100 INPUT "J/N";A$
 4110 AZ=110
 4120 IF S=0 THEN 4160
 4130 IF S=1 THEN 4170
 4140 IF S=2 THEN 4180
 4150 IF S=3 THEN 4190:ELSE S=S+1:GOTO 4200
 4160 IF A$="J"THEN AA=AZ+G:S=S+1:GOTO 4200:ELSE 4200
 4170 IF A$="J"THEN AB=AZ+G:S=S+1:GOTO 4200:ELSE 4200
 4180 IF A$="J"THEN AC=AZ+G:S=S+1:GOTO 4200
 4190 IF A$="J"THEN S=S+1:GOTO 4200
 4200 IF G=1 THEN 4250
 4210 IF G=2 THEN 4290
 4220 IF G=3 THEN 4330
 4230 IF G=4 THEN 4370
 4240 IF G=5 THEN 4410:ELSE 4450
 4250 PRINT "weisser Niederschlag mit Bariumchlorit?"
 4260 G=2
 4270 INPUT "J/N";A$
 4280 GOTO 4120
 4290 PRINT "Gasbildung durch Salzsaure?"
 4300 G=3
 4310 INPUT "J/N:";A$
 4320 GOTO 4120
 4330 PRINT "Entfaerbung durch Schwefelsaure?"
 4340 G=4
 4350 INPUT "J/N:";A$
 4360 GOTO 4120
 4370 PRINT "brauner Ring durch Schwefelsaure?"
 4380 G=5
 4390 INPUT "J/N:";A$
 4400 GOTO 4120
 4410 PRINT "gelber Niederschlag durch Silbernitrat?"
 4420 G=6
 4430 INPUT "J/N:";A$
 4440 GOTO 4120
 4450 IF S<4 THEN 4600
 4460 R=R+1
 4470 IF R>2 THEN GOSUB 4550:GOTO 4600
 4480 GOSUB 4490:GOTO 4050
 4490 FA=FA+1:PRINT "Sie haben Fehler begangen!"
 4500 PRINT "Ueberlegen Sie nocheinmal!"
 4510 PRINT "Sie beginnen wieder mit Anionen!":S=0
 4520 PRINT AT(23,31);">ENTER<"
 4530 IF INKEY$=""THEN 4530
 4540 RETURN
 4550 FA=FA+1:FH=1:PRINT "Sie haben Fehler begangen!"
 4560 PRINT "Ermitteln Sie ersteinmal die Kationen!"
 4570 PRINT AT(23,31);">ENTER<"
 4580 IF INKEY$=""THEN 4580
 4590 RETURN
 4600 WINDOW:CLS:WINDOW 5,23,0,31
 4610 PRINT AT(0,5);"Analyse der Kationen!"
 4620 PRINT AT(1,5);""
 4630 C=0
 4640 PRINT "gelbe Flamme bei Flammenprobe?":H=1
 4650 INPUT "J/N:";B$ 
 4660 BZ=120
 4670 IF C=0 THEN 4700
 4680 IF C=1 THEN 4710
 4690 IF C=2 THEN 4720:ELSE C=C+1:GOTO 4730
 4700 IF B$="J"THEN BA=BZ+H:C=C+1:GOTO 4730:ELSE 4730
 4710 IF B$="J"THEN BB=BZ+H:C=C+1:GOTO 4730:ELSE 4730
 4720 IF B$="J"THEN C=C+1:GOTO 4730
 4730 IF H=1 THEN 4790
 4740 IF H=2 THEN 4830
 4750 IF H=3 THEN 4870
 4760 IF H=4 THEN 4910
 4770 IF H=5 THEN 4950
 4780 IF H=6 THEN 4990:ELSE 5032
 4790 PRINT "violette Flamme bei Flammenprobe?"
 4800 H=2
 4810 INPUT "J/N:";B$ 
 4820 GOTO 4670
 4830 PRINT "gruene Flamme bei Flammenprobe?"
 4840 H=3
 4850 INPUT "J/N:";B$ 
 4860 GOTO 4670
 4870 PRINT "Farbbildung mit Ammoniumrhodanid?"
 4880 H=4
 4890 INPUT "J/N:";B$
 4900 GOTO 4670
 4910 PRINT "blaue Farbe mit Ammoniumhydoxid?"
 4920 H=5
 4930 INPUT "J/N:";B$
 4940 GOTO 4670
 4950 PRINT "hellgruener Niederschlag mit Natronlauge?"
 4960 H=6
 4970 INPUT "J/N:";B$
 4980 GOTO 4670
 4990 PRINT "blauer Niederschlag mit lackmuspapier?"
 5000 H=7
 5010 INPUT "J/N:";B$
 5020 GOTO 4670
 5032 P=P+1:IF BA=123 THEN 5036
 5034 IF BB=123 THEN 5036:ELSE 5044
 5036 IF AA=111 OR AA=115 THEN 5038:ELSE 5042
 5038 IF AB=111 OR AB=115 OR AB=0 THEN 5040:ELSE 5042
 5040 IF AC=111 OR AC=115 OR AC=0 THEN 5044:ELSE 5042
 5042 BR=1:GOSUB 5130:GOTO 4600
 5044 IF BA=125 AND BB=126 THEN GOSUB 5130:GOTO 4600:ELSE KN=1:GOTO 5090
 5090 IF C<3 THEN 5560
 5110 IF P>2 THEN 5190
 5120 GOSUB 5130:GOTO 4600
 5130 FB=FB+1:PRINT "Sie haben Fehler begangen!"
 5140 PRINT "Ueberlegen Sie nocheinmal!"
 5150 PRINT "Sie beginnen wieder mit Kationen!":C=0
 5160 PRINT AT(23,31);">ENTER<"
 5170 IF INKEY$=""THEN 5170
 5180 RETURN
 5190 WINDOW:CLS
 5200 PRINT AT(0,0);"Fehleraufloesung:":BH=4
 5210 PRINT AT(1,0);"================="
 5220 IF R>2 THEN 5230:ELSE 5260
 5230 PRINT AT(BH,0);"Die Anzahl der Anionen aus den Nach-"
 5240 PRINT AT(BH+1,0);"weisreaktionen ist zu gross."
 5250 PRINT AT(BH+2,0);"Sie koennen maximal drei betragen.":BH=BH+5
 5255 IF P>2 THEN 5260:ELSE 5290
 5260 PRINT AT(BH,0);"Die Anzahl der Kationen aus den Nach-"
 5270 PRINT AT(BH+1,0);"weisreaktionen ist zu gross."
 5280 PRINT AT(BH+2,0);"Sie koennen maximal zwei betragen.":BH=BH+5
 5290 IF BR=1 THEN 5300:ELSE 5320
 5300 PRINT AT(BH,0);"Eine Nachweisreaktion stellt eine"
 5310 PRINT AT(BH+1,0);"schwerloesliche Verbindung dar.":BH=BH+3 
 5320 IF KN=1 THEN 5330:ELSE 5350
 5330 PRINT AT(BH,0);"Es wurden gleichzeitig Kupfer- und"
 5340 PRINT AT(BH+1,0);"Nickelkationen nachgwiesen." 
 5350 END
 5560 WINDOW:CLS:WINDOW 5,23,10,31 
 5570 PRINT AT(0,5);"Sie haben folgende Loesungsmoeg-"
 5580 PRINT AT(1,5);"lichkeiten nachgewiesen."
 5590 PRINT AT(2,5);""
 5600 ZA=AA:GOSUB 5710:GOSUB 5630:GOSUB 5720:GOSUB 5630
 5610 ZA=AB:GOSUB 5710:GOSUB 5630:GOSUB 5720:GOSUB 5630
 5620 ZA=AC:GOSUB 5710:GOSUB 5630:GOSUB 5720:GOSUB 5630:GOTO 5940
 5630 IF ZB=0 THEN RETURN
 5640 IF ZA=111 THEN 5790
 5650 IF ZA=112 THEN 5800
 5660 IF ZA=113 THEN 5810
 5670 IF ZA=114 THEN 5820
 5680 IF ZA=115 THEN 5830
 5690 IF ZA=116 THEN 5840
 5700 IF ZA=0 THEN 5940
 5710 ZB=BA:GOTO 5730
 5720 ZB=BB
 5730 IF ZB=0 THEN RETURN
 5740 K=0
 5750 FOR Q=121 TO 127
 5760 K=K+1
 5770 IF ZB=Q THEN ON K GOTO 5850,5860,5870,5880,5890,5900,5910
 5780 NEXT Q
 5790 N$="clorid":GOTO 5920
 5800 N$="sulfat":GOTO 5920
 5810 N$="carbonat":GOTO 5920
 5820 N$="sulfid":GOTO 5920
 5830 N$="nitrat":GOTO 5920
 5840 N$="phosphat":GOTO 5920
 5850 M$="Natrium":RETURN
 5860 M$="Kalium":RETURN
 5870 M$="Barium":RETURN
 5880 M$="Eisen":RETURN
 5890 M$="Kupfer":RETURN
 5900 M$="Nickel":RETURN
 5910 M$="Ammonium":RETURN
 5920 PRINT;M$;N$:PRINT
 5930 RETURN
 5940 END
