Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 OUTC.12;@(0)=0;@(1)=87;@(2)=174;@(3)=259;@(4)=342;@(5)=423
   20 @(6)=500;@(7)=574;@(8)=643;@(9)=707;@(10)=766;@(11)=819
   30 @(12)=866;@(13)=906;@(14)=940;@(15)=966;@(16)=985;@(17)=996
   40 @(18)=1000;PR.;PR.;PR.;PR."DAS ALL - LETZTE HERAUSFORDERUNG"
   50 PR."~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";PR.;PR.
   60 PR."  Dies sind die Abenteuer des";TAB(10);PR."Raumschiffs"
   70 PR.;TAB(11);PR."ENTERPRISE";PR.;PR.
   80 PR."Die Mission :";PR."-------------";PR.
   85 PR."* neues Leben zu suchen";PR.
   90 PR."* Galaxien zu erforschen, die     nie zuvor ein ",
   93 PR."Mensch sah.";PR.
   95 INP."Ihr Rang (1-20)"R
  110 IFR<1G.95
  120 IFR>20G.95
  125 OUTC.12
  130 PO.27,192;PO.28,62;PO.29,255;PO.30,63;PO.35,0;PO.36,0
  140 C.H.(F50B);PO.27,96;PO.28,238;PO.29,255;PO.30,239
  150 C.H.(F6D1);
  160 PR."---> Berechne Ihre Position !"
  170 K=10+R/2;B=6-R/4
  175 J=K
  177 IFJ>3Z=3;G.180
  179 Z=J
  180 I=RND(Z);P=H.(3EC1)+RND(63)*4;PO.P,PE.(P)+I;J=J-I
  185 IFJ>0G.177
  190 FORI=1TOB;P=H.(3EC2)+RND(63)*4;PO.P,PE.(P)+1;N.I
  200 FORI=0TO63;PO.H.(3EC3)+I*4,RND(5)+2;N.I
  210 @(19)=RND(7);@(20)=RND(7);@(21)=RND(7);@(22)=RND(7)
  220 T=(K-R+10+K/R)*100+R*50;E=30000-R*500;G=(25*R)/4;H=10;F=0
  230 A=-1000;D=0;V=0;M=80;FORI=23TO33;@(I)=100;V=0
  240 N.I;A=-10000
  245 OUTC.12;PR."HABT ACHT !"
  247 PR."Sie wurden mit einer Mission    des Stoerfaktors",
  249 PR.#4,R*20," betraut."
  250 GOS.7800
  251 PR."Gott mit Ihnen !"
  255 GOS.4000
  260 GOS.5050;GOS.5250;GOS.5350
  261 GOS.5550;GOS.5710
  263 GOS.4100;I=INC.
  265 PR.;FORI=1TO9;PR.I," ",;GOS.6000+I*10;PR.;N.I
  280 GOS.4000;GOS.5650;GOS.5800;GOS.6160;GOS.7610
  285 GOS.4100
  290 IFRND(100/R)<3GOS.6500
  293 IFRND(100/R)<5GOS.6560
  295 PR.;PR."---> ",;I=INC.;I=I-72
  297 IFI<1G.265
  300 IFI>9G.265
  304 V=V+5;GOS.6000+I*10;PR.;PR.
  310 IFI#1G.340
  315 M=80
  320 IF@(23)<100M=80/(R+5)
  330 GOS.6110;GOS.7250;GOS.500;G.280
  340 IF@(I+22)>99G.400+I*10
  350 GOS.6000+I*10;PR." beschaedigt"
  360 G.280
  420 GOS.500;G.280
  430 GOS.5450;G.280
  440 GOS.6110;GOS.6750;GOS.500;G.280
  450 GOS.7100;GOS.6110;GOS.500;G.280
  460 E=F+E
  461 PR."Vorhandene Energie :",E;INP."Davon fuer Schild "F
  462 IFF>EPR."Haben leider keine ",F;PR."Einheiten mehr.";G.461
  463 E=E-F;G.280
  470 GOS.6720;G.280
  480 G.2000
  490 GOS.6605;G.280
  500 GOS.4000;GOS.5350;GOS.5550;GOS.5710;GOS.4100;RE.
 1000 PO.27,0;PO.28,236;PO.29,255;PO.30,239;C.H.(F6D1);RE.
 2000 FORI=1TO3;PR.I,"-",;GOS.3000+100*I;N.I
 2010 PR.;PR."C--> ",;I=INC.;I=I-72
 2020 IFI<1G.2000
 2030 IFI>3G.2000
 2040 GOS.I*100+3000;PR.;PR.
 2050 G.I*10+2100
 2110 GOS.4000;GOS.5000;PR.;PR.;I=INC.;GOS.5250;GOS.5350
 2115 GOS.5550;GOS.5710;GOS.4100;G.2010
 2120 GOS.8000;G.2010
 2130 G.280
 3100 PR."Galaxiskarte";RE.
 3200 PR."Missions-Lagebericht";RE.
 3300 PR."Ausstieg aus Computer";RE.
 4000 Q=PE.(43);N=PE.(44);RE.
 4100 PO.43,Q;PO.44,N;RE.
 5000 PO.43,0;PO.44,236;FORI=0TO7;FORJ=0TO7;P=H.(3EC0)+(I*8+J)*4
 5010 IFPE.(P)=0FORZ=1TO3;OUTC.63;N.Z;OUTC.32;G.5030
 5020 FORZ=1TO3;OUTC.PE.(P+Z)+48;N.Z;OUTC.32
 5030 N.J;PR.;N.I;RE.
 5050 PO.H.(3EC0)+(@(19)*8+@(20))*4,1;PO.27,192;PO.28,63
 5060 PO.29,255;PO.30,63;PO.35,0;PO.36,0;C.H.(F50B)
 5070 P=H.(3FC0);PO.P+@(21)*8+@(22),69
 5080 Z=H.(3EC0)+(@(19)*8+@(20))*4
 5085 Y=1
 5090 IFPE.(Z+1)=0G.5150
 5110 FORI=1TOPE.(Z+1)
 5120 J=RND(63)
 5130 IFPE.(H.(3FC0)+J)#0G.5120
 5140 PO.H.(3FC0)+J,75;@(33+Y)=J;Y=Y+1;N.I
 5150 IFPE.(Z+2)=0G.5200
 5160 FORI=1TOPE.(Z+2)
 5170 J=RND(63)
 5180 IFPE.(H.(3FC0)+J)#0G.5170
 5190 PO.H.(3FC0)+J,66;@(33+Y)=J;Y=Y+1;N.I
 5200 FORI=1TOPE.(Z+3)
 5210 J=RND(63)
 5220 IFPE.(H.(3FC0)+J)#0G.5210
 5230 PO.H.(3FC0)+J,42;N.I;FORI=H.(3FC0)TOH.(3FFF) 
 5235 IFPE.(I)=0PO.I,46
 5240 N.I;RE.
 5250 PO.43,0;PO.44,236;PR.;PR."Energie ",#5,E,"";PR.
 5260 PR."Schild  ",#5,F,"";PR.;PR."Sterntag ",#4,T-V,"";PR.
 5270 PR."Torpedos   ",#2,H,"";PR.""
 5280 PR."Quadrant ",#1,@(19)+1,",",@(20)+1;PR."-------------"
 5290 PR."Sektor   ",#1,@(21)+1,",",@(22)+1;PR.""
 5300 PR.;PR."";PR.;PR.;PR.
 5310 PR."(c)F.St.SeStSoftWare",;PO.H.(EE5F),160
 5320 FORI=H.(EC0D)TOH.(ECE0)STEP32;PO.I,161;N.I;PO.H.(ED2D),161
 5330 PO.H.(ED6D),161;PO.H.(EDAD),161;FORI=H.(EDED)TOH.(EE2D)
 5340 PO.I,161;I=I+31;N.I;PO.H.(ED0D),165;RE.
 5350 IF@(24)<100GOS.6600;RE.
 5355 PO.43,15;PO.44,236;OUTC.174;FORI=1TO15;OUTC.158;N.I
 5360 FORI=0TO7;PO.43,46+I*64;PO.44,236+(I*64+32)/256
 5365 OUTC.I+49;OUTC.159
 5370 FORJ=0TO7;OUTC.PE.(H.(3FC0)+I*8+J)
 5380 IFJ=7G.5395
 5390 OUTC.32
 5395 N.J;PO.43,I*64+79;PO.44,(79+I*64)/256+236
 5400 IFI=7PR."",;G.5420
 5410 OUTC.159;TAB(15)
 5420 N.I;PO.H.(EC1F),173;FORI=1TO15;PO.H.(EC1F)+I*32,244;N.I
 5430 PO.H.(EE1F),172;FORI=1TO8;PO.H.(EE2E)+I*2,I+48;N.I;RE.
 5450 FORI=@(19)-1TO@(19)+1;FORJ=@(20)-1TO@(20)+1
 5460 IFI<0G.5520
 5470 IFI>7G.5520
 5480 IFJ<0G.5520
 5490 IFJ>7G.5520
 5500 P=H.(3EC0)+(I*8+J)*4;PO.P,1;FORZ=1TO3;OUTC.PE.(P+Z)+48;N.Z
 5510 G.5530
 5520 FORZ=1TO3;OUTC.42;N.Z
 5530 OUTC.32;N.J;PR.;N.I;RE.
 5550 P=H.(3EC0)+(@(19)*8+@(20))*4
 5560 IFPE.(P+2)=0G.5600
 5563 J=PE.(P+1)+1;FORX=JTOJ+PE.(P+2)-1;I=@(33+X)
 5565 Y=(@(21)-I/8)*(@(21)-I/8);I=I-I/8*8
 5580 I=Y+(@(22)-I)*(@(22)-I)
 5595 IFI>3N.X;G.5600
 5596 GOS.4100;Z=R+5;I=31;P=9;J=@(I)/100;GOS.6570;GOS.4000
 5597 U=1;RE.
 5600 IFPE.(P+1)>0U=2;G.5620
 5610 U=0
 5620 RE.
 5650 P=H.(EC28);GOS.5700;PR.#5,E,;P=P+64;GOS.5700;PR.#5,F,
 5660 P=P+64;GOS.5700;PR.#5,T-V,;P=P+64;GOS.5700;PR.#5,H,;P=P+64
 5670 GOS.5700;PR." ",#1,@(19)+1,",",@(20)+1," ",;P=P+64
 5680 GOS.5700;PR." ",#1,@(21)+1,",",@(22)+1," ",
 5690 FORI=H.(EC2D)TOH.(ED6D)STEP64;PO.I,161;N.I;RE.
 5700 PO.43,P;PO.44,P/256-1;RE.
 5710 IFU>0G.5740
 5720 PO.43,160;PO.44,237;PR.">Klingonen ",#2,K-D,
 5730 PO.H.(EDAD),161;G.5780
 5740 IFU>1G.5760
 5747 E=30000-R*500;H=10;F=0;PO.43,160;PO.44,237
 5750 PR."> > Dock < < ",;PO.H.(EDAD),161;G.5780
 5760 PO.43,160;PO.44,237;PR."> Alarm !!! <",;PO.H.(EDAD),161
 5780 RE.
 5800 P=RND(64)-1;I=@(19)*8+@(20)
 5810 IFA>-10000G.5850
 5820 IFI=PG.5950
 5830 IFPE.(H.(3EC0)+P*4+2)=0G.5950
 5835 A=RND(300/(R/4+2))+180+V
 5840 J=150-RND(R*4);L=P;GOS.5960;G.5950
 5850 IFI#LG.5900
 5860 PO.43,224;PO.44,237;PR."In der Zeit  ",;PO.43,0;PO.44,238
 5870 PR."geschafft.Ba-",;PO.43,32;PO.44,238
 5880 PR."sis gerettet!",;GOS.6000;A=-10000;G.5950
 5900 IFA-V>0GOS.5960;G.5950
 5910 PO.43,224;PO.44,237;PR."Zu spaet! Ba-",;PO.43,0;PO.44,238
 5920 PR."sis von (",#1,L/8+1,",",L-L/8*8+1,")",;PO.43,32
 5930 PO.44,238;PR."zerstoert !! ",;A=-10000;GOS.6000
 5940 B=B-1;P=H.(3EC0)+L*4+2;PO.P,PE.(P)-1
 5950 RE.
 5960 PO.43,224;PO.44,237;PR."Base in (",#1,L/8+1,",",L-L/8*8+1,
 5970 PR.")",;PO.43,0;PO.44,238;PR."in Gefahr !! ",;PO.43,32
 5980 PO.44,238;PR."Zeit noch:",#3,A-V,
 6000 FORI=H.(EDED)TOH.(EE2D)STEP32;PO.I,161;N.I;RE.
 6010 PR."Triebwerke ",;RE.
 6020 PR."Nahsensoren ",;RE.
 6030 PR."Fernsensoren ",;RE.
 6040 PR."Phaser ",;RE.
 6050 PR."Photonentorpedos ",;RE.
 6060 PR."Schildkontrolle ",;RE.
 6070 PR."Schadensreport ",;RE.
 6080 PR."Computer ",;RE.
 6090 PR."Reparatur ",;RE.
 6110 P=H.(3EC0)+(@(19)*8+@(20))*4
 6115 IFPE.(P+1)=0RE.
 6120 IFU=1RE.
 6130 FORI=1TOPE.(P+1);P=@(33+I);J=(@(21)-P/8)*(@(21)-P/8)
 6138 P=P-P/8*8;J=J+(@(22)-P)*(@(22)-P)
 6140 P=(RND(99*R)+5000)/(J/30+1);J=@(I+33)
 6143 P=P/(RND(50/R)+3);PR.P,
 6145 PR." Einheiten vom Gegner auf (",#1,J/8+1,",",J-J/8*8+1,
 6147 PR.") ."
 6150 F=F-P;PR."Es bleiben ",#5,F;GOS.6160;GOS.6500;N.I;RE.
 6160 IFF<0G.6180
 6170 IFV<T+1RE.
 6180 OUTC.12;PR.;PR."ENTERPRISE im All verschollen.";PR.
 6185 PR.K-D," Klingonen erobern";PR."die Galaxis.";G.7700
 6500 IFRND(R*5)<R*2RE.
 6510 P=RND(9);J=@(22+P)/100;Z=RND(R*3)+3
 6530 @(22+P)=@(22+P)-Z
 6535 IFJ>1RE.
 6540 IF@(29)<100RE.
 6545 IFJ<1RE.
 6547 IFJ=@(22+P)/100RE.
 6550 GOS.6000+P*10;PR."ausgefallen";RE.
 6560 P=RND(9);I=P+22;J=@(I)/100;Z=RND(R/7+1)+RND(4)+1
 6570 @(I)=@(I)+Z
 6580 IFJ=@(I)/100RE.
 6585 IF@(29)<100RE.
 6587 IFJ>0RE.
 6590 GOS.6000+P*10;PR."repariert";RE.
 6600 FORI=0TO7;FORJ=0TO7;PO.I*64+J*2+H.(EC30),185;N.J;N.I;RE.
 6605 IFU#1PR."Andocken an Basis noetig fuer   Reparaturen.";RE.
 6610 GOS.6720;Z=0;FORI=23TO32
 6620 IF@(I)<100Z=Z+(100-@(I))*2
 6630 N.I
 6640 IFZ=0PR."Alles okay !";RE.
 6650 PR."Reparatur dauert",#4,Z," Tage.";PR."Reparieren (J/N)?"
 6660 J=INC.
 6670 IFJ=78RE.
 6680 IFJ#74G.6650
 6690 V=V+Z;FORI=23TO32
 6700 IF@(I)<100@(I)=100
 6710 N.I;RE.
 6720 FORI=1TO9;PR.@(I+22)," % ",;GOS.6000+I*10;PR.;N.I;RE.
 6750 Z=H.(3EC1)+(@(19)*8+@(20))*4;X=PE.(Z)+PE.(Z+1)
 6755 INP."Phaserenergie "I;Z=PE.(Z)
 6760 IFZ=0PR."Kein Klingon im Quadrant !";E=E-I/10;RE.
 6770 IFI>EPR."Nicht genug Energie !";RE.
 6775 FORJ=1TOZ;Y=@(J+33);P=(@(21)-Y/8)*(@(21)-Y/8);Y=Y-Y/8
 6778 P=P+(@(22)-Y)*(@(22)-Y)
 6779 P=P/(RND(25-R)+3)
 6780 P=I/(P/15+1);PR.#4,P," Einheiten auf Klingon (",
 6790 Y=@(33+J);PR.#1,Y/8+1,",",Y-Y/8*8+1,")";Y=(R/3+1)*500
 6800 IFP<YPR."Schild wehrt Phaser ab.";G.6850
 6810 PR."Klingon zerstoert !";D=D+1;PO.H.(3FC0)+@(33+J),46
 6820 P=H.(3EC0)+(@(19)*8+@(20))*4+1;PO.P,PE.(P)-1
 6830 @(33+J)=1000
 6850 N.J;FORJ=1TOX
 6855 IFX<1E=E-I;RE.
 6860 IF@(33+J)=1000FORY=JTOX-1;@(33+Y)=@(34+Y);N.Y;X=X-1;J=J-1
 6870 N.J;E=E-I;RE.
 7000 IFW<91S=1;C=1;G.7040
 7010 IFW<181S=1;C=-1;W=180-W;G.7040
 7020 IFW<271S=-1;C=-1;W=W-180;G.7040
 7030 S=-1;C=1;W=360-W
 7040 S=+S;C=+C;I=W/5;J=((W-I*5)*@(I+1)+(I*5+5-W)*@(I))/5;S=S*J
 7050 W=90-W;I=W/5;J=((W-I*5)*@(I+1)+(I*5+5-W)*@(I))/5;C=C*J
 7060 IFABS(C)>ABS(S)S=S*30/ABS(C);C=C*30/ABS(C);RE.
 7070 C=C*30/ABS(S);S=S*30/ABS(S);RE.
 7100 INP."Kurs (0-360) "P
 7110 IFP<0G.7100
 7120 IFP>360G.7100
 7125 W=P;GOS.7000;PR."Torpedo fertig .."
 7126 IFH=0PR."Aber - wir haben keine mehr !";RE.
 7127 PR." S T A R T !";H=H-1
 7130 FORI=0TO9;GOS.7550
 7140 X=PE.(H.(3FC0)+J*8+Z)
 7145 IFJ<0G.7240
 7146 IFJ>7G.7240
 7147 IFZ<0G.7240
 7148 IFZ>7G.7240
 7150 PR."(",#1,J+1,",",Z+1,") ",;OUTC.X;PR.
 7160 IFX=42PR."Sie koennen keinen Stern zer-   stoeren !";RE.
 7170 IFX=66PR."Sternbasis zerstoert !";B=B-1
 7180 IFX=66P=H.(3EC0)+(@(19)*8+@(20))*4+2;PO.P,PE.(P)-1;G.7220
 7190 IFX=75PR."Klingon zerstoert !";D=D+1;G.7210
 7200 N.I;RE.
 7210 P=H.(3EC0)+(@(19)*8+@(20))*4+1;PO.P,PE.(P)-1
 7220 PO.H.(3FC0)+J*8+Z,46
 7230 P=H.(3EC0)+(@(19)*8+@(20))*4;Z=J*8+Z
 7233 J=PE.(P+1)+PE.(P+2);FORI=1TOJ+1
 7235 IF@(I+33)=ZFORX=ITOJ;@(X+33)=@(X+34);N.X;RE.
 7237 N.I
 7240 PR."Torpedo ausser Kontrolle !";RE.
 7250 INP."Kurs (1-360) "W;GOS.7000;INP."Schub (0-80) "P
 7260 IFP>MGOS.6010;PR."beschaedigt.";PR."Maximum",#3,M;G.7250
 7270 IFP<1RE.
 7280 IF10*P>EPR."Nicht genug Energie;!";RE.
 7285 V=V+(P/10+2)*15
 7290 E=E-P*10;FORI=0TOP;GOS.7550
 7310 IFZ<0G.7400
 7320 IFZ>7G.7400
 7330 IFJ<0G.7400
 7340 IFJ>7G.7400
 7350 X=PE.(H.(3FC0)+Z+J*8)
 7360 IFX=42PR."Navigationsfehler !";G.7380
 7363 IFX=75PR."Klingon blockiert ENTERPRISE !";G.7380
 7365 IFX=66G.7380
 7370 N.I;I=P+1
 7380 I=I-1;GOS.7550
 7385 PO.H.(3FC0)+@(21)*8+@(22),46;PO.H.(3FC0)+Z+J*8,69
 7393 @(21)=J;@(22)=Z;V=V+P*30;RE.
 7400 I=P;GOS.7550;Z=Z+@(20)*8;J=J+@(19)*8
 7420 IFJ>63G.7500
 7430 IFJ<0G.7500
 7440 IFZ<0G.7500
 7450 IFZ>63G.7500
 7460 @(19)=J/8;@(21)=J-J/8*8;@(20)=Z/8;@(22)=Z-Z/8*8;GOS.5050
 7470 RE.
 7500 PR."Captain, auf dem Teppich bleiben(oder besser",
 7510 PR." in der Galaxis) !";V=V+P/5*30;GOS.6500;RE.
 7550 X=0;Y=0
 7560 IFS#0X=S/ABS(S)
 7590 IFC#0Y=C/ABS(C)
 7600 J=-(I*S+15*X)/30+@(21);Z= (I*C+15*Y)/30+@(22);RE.
 7610 IFD<KRE.
 7620 GOS.1000;OUTC.12;PR.;PR.;PR." Botschaft von der";PR.
 7630 PR."KOMMANDOBASIS DER FOEDERATION :";PR.;PR.
 7640 PR."> >> >>> GRATULATION !! <<< << < ";PR.;PR.
 7650 PR." Die Foederation ist gerettet !  "
 7660 PR."Sie werden befoedert zum  ",
 7663 FORI=1TO300
 7665 IFI/60*60=IOUTC.46
 7670 N.I;PR.;TAB(8);PR."A D M I R A L   ! !";PR.;PR.;G.7700
 7700 PR."Moechten Sie eine neue Mission  uebernehmen (J/N) ?"
 7710 I=INC.;IFI=74GOS.1000;G.10
 7720 STOP
 7800 PR."Sie muessen noch",#3,K-D," Klingonen   mit Hilfe von",
 7810 PR.#3,B," Sternbasen in",#6,T-V," Tagen zerstoeren."
 7820 PR."Der Toleranzfaktor betraegt 10 % ";RE.
 8000 GOS.7800;I=INC.;J=D*100/K;X=V/(T/100);PR."Sie haben",
 8010 PR.#4,J," % der Klingonen in",X," % der Zeit zerstoert.",
 8020 J=(J-X)*100/(X+1);PR." Ihr  Missionsfaktor ist jetzt",
 8030 PR.#5,J," %.";I=INC.
 8050 IFJ>-11G.8100
 8060 PR."Sie liegen hinter dem Plan und  ausserhalb der ",
 8065 PR."Toleranz. Sie";PR."werden ",
 8070 PR."sich dafuer verantworten!"
 8080 PR."(Vielleicht im Urlaub in den    Steinbruechen",
 8090 PR." Vulkaniens ?!)";RE.
 8100 IFJ>10G.8200
 8110 PR."Nicht schlapp machen !";PR."VORWAERTS !!";RE.
 8200 PR."Sie sind Spitze !";PR."WEITER SO !!";RE.
