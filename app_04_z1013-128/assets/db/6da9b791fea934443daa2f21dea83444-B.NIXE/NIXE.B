Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

    2 WINDOW:CLS:PRINT AT(15,11);"N  I  X  E"
    4 GOSUB 262
    6 Z1$=INKEY$:IF Z1$="" THEN 6
    8 CLS:PRINT:PRINT "Eine  Nixe  schwimmt   in  einem"
   10 PRINT "Schwimmbad  mit truebem  Wasser."
   12 PRINT "Sie koennen eine Peilung machen,"
   14 PRINT "um  Informationen   ueber  ihren"
   16 PRINT "Standort  einzuholen  ( 2 Straf-"
   18 PRINT "punkte )  und/oder  Sie  koennen"
   20 PRINT "Netze werfen,  indem Sie jeweils"
   22 PRINT "5  Felder  markieren  ( 1 Straf-"
   24 PRINT "punkt ).  Nach jeder Ihrer Hand-"
   26 PRINT "lungen  schwimmt die Nixe  will-"
   28 PRINT "kuerlich ein Karo weiter.       "
   30 PRINT "Fange  die Nixe  mit  moeglichst"
   32 PRINT "wenigen Strafpunkten!":PRINT
   34 Z2$=INKEY$:IF Z2$="" THEN 34
   36 CLEAR
   38 GOSUB 186
   40 DIM A(22,12)
   42 X1=INT(15*RND(1)+2)
   44 Y1=INT(5*RND(1)+3)
   46 FOR K=1 TO 20
   48 FOR J=1 TO 10
   50 A(K,J)=0
   52 NEXT
   54 NEXT
   56! Bassinraender eintragen
   58 FOR J=0 TO 11
   60 A(0,J)=2
   62 A(21,J)=2
   64 NEXT
   66 FOR K=0 TO 21
   68 A(K,0)=2
   70 A(K,11)=2
   72 NEXT
   74 Z=0:PRINT:D=0
   76!
   78 PRINT "Sie koennen P tippen  ( Peilen )"
   80 PRINT "oder N ( Netz auswerfen )":PRINT
   82 INPUT Q$
   84 IF D=1 THEN POKE L+1+P1+32*P2,32
   86 IF Q$="N" THEN 112
   88 IF Q$<>"P" THEN PRINT:PRINT "Fehler!":PRINT:GOTO 76
   90 PRINT:PRINT "Eingabe   X,Y  ( Koordinaten des"
   92 PRINT "Peilkaros )":PRINT
   94 INPUT "X,Y";P1,P2
   96 GOSUB 252
   98 Z=Z+2:D=1
  100 PRINT
  102 R=SQR((X1-P1)*(X1-P1)+(Y1-P2)*(Y1-P2)+.001)
  104 IF R>.9 THEN 108
  106 R=0
  108 PRINT:PRINT "Entfernung betraegt ";R:PRINT:PRINT "Meter.":PRINT
  110 GOTO 142
  112 PRINT:D=0
  114 Z=Z+1
  116 PRINT "Eingabe der X,Y  Koordinaten von"
  118 PRINT "5 Karos":PRINT:FOR K=1 TO 5
  120 PRINT "X,Y KOORDINATEN KARO ";K;" SIND ":PRINT
  122 INPUT "X,Y";C1,C2:PRINT
  124 IF A(C1,C2)>0 THEN 132
  126 GOSUB 248
  128 A(C1,C2)=1
  130 GOTO 136
  132 PRINT "Dieses  Karo  ist schon  besetzt"
  134 PRINT "Anderes Karo waehlen!":PRINT:GOTO 120
  136 NEXT
  138!
  140!
  142 M=0
  144 FOR K=X1-1 TO X1+1
  146 FOR J=Y1-1 TO Y1+1
  148 IF A(K,J)<>0 THEN 152
  150 M=M+1
  152 NEXT
  154 NEXT
  156 IF M=0 THEN 174
  158 X2=X1
  160 Y2=Y1
  162 X1=X2
  164 Y1=Y2
  166 X1=X1+SGN(RND(1)-.5)*INT(RND(1)+.5)
  168 Y1=Y1+SGN(RND(1)-.5)*INT(RND(1)+.5)
  170 IF A(X1,Y1)<>0 THEN 162
  172 GOTO 76
  174 CLS:PRINT "Gefangen mit ";Z;" Strafpunkten"
  176 PRINT:PRINT "auf Feld ";X1;",";Y1:GOSUB 256
  178 PRINT:PRINT "WEITER (J)/N ";
  180 Z3$=INKEY$:IF Z3$="N" THEN WINDOW:CLS:END
  182 IF Z3$<>"" THEN 2
  184 GOTO 180
  186 CLS:WINDOW 16,31,0,31
  188 L=-5116
  190 FOR I=1 TO 22
  192 POKE L+I,255
  194 NEXT
  196 FOR I=1 TO 22
  198 POKE L+352+I,255
  200 NEXT
  202 FOR I=1 TO 10
  204 POKE L+1+32*I,255
  206 NEXT
  208 FOR I=1 TO 10
  210 POKE L+22+32*I,255
  212 NEXT
  214 FOR I=1 TO 9
  216 POKE L-1+32*I,48+I
  218 NEXT
  220 POKE L+318,49
  222 POKE L+319,48
  224 FOR I=1 TO 9
  226 POKE L+449+I,48+I
  228 NEXT
  230 FOR I=0 TO 9
  232 POKE L+459+I,48+I
  234 NEXT
  236 POKE L+469,48
  238 FOR I=0 TO 9
  240 POKE L+I+427,49 
  242 NEXT
  244 POKE L+437,50
  246 RETURN
  248 POKE L+1+C1+32*C2,199
  250 RETURN
  252 POKE L+1+P1+32*P2,138
  254 RETURN
  256 L=-5115
  258 POKE L+X1+32*Y1,175
  260 RETURN
  262 L=-4828
  264 FOR I=1 TO 22
  266 POKE L+I,255
  268 NEXT
  270 FOR I=1 TO 22
  272 POKE L+384+I,255
  274 NEXT
  276 FOR I=1 TO 11
  278 POKE L+1+32*I,255:NEXT
  280 FOR I=1 TO 11
  282 POKE L+22+32*I,255:NEXT
  284 RETURN
  286 REM (C)     by K.L. Boon '81    (P) f.Z1013 by I. Koehler'87
