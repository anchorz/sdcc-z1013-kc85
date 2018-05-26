Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

 1000 A=100:GOTO 20:REM MUZ. BEGELEIDER
 1010 DIM T$(24):FOR I=1 TO 24:READ T$(I):NEXT I
 1020 GOSUB 100
 1030 PRINT "Een ogenblikje geduld s.v.p."
 1040 PRINT "Ik lees 5 begeleidingen in ..."
 1050 DIM RR(5,48):FOR H=1 TO 5
 1060 VE=7:HO=10:GOSUB 110
 1070 PRINT "=> ";
 1080 SR=H:GOSUB 300:PRINT SR$
 1090 FOR I=1 TO 48:READ RR(H,I):NEXT I
 1100 NEXT H
 1110 GOSUB 100
 1120 PRINT "Welk mwrk computer gebruikt u ?"
 1130 PRINT:PRINT "1 = Acorn BBC           7 = P2000M"
 1140 PRINT:PRINT "2 = Acorn Electron      8 = P2000T"
 1150 PRINT:PRINT "3 = Apple II-familie    9 = Sinclair Sp"
 1160 PRINT:PRINT "4 = Commodore 64        10= Tandy TRS80"
 1170 PRINT:PRINT "5 = Exidy               11= Sp.Video"
 1180 PRINT:PRINT "6 = MSX                 12= Ander merk"
 1190 PRINT:PRINT "Maak uw keuze <+ RETURN>";
 1200 INPUT MC
 1210 IF(MC<1)OR(MC>12) THEN GOSUB 250:GOTO 1110
 1220 LT=VAL(MID$("121224240024241224242400",2*MC-1,2))
 1230 GOSUB 100
 1240 SR$="                                 "
 1250 GOSUB 150:PRINT SR$
 1260 SR$="       MUZIKAAL BEGELEIDER       "
 1270 VE=1:HO=0:GOSUB 110:GOSUB 150:PRINT SR$
 1280 SR$="           < walsen >            "
 1290 VE=2:HO=0:GOSUB 110:GOSUB 150:PRINT SR$
 1300 SR$="                                 "
 1310 VE=3:HO=0:GOSUB 110:GOSUB 150:PRINT SR$
 1320 PRINT "Met dit programma kunt u een muzikale"
 1330 PRINT "begeleiding leren spelen op een Wals-"
 1340 PRINT "melodie. Er zijn erg veel verschillende"
 1350 PRINT "accoordenschema's hiervoor."
 1360 PRINT "Ik ben uitgegaan van de volgende"
 1370 PRINT "accoorden per maat:"
 1380 PRINT:PRINT "C - E - Am - Dm - C - G - C - C -"
 1390 PRINT:PRINT "Omdat er nogal wat verschillende bege-"
 1400 PRINT "leidingen zijn kunt u ze ook op andere"
 1410 PRINT "accoorden toepassen. U moet dan alfa-"
 1420 PRINT "betisch een aantal letters bijtellen"
 1430 PRINT "of aftrekken. Als ik bijvoorbeeld van"
 1440 PRINT "C > E maak dan moet ik van F > A maken"
 1450 PRINT "van G > B, enz."
 1460 VE=22:HO=36:GOSUB 110:PRINT "=>";:GOSUB 210
 1470 HO=0:FOR VE=4 TO 22:GOSUB 110
 1480 PRINT "                                       "
 1490 NEXT VE:VE=4:GOSUB 110
 1500 PRINT "U kunt kiezen uit verschillende bege-"
 1510 PRINT "leidingsmanieren. U hoort de tonen,"
 1520 PRINT "en tegelijk laat het beeldscherm de"
 1530 PRINT "gespeelde noten zien."
 1540 PRINT:PRINT "De noten zijn verdeeld over 2 oktaven"
 1550 PRINT "en worden als volgt genoteerd:"
 1560 PRINT:PRINT "+----------------------------+---------"
 1570 PRINT "!       -> 1e okt. <-        !>2e okt.<"
 1580 PRINT "+----------------------------+---------"
 1590 PRINT "!C-C#-D-D#-E-F-F#-G-G#-A-A#-B!c-c#-d .."
 1600 PRINT "+----------------------------+---------"
 1610 PRINT:PRINT "VEEL MUZIKAAL PLEZIER"
 1620 PRINT "            MET DIT PROGRAMMA!"
 1630 PRINT:PRINT "Walther van den Elshout"
 1640 VE=22:HO=36:GOSUB 110:PRINT "=>";:GOSUB 210
 1650 HO=0:FOR VE=4 TO 22:GOSUB 110
 1660 PRINT "                                       "
 1670 NEXT VE:VE=4:GOSUB 110
 1680 PRINT:PRINT "Ik heb 5 begeleidingsmanieren in mijn"
 1690 PRINT "geheugen. Welke wilt u horen <1-5>"
 1700 PRINT "=> STOPPEN = 0";
 1710 GOSUB 210
 1720 IF(IN<48)OR(IN>53) THEN GOSUB 250:GOTO 1710
 1730 IF IN=48 THEN 2050
 1740 Z=IN-48
 1750 HO=0:FOR VE=4 TO 22:GOSUB 110
 1760 PRINT "                                       "
 1770 NEXT VE:VE=4:GOSUB 110
 1780 BN$=IN$
 1790 PRINT:PRINT "Begeleiding nummer: ";BN$
 1800 PRINT "=====================":PRINT
 1810 SD=2:SV=6
 1820 FOR I=1 TO 48
 1830 X=RR(Z,I)-59
 1840 PRINT T$(X);" - ";:IF I/6=INT(I/6) THEN PRINT
 1850 SP=RR(Z,I)-LT:GOSUB 400
 1860 SV=6
 1870 IF I/3=INT(I/3) THEN SV=12
 1880 NEXT I
 1890 VE=21:HO=10:GOSUB 110
 1900 PRINT "Druk voor uitprinten op '*'"
 1910 VE=22:HO=10:GOSUB 110
 1920 PRINT "Zoniet, dan andere toets =>";
 1930 GOSUB 210
 1940 IF IN$="*" THEN 1960
 1950 GOTO 1650
 1960 SR$="Begeleiding nummer: ":GOSUB 350
 1970 SR$=BN$:GOSUB 350:GOSUB 360
 1980 SR$="=====================":GOSUB 350:GOSUB 360:GOSUB 360
 1990 FOR I=1 TO 48
 2000 X=RR(Z,I)-59
 2010 SR$=T$(X):GOSUB 350:SR$=" - ":GOSUB 350
 2020 IF I/6=INT(I/6) THEN GOSUB 360
 2030 NEXT I
 2040 GOSUB 360:GOSUB 360:GOTO 1650
 2050 HO=0:FOR VE=4 TO 22:GOSUB 110
 2060 PRINT "                                       "
 2070 NEXT VE:VE=9:GOSUB 110
 2080 PRINT "     ***************************"
 2090 PRINT "     * Walther van den Elshout *"
 2100 PRINT "     * Generaal Wicherslaan 14 *"
 2110 PRINT "     * 5623 GS       Eindhoven *"
 2120 PRINT "     ***************************"
 2130 SD=1000:GOSUB 450:GOTO 950
