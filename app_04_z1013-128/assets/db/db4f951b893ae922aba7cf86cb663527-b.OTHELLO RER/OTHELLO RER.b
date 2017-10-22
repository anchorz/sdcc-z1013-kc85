Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

    1 @(1)=64;@(2)=-64;@(3)=2;@(4)=-2
    2 @(5)=66;@(6)=-66;@(7)=-62;@(8)=62
    3 T=TOP;A=0
    4 FORI=0TO7
    5 B=8*I
    6 FORJ=1TO8
    7 POKET+B+J,PEEK(T-A-B-J-2)-48
    9 N.J
   10 A=A+3
   11 N.I
   12 G.6200
   13 GOSUB 6000
   15 OUTCHAR 12
   20 P.;P.
   30 P.'   1 2 3 4 5 6 7 8'
   31 P.
   40 P.' 1 . . . . . . . . 1'
   41 P.
   50 P.' 2 . . . . . . . . 2'
   51 P.
   60 P.' 3 . . . . . . . . 3'
   61 P.
   70 P.' 4 . . . * * . . . 4'
   71 P.
   80 P.' 5 . . . 0 0 . . . 5'
   81 P.
   90 P.' 6 . . . . . . . . 6'
   91 P.
   92 P.' 7 . . . . . . . . 7'
   93 P.
   94 P.' 8 . . . . . . . . 8'
   95 P.
   96 P.'   1 2 3 4 5 6 7 8'
   97 P.
  100 POKE 27,0;POKE 28,HEX(EF)
  105 POKE 29,HEX(FF);POKE 30,HEX(EF)
  110 CALL HEX(F6D1)
  115 F.I=1 TO 9;P.;N.I
  120 D=-4989
  122 P.'Sie spielen mit 0'
  124 P.'Moechten Sie beginnen ?'
  126 P.'1 - JA       2 - NEIN'
  128 INP.'EINGAB',E
  129 P.;P.;P.
  130 IFE=2GOTO170
  160 A=0;P.;P.;GOTO2090
  170 A=1;GOTO3000
  200 POKE HEX(1B),0
  210 POKE HEX(1C),HEX(EC)
  220 POKE HEX(1D),HEX(FF)
  230 POKE HEX(1E),HEX(EF)
  240 CALL HEX(F6D1)
  250 OUTCHAR 12
  260 RETURN
  700 F=0
  710 G=42;IFA=1G=48
  720 FORK=1TO8
  730 R=0
  740 FORI=1TO8
  750 Z=B+@(K)*I
  751 IFZ<-4989GOTO820
  752 IFZ>-4527GOTO820
  760 V=PE.(Z)
  761 IFV=46GOTO820
  770 IFV=GR=1
  780 IFV=48-6*AR=(R+1)*R
  790 IFR=2GOTO900
  800 IFR=0GOTO820
  810 N.I
  820 N.K
  830 IFF=0PO.B,46;GOTO1400
  835 IFA=0GOTO170
  840 GOTO 160
  900 F=1
  910 FORL=1TO8
  920 IFPE.(B+@(K)*L)#GGOTO820
  930 PO.B+@(K)*L,48-6*A
  940 N.L
  950 GOTO820
 1400 P.'!!! FEHLER !!!'
 1410 P.'=============='
 1500 P.'Wer ist am Zug ?'
 1510 P.'1 - Sie ?'
 1512 P.'2 - Der Rechner ?'
 1514 P.'3 - Spielabbruch ?'
 1520 INPUT'EINGAB',E
 1530 IFE>3G.1400
 1550 IFE=1GOTO160
 1560 IFE=2GOTO170
 1600 M=0;N=0
 1610 FORI=1TO8
 1620 FORJ=1TO8
 1630 IFPE.((J-1)*64+2*I-4989)=42M=M+1
 1635 IFPE.((J-1)*64+2*I-4989)=48N=N+1
 1640 N.J
 1650 N.I
 1653 GOSUB 200
 1654 P.;P.;P.;P.
 1655 P.'Auswertung:'
 1657 P.'==========='
 1659 P.'* : 0 = ',#2,M,' :',N
 1670 PRINT;PRINT;PRINT
 1680 GOSUB 1800
 1690 P.;P.;P.;
 1700 P."      Noch einmale?"
 1710 P."                   Ja = (ENTER)"
 1720 H=INCHAR
 1730 IF H=13 GOTO 1
 1740 STOP
 1800 I=N-M
 1805 P.;P.;P.;P.;P.
 1810 IF I>-1 GOTO 1840
 1820 PRINT"Sie haben verloren !"
 1830 RETURN
 1840 IF I=0 PRINT"Remis !!"
 1845 IF I=0 RETURN
 1850 PRINT"Sie haben gewonnen !!               Gratuliere !!"
 1860 P.;P.;P.
 1870 IF I<5 PRINT"Glueck gehabt!!"
 1875 GOTO 1950
 1880 IF I<10 PRINT"Sie sind schon ganz gut !!"
 1885 GOTO 1950
 1890 IF I<20 P."Ich glaube Sie Haben mich uebersOhr gehauen !"
 1895 GOTO 1950
 1900 IF I<30 PRINT"Sie haben sicher die Spielregelngeknackt !!"
 1905 GOTO 1950
 1910 IF I<40 PRINT"Mit Ihnen lohnt es sich nicht   mehr !!"
 1915 GOTO 1950
 1920 IF I<50 PRINT"Eine Spitzenleistung !!"
 1925 GOTO 1950
 1930 IF I>50 PRINT"Sie sind der"
 1940 P.;P.;P."     S U P E R C H A M P I O N   !!!!"
 1950 RETURN
 2040 P.'Der Rechner zieht:'
 2045 P.'X : Y = ',#2,X,':',Y
 2070 B=2*(X-1)+64*(Y-1)-4989
 2075 PO.B,48-6*A
 2080 GOTO700
 2090 P.'Ihre Koordinaten ?'
 2092 INP.'Spalte ',X
 2094 INP.'Zeile  ',Y
 2095 P.;P.
 2096 B=2*(X-1)+64*(Y-1)-4989
 2097 IF PEEK(B)#46 GOTO 1400
 2098 PO.B,48
 2099 GOTO700
 3000 D=-4989;U=0
 3002 W=0
 3010 FORY=0TO448STEP64
 3020 FORX=DTOD+14STEP2
 3030 B=X+Y;V=PE.(B)
 3032 U=U+1
 3040 IFV#46GOTO4000
 3050 C=PE.(T+U);C=C*10
 3070 FORK=1TO8
 3080 R=0
 3090 FORI=1TO8
 3092 Z=B+@(K)*I
 3100 V=PE.(Z)
 3102 IFZ<-4989GOTO3500
 3104 IFZ>-4494GOTO3500
 3110 IFV=46GOTO3500
 3120 IFV=48R=1
 3130 IFV=42R=(R+1)*R
 3140 IFR=0GOTO3500
 3150 IFR=2GOTO3600
 3400 N.I
 3500 N.K
 3510 GOTO4000
 3600 C=C+I
 3620 IFC>=WN=X;M=Y;W=C
 3622 P.'MOMENT BITTE ! ICH DENKE NACH.'
 3624 P.
 3630 GOTO3500
 4000 N.X
 4010 N.Y
 4020 IFW=0GOTO1400
 4040 X=(N-D)/2+1
 4050 Y=M/64+1
 4060 GOTO2040
 5000 91844819
 5001 11222211
 5002 82766728
 5003 42600624
 5004 42600624
 5005 82766728
 5006 11222211
 5007 91844819
 6000 OUTCHAR 12
 6005 P.;P."   SPIELERKLAERUNG !!"
 6010 P.;P."In diesem Spiel treten Sie gegenIhren Rechner an."
 6020 P."Durch gezieltes Setzen der eige-nen Steine gilt es ,"
 6030 P."soviel wie moeglich Positionen  auf dem Feld zu "
 6040 P."belegen und damit den Rechner zu   schlagen !"
 6050 P.;P."Diejenigen Steine , welche sich"
 6060 P."in einer lueckenlosen Linie"
 6070 P."(Gerade oder Diagonale)"
 6080 P."zwischen gegnerischen Steinen"
 6090 P."befinden , wechseln stets den"
 6100 P."Besitzer ."
 6110 P.;P."Mit jedem Spielzug sind "
 6120 P."gegnerische Steine zu erobern !!"
 6130 P.;P.
 6140 P."Wer zuletzt die meisten Steine  besitzt hat gewonnen !"
 6150 P.
 6160 P."              Starte mit (ENTER)"
 6170 H=INCHAR
 6180 IF H=13 RETURN
 6190 GOTO 6170
 6200 O.12;P."CODE:"
 6210 IF(I.)=PE.(H.(4500))G.6220
 6215 G.6210
 6220 G.13
