Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 CLS
   20 PRINT AT(11,1);""                               
   30 PRINT AT(12,0);"                            "
   40 PRINT AT(13,0);"        "
   50 PRINT AT(14,0);"                  " 
   60 PRINT AT(15,0);"               "
   70 PRINT AT(16,0);"                  " 
   80 PRINT AT(17,0);"              "
   90 PRINT AT(18,0);" "                         
   99 PAUSE 40
  100 CLS:M=0:S=0
  110 PRINT AT(1,7);"*1988-J.H.-SOFT*"
  120 PRINT AT(3,5);"     TORERO":PRINT AT(4,5);"      TORERO"              
  130 PRINT AT(5,5);"       TORERO":PRINT AT(6,5);"      TORERO"
  140 PRINT AT(7,5);"     TORERO":PRINT AT(8,5);"      TORERO"
  150 PRINT AT(9,3);"     TORERO"  
  151 PRINT AT(10,3);"      TORERO
  160 PRINT AT(11,3);"       TORERO"     
  170 PRINT AT(12,3);"        TORERO"    
  180 PRINT AT(13,3);"         TORERO"    
  190 PRINT AT(14,5);"                TORERO"     
  200 PRINT AT(15,5);"                 TORERO"      
  210 PRINT AT(16,5);"                  TORERO"
  220 PRINT AT(17,5);"                   TORERO"   
  240 PRINT AT(19,1);"Ein TORERO soll in einer Arena"
  250 PRINT AT(20,1);"einen STIER bezwingen.Der"      
  260 PRINT AT(21,1);"Torero muss sein rotes Tuch"
  270 PRINT AT(22,1);"10mal ueber den Stier werfen."  
  280 PRINT AT(23,1);"Sieger ist der,der die kuer-"
  290 PRINT AT(24,1);"zeste Zeit dazu braucht.Der"
  300 PRINT AT(25,1);"Torero wird mit =hoch;=run-"   
  310 PRINT AT(26,1);"ter;=links;=rechts gelenkt."
  320 PRINT AT(27,1);"Der Stier kann nicht gelenkt
  330 PRINT AT(28,1);"werden." 
  340 PRINT AT(29,25);"<ENT>"
  351 A$=INKEY$:IF A$=""GOTO 351
  352 G=0
  353 A=-4655  
  360 IF G=10 THEN PAUSE 20:CLS:GOTO 1500
  370 CLS:PRINT AT(1,3);"TIME:          PUNKTE:":PRINT AT(1,25);G
  380 PRINT AT(3,3);"=TORERO  =TUCH   =STIER":PRINT AT(3,21);CHR$(20)
  390 FOR L=2 TO 28:PRINT AT(5,L);CHR$(21):PRINT AT(28,L);CHR$(21):NEXT
  400 FOR K=6 TO 27:PRINT AT(K,2);CHR$(21):PRINT AT(K,28);CHR$(21):NEXT
  630 DOKE A,-15105      
  700 X=16:Y=8
  710 IF X<7 OR X>27 THEN GOTO 700
  720 IF Y<4 OR Y>27 THEN GOTO 700
  730 PRINT AT(X,Y);CHR$(20):GOSUB 2000:IF(-5120+X*32+Y)=A GOTO 1300
  735 GOTO 1010
  740 PRINT AT(X,Y);" ":R=INT(16*(RND(1))+1)
  750 ON R GOTO 800,850,900,950,810,820,830,840,860,870,880,890,910,920,930,940
  800 X=X-1:GOTO 710
  810 Y=Y+2:GOTO 710
  820 Y=Y-2:GOTO 710
  830 X=X+2:GOTO 710
  840 X=X-2:GOTO 710
  850 X=X+1:GOTO 710
  860 X=X-1:Y=Y+1:GOTO 710
  870 X=X-1:Y=Y-1:GOTO 710
  880 X=X+1:Y=Y+1:GOTO 710
  890 X=X+1:Y=Y-1:GOTO 710
  900 Y=Y+1:GOTO 710
  910 X=X-2:Y=Y+2:GOTO 710
  920 X=X-2:Y=Y-2:GOTO 710
  930 X=X+2:Y=Y+2:GOTO 710
  940 X=X+2:Y=Y-2:GOTO 710
  950 Y=Y-1:GOTO 710 
  999 IF PEEK(A)=20 GOTO 1300
 1000 DOKE A,-15105:GOTO 740
 1010 P$=INKEY$:IF P$=""THEN PAUSE 1:GOTO 740 
 1020 DOKE A,8224:IF P$=CHR$(11)THEN A=A-32:GOTO 999
 1030 IF P$=CHR$(10)THEN A=A+32:GOTO 999
 1040 IF P$=CHR$(8)THEN A=A-1:GOTO 999
 1050 IF P$=CHR$(9)THEN A=A+1:GOTO 999
 1100 GOTO 999
 1300 G=G+1:GOTO 353
 1500 PAUSE 20:CLS
 1510 PRINT AT(5,2);"Sie haben in einer Zeit von:" 
 1511 GOSUB 2300
 1520 PRINT AT(6,9);"ihr Tuch 10mal ueber
 1530 PRINT AT(7,2);"den Stier geworfen."
 1540 PRINT AT(11,4);"NOCHEINMAL:J/N"
 1545 W$=INKEY$:IF W$=""GOTO 1545
 1550 IF W$="N"GOTO 2500
 1555 IF W$="J"GOTO 100
 1556 GOTO 1540
 1560 IF W$<>"J"OR W$<>"N"GOTO 1540
 2000 PRINT AT(1,9);M:PRINT AT(1,13);S
 2010 S=S+1:IF S=60 THEN M=M+1:S=0
 2020 IF M=60 THEN H=H+1:M=0
 2040 RETURN
 2300 PRINT AT(6,1);M:PRINT AT(6,4);S:RETURN
 2500 PAUSE 10:CLS
 2510 PRINT AT(13,8);"AUF WIEDERSEHEN!":PAUSE 20:CLS:END
