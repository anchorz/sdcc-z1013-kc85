    1 CLS:PRINT
    2 PRINT "Berechnung von geometrichen     "
    3 PRINT "Figuren und einfachen Koerpern"   
    4 PRINT:PRINT "(FAECHE BZW VOLUMEN)"
    5 PRINT "==============================="
    6 PRINT:PRINT 
    7 PRINT "PARALLELOGRAMM................1" 
    8 PRINT "TRAPEZ........................2"  
    9 PRINT "RHOMBUS.......................3" 
   10 PRINT "DRACHENVIERECK................4"
   11 PRINT "RECHTECK......................5"
   12 PRINT "QUADRAT.......................6"
   13 PRINT "RECHTWINKLIGES DREIECK........7"
   14 PRINT "KREIS.........................8"  
   15 PRINT "KREISAUSSSCHNITT..............9"
   16 PRINT "WUERFEL......................10"
   17 PRINT "QUADER.......................11"
   18 PRINT "QUADRATISCHE PYRAMIDE........12"
   19 PRINT "ZYLINDER.....................13"
   20 PRINT "KEGEL........................14" 
   21 PRINT "KUGEL........................15 "
   22 PRINT:PRINT "ENDE.........................16 "
   23 INPUT "WELCHE BERECHNUNG (1-15) ?";A:A=INT(A)
   24 IF A<1 OR A>16 THEN 23
   25 ON A GOTO 27,33,40,40,46,52,61,67,76,82,26
   26 ON A-10 GOTO 91,99,105,112,118,127
   27 CLS:PRINT:INPUT "Hoehe a=";A
   28 PRINT:INPUT "Seite a=";B 
   29 PRINT:PRINT "Flaeche A=";B*A
   30 PRINT:INPUT "NEU (J/N)?";A$
   31 IF LEFT$(A$,1)="J"THEN 27
   32 GOTO 1
   33 CLS:PRINT:INPUT "Seite a=";A
   34 PRINT:INPUT "Seite c=";B
   35 PRINT:INPUT "Hoehe h=";C  
   36 PRINT:PRINT "Flaeche A=";(A+B)/2*C 
   37 PRINT:INPUT "NEU (J/N)?";A$
   38 IF LEFT$(A$,1)="J"THEN 33
   39 GOTO 1
   40 CLS:PRINT:INPUT "Diagonale e=";A
   41 PRINT:INPUT "Diagonale f=";B
   42 PRINT:PRINT "Flaeche A=";A*B/2
   43 PRINT:INPUT "NEU (J/N)";A$
   44 IF LEFT$(A$,1)="J"THEN 40
   45 GOTO 1
   46 CLS:PRINT:INPUT "Seite a=";A
   47 PRINT:INPUT "Seite b=";B
   48 PRINT:PRINT "Flaeche A=";A*B
   49 PRINT:INPUT "NEU (J/N)?";A$
   50 IF LEFT$(A$,1)="J"THEN 46
   51 GOTO 1
   52 CLS:INPUT "Seite a=";A
   53 PRINT :INPUT "Schritt=";B
   54 CLS:PRINT:PRINT
   55 PRINT TAB(3);"Seite "TAB(13);"Flaeche"
   56 FOR C=A TO A+10*B STEP B
   57 PRINT:PRINT TAB(3);C TAB(13);C*C:NEXT C     
   58 PRINT:INPUT "NEU (J/N)?";A$ 
   59 IF LEFT$(A$,1)="J"THEN 52
   60 GOTO 1
   61 CLS:PRINT:INPUT "Seite g=";A
   62 PRINT:INPUT "Hoehe hg=";B
   63 PRINT:PRINT "Flaeche A=";A*B/2
   64 PRINT:INPUT "NEU (J/N)?";A$
   65 IF LEFT$(A$,1)="J"THEN 61
   66 GOTO 1
   67 CLS:PRINT:INPUT "Radius r=";A
   68 PRINT:INPUT "Schritt=";B
   69 CLS:PRINT:PRINT
   70 PRINT TAB(3);"Radius "TAB(13);"Flaeche"
   71 FOR C=A TO A+10*B STEP B
   72 PRINT:PRINT TAB(3);C TAB(13);PI*C*C:NEXT C
   73 PRINT:INPUT "NEU (J/N)?";A$
   74 IF LEFT$(A$,1)="J"THEN 67
   75 GOTO 1
   76 CLS:PRINT:INPUT "Radius r=";A
   77 PRINT:INPUT "Winkel (in Grad)=";B
   78 PRINT:PRINT "Flaeche A=";PI*A*A*B/360
   79 PRINT:INPUT "NEU (J/N)";A$ 
   80 IF LEFT$(A$,1)="J"THEN 76
   81 GOTO 1
   82 CLS:PRINT:INPUT "Seite a=";A
   83 PRINT:INPUT "Schritt=";B
   84 CLS:PRINT:PRINT
   85 PRINT TAB(3);"Seite  "TAB(13);"Volumen "TAB(23);"Flaeche"
   86 FOR C=A TO A+B*10 STEP B
   87 PRINT:PRINT TAB(3);C TAB(13);C^3 TAB(23);6*C*C:NEXT C
   88 PRINT:INPUT "NEU (J/N)?";A$
   89 IF LEFT$(A$,1)="J"THEN 82
   90 GOTO 1
   91 CLS:PRINT:INPUT "Seite a=";A
   92 PRINT:INPUT "Seite b=";B
   93 PRINT:INPUT "Seite c=";C  
   94 PRINT:PRINT "Volumen V=";A*B*C 
   95 PRINT:PRINT "Flaeche Ao=";2*(A*B+A*C+B*C) 
   96 PRINT:INPUT "NEU (J/N)?";A$
   97 IF LEFT$(A$,1)="J"THEN 91
   98 GOTO 1
   99 CLS:PRINT:INPUT "Seite a=";A
  100 PRINT:INPUT "Hoehe h=";B
  101 PRINT:PRINT "Volumen V=";A*A*B/3
  102 PRINT:INPUT "NEU (J/N)?";A$
  103 IF LEFT$(A$,1)="J"THEN 99
  104 GOTO 1
  105 CLS:PRINT:INPUT "Hoehe h=";A
  106 PRINT:INPUT "Radius r=";B
  107 PRINT:PRINT "Volumen V=";PI*A*B*B
  108 PRINT:PRINT "Flaeche Ao=";2*I*B*B+2*PI*A*B 
  109 PRINT:INPUT "NEU (J/N)?";A$
  110 IF LEFT$(A$,1)="J"THEN 105
  111 GOTO 1
  112 CLS:PRINT:INPUT "Hoehe h=";A
  113 PRINT:INPUT "Radius r=";B
  114 PRINT:PRINT "Volumen V=";PI*A*B*B/3
  115 PRINT:INPUT "NEU (J/N)?";A$
  116 IF LEFT$(A$,1)="J"THEN 112
  117 GOTO 1
  118 CLS:PRINT:INPUT "Radius r=";A
  119 PRINT:INPUT "Schritt=";B
  120 CLS:PRINT:PRINT
  121 PRINT TAB(3);"Radius"TAB(11);"Volumen"TAB(22);"Flaeche"
  122 FOR C=A TO A+10*B STEP B
  123 PRINT:PRINT TAB(3);C TAB(11);4*PI*C^3/3 TAB(22);4*PI*C*C
  124 NEXT C:PRINT:INPUT "NEU (J/N)?";A$
  125 IF LEFT$(A$,1)="J"THEN 118
  126 GOTO 1
  127 CLS:PRINT:PRINT
  128 PRINT "Produced by Jens Scharsig"  
  129 PRINT:PRINT "in 1987":PRINT
  130 PRINT "BEETHOVENSTR.12":PRINT
  131 PRINT "RIESA":PRINT:PRINT "8400":PRINT
  132 PRINT AT(20,15);"<scharsoft>"
  133 PRINT AT(22,26);"C 1987"
  134 PAUSE 100:CLS:END
