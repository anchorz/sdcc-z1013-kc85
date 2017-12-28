Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 WINDOW:CLS:DIM O(151),P(151)
   20 READ C
   30 IF C=-1 THEN 200
   40 READ K,N,M
   50 FOR I=N TO M
   60 IF C=1 THEN 90
   70 PSET I,K
   80 GOTO 100
   90 PSET K,I
  100 NEXT
  110 GOTO 20
  120 DATA 0,1,5,14,1,4,2,5,0,6,5,14,1,10,3,4
  130 DATA 0,9,4,14,0,14,4,14,0,11,6,9,0,12,9,12
  140 DATA 0,17,5,14,1,4,18,21,0,22,5,14,1,10,19,20
  150 DATA 0,25,5,13,1,4,26,29,1,14,26,29,0,30,5,6,0,30,12,13
  160 DATA 0,33,5,13,1,4,34,37,0,38,5,13,1,14,34,37
  170 DATA 0,41,4,14,0,46,4,14,0,43,6,9,0,44,9,12
  180 DATA 0,49,6,12,1,4,49,53,0,54,5,13,1,14,49,53
  190 DATA 0,57,5,14,1,4,58,61,0,62,5,14,1,10,59,60,-1
  200 LOCATE 10,1:PRINT "Schlaengeln Sie sich durch die":PRINT
  210 PRINT "  Labyrinthe und erreichen Sie":PRINT
  220 PRINT "     die markierten Punkte.":PRINT
  230 BEEP:PRINT "      druecken Sie 'S4-S'"
  240 PRINT AT(25,25);""
  250 PRINT AT(26,24);"  "
  260 PRINT AT(27,23);" "
  270 PRINT AT(28,23);""
  280 PRINT AT(29,23);"":PAUSE:BEEP
  290 Q2=12:Q6=12:PU=0:TT=90
  300 IF Q2=0 THEN 880
  310 WINDOW 8,31:CLS:PRINT:PRINT:IF Q6<10 THEN 530
  320 PRINT STRING$(32,"");
  330 PRINT "                          ";
  340 PRINT "        ";
  350 PRINT " "SPC(26)" ";
  360 N$="            "
  370 PRINT N$;N$;
  380 PRINT "                  ";
  390 PRINT "          ";
  400 M$="                            ":PRINT M$;
  410 PRINT "      ";
  420 PRINT ""SPC(30)"";
  430 PRINT "      ";
  440 PRINT "                            ";
  450 PRINT "    ";
  460 PRINT M$;
  470 PRINT "              ";
  480 PRINT "                    ";
  490 PRINT "                ";
  500 PRINT "            ";
  510 PRINT "                          ";
  520 PRINT STRING$(32,"");:GOTO 580
  530 IF Q6<>4 THEN 920:ELSE PRINT STRING$(31,"");" ";
  540 FOR W=2 TO 18 STEP 2:PRINT "";SPC(29);" ";
  550 PRINT "                ";:NEXT
  560 PRINT ""SPC(29)" ";
  570 PRINT STRING$(31,"");" ";
  580 PRINT AT(13,17);""
  590 GOSUB 860:O(1)=13:O(2)=13:P(1)=17:P(2)=18
  600 Q1=1:Q3=3:Q4=9:Q5=9:LOCATE 9,0:PRINT STRING$(32," ")
  610 A=0:B=1:LOCATE 9,0:X=18:Y=13
  620 PRINT "Punkte:";SPC(10);"High:";HI:BEEP 5:GOTO 690
  630 LOCATE 9,7:PRINT PU:CALL*F130:I=PEEK(4)
  640 IF I=8 THEN B=-1:A=0
  650 IF I=9 THEN B=1:A=0
  660 IF I=85 THEN A=-1:B=0
  670 IF I=32 THEN A=1:B=0
  680 IF Y+A=U AND X+B=U2 THEN HLOAD 5,5,1:PU=PU+50:PRINT AT(U,U2);" ":GOSUB 860
  690 IF PEEK((Y+A)*32+X+B-5120)<>32 THEN 630
  700 Y=Y+A:X=X+B:PRINT AT(Y,X);""
  710 PRINT AT(Y-A,X-B);""
  720 IF PEEK((Y-A)*32+X-5120)=32 THEN 770
  730 IF PEEK(Y*32+X+1-5120)=32 THEN 770
  740 IF PEEK((Y-1)*32+X-5120)=32 THEN 770
  750 W=PEEK((Y+A)*32+X+B-5120)
  760 IF W<>32 AND W<>199 AND(X+B<>U2 AND Y+A<>U)THEN 880
  770 O(Q3)=Y:P(Q3)=X:IF Q3=TT THEN TT=TT+10:Q6=Q6-2:Q2=Q6:GOSUB 1130:GOTO 1150
  780 Q3=Q3+1:IF Q2=0 THEN Q2=Q6:GOTO 850
  790 Q2=Q2-1:PRINT AT(Q4,Q5);" ":LOCATE O(Q1),P(Q1)
  800 IF P(Q1)<P(Q1+1)THEN PRINT ""
  810 IF P(Q1)>P(Q1+1)THEN PRINT ""
  820 IF O(Q1)>O(Q1+1)THEN PRINT CHR$(154)
  830 IF O(Q1)<O(Q1+1)THEN PRINT CHR$(157)
  840 Q4=O(Q1):Q5=P(Q1):Q1=Q1+1
  850 PU=PU+1:GOTO 630
  860 U=11+INT(RND(1)*19):U2=1+INT(RND(1)*30):IF PEEK(32*U+U2-5120)<>32 THEN 860
  870 PRINT AT(U,U2);CHR$(RND(1)*4+202):RETURN
  880 GOSUB 1140:PRINT AT(9,0);"Gesamt:  ";PU
  890 IF PU>HI THEN HI=PU
  900 LOCATE 9,16
  910 INPUT "NEUES SPIEL?";R$:IF R$="J"OR R$="JA"THEN 290:ELSE WINDOW:CLS:STOP
  920 PRINT STRING$(32,"");
  930 PRINT "                            ";
  940 PRINT "            ";
  950 PRINT "                        ";
  960 PRINT "            ";
  970 PRINT "                      ";
  980 PRINT "            ";
  990 PRINT "            ";
 1000 PRINT "    "SPC(18)"    ";
 1010 PRINT "        ";
 1020 PRINT "     "SPC(18)"     ";
 1030 N$="          "
 1040 PRINT N$;N$;
 1050 PRINT "    "SPC(12)"    ";
 1060 PRINT "            ";
 1070 PRINT "  "SPC(22)"  ";
 1080 PRINT "          ";
 1090 PRINT "                          ";
 1100 PRINT "          ";
 1110 PRINT "                          ";
 1120 PRINT STRING$(32,"");:GOTO 580
 1130 FOR I=5 TO 0 STEP-1:HLOAD I,4,1:NEXT:RETURN
 1140 FOR I=0 TO 5:HLOAD I,4,1:NEXT:RETURN
 1150 PRINT AT(9,7);PU+INT(PU/5):PRINT AT(9,17);"Bonus:";INT(PU/5);" "
 1160 PU=PU+INT(PU/5):PAUSE 30:GOTO 300
