Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

1 GOSUB 600
3 S=HEX(EECE)
4 Y=PEEK(S);POKE S,175
5 PRINT"Cursor:",
6 W=INCHAR;PRINT;GOTO 400
7 GOTO 500
8 POKE S,Y
10 IF W='/' LET S=S-32
15 IF W='+' LET S=S-31
20 IF W=' ' LET S=S+32
25 IF W='-' LET S=S+33
30 IF W='L' LET S=S-1
35 IF W=',' LET S=S+31
40 IF W='>' LET S=S+1
45 IF W='P' LET S=S-33
50 Z=PEEK(S);POKE S,175
53 IF W='@' PRINT"Bildschirm loeschen";GOTO 350
55 IF W='N' GOTO 60
57 GOTO 300 
60 INPUT"Zeichenkode"K
70 IF K=0 GOTO 150
80 POKE S,K
90 GOTO 4
150 O=INCHAR
160 IF O='N' POKE S,Z;GOTO 4
170 IF O='P' POKE S,K;GOTO 4
180 IF O='V' LET K=K+1
190 IF K=256 LET K=23
200 IF O='R' LET K=K-1
210 IF K=22 LET K=255
220 POKE S,K
230 GOTO 150
300 IF W='R' GOTO 800
305 Y=Z
310 GOTO 6
350 FOR I=HEX(EC00) TO HEX(F000)
360 POKE I,32
370 NEXT I
390 GOTO 3
400 IF W='A' POKE S,K;S=S-1
405 IF W='Q' POKE S,K;S=S-33
410 IF W='D' POKE S,K;S=S+1
415 IF W='E' POKE S,K;S=S-31
420 IF W='W' POKE S,K;S=S-32
425 IF W='C' POKE S,K;S=S+33
427 IF W='Y' POKE S,K;S=S+31
430 IF W='X' POKE S,K;S=S+32
435 IF W='K' PRINT"Zeichen entspr. ",#3,Y
437 IF W='S' LET K=Y
440 GOTO 7
500 IF W='A' GOTO 10
505 IF W='Q' GOTO 10
510 IF W='D' GOTO 10
515 IF W='E' GOTO 10
520 IF W='W' GOTO 10
525 IF W='C' GOTO 10
530 IF W='Y' GOTO 10
535 IF W='X' GOTO 10
540 GOTO 8
600 POKE 27,HEX(C0)
610 POKE 28,HEX(EF)
620 POKE 29,00
630 POKE 30,HEX(F0)
640 CALL(HEX(F6D1))
650 RETURN
800 POKE 27,00
810 POKE 28,HEX(EC)
820 POKE 29,00
830 POKE 30,HEX(F0)
840 CALL(HEX(F6D1))
850 STOP