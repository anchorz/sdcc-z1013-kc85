Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10!    Fibonacci-Zahlen bis 184
   20!    DiAmANT  1.1.'93        
   30!
   40 PRINT "Bitte warten...":DIM F(190)
   50 F(1)=1:F(2)=1:FOR I=3 TO 184:F(I)=F(I-1)+F(I-2):NEXT
   60 PRINT:INPUT "erster  Wert:";X:INPUT "letzter Wert:";Y
   70 PRINT " x  FIB(x)"
   80 FOR I=X TO Y:F=I:IF F<1 THEN F=1
   90 PRINT I;TAB(5);F(F):NEXT
  100 GOTO 60
