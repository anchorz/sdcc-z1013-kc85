Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

    0 REM JENS MOECKEL SOFTWARE
    5 O.12;P.;P.;P.;P.;P.;P.;P.;P.
    6 P."          FAHRTRAINER"
    7 P.;P.;P.;P.;P."                 by J.MOECKEL"
   10 P.;P.;P.
   11 P."Eingaben:  C=rechts S4=links"
   12 OUT(1)=207;OUT(1)=0
   13 E=0
   14 F.I=1TO5000;N.I
   15 M=0;N=0
  700 P=0
  710 O=0
  800 OUT(2)=95
  900 B=15
  910 F=17
  920 C=H.(EDE0)
  930 S=14
  950 OUTC.12
 1000 P.;P.;P.
 1001 P."         PUNKTE:",#1,P
 1002 P.;P.
 1004 P.
 1010 G=H.(EC00);H=H.(EC1F)
 1011 J=H.(ECDF);K=H.(ECC0)
 1012 L=42;GOSUB8000
 1015 G.1030
 1016 PO.H.(EC57),'0'
 1017 PO.H.(EC98),'0'
 1018 PO.H.(EC97),'0'
 1020 PO.H.(EC96),'0'
 1022 PO.H.(EC95),'0'
 1025 GOS.3245
 1030 IFO<1G.1060
 1031 IF@(11)=1G.1060
 1032 F.I=1TO10
 1034 PO.H.(EC76)+(O-1)*3,32
 1036 F.J=1TO200;N.J
 1040 PO.H.(EC76)+(O-1)*3,205
 1042 F.J=1TO200;N.J
 1050 N.I
 1051 RETURN
 1060 U=1;GOS.3245
 1061 IF@(11)=0G.1070
 1062 @(11)=0
 1063 IFO=0G.1070
 1064 F.I=1TOO
 1065 PO.H.(EC76)+(I-1)*3,205;N.I
 1070 GOS.8100
 1072 P.;P.;P.
 1074 F.I=10TO1STEP-1
 1076 P."  START IN ",#1,I," SEKUNDEN"
 1077 F.X=1TO1550;N.X
 1078 PO.H.(2B),H.(40)
 1080 N.I
 1082 P.
 1084 OUTC.12
 1090 REM
 1095 N=0
 1100 F.I=1TORND(40)+26
 1101 M=M+1
 1105 D=C+F
 1106 F=D-C
 1108 A=15-B/2
 1110 TAB(A)
 1130 P.")",
 1140 POKEC+F,206
 1141 PO.C+F-32-E,32
 1150 TAB(B)
 1170 P."("
 1175 IFI<25G.1200
 1176 E=0
 1180 IFIN(2)=94F=F+1;E=1;IFF=B+APO.C+F,206;G.3000
 1190 IFIN(2)=87F=F-1;E=-1;IFF=A+1PO.C+F,206;G.3100
 1200 N.I
 1490 D=C+F
 1500 Z=RND(S)
 1550 IFA>ZY=-1
 1560 IFA<ZY=1
 1600 F.A=ATOZSTEPY
 1610 M=M+1
 1640 TAB(A)
 1650 P.")",
 1655 POKED,206
 1656 PO.D-32-E,32
 1660 TAB(B)
 1670 P."("
 1672 IFPEEK(D+1)#32G.3000
 1674 IFPEEK(D-1)#32G.3000
 1677 IFM>99N=N+1;M=0;B=B-1;IFB<6M=20;IFB=4G.4000
 1679 E=0
 1680 IFIN(2)=94D=D+1;E=1
 1690 IFIN(2)=87D=D-1;E=-1
 1700 IFPEEK(D+1)#32GOTO3000
 1710 IFPEEK(D-1)#32GOTO3000
 1720 IFE#0IFPEEK(D+32)#32G.3000
 1740 N.A
 1800 G.1500
 3000 REM
 3100 OUT(0)=1
 3110 POKED,206
 3150 POKED,42
 3151 POKED+1,42
 3152 POKED-32,42
 3153 POKED+32,42
 3154 POKED-1,42
 3155 F.I=1TO22;N.I
 3156 OUT(0)=0
 3157 POKED,32
 3160 POKED+33,42
 3161 F.I=1TO50;N.I
 3162 POKED+29,42
 3164 POKED-65,42
 3165 F.I=1TO30;N.I
 3166 POKED+32,32
 3168 POKED+63,42
 3169 F.I=1TO50;N.I
 3170 POKED-34,42
 3172 POKED+1,32
 3173 F.I=0TO50;N.I
 3174 POKED-1,32
 3176 POKED-32,32
 3178 F.I=1TO30;N.I
 3180 POKED+33,32
 3182 POKED-98,42
 3183 F.I=1TO50;N.I
 3184 POKED+29,32
 3186 POKED-65,32
 3188 F.I=1TO30;N.I
 3190 POKED+63,32
 3192 POKED-34,32
 3193 U=0
 3194 POKED-98,32
 3195 IFM>=100N=N+M/100
 3196 IFM>=100M=M-100;G.3196
 3240 P=P+N
 3245 Q=P/100;PO.H.(EC70),Q+48
 3246 IFP>100Q=Q-100;G.3246
 3247 N=0
 3250 PO.H.(EC71),P/10+48
 3252 Q=P
 3254 IFQ>9Q=Q-10;G.3254
 3255 R=H.(EC72)
 3260 PO.R,Q+48
 3270 PO.R+1,M/10+48
 3272 Q=M
 3274 IFQ>9Q=Q-10;G.3274
 3280 PO.R+2,Q+48
 3300 IFU=1RETURN
 3305 O=O+1
 3306 GOS.1030
 3310 @(11)=0
 3400 F.I=1TO4
 3410 OUT(0)=1
 3420 F.R=1TO1000;N.R
 3430 OUT(0)=0
 3440 F.R=1TO100;N.R
 3450 N.I
 3500 IFO<3G.3600
 3510 GOS.8130;OUTC.12
 3520 P.;P.;P.
 3530 P."DAS WAR'S DANN WOHL !"
 3544 P.;P.
 3550 P."ERREICHTE PUNKTEZAHL:",#2,P*100+M
 3570 P.;P.;P.;P."NOCH EIN SPIEL ? (JA=ENT):",
 3575 I=INC.
 3576 M=0;N=0
 3580 IFI=13G.700
 3590 OUTC.12;P."ENDE";STOP
 3600 REM
 3891 F=17
 3892 C=H.(EDE0)
 3900 OUTC.12;G.1090
 3983 S=14
 4000 REM
 4010 POKED+31,'Z';POKED+32,'I'
 4020 POKED+33,'E';POKED+34,'L'
 4090 F.T=1TO3
 4100 F.I=1TO3
 4110 OUT(0)=1
 4112 F.R=1TO100;N.R
 4115 OUT(0)=0
 4120 F.R=1TO1000;N.R
 4130 N.I
 4150 F.I=1TO3
 4160 F.S=1TO3
 4170 OUT(0)=1
 4180 OUT(0)=0
 4190 F.R=1TO100;N.R
 4200 N.S
 4210 F.R=1TO1000;N.R
 4220 N.I
 4230 N.T
 4232 Z=RND(S)
 4299 U=1
 4300 GOS.8130
 4305 M=0
 4310 OUTC.12
 4320 P.;P.;P.
 4330 P."DURCHFAHRT GESCHAFFT !"
 4340 P.;P.
 4345 P=P+N;N=0
 4350 P."BISHERIGE ZUSAMMENSTOESSE:",#1,O
 4360 P.;P.
 4370 P."ERREICHTE PUNKTZAHL:",#2,P*100+M
 4380 P.;P.;P.
 4390 P."      WEITER=ENT (N=ENDE):",
 4400 I=INC.;IFI='N'OUTC.12;P."ENDE";STOP
 4510 OUTC.12;B=13
 4520 S=14
 4530 @(11)=1
 4600 G.800
 7999 REM J.MOECKEL-SOFT
 8000 REM SUBROUTINE FENSTER
 8010 F.I=GTOH;POKEI,L;N.I
 8020 F.I=HTOJSTEP32;POKEI,L;N.I
 8030 F.I=JTOKSTEP-1;POKEI,L;N.I
 8040 F.I=KTOGSTEP-32;POKEI,L;N.I
 8050 RETURN
 8100 REM FENSTER
 8110 PO.H.(1B),H.(E0)
 8111 PO.H.(1C),H.(EC)
 8112 PO.H.(1D),0
 8113 PO.H.(1E),H.(F0)
 8114 CALLH.(F6D1)
 8115 RETURN
 8130 REM VOLLES WINDOW
 8132 PO.H.(1B),0
 8133 PO.H.(1C),H.(EC)
 8134 PO.H.(1D),0
 8135 PO.H.(1E),H.(F0)
 8140 CALLH.(F6D1)
 8150 RETURN
