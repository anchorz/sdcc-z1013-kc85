Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

    1 A$="KLEINCOMPUTER robotron Z1013"
    2 A2$="SPIEL"
    3 A3$="R+HANOI"
    4 A4$="TURM":A5$="VON HANOI"
    8! VERSION 2, 6.6.86 --
   10 BORDER 2:PAPER 1:INK 8:WINDOW:CLS:PRINT AT(0,0);" "
   11 PRINT AT(1,2);A$
   12 PRINT AT(2,2);A1$:PRINT AT(4,2);"",STRING$(26,""),""
   13 PRINT AT(5,2);"":PRINT AT(5,29);""
   14 PRINT AT(6,2);"",STRING$(26,""),"" 
   15 PRINT AT(5,3);A2$:PRINT INK 3;AT(5,21);A3$
   16 INK 2:PRINT AT(8,2);STRING$(28,"")
   17 FOR I=9 TO 13:PRINT AT(I,2);"":PRINT AT(I,29);"":NEXT I
   18 PRINT AT(14,2);STRING$(28,"")
   19 INK 8:PRINT AT(10,28-LEN(A4$));A4$:PRINT AT(12,28-LEN(A5$));A5$
   20 INK 3:PRINT AT(17,2);"VEB ROBOTRON-MESSELEKTRONIK "
   21 PRINT AT(19,2);">OTTO SCHOEN< DRESDEN":INK 8
   45 PRINT INK 4;AT(22,23);">ENTER<"
   46 IF INKEY$<>CHR$(13) THEN 46
   50! INIT. --
   70 DIM T$(5),P(5,2)
   80 GOSUB 1000
  100 INK 4:PAPER 5:WINDOW:CLS
  110 N=0
  150 PRINT:PRINT "T U R M   V O N   H A N O I"
  160 PRINT:PRINT STRING$(31,"*")
  170 PRINT:PRINT:PRINT TAB(3);1;TAB(13);2;TAB(23);3:PRINT
  175 WINDOW 9,23,0,31
  180! 1.TURM --
  185 FOR I=1 TO 5:PRINT T$(I):P(I,0)=I:P(I,1)=0:P(I,2)=0:NEXT I
  208! ABFRAGE --
  210 WINDOW 17,23,0,31:PAPER 1:INK 4:CLS:PRINT
  220 PRINT "Sie starten jetzt den Versuch";N+1 
  230 PRINT AT(20,1);"Transport von Position :":WINDOW 20,20,26,31
  232 X$=INKEY$:INPUT "";A:PRINT A;
  235 IF A<1 OR A>3 THEN 280
  240 PRINT AT(22,1);"Transport nach Position:":WINDOW 22,22,26,31
  245 X$=INKEY$:INPUT "";B:PRINT B;
  250 IF B<1 OR B>3 THEN 280:ELSE 300
  280 WINDOW 17,23,0,31:GOSUB 1200:GOTO 210  :! FEHLER --
  300! VERSUCH --
  310 N=N+1:A1=A-1:B1=B-1:V=0
  320 FOR I=1 TO 5
  330 IF P(I,A1)>0 THEN V=I:VS=P(I,A1):I=5
  340 NEXT I
  360 IF V=0 THEN 540
  390 W=5:WU=6
  400 FOR I=1 TO 5
  410 IF P(I,B1)>0 THEN W=I-1:WU=P(I,B1): I=5
  420 NEXT I
  450 IF VS<WU OR W=5 THEN 460
  455 WINDOW 17,23,0,31:GOSUB 1500:GOTO 540  :! FEHLER --
  460 P(W,B1)=VS:P(V,A1)=0
  500! UMSETZEN --
  502 INK 4:PAPER 5
  510 A=A1*10:B=B1*10
  520 PRINT AT(8+V,A);T$(0)
  530 PRINT AT(8+W,B);T$(VS)
  540 IF P(1,2)=1 OR N>=80 THEN PAUSE 20:GOTO 600:ELSE 210
  600! AUSWERTUNG ---
  630 PAPER 5:INK 8:WINDOW:CLS:IF N>31 GOTO 690
  660 CLS:PRINT TAB(92)"FAST UNMOEGLICH !"
  670 PRINT TAB(80)"31 Zuege sind das minimal Erreichbare !"
  680 GOTO 890
  690 IF N>35 THEN 750
  700 PRINT:PRINT "  Geben Sie zu, dass Sie nicht"
  710 PRINT:PRINT "  allein gespielt haben!  Fuer eine"
  720 PRINT:PRINT "  Einzelperson sind Sie zu schlau !"
  740 GOTO 890
  750 IF N>40 THEN 790
  760 PRINT:PRINT "  Sie sind schon ganz gut."
  770 PRINT:PRINT "  Ihnen fehlt nur etwas Uebung."
  780 GOTO 890
  790 IF N>=80 THEN 930
  800 PRINT:PRINT "  Verlieren Sie bloss nicht die Nerven!!"
  810 PRINT:PRINT "  Konzentrieren Sie sich, vielleicht"
  820 PRINT:PRINT "  wird noch 'was Brauchbares aus Ihnen !"
  890 PRINT:PRINT:PRINT:W$="J":INPUT "  Neues Spiel: (J)/N ";W$
  900 IF W$="J"THEN 920
  910 PAPER 1:INK 7:CLS:PRINT AT(0,0);" ":PRINT AT(12,11);"Auf Wiedersehen !"
  915 PAUSE 30:CLS:END  :!ENDE--------
  920 IF N>60 THEN 930:ELSE 100
  930 BORDER 1:PAPER 1:INK 4:CLS:PRINT AT(0,0);" "
  940 PRINT AT(2,0);"Sie, Sie...Sie waren es, der mich eben"
  950 PRINT AT(5,0);"mit",N,"Versuchen gequaelt hat."
  960 PRINT AT(8,0);"I C H   W I L L   N I C H T   M E H R  !"
  970 PAUSE 90:CLS:END
 1000 T$(0)="         "
 1010 T$(1)="        "
 1020 T$(2)="      "
 1030 T$(3)="    "
 1040 T$(4)="  "
 1050 T$(5)=""
 1060 RETURN
 1200! FEHLER
 1210 INK 2:CLS:PRINT AT(17,0);" ":BEEP
 1220 PRINT AT(19,8);"Wo soll denn das sein ?":PAUSE 30
 1230 RETURN
 1500 INK 2:CLS:PRINT AT(17,0);" ":BEEP
 1505 PRINT AT(18,13);"F E H L E R !"
 1510 PRINT AT(20,13);"Regel beachten !":PAUSE 30
 1530 RETURN
