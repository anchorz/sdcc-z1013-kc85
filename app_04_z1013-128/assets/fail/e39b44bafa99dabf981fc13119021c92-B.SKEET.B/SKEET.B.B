Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

    5 A$="Mikrorechnerbausatz -Z1013-"
   10 A2$="SPIELPROGRAMM"   
   15 A4$="SKEET"     
   20 A5$="WURFTAUBENSCHIESSEN"
   25 WINDOW:CLS:PRINT AT(0,0);" "
   30 PRINT AT(2,2);A$  
   35 PRINT AT(4,0);"",STRING$(29,""),"" 
   40 PRINT AT(5,0);"":PRINT AT(5,30);""         
   45 PRINT AT(6,0);"",STRING$(29,""),""     
   50 PRINT AT(5,2);A2$
   55 PRINT AT(8,0);STRING$(31,"")
   60 FOR I=9 TO 13:PRINT AT(I,0);"":PRINT AT(I,30);"":NEXT I     
   65 PRINT AT(14,0);STRING$(31,"") 
   70 PRINT AT(10,29-LEN(A4$));A4$:PRINT AT(12,29-LEN(A5$));A5$    
   75 PRINT AT(19,2);"* VEB ROBOTRON-ELEKTRONIK *    
   80 PRINT AT(21,13);"RIESA" 
   85 PRINT AT(30,22);">ENTER<"
   90 T$=INKEY$:IF T$=""THEN 90
  220 O(0)=201:O(1)=207:O(2)=195:O(3)=166:O(4)=140
  235 WINDOW:CLS:PRINT AT(0,0);" "
  240 M$="N"
  250 PRINT AT(3,0);"DURCH DRUECKEN DER TASTE >SPACE<"
  260 PRINT AT(5,0);"MUESSEN SIE DIE ANFLIEGENDEN"
  270 PRINT AT(7,0);"WURFTAUBEN ABSCHIESSEN."
  288 PRINT AT(10,0);"WAEHLEN SIE BITTE"
  290 PRINT AT(12,0);"SCHWIERIGKEITSSTUFE 1 ODER 2"
  291 PRINT AT(14,0);"UND WARTEN SIE"
  292 PRINT AT(16,0);"EINIGE SEKUNDEN.":PRINT AT(22,0);"STUFE: (1)/2":M$="1"
  300 WINDOW 22,22,15,31:INPUT "";M$
  301 IF M$="1"OR M$="2"THEN PAUSE 10:WINDOW:CLS:PRINT AT(0,0);" ":GOTO 310
  302 PRINT AT(20,0);"WIE BITTE ?":GOTO 300
  310 PRINT AT(8,3);"ACHTUNG...":FOR I=1 TO 120:NEXT:PRINT AT(10,3);"FERTIG..."
  320 FOR I=1 TO 100:NEXT:PRINT AT(12,3);"LOS!!!":FOR I=1 TO 60:NEXT
  450 CLS:PRINT AT(0,0);" ":A=0:B=0
  460 PRINT AT(8,1);"TAUBEN :",A
  470 PRINT AT(10,1);"TREFFER:",B
  480 POKE 5,0
  490 N=INT(RND(1)*6.8):IF(N=C)OR(N=0)GOTO 490 ELSE C=N
  510 IF M$="1"GOTO 570
  520 L=INT(RND(1)*5.8)+1:ON L GOTO 530,540,550,560,565,570
  530 Z=-4149:GOTO 580
  540 Z=-4147:GOTO 580
  550 Z=-4143:GOTO 580
  560 Z=-4141:GOTO 580
  565 Z=-4139:GOTO 580
  570 Z=-4145
  580 V=INT(RND(1)*4.9):P=INT(RND(1)*5.9)
  600 ON C GOTO 660,670,680,690,700,710
  660 E=-4480:F=E+31:G=1:GOTO 720
  670 E=-4449:F=E-31:G=-1:GOTO 720
  680 E=-4641:F=E-31:G=-1:GOTO 720
  690 E=-4672:F=E+31:G=1:GOTO 720  
  700 E=-4960:F=E+(27*33):G=33:GOTO 720
  710 E=-4961:F=E+(27*31):G=31:GOTO 720
  720 FOR I=-4117 TO-4106:POKE I,32:NEXT I:FOR I=1 TO 200:NEXT I
  760 FZ=Z:A=A+1:X=0:POKE FZ+32,204
  770 FOR K=E TO F STEP G
  790 POKE K-G,32:POKE K,O(V):IF K=F THEN POKE K,32
  800 IF K=Z GOTO 930
  810 IF X<>0 GOTO 840
  820 IC=PEEK(5)          
  830 IF IC<>32 THEN 880 ELSE X=1
  840 IF Z<-5040 THEN POKE Z,32:GOTO 880
  850 Z=Z-64:POKE Z,58:POKE Z+64,32:IF Z=K GOTO 930
  880 NEXT K
  890 POKE Z,32:IF A=50 THEN 1110 ELSE 460
  930 B=B+1
  950 POKE K,202:POKE K+2,42
  970 POKE K-2,42:POKE K+32,42
  990 POKE K-32,42:POKE K+66,42
 1010 POKE K-66,42:POKE K-70,42
 1030 POKE K- 6,42:POKE K+70,42
 1040 FOR I=1 TO 150:NEXT I
 1050 POKE K,32:POKE K+2,32
 1060 POKE K-32,32:POKE K+32,32
 1070 POKE K-2,32:POKE K+66,32
 1080 POKE K+70,32:POKE K-66,32
 1090 POKE K-70,32:POKE K- 6,32
 1100 IF A<50 GOTO 460
 1110 FOR I=-4117 TO-4106:POKE I,32:NEXT I
 1120 CLS:PRINT AT(0,0);" "
 1130 PRINT AT(3,2);"SIE HABEN BEI"
 1140 PRINT AT(5,1);A,"TAUBEN"
 1150 PRINT AT(7,1);B,"MAL GETROFFEN !"
 1160 IF B>12 GOTO 1270
 1170 IF M$="1"GOTO 1230
 1180 PRINT AT(10,1);"SIE HABEN SICH FUER DEN ANFANG"
 1190 PRINT AT(12,1);"ZUVIEL VORGENOMMEN, VERSUCHEN"
 1200 PRINT AT(14,1);"SIE ES DOCH EINMAL MIT DER"
 1210 PRINT AT(16,1);"EINFACHEN VARIANTE."
 1220 GOTO 1450
 1230 PRINT AT(10,1);"ES IST ZWECKLOS MIT IHNEN,"
 1240 PRINT AT(12,1);"SIE SOLLTEN LIEBER MIT"
 1250 PRINT AT(14,1);"MURMELN SPIELEN !"
 1260 GOTO 1450
 1270 IF B>18 GOTO 1320
 1280 PRINT AT(10,1);"SIE SOLLTEN WENIGER TRINKEN,"
 1290 PRINT AT(12,1);"BEVOR SIE SICH AN SOLCH EIN"
 1300 PRINT AT(14,1);"SCHWIERIGES SPIEL HERANWAGEN."
 1310 GOTO 1450
 1320 IF B>25 GOTO 1340
 1330 PRINT AT(10,1);"NA JA...!":GOTO 1450
 1340 IF B>35 GOTO 1380
 1350 PRINT AT(10,1);"NICHT SCHLECHT, SIE MACHEN"
 1360 PRINT AT(12,1);"SICH LANGSAM !"
 1370 GOTO 1450
 1380 FOR J=0 TO 31:PRINT AT(0,J);CHR$(203):NEXT
 1390 FOR J=1 TO 31:PRINT AT(J,31);CHR$(203):NEXT 
 1400 FOR J=0 TO 31:PRINT AT(31,31-J);CHR$(203):NEXT
 1410 FOR J= 0 TO 31:PRINT AT(31-J,0);CHR$(203):NEXT
 1420 PRINT AT(10,2);"HERVORRAGEND, SIE SIND EIN"
 1430 PRINT AT(12,2);"MEISTERSCHUETZE, SIE KOENNEN"
 1440 PRINT AT(14,2);"EINEN AUSGEBEN !!!"
 1450 PRINT AT(22,5);"NOCH EINMAL: (J)/N "   
 1460 J$=INKEY$:IF J$=""GOTO 1460 
 1461 IF ASC(J$)=13 OR J$="J"THEN INK 7:CLS:GOTO 290
 1480 CLS:PRINT INK 1;AT(0,0);" ":PRINT INK 3;AT(12,7);"AUF WIEDERSEHEN !"
 1490 PAUSE 30:CLS 
 1500 END
