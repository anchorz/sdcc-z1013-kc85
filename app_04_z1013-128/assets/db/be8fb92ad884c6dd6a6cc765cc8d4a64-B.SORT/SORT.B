Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

    1 CLS:GOSUB 10
    2 PRINT:PRINT:PRINT:PRINT
    3 PRINT "Tragen Sie die Daten in die"
    4 PRINT ">DATA-Zeilen< mit"
    5 PRINT:PRINT "        >> EDIT90 <<"
    6 PRINT:PRINT "ein."
    7 PRINT "Starten Sie das Programm mit"
    8 PRINT:PRINT "        >> RUN 40 <<":PRINT:PRINT:PRINT
    9 STOP
   10 PRINT AT(10,8);"Sortierprogramm"
   20 PRINT AT(12,8);"***************"
   30 PRINT AT(14,12);"*******"
   32 PAUSE 40
   33 CLS
   35 RETURN
   40 INPUT "Anzahl der Daten N= ";N
   50 DIM X(N)
   60 FOR I=1 TO N:READ X(I):NEXT I
   70 GOSUB 800
   80 FOR I=1 TO N:PRINT X(I);:NEXT I
   90 DATA
  100 DATA
  110 DATA
  120 DATA
  130 DATA
  140 DATA
  150 DATA
  160 DATA
  170 DATA
  180 DATA
  190 DATA
  200 DATA
  790 END
  800 REM UP SORTIERPROGRAMM
  810 FOR K=2 TO N
  820 FOR I=K TO N
  830 IF X(K-1)<=X(I) THEN 850
  840 X(0)=X(K-1):X(K-1)=X(I):X(I)=X(0)
  850 NEXT I
  860 NEXT K
  870 RETURN
