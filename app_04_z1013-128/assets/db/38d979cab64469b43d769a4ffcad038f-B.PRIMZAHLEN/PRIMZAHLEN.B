Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

    5 CLS
   10 PRINT AT(5,3);" Primzahlenermittlung"
   40 PRINT AT(7,3);" ********************"
   70 PRINT AT(10,2);"Laufzeit:"
   71 PRINT AT(13,5);"                   "
   72 PRINT AT(14,5);"                   "
   73 PRINT AT(15,5);"    81920          "
   74 PRINT AT(16,5);"    40960          "
   75 PRINT AT(17,5);"    20480          "
   76 PRINT AT(18,5);"    10240          "
   77 PRINT AT(19,5);"     5120          "
   78 PRINT AT(20,5);"     2560          "
   79 PRINT AT(21,5);"     1280          "
   80 PRINT AT(22,5);"      640          "
   81 PRINT AT(23,5);"      320  00 03 08"
   82 PRINT AT(24,5);"      160  00 00 55"
   83 PRINT AT(25,5);"       80  00 00 18"
   84 PRINT AT(26,5);"       40  00 00 06"
   85 PRINT AT(27,5);"       20  00 00 03"
   86 PRINT AT(28,5);"       10  00 00 01"
   87 PRINT AT(29,5);" "
   88 PRINT AT(30,5);" Anzahl d.  h  m  s"
   89 PRINT AT(31,5);"Primzahlen  Z e i t"
   90 PAUSE 60
  100 CLS
  130 PRINT:PRINT:PRINT "   Primzahlenermittlung"
  160 PRINT:PRINT "   ===================="
  190 PRINT:PRINT
  220 INPUT "Maximaler Testbereich=";Z
  250 FOR N=2 TO Z
  280 FOR K=2 TO Z/2
  310 M=N/K
  340 L=INT(M)
  370 IF L=0 THEN 520
  400 IF L=1 THEN 490
  430 IF M>L THEN 490
  460 IF M=L THEN 550
  490 NEXT K
  520 PRINT N;
  550 NEXT N
  580 PRINT
  610 PRINT:PRINT:PRINT
  640 PRINT "Ende des Testbereiches" 
  670 END
