Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 E=H.(EC00)
   20 F=H.(E400)
   30 F=8000
   40 Z=1;S=1;B=32;C=1;D=I
   50 IFJ=0G.80
   60 PR.;PR."Wirklich (J/sonst ENDE) ?";W=INC.
   70 IFW#74STOP
   80 GOS.5000
   90 J=1
   95 GOS.5980
  100 G.2000
 1000 REM UMRANDUNG
 1010 F.I=0TO31
 1020 PO.E+I,160;PO.H.(EFFF)-I,160
 1030 PO.E+I*32,161;PO.E+I*32+31,161
 1040 PO.E+256+I,160;N.I
 1050 PO.E,168;PO.E+31,169;PO.E+256,163
 1060 PO.E+287,165;PO.H.(EFFF),170;PO.H.(EFFF)-31,167
 1070 RE.
 1075 OUTC.12;PR.;PR.;
 1080 PR."  SeSt SoftWare Int. presents"
 1090 PR."             Paint"
 1100 PR.;PR."  Zeichensatz Teil ",#1,J
 1110 PR.;PR."  I ",;OUTC.203;PR." SeSt SoftWare"
 1115 PR.;PR.;
 1120 F.I=(J-1)*242/3+14TOJ*242/3+14
 1130 PR." ",;OUTC.I;PR.#4,I,
 1140 IF(I-13-J/3)/5*5=I-13-J/3PR."  ",
 1150 N.I;PR.;PR.;
 1155 PR."  Zeichen <Nr>  weiter < 0>";PR." ",
 1157 GOS.1000
 1160 INP."  Eingabe "A
 1170 IFA#0G.1190
 1180 J=J+1
 1183 IFJ=4J=1
 1186 G.1075
 1190 IFA>13G.1230
 1200 IFA<256G.1230
 1210 G.1075
 1230 G.4000
 2000 REM HELP
 2010 OUTC.12;PR.;PR.;
 2020 PR."  SeSt SoftWare Int.";PR.
 2030 PR."     (c) by  F St"
 2040 PR.;PR."           P A I N T";PR.
 2045 PR.;
 2050 PR.;PR."   ?  Hilfe bzw. Menu"
 2060 PR.;PR."   Z  Zeichencodetabelle"
 2070 PR.;PR."   C  Zeichen wechseln"
 2080 PR.;PR."   P  Positionieren Zeichen"
 2090 PR.;PR."   L  Laden Bild"
 2100 PR.;PR."   S  Sichern Bild"
 2110 PR.;PR."   V  Verwerfen Bild / Ende"
 2115 PR.;PR.;PR."   Steuerung des Zeichens :"
 2117 PR.;PR."    Cursortasten,Space,'U'"
 2118 PR.;PR."     <ET> Zeichen setzen"
 2120 GOS.1000
 2125 W=INC.
 2127 IFW=13G.4000
 2128 G.2150
 2130 W=INC.
 2150 IFW=63G.2000
 2160 IFW=90G.1075
 2170 IFW=76G.2300
 2180 IFW=86G.10
 2190 IFW=83G.2400
 2200 IFW=67G.2500
 2210 IFW=80G.2600
 2220 IFW=85Z=Z-1;G.3000
 2230 IFW=32Z=Z+1;G.3000
 2240 IFW=9S=S+1;G.3000
 2250 IFW=8S=S-1;G.3000
 2255 IFW=13B=A;G.2130
 2260 G.2130
 2300 C.H.(A0C)
 2310 C.H.(10F)
 2320 C.H.(A19)
 2330 C.H.(10F)
 2340 G.4000
 2400 OUTC.12
 2410 PR."  Filename :",
 2420 I$(TOP)
 2430 IFLEN>16PR."  zu lang !";G.2410
 2440 F.I=0TOLEN;PO.H.(F0)+I,PE.(TOP+I);N.I
 2450 PO.H.(E0),F
 2460 PO.H.(E1),F/256;PO.H.(E2),F+1024
 2470 PO.H.(E3),(F+1024)/256;C.H.(A0C)
 2480 C.H.(10C);C.H.(A19);C.H.(10C)
 2490 G.4000
 2500 INP." ASCII-Code "A
 2510 PO.F+Z*32+S,A
 2520 G.4000
 2600 INP."Zeile ",Z,"Spalte ",S 
 2610 G.4000
 3000 IFZ<0Z=31
 3010 IFS<0S=31
 3020 IFS>31S=0
 3030 IFZ>31Z=0
 3040 PO.C*32+D+E,B
 3050 PO.C*32+D+F,B
 3060 B=PE.(F+Z*32+S)
 3070 PO.F+Z*32+S,A
 3080 PO.E+Z*32+S,A
 3085 C=Z;D=S
 3090 G.2130
 4000 PO.H.(1B),F
 4010 PO.H.(1C),F/256
 4020 PO.H.(1D),E
 4030 PO.H.(1E),E/256
 4040 PO.H.(23),1024
 4050 PO.H.(24),4
 4060 C.H.(F51D)
 4065 IFW=80G.3000
 4070 G.2130
 5000 PO.H.(1B),F
 5010 PO.H.(1C),F/256
 5020 PO.H.(1D),F+1024
 5030 PO.H.(1E),(F+1024)/256
 5040 PO.H.(23),32
 5045 PO.H.(24),32
 5050 C.H.(F50B)
 5060 RE.
 5980 OUTC.12
 5990 PR.
 6000 PR.;PR."          P A I N T"
 6010 PR."          ~~~~~~~~~";PR.;PR.
 6020 PR."  (c) by F.St. from SeSt SW"
 6030 PR.;PR.;PR.
 6040 PR."  SeSt SoftWare  International"
 6050 PR."  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~";PR.;PR.
 6060 PR."      Robert Seeger";PR.
 6070 PR."      Frank  Staudtmeister";PR.
 6075 PR.
 6080 PR."      TH  'C. Schorlemmer'";PR.
 6090 PR."      Wohnheim  12 / 10-16"
 6095 PR.
 6100 PR.;PR."        M E R S E B U R G"
 6110 PR."        ";PR.
 6120 PR."             4 2 0 0"
 6130 GOS.1000
 6140 A=INC.;RE.
