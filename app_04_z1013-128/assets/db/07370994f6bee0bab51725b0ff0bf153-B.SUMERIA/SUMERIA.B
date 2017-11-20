Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

    5 CLEAR 40
   10 WINDOW:CLS
   20 PRINT AT(6,10);"S U M E R I A":WINDOW 9,23,1,31
   30 PRINT "REGIEREN SIE DAS ANTIKE SUMERIA"
   40 PRINT "IHRE REGIERUNGSZEIT BETRAEGT 10":PRINT "JAHRE.":PRINT
   50 PRINT "NACH  ABLAUF JEDES  JAHRES  ER-"
   55 PRINT "HALTEN  SIE  EINE  ANALYSE  DER"
   60 PRINT "ENTWICKLUNG   IHRER   STADT."
   70 WINDOW:PAUSE 200
   80 CLS:A=100:G=1000:L=200:M=2800:K=3:DIM E$(27)
   90 B1=0:D1=0:E1=0:E2=0:F1=0
  100 WINDOW:CLS:Z=Z+1:PRINT "J A H R ";Z
  110 PRINT:PRINT "BEVOELKERUNG"
  120 PRINT " Gestorben";:X=B:GOSUB 310
  130 PRINT " Zugaenge";:X=C:GOSUB 310
  140 C=INT(RND(1)*16):IF C=0 THEN 170
  150 PRINT " Bestand";:X=A:GOSUB 310
  160 GOTO 230
  170 WINDOW 16,23,0,31
  180 PRINT "Die  P E S T  hat die Haelfte" 
  185 PRINT "der Bevoelkerung dahingerafft,"
  190 PRINT "50 Prozent  der Vorraete sind"
  200 PRINT "durch  Braende  vernichtet !":A=INT(A/2):M=INT(M/2)
  210 PAUSE 100:CLS
  220 WINDOW 5,15,0,31:GOTO 150
  230 D=INT(A*.82):PRINT " dar.Arbeitskraefte";:X=D:GOSUB 310:PRINT
  240 PRINT "LANDBESITZ   ha";:X=G:GOSUB 310
  250 PRINT "Ernteertrag dt/ha";:X=K:GOSUB 310
  260 PRINT "Rattenfrassverluste";:X=L:GOSUB 310
  270 PRINT "VERFUEGBARE VORRAETE";:X=M:GOSUB 310
  280 J=INT(RND(1)*8.3+17):PRINT "Preis je ha Land";:X=J:GOSUB 310
  290 IF T>0 THEN PRINT "STADTSCHULDEN";:X=T:GOSUB 310
  300 H=0:I=0:N=0:O=0:P=0:Q=0:GOTO 320
  310 V=LEN(STR$(X)):PRINT TAB(26-V);X:RETURN
  320 WINDOW 16,23,0,31
  330 D$(1)="SIE BESITZEN NUR":D$(3)="ha LAND"
  340 D$(4)="dt KORN":D$(5)="ARBEITSKRAEFTE"
  350 INPUT "WIEVIEL LAND KAUFEN SIE       ?";H
  360 O=H*J:IF O=>M THEN PRINT:PRINT D$(1);M;D$(4):GOTO 350
  370 M=M-O:G=G+H:IF H>0 THEN 400
  380 INPUT "WIEVIEL LAND VERKAUFEN SIE    ?";I
  390 N=I*J:IF I=>G THEN PRINT:PRINT D$(1);G;D$(3):GOTO 380
  400 M=M+N:G=G-I:IF A<M/15 THEN 420
  410 INPUT "WIEVIEL KORN WOLLEN SIE BORGEN?";P:T=T+P:M=M+P:GOTO 430
  420 IF T>0 THEN INPUT "WIEVIEL SCHULDEN TILGEN SIE   ?";Q:ELSE 430
  430 T=T-Q:M=M-Q:T=INT(T*1.1)
  440 INPUT "WIEVIEL KORN BEKOMMT IHR VOLK ?";E
  450 IF E>M THEN PRINT:PRINT D$(1);M;D$(4):GOTO 440:ELSE M=M-E
  460 IF E>(20*A)THEN E=20*A
  470 B=INT((20*A-E)/20+.5):IF B=>A*.5 THEN WINDOW:CLS:GOTO 590:ELSE Y=Y+B
  480 A=A-B+C:AA=AA+A
  490 INPUT "WIEVIEL LAND BEBAUEN SIE      ?";S:IF S=0 THEN 570
  500 IF S>G THEN PRINT:PRINT D$(1);G;D$(3):GOTO 490
  510 IF M/S<.25 THEN PRINT:PRINT D$(1);M;D$(4):GOTO 490
  520 IF M/S>.25 AND(M/S)<.5 THEN R=M:W=M/S*2
  530 IF M/S>.5 THEN R=INT(S*.5):W=1
  540 IF D/S<.04 THEN PRINT:PRINT D$(1);D;D$(5):GOTO 490
  550 IF D/S>.04 AND D/S<.08 THEN U=D/S/.8
  560 IF D/S>.08 THEN U=1
  570 K=INT(RND(1)*5.8*W*U)+1:IF K>5 THEN K=5
  580 L=INT(RND(1)*G/20):M=M-L:M=M-R:M=M+K*S:IF Z<10 THEN 100:ELSE WINDOW:GOTO 640 
  590 PRINT "SIE HABEN IN NUR EINEM JAHR":PRINT TAB(10);B
  595 PRINT "EINWOHNER VERHUNGERN LASSEN":PRINT
  600 PRINT "SOVIEL UNVERMOEGEN  KOENNEN"
  605 PRINT "SELBST  DIE SO  FRIEDLICHEN"
  610 PRINT "SUMERIANER NICHT HINNEHMEN."
  620 PRINT "WENN  SIE  NICHT VERSUCHEN,"
  625 PRINT "SCHNELL  LAND ZU  GEWINNEN,"
  630 PRINT "WIRD   MAN   SIE  HAENGEN !":PAUSE 200:CLS:END
  640 CLS:E$(1)="Waehrend Ihrer  10-jaehrigen Re-gierungszeit sind "
  650 E$(2)=" Bewohner  verhungert.":E$(3)="Das sind im Durchschnitt"
  660 E$(4)="    Prozent der Bevoelkerung.":E$(6)="ha je Einwohner "
  670 E$(5)="Die  landwirtschaftliche   Nutz-flaeche hat sich von 10 ha auf  "
  680 E$(7)="vermindert.":E$(8)="erhoeht." 
  685 E$(9)="Sie haben Ihrem Nachfolger      "
  690 E$(10)="dt Schulden hinterlassen.":E$(11)="Bei Ihnen brauchten "
  700 E$(12)="keine ":E$(13)="kaum  ":E$(27)="ha    je Einwohner.":E$(18)="und
  710 E$(26)="Zu den gueltigen  Preisen  umge-rechnet,entspricht das"
  720 E$(14)="Ein-  wohner verhungern.Deshalb waren Sie  auch  immer"
  730 E$(15)=" ein  beliebter Regent.":E$(21)="Einwohner aufhaengen!"
  740 E$(16)="Nachdem bekannt ist, dass Sie   das nur zu Lasten "
  750 E$(17)="der zukuenfti-gen Nahrung ":E$(19)=" von Schulden"
  760 E$(20)="erreichen konnten,  moechten Sie":E$(24)="  verzeihen Ihnen "
  770 E$(22)="Nachdem bekannt ist, dass Sie   Sumeria zum Reichtum fuehrten,"
  780 E$(23)="   haetten die Einwohner Sie gern zum Regenten auf Lebenszeit."
  790 E$(25)="Einwohner     Ihre    hartherzige Regierungszeit."
  800 IF Y>0 THEN PRINT E$(1);Y;E$(2):A1=(INT(Y*1000/AA))/10:PRINT E$(3);A1;E$(4)
  810 IF Y=0 THEN PRINT E$(1);E$(12);E$(2):F1=1
  820 B1=INT(G/A):C1=INT(T/J+.5)
  830 IF B1>10 THEN PRINT E$(5);B1;E$(6);E$(8)
  840 IF B1<10 THEN PRINT E$(5);B1;E$(6);E$(7)
  850 IF B1=10 THEN PRINT E$(5);" gleichem Stand gehalten."
  860 IF T>0 THEN PRINT E$(9);T;E$(10)
  870 D1=INT(C1/A+.5):E1=B1-D1:IF D1>0 THEN PRINT E$(26);D1;E$(27)
  880 IF Y=0 THEN PRINT E$(11);E$(12);E$(14);E$(15)
  890 IF Y>0 AND Y<10 THEN PRINT E$(11);E$(13);E$(14);E$(15):F1=1
  900 IF B1>9 AND E1<10 THEN E2=2
  910 IF E1<10 AND B1<10 THEN E2=4
  920 F2=INT(RND(1)*A/2+2):IF D1=0 THEN E2=E2-1
  930 IF F1=1 AND E2=2 THEN PRINT E$(16);E$(19):PRINT E$(20);F2;E$(21)
  940 IF F1=1 AND E2=3 THEN PRINT E$(16);E$(17):PRINT E$(20);F2;E$(21)
  950 IF F1=1 AND E2=4 THEN PRINT E$(16);E$(17);E$(18);E$(19):PRINT E$(20);F2;E$(21)
  960 IF F1=0 AND FE2>0 THEN 1010
  970 IF Y=0 AND E1>15 THEN PRINT "Eine weise Regierungszeit.Karl,":ELSE 1000
  980 PRINT "Konrad und Alexander (die  Gros-sen) haetten es nicht ";
  990 PRINT " besser   gekonnt." 
 1000 IF Y=0 AND E1>20 THEN PRINT E$(22);E$(23)
 1010 IF Y>50 AND E1<10 THEN PRINT "Die Bevoelkerung atmet auf.":ELSE 1040
 1020 PRINT "Endlich  ist Ihre eigennuetzige,korrupte Regierungszeit vorbei."
 1030 PRINT "DAS VOLK FORDERT IHREN KOPF!!"
 1040 IF Y>10 AND E1>20 THEN PRINT E$(22);E$(24);F2;E$(25)
 1050 PRINT AT(22,0);"WOLLEN SIE NOCHMAL SPIELEN(J/N)?":U$=INKEY$
 1060 IF U$="J"THEN CLEAR:GOTO 80
 1070 IF U$="N"THEN CLS:END:ELSE 1050
