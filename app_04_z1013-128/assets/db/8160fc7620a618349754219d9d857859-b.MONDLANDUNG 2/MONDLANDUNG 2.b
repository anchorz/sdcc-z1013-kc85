Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

    2 OUTCHAR 12
    5 GOSUB 3500
   10 OUTCHAR 12
   20 S=0;T=500 
   30 E=1000;G=100
   32 P."  ZEIT  TANK ENTF. GESCHW VERBR"
   34 P.
   35 P."--------------------------------"
   40 P.S,T,E,G,"  ",
   73 IF T=0 GOTO 77
   75 INPUT V
   76 GOTO 80
   77 V=0 
   79 P.V
   80 IF V>100 GOTO 1000
   90 IF V>T GOTO 1000
  100 A=3-10*V/(20+T/100)
  110 IF G>-1*A GOTO 200 
  150 X=E+G*G/(2*A)  
  160 IF X<0 GOTO 1100
  200 E=E-G-A/2 
  210 G=G+A;S=S+1;T=T-V
  240 IF E>0 GOTO 40
  250 GOTO 1110
 1000 P."NICHT SCHUMMELN !"
 1010 GOTO 40  
 1110 E=-E/2
 1115 OUTCHAR 12
 1116 P.
 1117 P.
 1118 P.
 1119 P.
 1120 IF E>0 GOTO 1200 
 1130 P."SAUBER GELANDET"
 1140 STOP
 1200 IF E>1 GOTO 1300
 1210 P."GELANDET , ABER . . ."
 1220 STOP
 1300 IF E>2 GOTO 1500 
 1310 P."VERBANDSKASTEN LINKS"
 1320 P."OBEN RECHTS HINTEN"
 1500 IF E>2 GOTO 1950
 1510 P."SANI-RAKETE IST,WENN"
 1520 P."LANDUNG GLUECKT IN"
 1530 P."EINIGEN MINUTEN DA!"
 1950 IF E>5 GOTO 2040
 2000 P."NU,WIE SIEHT DER MOND"
 2010 P."VON INNEN AUS? UEBER-"
 2020 P."SENDE BITTE AUFNAHMEN!"
 2030 P.
 2040 IF E<7 GOTO 3000
 2050 P."VON DER ERDE GEKOMMEN,"
 2060 P."VOM MONDE GENOMMEN"
 2070 P."              AMEN"
 2080 P.
 2090 P."DAS HAMM'SE NU DAVON"
 2100 P."FLIEGEN IST SCHOEN DOCH"
 2110 P."TRABANT 'FAHREN' IST"
 2120 P." S I C H E R E R !?I?!"
 3000 STOP
 3500 FOR X=0 TO 5
 3510 P.
 3520 NEXT X
 3530 P."################################"
 3540 P.
 3550 P."  M O N D L A N D U N G"
 3560 P.
 3570 P."   ES SIND DIE HOEHE IN M"
 3580 P."   DER TANKINHALT IN L DIE"
 3590 P."   ZEIT IN S UND DIE GE-"
 3600 P."   SCHWINDIGKEIT IN M/S"
 3610 P."   ANGEGEBEN."
 3620 P."   DURCH DIE EINGABE DES"
 3630 P."   VERBRAUCHES FUER DIE"
 3640 P."   NAECHSTE SEKUNDE WIRD"
 3650 P."   DIE NEUE POSITION DER"
 3660 P."   LANDEFAEHRE BERECHNET"
 3670 P."   UND AUSGEDRUCKT."
 3680 P. 
 3690 P.
 3700 P."################################"
 3900 FOR Y=0 TO 20000
 3910 NEXT Y
 4000 RETURN