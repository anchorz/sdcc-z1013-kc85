Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 O.12
   15 H=1024
   20 P.;P.
   25 K=0
   30 P."         T E L E T E X T"
   40 P."      ----------------------"
   50 P.;P."Mit diesem Programm ist es moeg-",
   55 P."lich , einzelne Bildschirmseiten",
   60 P."auf Kassette zu speichern."
   65 P."Bei 'Aufbau' erfolgt das be-"
   70 P."schreiben des Bildschirmes und"
   75 P."des Zwischenspeichers."
   80 P."Korrekturen sind ohne weiteres"
   85 P."moeglich. Zum vorzeitigen pro-"
   90 P."grammierabschluss gelangt man"
   95 P."durch betaetigen von 'ENT'"
  100 P."Mit'Anzeigen/Aendern' wird der"
  105 P."Speicherinhalt ausgedruckt;"
  110 P."Korrekturen und Abbruch sind "
  115 P."nach betaetigen von 'S' wie bei"
  120 P."'Aufbau' realisierbar."
  125 P."Bei'Daten retten erfolgt das"
  130 P."Abspeichern auf Kassette."
  140 P."Durch 'Start' werden die bilder"
  145 P."auf den Bildschirm und in den"
  150 P."Zwischenspeicher geladen. Mit"
  155 P."'S4'ist nach jeder vollen Seite"
  160 P."der Sprungcins Grundmenue voll-"
  165 P."ziehbar."
  200 P.;P."                    >ENTER<"
  205 IFI.#13G.205
  210 O.12;P.;P.
  220 P.;P."Aufbau...................1"
  230 P.;P."Anzeige/Aendern..........2"
  240 P.;P."Daten retten.............3"
  250 P.;P."Start....................4"
  260 P.;P."Stop.....................5"
  270 P.;INP."Eingabe der Kennziffer  "X
  280 IFX<1G.270
  290 IFX>5G.270
  300 G.X*1000
  630 PO.I,255;F.N=1TO10;N.N;PO.I,32
 1000 A=0;B=32;C=16;D=36
 1001 R=0;U=0
 1002 T=0
 1005 E=32;F=0
 1010 G=-2805
 1020 GOS.6000
 1030 I=-5120;J=8192
 1035 R=0;H=1024
 1040 O.12
 1050 F.L=1TOH-R
 1065 M=I.
 1070 PO.I,M
 1080 IFM=08G.6100
 1085 IFM=09G.6200
 1090 IFM=13G.210
 1095 IFM=32G.6300
 1100 PO.J,M
 1110 R=R+1
 1115 I=I+1;J=J+1;Q=Q-1
 1120 N.L
 1125 U=1
 1130 G.210
 2000 O.12;P=1;I=-5120;J=8192
 2004 IFT=1R=1024
 2005 Q=R;R=0
 2006 IFU=1Q=1024
 2010 F.O=1TOQ
 2030 PO.I,PE.(J)
 2040 I=I+1;J=J+1
 2041 R=R+1
 2043 P=1
 2045 IFIN(2)=87G.1050
 2050 N.O
 2060 G.1050
 3000 P.;P.
 3010 P."Abspeichern erfolgt bei >ENT<"
 3020 IFI.#13G.3020
 3030 A=0;B=32;C=16;D=36
 3040 G=-3223;GOS.6000
 3050 F.L=1TO1000;N.L
 3060 G.210
 4000 O.12
 4010 A=0;B=236;C=255;D=239
 4020 G=-3080
 4025 GOS.6000
 4030 A=0;B=236;C=0;D=32
 4040 E=0;F=04
 4045 G=-2787
 4050 GOS.6000
 4060 F.L=1TO10
 4065 Q=1024;T=1
 4070 IFIN(2)=87G.210
 4076 N.L
 4080 U=1
 4090 G.4010
 5000 STOP
 6000 PO.27,A;PO.28,B;PO.29,C;PO.30,D
 6010 PO.35,E;PO.36,F
 6020 C.G
 6030 RE.
 6100 PO.I,PE.(J)
 6110 J=J-1;I=I-1;R=R-1
 6115 Q=Q+1
 6120 G.1050
 6200 PO.I,PE.(J)
 6210 G.1110
 6300 PO.I,255;F.N=1TO50;N.N;PO.I,32
 6310 G.1100
20000 A=IN(2);P.A,O.A;W.(A);G.20000
