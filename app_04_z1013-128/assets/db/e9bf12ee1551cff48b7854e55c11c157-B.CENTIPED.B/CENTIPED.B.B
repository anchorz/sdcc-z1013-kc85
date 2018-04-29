Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

    1!**** C E N T I P E D E *****
    2!*    =================     *
    3!*                          *
    4!*BEARBEITET FUER Z1013 NACH*
    5!*JEFF MINTERS ZX81-GAME VON*
    6!*D.AMBRAS, 17.08.1990      *
    7!****************************
    8!
   10 CLEAR 300,30000:FOR I=30705 TO 30815:POKE I,0:NEXT
   20 WINDOW:GOSUB 230:GOSUB 210
   30 WA=1:SP=MA:BL=5:SC=0:LE=7:BS=NB
   40 GOSUB 90:GOSUB 60:CALL*2C18
   50 IF PEEK(30703)=255 THEN 910:ELSE 790
   60 CLS:FOR X=0 TO 30:PRINT AT(X,31);"":NEXT:DOKE 30805,-4145
   70 PRINT AT(0,0);"":PRINT AT(31,0);STRING$(32,"")
   80 FOR X=1 TO BL:PRINT AT(2*INT(RND(1)*14)+1,INT(RND(1)*28)+2);"":NEXT:RETURN
   90 DOKE 30705,9215:POKE 30703,0:POKE 30814,0
  100 DF=-5115:DOKE 30707,DF:FOR X=30709 TO 30721:POKE X,254:NEXT
  110 DOKE 30721,9215:IF WA<3 THEN EN=30723:GOTO 190
  120 LE=13:DF=DF+5:DOKE 30723,DF
  130 FOR X=30725 TO 30735:POKE X,254:NEXT
  140 IF WA>3 THEN POKE 30814,1
  150 DOKE 30735,11263:IF WA<6 THEN EN=30737:GOTO 190
  160 BL=BL+1:LE=18:DF=DF+5:DOKE 30737,DF
  170 FOR X=30739 TO 30747:POKE X,254:NEXT
  180 DOKE 30747,9215:EN=30749
  190 FOR X=EN TO EN+3:POKE X,0:NEXT:POKE 30807,0
  200 POKE 30815,SP*3:POKE 30810,LE:RETURN
  210 DIM Q$(10),N$(10):FOR X=1 TO 10:N$(X)="JCM.Software":Q$(X)=" 000000":NEXT
  220 RETURN
  230 CLS:PRINT "  Jeff Minters presents ...":PRINT:PRINT
  240 PRINT "          "
  250 PRINT "            "
  260 PRINT "               "
  270 PRINT "             "
  280 Y=10:FOR X=4 TO 19 STEP 4
  290 PRINT AT(Y,X);"":PRINT AT(Y+1,X);"":PRINT AT(Y+2,X);"":NEXT
  300 PRINT AT(Y,20);"":PRINT AT(Y+1,20);"":PRINT AT(Y+2,20);""
  310 PRINT AT(9,21);"":PRINT AT(8,20);"":PRINT AT(9,22);"":PRINT AT(8,23);""
  320 PRINT AT(17,3);"A Z1013 VERSION OF THE NEW"
  330 PRINT AT(19,11);"ARCADE GAME
  340 D=25:PRINT AT(8,20);"":PRINT AT(8,23);""
  350 FOR X=1 TO D:IF INKEY$=""THEN NEXT:GOTO 370
  360 X=D:NEXT:GOTO 410
  370 PRINT AT(8,20);"":PRINT AT(8,23);""
  380 FOR X=1 TO D:IF INKEY$=""THEN NEXT:ELSE 360
  390 IF J<3 THEN PRINT AT(25,5);"Press a key to begin ...":J=J+1:GOTO 340
  400 PRINT AT(25,5);STRING$(26," "):J=0:GOTO 340
  410 CLS:PRINT " C E N T I P E D E  is the
  420 PRINT "greatest new idea since":PRINT "Space Invaders.":PRINT
  430 PRINT " Your base is being invaded
  440 PRINT "by hostile segmented Aliens.
  450 PRINT "These Aliens aim to kill you.
  460 PRINT " If they bomb you, or you allow
  470 PRINT "them to overrun base camp,
  480 PRINT "your base will explode."
  490 PRINT " Aliens turn each time they
  500 PRINT "encounter an obstacle. If shot
  510 PRINT "in the middle, they break into
  520 PRINT "two independent halves.
  530 PRINT " You must shot all segments
  540 PRINT "before they land.":PRINT "Fire accurately.
  550 PRINT:PRINT " You must score a direct hit,
  560 PRINT "else you merely deflect the
  570 PRINT "Aliens.":GOTO 600
  580 PRINT:PRINT:PRINT TAB(16)"Press a key ..."
  590 X=RND(1):IF INKEY$=""THEN 590:ELSE CLS:RETURN
  600 GOSUB 580:PRINT "Your lazer base is moved left
  610 PRINT "and right by Cursor-keys
  620 PRINT "( <-- and --> ).":PRINT:PRINT
  630 PRINT "Use Spacebar to fire.":PRINT:PRINT
  640 PRINT " The successive waves of Aliens
  650 PRINT "get successively faster and
  660 PRINT "more difficult ...
  670 PRINT:PRINT:PRINT " A Table of scores is kept, so
  680 PRINT "competitions can easy be held.":PRINT:GOSUB 580
  690 PRINT "You may now set parameters
  700 PRINT "for the game:":PRINT:PRINT
  710 PRINT " 1) What Speed ?":PRINT "    ( 20=slow   1=blitz )"
  720 PRINT:INPUT A$:PRINT:MA=VAL(A$):IF MA<1 OR MA>INT(MA)OR MA>20 THEN 710
  730 PRINT A$ " OK.":PRINT
  740 PRINT:PRINT " 2) How many bases a game? (1-8)":PRINT "? ";
  750 A$=INKEY$:IF A$<"1"OR A$>"8"THEN 750
  760 PRINT A$:NB=VAL(A$):PRINT:PRINT A$ " OK."
  770 PRINT:PRINT:PRINT "       Prepare yourself ..."
  780 PAUSE 20:RETURN
  790 X=DEEK(30805)+4160:PRINT AT(31,X-1);"":PAUSE 3
  800 FOR PB=0 TO 4:PAUSE 1:PRINT AT(30-PB,X);"":NEXT
  810 PRINT AT(31-PB,X-1);"":PRINT AT(30-PB,X);""
  820 PRINT AT(31,X-1);"":PAUSE 3
  830 FOR PB=0 TO 4:PAUSE 1:PRINT AT(30-PB,X);" ":NEXT
  840 PRINT AT(31-PB,X-1);"":PAUSE 3
  850 PRINT AT(30-PB,X);" ":PRINT AT(31-PB,X-1);"   ":PAUSE 10:BS=BS-1
  860 IF BS=0 THEN PRINT AT(11,2);"EARTHLING.. YOU ARE DEFEATED":GOTO 900
  870 PRINT AT(11,4);"You have",BS,"base
  880 IF BS>1 THEN PRINT AT(11,19);"s left.":GOTO 900
  890 PRINT AT(11,19);" left."
  900 PAUSE 20
  910 PAUSE 10:CLS:PRINT AT(2,7);"** SCORING  X",WA,"**"
  920 SC=SC+(21-SP)*WA*(LE-PEEK(30810)):S$=STR$(SC)
  930 IF BS=0 THEN 1120
  940 IF PEEK(30703)=255 THEN WA=WA+1:SP=SP-2
  950 IF SP<1 THEN SP=1
  960 IF WA=3 OR WA=6 THEN SP=MA
  970 PRINT AT(5,4);"Your score so far :",S$:GOTO 1000
  980 FOR X=1 TO 12:PRINT AT(5,24);"     ":PAUSE 5
  990 PRINT AT(5,23);S$:PAUSE 5:NEXT:GOTO 40
 1000 WINDOW 9,31,0,31
 1010 PRINT "EARTHLING..You dare to survive.
 1020 PRINT:PRINT "    Prepare for next wave.":PRINT:PRINT
 1030 IF VW=WA THEN 1080
 1040 IF WA<>3 AND WA<>6 THEN 1080
 1050 PRINT "     EXPECT  REINFORCEMENT":VW=WA
 1060 PRINT:PRINT "  We have brought more troops 
 1070 PRINT:PRINT "     to aid our Invasion.":PRINT:PRINT
 1080 IF WA>3 THEN PRINT "  ** OUR TROOPS ARE ARMED **":PRINT
 1090 PRINT "    Delay factor now :";SP
 1100 PRINT:PRINT:PRINT "Your base camp :":PRINT
 1110 FOR F=1 TO BS:PRINT " ";:NEXT:WINDOW:GOTO 980
 1120 PRINT AT(6,7);"*** GAME OVER ***"
 1130 PRINT AT(10,5);"You scored",S$," Points.
 1140 FOR X=1 TO 10
 1150 IF VAL(Q$(X))>=VAL(S$)THEN NEXT:PAUSE 25:GOTO 1210
 1160 IF X=10 THEN 1180
 1170 FOR Y=10 TO X+1 STEP-1:Q$(Y)=Q$(Y-1):N$(Y)=N$(Y-1):NEXT
 1180 Q$(X)=S$:PRINT AT(15,0);"Enter your name for score table.
 1190 PRINT AT(18,10);"************":PRINT AT(19,10);"*          *"
 1200 PRINT AT(20,10);"************":WINDOW 19,19,10,20:INPUT "";N$(X)
 1210 WINDOW:CLS:PRINT " RANK   SCORE   PLAYER"
 1220 PRINT "*****************************
 1230 PRINT
 1240 FOR X=1 TO 10:PRINT " "X;TAB(7);Q$(X);TAB(16);N$(X):NEXT
 1250 PRINT:PRINT:PRINT:PRINT "Press P to play again, or any
 1260 PRINT:PRINT "other key for instructions
 1270 PRINT:PRINT "or reset parameters.
 1280 A$=INKEY$:IF A$=""THEN 1280
 1290 IF A$="P"THEN 20:ELSE GOSUB 410:GOTO 30
