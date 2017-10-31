Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 CLS:PRINT:PRINT
   20 ABW=0
   30 E1=1E-5
   40 INPUT "Anzahl der Messwerte:";M
   50 PRINT:PRINT
   60 INPUT "gewuenschter Polynomgrad:";N
   70 N=N+1
   80 PRINT:PRINT
   90 DIM A(M,M),F(M)
  100 PRINT "Eingabe der Messwerte:":PRINT:PRINT
  110 FOR I=1 TO M
  120 PRINT "X(";I;")=";
  130 INPUT A(I,2)
  140 PRINT "Y(";I;")=";
  150 INPUT F(I)
  160 PRINT     
  170 A(I,1)=1
  180 FOR K=3 TO N
  190 A(I,K)=A(I,K-1)*A(I,2)
  200 NEXT K
  210 NEXT I
  220 DIM Z(M)
  230 DIM B(M),C(M),D(M),S(M,M-1)
  240 DIM U(M),V(M,M),W(M,M)
  250 GOSUB 390
  260 IF NOT (P1=0) THEN 300
  270  PRINT "SPALTENVEKTOREN"
  280  PRINT "SIND LIN ABHAENGIG" 
  290  STOP
  300 PRINT "LOESUNGSVEKTOR"
  310 PRINT " "
  320 FOR J=1 TO N
  330 PRINT " "         
  340 PRINT "X^";J-1 ;      "=" Z(J)  
  350 PRINT " "        
  360 NEXT J
  370 INPUT "Wertevergleich->{ENT.}";TR
  380 GOTO 1110
  390 FOR I=1 TO M
  400    V(I,1)=A(I,1)
  410 NEXT I
  420 FOR I=1 TO M
  430    B(I)  =V(I,1)
  440 NEXT I
  450 GOSUB 1000
  460 U(1) = R
  470 IF NOT (R <= E1) THEN 500
  480  P1 = 0
  490  RETURN
  500 FOR I=1 TO M
  510    W(I,1)=V(I,1)/R
  520 NEXT I
  530 FOR J=2 TO N
  540    FOR I=1 TO M
  550        V(I,J)=A(I,J)
  560    NEXT I
  570    FOR K=1 TO J-1 
  580        FOR I=1 TO M
  590            C(I)=A(I,J)
  600            D(I)=W(I,K)
  610        NEXT I
  620        GOSUB 1060
  630        S(J,K)=P
  640        FOR I=1 TO M
  650            V(I,J)=V(I,J)-P*W(I,K)
  660        NEXT I
  670    NEXT K
  680    FOR I=1 TO M
  690        B(I)=V(I,J)
  700    NEXT I
  710    GOSUB 1000
  720    U(J)=R
  730    IF NOT (R <= E1) THEN 760
  740      P1=0
  750      RETURN
  760    FOR I=1 TO M
  770        W(I,J)=V(I,J)/R
  780    NEXT I
  790 NEXT J 
  800 P1=1 
  810 FOR I=1 TO M
  820    C(I)=F(I)
  830    D(I)=W(I,N)
  840 NEXT I
  850 GOSUB 1060
  860 Z(N)=P/U(N)
  870 FOR J=N-1 TO 1 STEP -1 
  880    FOR I=1 TO M                   
  890        C(I)=F(I)
  900        D(I)=W(I,J)
  910    NEXT I
  920    GOSUB 1060
  930    Z(J)=P
  940    FOR K= J+1 TO N
  950        Z(J)=Z(J)-Z(K)*S(K,J)
  960    NEXT K
  970    Z(J)=Z(J)/U(J)
  980 NEXT J
  990 RETURN
 1000 R=0
 1010 FOR I=1 TO M
 1020    R=R+B(I)*B(I)
 1030 NEXT I
 1040 R=SQR (R)
 1050 RETURN
 1060 P=0
 1070 FOR I=1 TO M
 1080    P=P+C(I)*D(I)
 1090 NEXT I
 1100 RETURN
 1110 PRINT:PRINT "X","Y";TAB(22);"Y*"
 1120 PRINT
 1130 FOR I=1 TO M
 1140 Y=0
 1150 FOR J=N TO 1 STEP -1
 1160 Y=Y*A(I,2)+Z(J)
 1170 Y=INT(Y*1000+.5)/1000
 1180 NEXT J        
 1190 PRINT A(I,2),F(I);TAB(22);Y   
 1200 ABW=ABW+ABS(F(I)-Y)
 1210 PRINT
 1220 NEXT I
 1230 PRINT "max.Fehler:";ABW 
 1240 PRINT
 1250 PRINT:INPUT "neuer Polynomgrad=";N
 1260 N=N+1
 1270 FOR I=1 TO M
 1280 FOR K=3 TO N
 1290  A(I,K)=A(I,K-1)*A(I,2)
 1300 NEXT K
 1310 NEXT I
 1320 CLS
 1330 ABW=0
 1340 GOTO 250
