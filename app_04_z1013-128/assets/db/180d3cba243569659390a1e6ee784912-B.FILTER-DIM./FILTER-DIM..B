Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 WINDOW:CLS
   20 PRINT AT(10,7);"SELEKTIVES FILTER"
   25 PRINT AT(11,14);"mit"
   30 PRINT AT(12,5);"Mehrfachgegenkopplung"
   40 PRINT AT(14,5);">>>>>>>>>>+<<<<<<<<<<"
   50 PRINT AT(27,17);"Copyright:"
   60 PRINT AT(29,17);"P.H e b l i k"
   62 PAUSE 50:CLS
   64 PRINT AT(15,2);"Dieses Programm wurde fuer den"
   65 PRINT AT(16,2);"Z 1013 ueberarbeitet von"
   66 PRINT AT(18,18);"Dieter Waldt"
   67 PRINT AT(19,21);"Y2 8OH"
   70 PAUSE 50
   75 CLS
  100 PRINT
  110 PRINT "          "
  120 PRINT "                     "
  130 PRINT "          C    R2     "
  140 PRINT "                    "
  150 PRINT "      R1         "
  160 PRINT "           "
  170 PRINT " o        o"
  180 PRINT "       C           "
  190 PRINT "Ue                    Ua"
  200 PRINT "                           "
  210 PRINT " o                   o"
  220 PRINT "         R3           "
  230 PRINT "                     "
  240 PRINT "                       "
  250 PRINT "                  "
  260 PRINT
  265 PRINT AT(7,24);CHR$(151)
  270 WINDOW 17,31,0,31
  280 PRINT "Eingabe der"
  290 PRINT "Schaltungsparameter"
  300 PRINT "---------------------"
  310 INPUT "Guete Q als Faktor:";Q
  320 INPUT "Resonanzfrequenz Fo:";FO
  330 INPUT "Verstaerkung in Resonanz Vr:";VR
  340 INPUT "Leerlaufverst.des OPV Vl:";VL
  350 INPUT "Kondensatoren C:";C
  360 CLS
  370 R2=Q/(PI*FO*C)
  380 R1=R2/(2*VR)
  390 R3=R1/((4*PI*PI*C*C*FO*FO*R1*R2)-1)
  400 IF VL<(5*Q*Q) THEN 460
  410 PRINT "R1=";R1
  420 PRINT "R2=";R2
  430 PRINT "R3=";R3
  440 PRINT:PRINT "Alle Widerstandswerte in Ohm"
  450 GOTO 600
  460 PRINT "Leerlaufverstaerkung fuer"
  470 PRINT "geforderte Guete nicht"
  480 PRINT "ausreichend !"
  490 PAUSE 30
  500 Q=SQR(VL/5)
  510 CLS
  520 PRINT:PRINT "Maximal erreichbare Guete:";INT(Q)
  522 PAUSE 50:CLS
  530 GOTO 280
  600 PRINT:PRINT "Berechnung der Parameter"
  610 PRINT "mit genormten Widerstandswerten:"
  620 INPUT "R1=";R1
  630 INPUT "R2=";R2
  640 INPUT "R3=";R3
  645 FO=SQR((R1+R3)/(R3*4*PI*PI*C*C*R1*R2))
  650 Q=R2/(PI*FO*C)
  660 VR=R2/(2*R1)
  670 CLS
  680 PRINT:PRINT "Fo=";FO
  690 PRINT " Q=";Q
  700 PRINT "Vr=";VR
  710 PRINT "                 R1=";R1
  720 PRINT "                 R2=";R2
  730 PRINT "                 R3=";R3
  740 END
