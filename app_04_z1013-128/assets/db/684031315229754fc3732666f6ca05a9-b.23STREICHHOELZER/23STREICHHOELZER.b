1 REM SPIEL DER 23 STREICHHOELZER
10 OUTC.12
20 F.I=1 TO 10
30 P.
40 P."DAS SPIEL DER " 
60 P.;P."23 STREICHHOELZER"
70 F.I=1 TO 5000
80 N.I
85 OUTC.12
90 F.I=1 TO 10
100 P.
110 N.I
120 P."HIER SIND 23 STREICHHOELZER!"
140 P.;P."SIE NEHMEN STETS 1,2 ODER 3."
160 P.;P."DARAUF NEHME ICH 1,2 ODER 3."
180 P.;P."WER DAS LETZTE STREICHHOLZ"
200 P.;P."NIMMT, HAT VERLOREN."
210 P.;P.
220 P.;P."VERSTANDEN ? ES GEHT LOS !!!"
230 F.I=1 TO 10000
240 N.I
250 OUTC.12
300 P.;P.;P.;P.
310 M=23
320 Z=0
325 IF M=1 GOTO 1000
330 P."HIER SIND JETZT",#3,M," HOELZER."
400 Q=HEX(EE24)
410 F. K=1 TO 5
420 Z=Z+1
440 IF Z<=M POKE Q,161
450 Q=Q+1
460 N.K
470 Q=Q+1
480 IF Z<M GOTO 410
500 P.
510 INP."WIEVIELE NEHMEN SIE ?"N
515 P.
530 IF N>3 GOTO 900
540 IF N<1 GOTO 900
550 IF N>M GOTO 900
560 M=M-N
580 IF M=1 GOTO 800
590 R=M-4*(M/4)
600 IF R#1 GOTO 650
610 C=RND(3)
620 GOTO 660
650 C=3+R-4*((R+3)/4)
660 M=M-C
670 OUTC.12
680 P."ICH NEHME",#3,C
690 P.;GOTO 320
800 OUTC.12
810 F.I=1 TO 15
820 P.
830 N.I
840 P."HERZLICHEN GLUECKWUNSCH,"
845 P.;P."SIE HABEN GEWONNEN!!!!"
850 P.;INP."NOCH EINMAL ? JA=1"A
880 IF A=1 GOTO 250
890 STOP 
900 P."NA...NICHT MOGELN !!!"
910 GOTO 510
1000 F.I=1 TO 20
1010 P.
1020 N.I
1030 P."TJA....DAS LETZTE HOLZ WERDEN"
1040 P.;P."SIE WOHL NEHMEN MUESSEN !!!"
1045 A=HEX(EE28)
1050 Q=A
1055 POKE Q,207
1060 Q=Q+1
1065 F.I=1 TO 5
1070 IF Q<HEX(EE2E) POKE Q,160
1075 Q=Q+1
1080 N.I
1090 Z=0
1095 Q=A-32
1100 F.I=1 TO 5
1110 POKE Q,127+RND(8)
1150 Q=Q-32
1160 N.I
1170 Z=Z+1
1180 IF Z<4 GOTO 1095
1200 Q=A
1210 F.I=1 TO 6
1220 POKE Q,32
1230 Q=Q-32
1240 N.I
1250 A=A+1
1260 IF A<HEX(EE2E) GOTO 1050
1300 GOTO 850