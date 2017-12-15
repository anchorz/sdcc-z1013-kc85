    5! DOPPELTE ROTAION
   10 CLS
   20 PRINT "DOPPELTE ROTATION"
   25 PRINT "================="
   28 PRINT
   30 PRINT:PRINT "Die folgenden Buchstaben sind zu"
   40 PRINT "ordnen.Nach der Vorgabe eines"
   45 PRINT
   50 PRINT "Buchstabens werden die Davor- "
   55 PRINT
   60 PRINT "und die Danachstehenden jeweils"
   65 PRINT
   70 PRINT "in ihrer Reihenfolge umgedreht."
   80 PRINT:N=0
   90 FOR I=1 TO 10
  100 A(I)=I-1
  110 NEXT I
  120 FOR I=1 TO 10
  130 J=INT(10*RND(1))+1:IF J=I THEN 130
  140 Z=A(I):A(I)=A(J):A(J)=Z
  150 NEXT I
  160 FOR I=1 TO 10
  170 PRINT CHR$(A(I)+65);
  180 NEXT I
  190 FOR I=0 TO 9
  200 IF I<>A(I+1)THEN 230
  210 NEXT I
  220 PRINT:PR "Mit";N;VERSUCHEN GELOEST ":GOTO420
  230 PRINT "  Fester Buchstabe:";
  240 B$=INKEY$
  250 IF B$<"A"THEN 240
  260 IF B$>"J"THEN 240
  270 PRINT B$
  280 L=ASC(B$)-65
  290 FOR K=1 TO 10
  300 IF A(K)=L THEN 320
  310 NEXT K
  320 N=N+1
  330 IF K<3 THEN 370
  340 FOR I=1 TO INT(K/2)
  350 Z=A(I):A(I)=A(K-I):A(K-I)=Z
  360 NEXT I
  370 IF K>8 THEN 410
  380 FOR I=INT((13+K)/2)TO 10
  390 Z=A(I):A(I)=A(11+K-I):A(11+K-I)=Z
  400 NEXT I
  410 GOTO 160
  420 PRINT:PRINT "Auf ein Neues(J/N)? "
  430 B$=INKEY$
  440 IF B$="J"THEN 80
  450 IF B$="N"THEN 430
