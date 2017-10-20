Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

1 O.12
2 REM PROGRAMMGESTALTUNG        19.09.1986 KARL-HEINZ DOELL
3 G.7000
5 P."FUER DIESES SPIEL NEHMEN SIE DIE"
6 P."ENTSPRECHENDEN VORDRUCKE,ODER   "
7 P."SIE FERTIGEN SICH GEWINNKARTEN  "
8 P."NACH NACHFOLGENDEN MUSTER SELBST"
9 P."AN."
10 P.;P."DIE RECHTE BREITE SPALTE TEILEN "
11 P."SIE NOCH IN KLEINERE SPALTEN EIN"
12 P."SO KOENNEN SIE MEHRERE SPIELE   "
13 P."AUF EINER KARTE EINTRAGEN.
14 P.;P."ZUERST ZEIGE ICH IHNEN EINE     "
15 P."GEWINNKARTE OHNE SCHRIFTEINDRUCK"
16 P."WEGEN DES PLATZMANGELS.DANACH
17 P.;P."KOENNEN SIE DEN OBEREN UND      "
18 P."UND UNTEREN TEIL GETRENNT SEHEN."
19 P."DORT SIND DANN DIE WERTE MIT    "
20 P."EINGESCHRIEBEN UND ERKLAERT."
25 W=INC.;O.12
26 O.12
28 P.;P.
30 P."         1.SPIEL 2.SPIEL 3.SPIEL"
31 P.""
32 P.""
33 P.""
34 P.""
35 P.""
36 P.""
37 P.""
38 P.""
39 P.""
40 P.""
41 P.""
42 P.""
43 P.""
44 P.""
45 P.""
46 P.""
47 P.""
48 P.""
49 P.""
50 P.""
51 P.""
52 P.""
53 P.""
54 P.""
55 P.""
56 P.""
57 P.""
89 W=INC.;O.12;P.
90 P."   KNIFFEL - GEWINNKARTE  "
91 F.X=1TO31;O.45;N.X;P.
92 P.
93 P."NAME :"
99 P.""
100 P."1er    nur EINER zaehlen"
101 P.""
102 P."2er    nur ZWEIER zaehlen"
103 P.""
104 P."3er    nur DREIER zaehlen"
105 P.""
106 P."4er    nur VIERER zaehlen"
107 P.""
108 P."5er    nur FUENFER zaehlen"
109 P.""
110 P."6er    nur SECHSER zaehlen"
111 P.""
112 P.""
113 P."gesamt :   "
114 P.""
115 P.""
116 P."BONUS  +35  bei mehr als 63 P."
117 P.""
118 P.""
119 P."SUMME =    vom oberen Teil"
120 P.""
125 P."DAS IST DIE OBERE HAELFTE DES"
126 P.
127 P."SPIELSCHEINES."
128 P.
140 P."UNTERE HAELFTE= TASTE DRUECKEN ",;W=INC.
142 O.12
148 P.
149 P.""
150 P."DREIERPASCH alle AUGEN zaehlen"
151 P.""
152 P."VIERERPASCH alle AUGEN zaehlen"
153 P.""
154 P."FULL-HOUSE  es gibt 25 PUNKTE"
155 P.""
156 P."KLEI.STRASSEes gibt 30 PUNKTE"
157 P.""
158 P."GROS.STRASSEes gibt 40 PUNKTE"
159 P.""
160 P."KNIFFEL     es gibt 50 PUNKTE"
161 P.""
162 P."CHANCE      alle AUGEN zaehlen"
163 P.""
164 P.""
165 P."gesamt Summevom oberen Teil"
166 P.""
167 P.""
168 P."gesamt Summevom unteren Teil"
169 P.""
170 P.""
171 P."ENDSUMME =  "
172 P.""
173 P.;P.
175 P."WOLLEN WIR DAS SPIEL BEGINNEN ?"
176 P.
177 P."DANN DRUECKEN SIE EINE TASTE."
180 P.
190 W=INC.
195 G.3000
200 REM
210 R=65;S=66;T=67;U=68;V=69
220 O=R;P=S;Q=T;N=U
230 F.X=1TO2000;N.X
290 Y=0
300 GOS.650;GOS.660;GOS.670;GOS.680;GOS.690
305 J=A;K=B;L=C;M=D
320 O.12
322 Y=Y+1
325 F=0;G=0;H=0;I=0
327 P.;P.;P.
330 P."     DER",#2,Y,". WURF ERGAB :"
331 P.
332 F.X=1TO32;O.126;N.X;P.
335 P."     A     B     C     D     E"
340 P.;P.A,B,C,D,E
360 P.;F.X=1TO32;O.126;N.X
362 P.
365 IF Y=3 P.;P."   DAS WAR IHR LETZTER WURF";P.
370 IF Y=3 F.X=1TO2000;N.X;G.1000
400 P.;P."WELCHE WUERFEL NOCH EINMAL ?"
405 F=0;G=0;H=0;I=0
407 P.
410 P."WUERFEL 1 ",;F=INC.;O.F
412 IF F=13 G.1000
415 GOS.(F*10)
417 P.
420 P."WUERFEL 2 ",;G=INC.;O.G
422 IF G=13 G.1000
424 IF G=32 G.320
425 GOS.(G*10)
427 P.
430 P."WUERFEL 3 ",;H=INC.;O.H
432 IF H=13 G.1000
434 IF H=32 G.320
435 GOS.(H*10)
437 P.
440 P."WUERFEL 4 ",;I=INC.;O.I
442 IF I=13 G.1000
444 IF I=32 G.320
445 GOS.(I*10)
450 G.320
500 STOP
650 A=RND(6);RET.
660 B=RND(6);RET.
670 C=RND(6);RET.
680 D=RND(6);RET.
690 E=RND(6);RET.
1000 REM
1001 O.12
1002 J=A;K=B;L=C;M=D
1005 F.X=1TO4
1010 IF A>B A=B;B=J;J=A;K=B;R=S;S=O;P=S
1020 IF B>C B=C;C=K;K=B;L=C;S=T;T=P;Q=T
1030 IF C>D C=D;D=L;L=C;M=D;T=U;U=Q;N=U
1040 IF D>E D=E;E=M;M=D;U=V;V=N
1050 O=R;P=S;Q=T;N=U
1060 N.X
2000 P.;F.X=1TO32;O.61;N.X
2002 P.
2005 P." HIER SIND DIE WUERFEL SORTIERT"
2006 P.
2010 TAB(3);O.R;TAB(5);O.S;TAB(5);O.T;TAB(5);O.U;TAB(5);O.V
2012 P.;P.
2050 REM
2054 P."  ENDERGEBNIS  "
2060 P."     "
2061 P."                    "
2062 P." ",#2,A,"  ",#2,B,"  ",#2,C,"  ",#2,D," ",
2063 P." ",#2,E," "
2064 P."                    "
2065 P."     "
2068 P.
2070 P.""
2071 P.
2072 G.5000
2073 P.
2074 P."ALLE PUNKTE ZUSAMMEN ERGEBEN",#3,(A+B+C+D+E)
2075 P.
2077 F.X=1TO32;O.45;N.X;P.
2080 P."DER NAECHSTE SPIELER MUSS NUN"
2082 P.
2085 P."   AUF >ENTER< DRUECKEN   ",;W=INC.
2095 IF W#13 G.4000
3000 REM
3010 O.12
3020 F.X=1TO14;P.;N.X
3025 P."   ICH WUERFEL FUER SIE   "
3030 F.X=1TO15;P.;N.X
3035 G.200
3062 IF Y=3 P.;P."   DAS WAR IHR LETZTER WURF";P.;P.
4000 O.12;F.X=1TO11;P.;N.X
4005 F.X=1TO32;O.197;N.X
4006 P.
4010 P." AUF WIEDERSEHEN "
4015 F.X=1TO32;O.197;N.X
4020 F.X=1TO14;P.;N.X
4030 STOP
5000 IF B=A G.5020
5010 G.5100
5020 IF C=B G.5040
5030 G.5100
5040 IF D=C G.5060
5050 G.5500
5060 IF E=D G.6000
5070 G.6100
5100 IF C=B G.5120
5110 G.5200
5120 IF D=C G.5140
5130 G.5200
5140 IF E=D G.6100
5150 G.6200
5200 IF D=C G.5220
5210 G.5300
5220 IF E=D G.5510
5230 G.6600
5300 IF B=A+1 G.5320
5310 F.5400
5320 IF C=B+1 G.5340
5330 G.5400
5340 IF D=C+1 G.5360
5350 G.5400
5360 IF E=D+1 G.6500
5370 G.6400
5400 IF C=B+1 G.5420
5410 G.5600
5420 IF D=C+1 G.5440
5430 G.5600
5440 IF E=D+1 G.6400
5450 G.6600
5500 IF E=D G.6300
5505 G.6200
5510 IF B=A G.6300
5515 G.6200
5600 IF C=B G.5620
5610 G.5700
5620 IF D=C+1 G.5640
5630 G.6600
5640 IF E=D+1 G.6400
5650 G.6600
5700 IF D=C G.5720
5710 G.6600
5720 IF E=D+1 G.6400
5730 G.6600
6000 P.
6010 P."HALLO DAS IST EIN  > KNIFFEL <"
6020 G.2077
6100 P.
6110 P."DU HAST EINEN   > 4er PASCH <"
6115 P.
6120 P."ODER EINEN WURF MIT DREI",#2,C,"er ."
6130 G.2073
6200 P.
6210 P."DU HAST EINEN   > 3er PASCH <"
6215 P.
6220 P."ODER EINEN WURF MIT DREI",#2,C,"er ."
6230 G.2073
6300 P.
6310 P."DAS IST EIN    FULL HOUSE "
6315 P.
6320 P."ODER EIN    DREIER PASCH  "
6325 P.
6330 P."ODER EINEN WURF MIT DREI",#2,C,"er ."
6340 G.2073
6400 P.
6410 P."DAS IST EINE   KLEINE STRASSE "
6415 P.
6420 P."ODER IHRE LETZTE CHANCE MIT",#3,(A+B+C+D+E)
6425 P.
6430 P."PUNKTEN ."
6440 G.2077
6500 P.
6510 P."DAS IST EINE   GROSSE STRASSE "
6515 P.
6520 P."ODER IHRE LETZTE CHANCE MIT",#3,(A+B+C+D+E)
6525 P.
6530 P."PUNKTEN ."
6540 G.2077
6600 P.
6610 P."NUN HABEN SIE NUR EINE >CHANCE <"
6620 P."DIE IHNEN",#3,(A+B+C+D+E)," PUNKTE ANBIETET."
6630 G.2077
7000 P.;P.;F.X=1TO32;O.194;N.X
7005 P.;P."      KNIFFEL       "
7006 P.
7010 F.X=1TO32;O.194;N.X
7012 P.;P.;P.
7020 P."DIE ERKLAERUNG DES SPIELES";P.
7025 P."ERFOLGT AUF DEN NAECHSTEN 4";P.
7030 P."SEITEN,JEWEILS NACH TASTENDRUCK."
7035 P.
7040 P."SIE HABEN IMMER 3 WUERFE WENN   "
7045 P."SIE AM ZUG SIND.SOLLTEN SIE MIT "
7050 P."DEM WUERFEL-ERGEBNIS ZUFRIEDEN  "
7055 P."SEIN,SO DRUECKEN SIE >ENTER<  . "
7060 P."WOLLEN SIE NOCH EINMAL WUERFELN,"
7065 P."SO GEBEN SIE DIE BUCHSTABEN DER "
7070 P."WUERFEL EIN UND DRUECKEN >SPACE<"
7080 W=INC.;O.12;G.5
