Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 GOTO 130
   20 POKE 16378,Z:POKE 16379,S:CALL 16224
   30 RETURN
   40 FOR L=0 TO 2*PI STEP .04:S=XA+INT(COS(L)*XE+.5):Z=YA+INT(SIN(L)*XE+.5)
   50 GOSUB 20
   60 NEXT L
   70 RETURN
   80 IF XE=XA THEN XE=XE+.1
   82 TS=XE-XA:T=(YE-YA)/TS:TS=ABS(TS/80)
   83 IF XA>XE THEN TS=-TS
   85 FOR L=XA TO XE STEP TS 
   90 Z=INT(T*(L-XA)+YA+.5):S=INT(L+.5)
  100 GOSUB 20
  110 NEXT L
  120 RETURN
  130 CLS
  140 PRINT:PRINT " DEMONSTRATION ZUM HC-BASIC+PSET"
  150 PRINT:PRINT "Dieses BASIC ist das normale":PRINT
  160 PRINT "robotron-HC-BASIC mit den Funk-":PRINT
  170 PRINT "tionstasten S4+":PRINT
  180 PRINT "A-AUTO":PRINT "C-CONTINUE":PRINT "D-DELETE":PRINT "I-INSERT":PRINT "J-CLEARLINE"
  190 PRINT "K-STOP":PRINT "L-LIST":PRINT "N-RENUMBER":PRINT "P-PAUSE"
  200 PRINT "R-RUN":PRINT "V-KURSOR an den Zeilenanfang"
  210 PRINT "W-KURSOR an das Zeilenende":PRINT:PRINT "-alles ohne Parameter."
  220 PRINT:PRINT:PRINT:PRINT TAB(15);:INPUT "<ENTER>";L:CLS
  230 PRINT:PRINT "An dieses BASIC wurden zwei":PRINT:PRINT "Routinen angehaengt,welche" 
  235 PRINT
  240 PRINT "im Textpuffer stehen und beim":PRINT:PRINT "ersten Kaltstart aktiviert"
  250 PRINT:PRINT "und dann abgehaengt werden.":PRINT
  255 PRINT "Die NMI-TASTE wird auf BRK pro-":PRINT
  260 PRINT "grammiert und das PSET-Programm":PRINT
  270 PRINT "am oberen RAM-Ende installiert.":PRINT
  280 PRINT "Das UP ist A0H lang woraus sich":PRINT
  290 PRINT "fuer 16k RAM ein MEMORYSIZE von":PRINT
  300 PRINT "16222 ergibt.Benutzt wird":PRINT
  310 PRINT "der 4. Quadrant,also 1,1 ist":PRINT
  320 PRINT "links oben (wie PRINTAT),die":PRINT
  330 PRINT "Aufteilung 63x63 Punkte.":PRINT
  340 PRINT TAB(15);:INPUT "<ENTER>";L:CLS
  350 PRINT:PRINT "Die Zeile wird in 16378 ge-":PRINT
  360 PRINT "pokt,die Spalte in 16379.":PRINT:PRINT "Aufruf dann mit CALL 16224.":PRINT
  370 PRINT "Fuer Erweiterte:Das UP steht":PRINT
  380 PRINT "dann in 3F60-3FFF,das NWT ist":PRINT
  390 PRINT "nicht aenderbar,das HWT ist in":PRINT
  400 PRINT "folgende Zellen einzutragen:":PRINT
  410 PRINT "(vor erstem BASIC-Kaltstart":PRINT:PRINT "nach dem Laden!)":PRINT
  420 PRINT "2B0D,-2B,-34,-76 .":PRINT
  430 PRINT "Die UPs in Basic sind":PRINT:PRINT "PSET (Z,S   Start Z.20)":PRINT
  435 PRINT "LINE  (XA,XE,YA,YE Start Z.40)":PRINT
  440 PRINT "CIRCLE (XA,YA,XE>r Start Z.80)":PRINT
  450 PRINT "Viel Erfolg  M.Voigt,Magdeburg":PRINT
    5 GOTO 460
   10 WINDOW:DIM S(3,38):DIM T(3,38):CLS:PRINT
   20 PRINT "FOURIER-ANALYSE    de Y39QG":PRINT "---------------":PRINT
   30 PRINT "ISME-SOFTWARE":PRINT:PRINT
   40 PRINT AT (7,3);"MOMENT..."
   50 FOR L=0 TO 360 STEP 10:P=L/10:Q=2*PI*L/360
   60 S(1,P)=SIN(Q):T(1,P)=COS(Q):NEXT L
   70 FOR L=0 TO 360 STEP 15:P=INT(L/10):Q=2*PI*L/360
   80 S(2,P)=SIN(Q):T(2,P)=COS(Q):NEXT L
   90 DIM Y(37):DIM P(37):DIM A(20):DIM B(20):DIM C(20)
  100 CALL-2376:INPUT "GRUNDFREQUENZ?  (ZAHL) ";F
  110 CALL-2363:INPUT "GRUNDFREQUENZEINHEIT   ";E$
  120 CALL-2376:INPUT "PERIODENDAUER   in Skt ";ST
  130 INPUT "SEHR GENAU ?  x1,2,3   ";G 
  140 IF G=2 THEN W=2 :ELSE W=1
  150 G=G*12:N=G/2
  160 CLS:PRINT:PRINT "EINGABE DER KURVE:"
  170 FOR L=1 TO G
  180 P=ST*L/G+.05:P1=INT(10*(P-INT(P))):P=INT(P)+P1/10
  190 PRINT "Y-Skt BEI"P;:PRINT TAB(16);"Skt";:INPUT Y(L)
  200 A0=A0+Y(L):NEXT L
  210 A0=A0/G:Q=INT(100*(A0-INT(A0))):A0=INT(A0)+Q/100
  220 CLS:PRINT:PRINT "VORSPANNUNG:"A0 "Skt":PRINT
  230 FOR L=1 TO N
  240 FOR P=1 TO G
  250 X=INT((L*P/N-2*INT(L*P/G))*18) 
  260 A(L)=A(L)+T(W,X)*Y(P):B(L)=B(L)+S(W,X)*Y(P):NEXT P
  270 C(L)=SQR(A(L)*A(L)/(N*N)+B(L)*B(L)/(N*N)):Q=INT(100*(C(L)-INT(C(L))))
  280 C(L)=(INT(C(L))+Q/100):PRINT L*F;:PRINT TAB(9);E$ " mit";
  290 PRINT TAB(19);C(L);:PRINT TAB(28);"Skt":IF C(L)>H THEN H=C(L)
  300 NEXT L
  310 INPUT L
  320 WINDOW 2,31,0,18:CLS:FOR L=1 TO N
  330 Q=INT(30.5-C(L)*28/H)
  340 FOR P=30 TO Q STEP -1
  350 PRINT AT (P,L);"#":GOTO 360:""
  360 NEXT P
  370 NEXT L
  380 PRINT AT (31,1);"G23456789012345678"
  390 FOR L=(N+1) TO 20
  400 PRINT AT (31,L);" "
  410 NEXT L
  420 PRINT AT (31,20);"HARMONISCHE":CALL-2363
  430 WINDOW 22,24,20,31:INPUT "WEITER ? W";E$
  440 IF E$="W" THEN WINDOW:CLS:RUN 100:ELSE GOTO 450
  450 WINDOW:CLS:END
  460 CLS:PRINT:PRINT "  Beschreibung FOURIER":PRINT
  470 PRINT "Dieses   Programm   dient   der":PRINT
  490 PRINT "Untersuchung  von   oszillogra-":PRINT
  500 PRINT "fierten   Signalen   auf   ihre":PRINT
  510 PRINT "harmonischen    Frequenzanteile":PRINT
  520 PRINT "hin.Die  Ein-und Ausgaben  sind":PRINT
  530 PRINT "BS-Skalen-orientiert , bis  auf":PRINT
  540 PRINT "das  Diagramm , es  ist  %-ual,":PRINT
  550 PRINT "der  max.  analysierte   Anteil":PRINT
  560 PRINT "ist  100% .    Die  geforderten":PRINT
  570 PRINT "Eingaben beziehen  sich relativ":PRINT
  580 PRINT "auf den betrachteten Nulldurch-":PRINT
  590 PRINT "gang,ab dann eine ganze Periode":PRINT
  600 PRINT "Die Startzeile ist 10 .":PRINT
  610 PRINT "Viel Erfolg ! M.Voigt,Magdeburg":PRINT
