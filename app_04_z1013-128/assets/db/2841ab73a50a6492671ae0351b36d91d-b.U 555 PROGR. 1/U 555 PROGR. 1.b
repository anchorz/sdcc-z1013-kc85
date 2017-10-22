Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 REM EPROMPROGRAMMIERUNG
   11 GOS.5030;OUTC.12
   15 GOS.3000;P.
   16 P."                        >ent<";W=INC.
   20 A=H.(3FF0)
   30 PO.A,6;PO.A+1,116;PO.A+2,H.(3E);PO.A+4,H.(D3);PO.A+5,H.(AD)
   40 PO.A+6,0;PO.A+7,H.(10);PO.A+8,H.(FD);PO.A+9,H.(3E)
   50 PO.A+11,H.(D3);PO.A+12,H.(AD);PO.A+13,H.(C9)
   60 OUT(174)=207;OUT(174)=0
   70 OUT(175)=207;OUT(175)=0
   80 OUT(186)=207;OUT(186)=0
   90 OUT(187)=207;OUT(187)=0
   95 OUT(173)=8
   97 G.2000
  100 F.I=1TO50;F.J=0TO3;F.K=0TO255;OUT(185)=@(J*256+K);OUT(172)=K
  110 OUT(173)=J+8;PO.16371,J;PO.16378,8+J;CALL16368;N.K;N.J;P.I;
      N.I
  130 OUT(173)=8;OUT(185)=0;OUT(172)=0
  160 GOSUB5030;OUTC.12;P.
  170 P."end of programming"
  180 OUT(0)=1
  190 P.;P.;P."put of 12 and 26 volts !";P.
  200 P."quit with >ent<",;W=INC.
  210 OUT(0)=0
  220 P.;P.;P.;P."wish You a memory-test ? (Y/N)",;W=INC.
  222 OUTC.W
  225 P.
  230 IFW='N'P.;P."end";STOP
  235 T=0
  240 OUT(187)=207;OUT(187)=255
  245 FORJ=0TO3;FORK=0TO255;A=PEEK(Q+J*256+K);OUT(172)=K
  250 OUT(173)=J+8
  255 U=IN(185);IFU#AP."error in ",;S=J*256+K;WORD(S);P."H";T=T+1
  260 NEXTK;NEXTJ
  265 P.;P.T," errors";P.
  270 P."end"
  500 STOP
 2000 REM VORSTELL
 2010 OUTC.12;P.
 2020 P."      EPROM  -  PROGRAMMING"
 2030 P.;P."             for chip  U 555"
 2040 OUT(1)=207;OUT(1)=0
 2050 OUT(0)=1;OUT(0)=0
 2060 P."--------------------------------";P.;P.
 2070 P."1. put PIO-modul at port A Z1013";P."quit with >ent<"
 2075 W=INC.
 2080 P.;P."2. input place of source";P.
 2090 INPUT"for instance HEX(B000)"Q
 2095 P.;P."place of source:",;WORD(Q);P."H"
 2096 P.;P."wait one moment please !!";FORI=0TO1023
 2097 @(I)=PEEK(Q+I);N.I
 2100 P.;P."3. put in 12 volts for /CS";P.;P."quit with >ent<"
 2110 W=INC.
 2120 P.;P."4. put in programming-voltage";P.;P."quit with >ent<"
 2130 W=INC.
 2140 OUTC.12;P.
 2150 P."BREAK only in an emergency and";P.
 2160 P."      only between >allowed< and"
 2170 P."      >forbidden< ! (time 6 sec)"
 2180 P."      with key >BREAK<";P.
 2190 P."      also put off 12 and 26 V !"
 2195 P.;P.
 2200 P."Programming-time about one hour."
 2210 P."                 (50 cycles)"
 2215 P.;P.;P.;P.;P.;P.;P.;P.
 2220 P.;P.;P.;P."start ?  (ent)",;W=INC.
 2230 GOSUB5000;OUTC.12
 2240 G.100
 3000 P."observe: programming-voltage"
 3010 P.;P."behind the B 3170 = 26 volts !"
 3020 RETURN
 4999 STOP;REM WINDOW
 5000 W=H.(1B);PO.W,H.(40);PO.H.(1C),H.(EF);PO.W+2,0;PO.W+3,240
 5010 CALLH.(F6D1)
 5020 RETURN
 5030 W=H.(1B);PO.W,0;PO.W+1,H.(EC);PO.W+2,0;PO.W+3,240
 5040 CALLH.(F6D1)
 5050 RETURN
