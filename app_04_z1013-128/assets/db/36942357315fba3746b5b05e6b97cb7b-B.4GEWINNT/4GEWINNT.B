Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

    5 CLS:PRINT AT(0,0);" "
   15 PRINT AT(5,1);"*   *  *  *  *  *  *  *  *   *":FOR Y=7 TO 17 STEP 2 
   25 PRINT AT(Y,1);"*"
   35 NEXT Y:FOR X=7 TO 17 STEP 2:PRINT AT(X,30);"*":NEXT X
   45 PRINT AT(19,1);"*   *  *  *  *  *  *  *  *   *":FOR R=7 TO 24
   55 PRINT AT(10,R);"":PRINT AT(14,R);"":NEXT R:FOR S=11 TO 13 
   65 PRINT AT(S,6);"":PRINT AT(S,25);"":NEXT S 
   75 PRINT AT(12,8);"4  G E W I N N T":PAUSE 10
   85 PRINT AT(12,8);"                ":PAUSE 8:F=F+1:IF F<8 THEN 75
   90 F=0:CLS:PRINT:PRINT "Spielregel":PRINT "==========":PRINT
   95 PRINT:PRINT "Gleich erscheinen 7 Spalten."
  105 PRINT:PRINT "Zwei SpieLer koennen abwechselnd"
  115 PRINT "einen Stein durch Eingabe der"
  120 PRINT:PRINT "Zeilennummer einwerfen."
  125 PRINT:PRINT "Wer als erster 4 Steine neben-"
  135 PRINT:PRINT "einander,uebereinander oder"
  145 PRINT:PRINT "diagonal hat, gewinnt."
  147 PRINT:PRINT:PRINT "Fertig? ....Dann >ENTER<";
  150 A$=INKEY$:IF A$=""THEN 150 ELSE CLS
  155 DIM X$(5,6)
  175 FOR W=0 TO 6:FOR V=0 TO 5:X$(V,W)=" ":NEXT V:NEXT W
  185 CLS:PRINT AT(0,0);" ":FOR S=2 TO 30 STEP 4    
  195 FOR Z=2 TO 22:PRINT AT(Z,S);CHR$(161):NEXT Z:NEXT S:FOR Y=2 TO 30
  205 PRINT AT(23,Y);CHR$(158):NEXT Y:FOR N=1 TO 7:PRINT AT(2,4*N-1);N:NEXT N
  215 A$="":B$="" 
  225 PRINT AT(25,0);"Eingabe Spieler A !"
  235 PRINT AT(27,0);"Spalte?" 
  245 A$=INKEY$:IF A$=""THEN 245
  255 A=VAL(A$)
  265 IF A>7 THEN 235 
  275 A=A-1:FOR B=5 TO 0 STEP-1:IF X$(B,A)=" "THEN 295
  285 NEXT B:A=A+1:GOSUB 625:GOTO 235
  295 X$(B,A)="":E=3*B+5:F=4*A+4:PRINT AT(E,F);"":GOSUB 385
  305 PRINT AT(25,0);"Eingabe Spieler B !":PRINT AT(27,0);"Spalte?" 
  315 C$=INKEY$:IF C$=""THEN 315
  325 C=VAL(C$)
  335 IF C>7 THEN 305
  345 C=C-1:FOR D=5 TO 0 STEP-1:IF X$(D,C)=" "THEN 365
  355 NEXT D:A=C+1:GOSUB 625:GOTO 305
  365 X$(D,C)="":E=3*D+5:F=4*C+4:PRINT AT(E,F); "":GOSUB 385
  375 GOTO 225
  385 FOR I=0 TO 6                                                               
  395 FOR K=5 TO 3 STEP-1   
  405 IF X$(K,I)=" "THEN 425
  415 IF X$(K,I)=X$(K-1,I)AND X$(K,I)=X$(K-2,I)AND X$(K,I)=X$(K-3,I)THEN 565
  425 NEXT K:NEXT I
  435 FOR K=0 TO 3:FOR I=5 TO 3 STEP-1             
  445 IF X$(I,K)=" "THEN 465
  455 IF X$(I,K)=X$(I-1,K+1)AND X$(I,K)=X$(I-2,K+2)AND X$(I,K)=X$(I-3,K+3)THEN 565
  465 NEXT I:NEXT K
  475 FOR K=3 TO 6:FOR I=5 TO 3 STEP-1
  485 IF X$(I,K)=" "THEN 505
  495 IF X$(I,K)=X$(I-1,K-1)AND X$(I,K)=X$(I-2,K-2)AND X$(I,K)=X$(I-3,K-3)THEN 565
  505 NEXT I:NEXT K
  515 FOR I=5 TO 0 STEP-1:FOR K=0 TO 3
  525 IF X$(I,K)=" "THEN 545
  535 IF X$(I,K)=X$(I,K+1)AND X$(I,K)=X$(I,K+2)AND X$(I,K)=X$(I,K+3)THEN 565
  545 NEXT K:NEXT I
  555 RETURN
  565 PRINT AT(27,0);"Hat gewonnen !!!"
  575 PRINT AT(29,0);"Wollen Sie weiter spielen (J/N)"
  595 O$=INKEY$:IF O$=""THEN 595
  605 IF O$="N"THEN CLS:PRINT "    A U F  W I E D E R S E H E N  !":END
  615 IF O$="J"THEN 175
  625 PRINT AT(29,0);"Spalte ist schon gefuellt !":PAUSE 35
  645 PRINT AT(29,0);"                           ":RETURN
