Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

5 OUTC.12
6 P.' '
7 P.'                             '
10 P.'    '
20 P.'       '
30 P.'             '
40 P.'       '
50 P.'                            '
60 P.'                             '
65 P.'                             '
70 P.'      '
80 P.'                          '
90 P.'             '
100 P.'                   '
110 P.'       '
120 P.'                            '
130 P.'                             '
140 P.'                             '
150 P.' '
155 FOR I=-1000 TO1
156 IF I=2 G.158
157 N.I
160 OUTC.12
170 P.''
180 P.'   '
190 P.'   '
200 P.'     RICHTIGE'
210 P.'(C)by kaup-computer';
220 P.'                   FARBE STELLE'
225 P.'-------------------------------'
230 PO.H.(1B),H.(E0)
240 PO.H.(1C),H.(EC)
250 PO.H.(1D),H.(FF)
260 PO.H.(1E),H.(EF)
270 CALL (H.(F6D1))
280 P.'*ICH HABE MIR VON BLAU,ROSA,ROT'
285 P.
290 P.' GRUEN,GELB UND BRAUN 4 FARBEN'
295 P.
300 P.' GEMERKT !!!'
305 P.
310 P.'*ES IST HERAUSZUFINDEN,WELCHE'
315 P.
320 P.' FARBE AN WELCHER STELLE STEHT'
325 P.
330 P.'**  6 VERSUCHE SIND MOEGLICH  **
335 P.
340 P.'GIB EIN : "S" FUER START!!
345 P.
350 P.'DANACH GIB 4 VERSCHIEDENE'
355 P.'
360 P.'FARBEN EIN UND BEACHTE DIE'
365 P.'
366 P.'AUSWERTUNG "FARBE STELLE"
367 P.
370 P.'V I E L   S P A S S  !!!!'
380 P.'**************************'
390 S=INC.
400 IF S=83 OUTC.12
410 A=RND(6)
420 B=RND(6)
430 IF B=A G.420
440 C=RND(6)
450 IF C=A G.440
460 IF C=B G.440
470 D=RND(6)
480 IF D=A G.470
490 IF D=B G.470
500 IF D=C G.470
510 X=0
520 F=0,M=0,N=0
530 I=INC.
550 Q=I-72
560 IF Q=A N=N+1
561 O=Q
567 GOSUB 2000
570 I=INC.
580 Q=I-72
590 IF Q=B N=N+1
600 P=Q
620 GOSUB 2000
630 I=INC.
640 Q=I-72
650 IF Q=C N=N+1
655 R=Q
660 IF P=O P.;G.787
680 GOSUB 2000
690 I=INC.
700 Q=I-72
710 IF Q=D N=N+1
720 S=Q
730 IF R=O P.;G.787
740 IF R=P P.;G.787
750 IF S=O P.;G.787
752 IF S=P P.;G.787
753 IF S=R P.;G.787
760 GOSUB 2000
780 G.800
787 P.'ES SOLLTEN 4 VERSCHIEDENE'
788 P. 
789 P.'FARBEN EINGEGEBEN WERDEN !!!
791 P.
792 P.'SIE MUESSEN NEU BEGINNENN MIT S'
793 S=INC.
794 IF S=83 OUTC.12
796 G.510
800 X=X+1
815 P.#2,M,#3,N
820 P.
830 IF M+N=8 G.870
850 IF X=6 G.910
860 IF F=4 G.520
870 P.'GEWONNEN MIT',#2,X,' ','VERSUCH(EN)'
880 P.
890 IF X=1 P.'DAS WAR ZUFALL'
910 IF X=6P.'DAS WAR DER LETZTE VERSUCH'
920 P.
930 IF M+N<8 P.'SIE HABEN VERLOREN !!'
940 P.
950 P.'LOESUNG :'
960 P.
965 P.
970 Q=A
980 GOSUB 2000
990 Q=B
1000 GOSUB 2000
1010 Q=C
1020 GOSUB 2000
1030 Q=D
1040 GOSUB 2000
1050 P.
1060 P.
1070 P.'EIN NEUES SPIEL BEGINNTT MIT S'
1080 G.390
1085 P.
1090 STOP
2000 IF Q=A M=M+1
2010 IF Q=B M=M+1
2020 IF Q=C M=M+1
2030 IF Q=D M=M+1
2040 IF Q=1 P.'BLAU','  ',
2050 IF Q=2 P.'ROT','   ',
2060 IF Q=3 P.'GRUEN',' ',
2070 IF Q=4 P.'GELB','  ',
2080 IF Q=5 P.'ROSA','  ',
2090 IF Q=6 P.'BRAUN',' ',
2100 F=F+1
2110 RETURN
