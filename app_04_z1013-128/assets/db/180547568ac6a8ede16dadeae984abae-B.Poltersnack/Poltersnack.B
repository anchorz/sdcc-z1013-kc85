Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 CLEAR:CLS:PRINT:PRINT STRING$(32,"=")+"********** POLTERSNACK *********";
   20 PRINT STRING$(32,"="):PRINT
   30 DIM A(32),B(32),C(32),H(32),R(32),S(32):E=1:Z=10:N=0:A(0)=32
   40 N=N+1:A(N)=E+Z:E=E+1:IF E=9 THEN Z=Z+10:E=1
   50 IF Z<50 GOTO 40
   60 WINDOW 5,31,0,31:PRINT "Kennen Sie die Spielregeln? ";:BEEP
   70 A$=INKEY$:IF A$<>"J"AND A$<>"N"GOTO 70
   80 PRINT A$:BEEP:IF A$="J"GOTO 170
   90 CLS:PRINT "Jeder  Spieler  bekommt 6 Kartenvon einem Talon von 32 ";
  100 PRINT "Karten.":PRINT:PRINT "Eine Karte wird aufgedeckt.":PRINT
  110 PRINT "Gewonnen hat,wer als erster alleseine Karten ablegen konnte."
  120 PRINT:PRINT "Es duerfen nur  Karten  abgelegtwerden,die in Bild und ";
  130 PRINT "Farbe mitder Karte  auf dem  Tisch ueber-einstimmen.":PRINT
  140 PRINT "Wer nicht bedienen kann muss so-lange Nachschub vom Talon ";
  150 PRINT "nehmen,bis er bedienen kann.";:FOR I=1 TO 6:PRINT:NEXT
  155 PRINT SPC(20);">ENTER<";:BEEP
  160 A$=INKEY$:IF A$=""THEN 160:ELSE BEEP
  170 CLS:PRINT:PRINT "Bitte etwas Geduld, ich mische !"
  180 FOR D=0 TO 3:NB=0:NC=A(0)+1
  190 FOR N=1 TO A(0):ON INT(2*RND(1)+1)GOTO 230,240
  200 NEXT N
  210 FOR N=1 TO A(0):A(N)=B(N)+C(N):B(N)=0:C(N)=0
  220 NEXT N,D:FR=0:NR=0:GOTO 250
  230 NB=NB+1:B(NB)=A(N):GOTO 200
  240 NC=NC-1:C(NC)=A(N):GOTO 200
  250 GOSUB 470
  260 PRINT TA$;:BEEP
  270 B$=INKEY$:IF B$<>"J"AND B$<>"N"GOTO 270
  280 PRINT B$:BEEP:PRINT:IF B$="J"THEN F=1:ELSE F=2
  290 FOR N=1 TO 6:H(N)=A(33-N):A(0)=A(0)-1:H(0)=H(0)+1:A(33-N)=0:NEXT N
  300 FOR N=1 TO 6:R(N)=A(27-N):A(0)=A(0)-1:R(0)=R(0)+1:A(27-N)=0:NEXT N
  310 T=A(0):R=S(0)+1:S(R)=A(T):A(T)=0:A(0)=A(0)-1:S(0)=R
  320 N=S(0):X=S(N):GOSUB 760
  330 PRINT TB$+" "+A$:PRINT:PRINT TG$;R(0);"Karten":PRINT
  340 IF FR=1 THEN FR=0:PRINT "Ich musste eine Karte nehmen":PRINT STRING$(32,"-")
  350 PRINT TC$:M=H(0):FOR N=1 TO M:X=H(N):GOSUB 760
  360 IF N<10 THEN PRINT," ";N;:ELSE PRINT,N;
  370 PRINT " "+A$:NEXT N:PRINT
  380 IF H(0)=0 THEN PRINT TK$:GOTO 900
  390 IF R(0)=0 THEN PRINT TL$:GOTO 900
  400 IF A(0)=0 THEN GOSUB 600
  410 IF F=2 THEN PRINT TE$:PRINT TF$:PRINT SPC(20);">ENTER<";:BEEP:ELSE 430
  420 A$=INKEY$:IF A$=""THEN 420:ELSE BEEP:PRINT:PRINT:GOTO 460
  430 IF F=3 THEN PRINT TJ$:BEEP:BEEP:BEEP
  440 IF F=4 THEN PRINT TH$:BEEP:BEEP:BEEP
  450 F=1:CALL*F6B8:BEEP:INPUT "Nr. der Karte (Nachschub=0):";A:BEEP
  455 CALL*F6C5:PRINT
  460 ON F GOSUB 530,570:GOTO 320
  470 TA$="Wollen Sie beginnen? ":TB$="Auf dem Tisch liegt: "
  480 TC$="Ihre Karten: ":TE$="Ich bin nun an der Reihe "
  490 TF$=", Quittieren Sie mit ":TG$="Ich habe noch"
  500 TH$="???fehlerhafte Eingabe, nochmal!":TJ$="Regelverstoss, nochmal!"
  510 TK$="Sie haben gewonnen!!!           GLUECKWUNSCH!"
  520 TL$="*Damit habe ich gewonnen,AETSCH*":TD$="Sie haben alle Karten"
  525 RETURN
  530 IF A>H(0)THEN F=4:RETURN
  540 IF A=0 THEN GOSUB 710:RETURN
  550 P=H(A):GOSUB 640:IF FP=2 THEN F=3:RETURN
  560 GOSUB 690:F=2:RETURN
  570 GOSUB 670:IF FP=1 THEN GOSUB 720:F=1:RETURN
  580 FR=1:GOSUB 740:RX=R(0):P=R(RX):GOSUB 640:IF FP=2 GOTO 580
  590 A=R(0):GOSUB 720:F=1:RETURN
  600 M=S(0):IF M<1 THEN PRINT "Karten sind alle, Remis.":GOTO 900
  610 X=S(M):S(M)=0:M=M-1:S(0)=S(0)-1
  620 FOR N=1 TO M:A(N)=S(M):S(M)=0:A(0)=A(0)+1:S(0)=S(0)-1:M=M-1:NEXT N
  630 S(1)=X:S(0)=S(0)+1:PRINT "Talon war leer":BEEP:RETURN
  640 VX=S(0):V=S(VX):PG=INT(P/10):VG=INT(V/10):IF PG=VG THEN FP=1:RETURN
  650 PK=INT(P-10*PG):VK=INT(V-10*VG):IF PK=VK THEN FP=1:RETURN
  660 FP=2:RETURN
  670 FOR A=1 TO R(0):P=R(A):GOSUB 640:IF FP=2 THEN NEXT A
  680 RETURN
  690 S(0)=S(0)+1:SX=S(0):S(SX)=H(A)
  700 FOR N=A TO H(0):H(N)=H(N+1):NEXT N:H(0)=H(0)-1:RETURN
  710 H(0)=H(0)+1:HX=H(0):AX=A(0):H(HX)=A(AX):A(AX)=0:A(0)=A(0)-1:RETURN
  720 S(0)=S(0)+1:SX=S(0):S(SX)=R(A)
  730 FOR N=A TO R(0):R(N)=R(N+1):NEXT N:R(0)=R(0)-1:RETURN
  740 R(0)=R(0)+1:RX=R(0):IF A(0)=0 THEN GOSUB 600:IF A(0)=0 THEN PRINT TD$:GOTO 900
  750 AX=A(0):R(RX)=A(AX):A(AX)=0:A(0)=A(0)-1:RETURN
  760 IF X>40 THEN A$="":GOTO 800
  770 IF X>30 THEN A$="":GOTO 800
  780 IF X>20 THEN A$="":GOTO 800
  790 A$=""
  800 X=X/10:X=X-INT(X):X=X*10
  810 IF X>7.5 THEN A$=A$+" A ":RETURN
  820 IF X>6.5 THEN A$=A$+" K ":RETURN
  830 IF X>5.5 THEN A$=A$+" D ":RETURN
  840 IF X>4.5 THEN A$=A$+" B ":RETURN
  850 IF X>3.5 THEN A$=A$+" 10":RETURN
  860 IF X>2.5 THEN A$=A$+" 9 ":RETURN
  870 IF X>1.5 THEN A$=A$+" 8 ":RETURN
  880 IF X>.5 THEN A$=A$+" 7 ":RETURN
  890 A$="--":RETURN
  900 PRINT:PRINT "Noch ein Spiel? ";:BEEP:BEEP:BEEP
  910 A$=INKEY$:IF A$<>"J"AND A$<>"N"GOTO 910
  920 PRINT A$:BEEP:WINDOW:IF A$="J"THEN RUN
  930 CLS:FOR I=1 TO 15:PRINT:NEXT:PRINT TAB(8);"Auf wiederseh'n"
  940 FOR I=1 TO 13:PRINT:NEXT:END