25000 DATA "C","C#","D","D#","E"
25010 DATA "F","F#","G","G#","A"
25020 DATA "A#","B"
25030 DATA "c","c#","d","d#","e"
25040 DATA "f","f#","g","g#","a"
25050 DATA "a#","b"
25060 DATA 60,64,67,72,67,64
25070 DATA 64,68,71,76,71,68
25080 DATA 69,72,76,81,76,69
25090 DATA 62,65,69,74,69,66
25100 DATA 60,64,67,72,67,64
25110 DATA 67,71,74,79,74,71
25120 DATA 60,64,67,72,67,64
25130 DATA 60,64,67,72,72,72
25140 DATA 60,67,67,62,67,67
25150 DATA 64,71,71,68,71,70
25160 DATA 69,76,76,72,76,75
25170 DATA 62,69,69,69,65,62
25180 DATA 60,72,72,72,71,69
25190 DATA 67,74,74,79,77,74
25200 DATA 72,67,67,64,67,64
25210 DATA 60,64,67,72,60,60
25220 DATA 60,62,64,67,69,67
25230 DATA 64,66,68,71,72,71
25240 DATA 69,71,72,76,77,76
25250 DATA 62,64,65,69,71,69
25260 DATA 60,62,64,67,69,67
25270 DATA 67,69,71,74,76,74
25280 DATA 60,69,67,65,64,62
25290 DATA 60,64,67,72,67,60
25300 DATA 60,64,65,67,69,70
25310 DATA 71,68,66,64,66,68
25320 DATA 69,64,62,60,64,69
25330 DATA 69,65,64,62,64,65
25340 DATA 67,64,62,60,62,64
25350 DATA 67,69,67,65,64,62
25360 DATA 60,64,67,69,67,64
25370 DATA 72,67,64,60,60,60
25380 DATA 67,64,62,60,62,64
25390 DATA 71,68,66,64,66,68
25400 DATA 76,72,71,69,71,72
25410 DATA 74,69,65,62,65,69
25420 DATA 67,64,62,60,62,64
25430 DATA 67,69,67,65,64,62
25440 DATA 60,64,67,69,67,64
25450 DATA 67,64,62,60,60,60
32000 REM ###########################
32010 REM # DIT PROGRAMMA WERD GE-  #
32020 REM # SCHREVEN DOOR:          #
32030 REM # WALTHER VAN DEN ELSHOUT #
32040 REM # GENERAAL WICHERSLAAN 14 #
32050 REM # 5623 GS       EINDHOVEN #
32060 REM # TEL: 040 - 451098       #
32070 REM # AUG.'89    COMMODORE 64 #
32080 REM C##########################
32090 REM
32100 REM TROS-RADIO DD 891129
