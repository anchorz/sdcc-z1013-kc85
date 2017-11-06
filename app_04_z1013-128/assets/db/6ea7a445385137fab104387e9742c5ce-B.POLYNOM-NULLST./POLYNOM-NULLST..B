Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 CLS
   20 INPUT "Grad des Polynoms:";N
   30 PRINT:M=N:DIM A(N),B(N),C(N)
   40 INPUT "Koeff.hoechster Potenz:";A0
   50 FOR K=1 TO N
   60 PRINT:PRINT "A(";K;")=";
   70 INPUT A(K)
   80 A(K)=A(K)/A0
   90 NEXT K:PRINT:PRINT
  100 C(1)=1
  110 IF N=1 THEN PRINT:PRINT "X( 0 )=";-A(1):END 
  120 IF N=2 THEN P=A(1):Q=A(2):GOSUB 400:END
  130 P=1:Q=0
  140 B(1)=A(1)-P
  150 B(2)=A(2)-Q-P*B(1)
  160 FOR K=3 TO N
  170 B(K)=A(K)-Q*B(K-2)-P*B(K-1)
  180 NEXT K
  190 C(2)=B(1)-P
  200 FOR K=3 TO N
  210 C(K)=B(K-1)-Q*C(K-2)-P*C(K-1)
  220 NEXT K
  230 W=C(N-1)*C(N-1)-C(N)*C(N-2)
  240 U=(B(N-1)*C(N-1)-B(N)*C(N-2))/W
  250 V=(B(N)*C(N-1)-B(N-1)*C(N))/W
  260 IF ABS(U)+ABS(V)<1E-5 THEN GOSUB 400:GOTO 280
  270 P=P+U:Q=Q+V:GOTO 140
  280 N=N-2
  290 FOR K=1 TO N
  300 A(K)=B(K)
  310 NEXT K
  320 GOTO 100
  400 D=P*P/4-Q:PRINT
  410 D0=SQR(ABS(D))
  420 PRINT "X(";M-N+1;")=";
  430 IF D<0 THEN PRINT -P/2;"+J*";D0:PRINT:PRINT "X(";M-N+2;")=";-P/2;"-J*";D0  
  440 IF D>=0 THEN PRINT (D0-P/2):PRINT:PRINT "X(";M-N+2;")=";(-D0-P/2)  
  450 RETURN
