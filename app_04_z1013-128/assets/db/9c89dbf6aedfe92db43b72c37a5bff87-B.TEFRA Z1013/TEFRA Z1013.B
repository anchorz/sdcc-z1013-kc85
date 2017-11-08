Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 CLS: PRINT TAB(8);"## TEFRA ##": PRINT
   20 H=199: A=0: B=0: M=0: X=0: Y=0: Q=31: H=155
   30 INPUT "X1, X2 =";X1,X2: XD=(X2-X1)/32: Z=27: G=42: E=.01
   40 INPUT "Y1, Y2 =";Y1,Y2: YD=(Y2-Y1)/Q: Y=Y2+YD: WINDOW 0,Q,0,31: CLS
   50 FOR I=0 TO Q-1: X=X1-XD: Y=Y-YD
   60 FOR J=0 TO 31: X=X+XD: A=.5: B=0: C=A: D=B: F=H
   70  FOR N=1 TO Z
   80   C=A*A-B*B-X: D=A*B: D=D+D-Y
   90   IF ABS(C-A)<E AND ABS(D-B)<E THEN F=N+95: N=Z
  100  A=C: B=D: IF ABS(A) + ABS(B) >G THEN F=N+63 : N=Z
  110 NEXT: PRINT CHR$(F);: NEXT: NEXT
  120 INPUT "";A: IF A=0 THEN END
