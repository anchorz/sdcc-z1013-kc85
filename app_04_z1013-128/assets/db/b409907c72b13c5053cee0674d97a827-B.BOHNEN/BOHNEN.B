Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   20 WINDOW:CLS:CLEAR 255
   30 WINDOW 4,23,4,31
   31 PRINT ""
   32 PRINT "                      "
   33 PRINT " 19                85 "
   34 PRINT "                  "
   35 PRINT "                "  
   36 PRINT "                "
   37 PRINT "               "
   38 PRINT "               "
   39 PRINT "                "
   40 PRINT "                "
   41 PRINT "                  "
   42 PRINT "                      "
   43 PRINT "                      "
   44 PRINT "     DAS BOHNENSPIEL  "
   45 PRINT ""
   50 PAUSE 50
  100 WINDOW:CLS:CLEAR:GOTO 110
  105 PRINT AT(X,Y);"":RETURN  
  110 GOSUB 105:IF Y<31 THEN Y=Y+1:GOTO 110 
  115 GOSUB 105:IF X<31 THEN X=X+1:GOTO 115
  120 GOSUB 105:IF Y>0 THEN Y=Y-1:GOTO 120
  125 GOSUB 105:IF X>0 THEN X=X-1:GOTO 125
  130 PRINT AT(2,10);"* BOHNENSPIEL *"
  135 PRINT AT(4,1);STRING$(30,"")
  140 PRINT AT(12,2);"Antworten Sie bitte auf meine"
  145 PRINT AT(14,2);"Fragen mit J bzw. N":PAUSE 30
  150 PRINT AT(12,1);STRING$(30," "):PRINT AT(14,1);STRING$(30," ")
  155 PRINT AT(13,5);"Anleitung erwuenscht?"
  160 A$=INKEY$:IF A$="N"THEN 295:ELSE IF A$<>"J"THEN 160
  165 WINDOW 5,30,2,30:CLS:PRINT AT(0,0);""
  170 PRINT "Vom Spieler wird die Anzahl  seiner"
  175 PRINT "Felder festgelegt.Der Gegner besitzt"
  180 PRINT "ebensoviele. Auf jedem Feld  liegen"
  185 PRINT "am Spielbeginn je 6 Bohnen.  Der"
  190 PRINT "am Zug befindliche Spieler   waehlt"
  195 PRINT "eines seiner Felder aus. Die auf"
  200 PRINT "diesem Feld liegenden Bohnen werden"
  205 PRINT "der Reihe nach auf die nach- folgenden"
  210 PRINT "Felder verteilt. Das Feld,   auf dem"
  215 PRINT "die letzte Bohne verteilt    worden"
  220 PRINT "ist,wird auf Gewinn geprueft "
  240 PRINT "Kann es weiter gehen? J/N"
  245 A$=INKEY$:IF A$<>"J"THEN 245
  246 CLS:PRINT "Liegen auf diesem Feld 2 / 4 oder 6"
  247 PRINT "Bohnen, so werden diese dem  Spieler gutgeschrieben"
  250 PRINT "Trifft das zu, werden ausser dem noch"
  255 PRINT "die vorangegangenen Felder   geprueft."
  260 PRINT "Hat ein Spieler auf seinen   Feldern"
  265 PRINT "keine Bohne mehr, und kann   deshalb""
  270 PRINT "nicht mehr verteilen,ist das Spiel"
  275 PRINT "zu Ende. Die restlichen Boh- nen gehoeren"
  280 PRINT "dem Gegner."
  285 PRINT:PRINT:PRINT "Alles klar?";
  290 A$=INKEY$:IF A$=""THEN 290
  293 IF A$<>"J"THEN 165
  295 WINDOW 5,30,2,30:CLS:PRINT AT(0,0);"":PRINT
  300 PRINT "Wollen Sie mit mir spielen?";:W=0
  305 A$=INKEY$:IF A$="J"THEN 360
  310 IF A$<>"N"THEN 305:ELSE T1$=" nimmt":T2$=T1$:W=1:X=0
  315 PRINT A$:PRINT:PRINT "Dann brauche ich aber Ihren  Namen"
  320 PRINT "und den Ihres Partners.":INPUT "Ihr Name bitte:";S1$
  325 INPUT "Ihr Partner   :";S2$:S1$=LEFT$(S1$,8):S2$=LEFT$(S2$,8)
  330 IF S1$=S2$ THEN S1$=LEFT$(S1$,7)+"1":S2$=LEFT$(S2$,7)+"2":GOTO 350
  335 INPUT "Wer will beginnen? ";A$:IF S1$=A$ THEN 375
  340 IF A$=S2$ THEN S2$=S1$:S1$=A$:GOTO 375
  345 PRINT "Entscheiden Sie sich: ";S1$;" oder ";:PRINT S2$:GOTO 335
  350 PRINT "Da Ihre Namen gleich sind, heissen":PRINT "Sie ";S1$;
  355 PRINT " und Ihr Partner ";S2$:GOTO 335
  360 PAUSE 1:PRINT A$:PRINT:PRINT "Wollen Sie beginnen?";
  365 A$=INKEY$:IF A$="J"THEN X=0:ELSE X=1:IF A$<>"N"THEN 365
  370 S2$="Ich":T2$=" nehme":S1$="Sie":T1$=" nehmen":PRINT A$
  375 PRINT:PRINT "Mit wieviel Feldern spielen  Sie?";:CALL*F6B8:PAUSE 2
  380 A$=INKEY$:IF A$<"1"OR A$>"7"THEN 380:ELSE M=VAL(A$):CALL*F6C5
  385 Y=INT((31-4*M)/(M+1)):WINDOW 1,30,1,30:CLS:Z=Y+1-(M=3 OR M=4 OR M=7)
  390 WINDOW:A=Z:FOR I=1 TO M:PRINT AT(2,A);"":PRINT AT(3,A);""+CHR$(64+I)+""
  395 PRINT AT(4,A);"":PRINT AT(5,A);"  ":PRINT AT(6,A);" 6"
  400 PRINT AT(7,A);"  ":PRINT AT(8,A);"":PRINT AT(12,A);""
  405 PRINT AT(13,A);"  ":PRINT AT(14,A);" 6":PRINT AT(15,A);"  "
  410 PRINT AT(16,A);"":PRINT AT(17,A);""+CHR$(64+M+I)+""
  415 PRINT AT(18,A);"":A=A+4+Y:NEXT:PRINT AT(20,1);STRING$(30,"")
  420 PRINT AT(27,7);S1$
  425 PRINT AT(27,23);S2$
  430 PRINT AT(25,1);STRING$(30,"")
  433 PRINT AT(28,1);STRING$(30,"")
  434 FOR I=26 TO 30:PRINT AT(I,16);"":NEXT I
  435 M=2*M:DIM Z(M):FOR I=1 TO M:Z(I)=6:NEXT:W$="":I=RND(1):IF X=1 THEN 555 
  440 IF W$=S1$ THEN W$=S2$:X$=T2$:X=1:ELSE W$=S1$:X$=T1$:X=0
  445 PRINT AT(21,1);W$+X$+" Feld" 
  450 A$=INKEY$:IF A$<CHR$(65+M*W*X/2)OR A$>=CHR$(65+M/2+M*W*X/2)THEN 450
  455 U=ASC(A$)-64:IF Z(U)=0 THEN 450:ELSE PRINT AT(21,25);A$
  460 T=Z(U):Z(U)=-1:U=U-1:IF U=0 THEN U=M
  465 U=U+1+M*(U=M):Z(U)=Z(U)+1:T=T-1:GOSUB 470:ON 1-(T>=0)GOTO 480,465
  470 PRINT AT(6-8*(U>M/2),Z+1+(4+Y)*(U-1+M/2*(U>M/2)));RIGHT$(STR$(Z(U)),2)
  471 E1=(6-8*(U>M/2))+5:E2=(Z+1+(4+Y)*(U-1+M/2*(U>M/2))) 
  472 PRINT AT(E1,E2);"^"
  475 BEEP:PAUSE 20:PRINT AT(E1,E2);" ":RETURN
  480 PRINT AT(22,1);"Letzte Bohne auf "+CHR$(64+U)+" ->  "+RIGHT$(STR$(Z(U)),2)
  485 PAUSE 25:S=Z(U):IF S<>2 AND S<>4 AND S<>6 THEN 505
  490 PRINT AT(23,1);"GEWINN auf "+CHR$(64+U)+" -> "+RIGHT$(STR$(Z(U)),2)
  495 Z(U)=0:GOSUB 470:IF X=0 THEN N=N+S:O=N:ELSE P=P+S:O=P
  500 PRINT AT(29,8+16*X);RIGHT$(STR$(O),2):U=U-1-M*(U=1):GOTO 485
  505 PAUSE 30:FOR O=1 TO 3:PRINT AT(20+O,1);STRING$(30," "):NEXT:S=0
  510 FOR O=1 TO M/2:S=S+Z(O):NEXT:IF X+W=0 THEN ON(1-(6*M>N+P+S))GOTO 565,525
  515 IF X=1 THEN ON(1-(S=0))GOTO 440,565
  520 IF 6*M>N+P+S THEN 440:ELSE GOTO 565
  525 T=0:X=1:FOR S=M/2+1 TO M:R=0:V=S+Z(S):IF V=S THEN 550
  530 IF V>M THEN V=V-M:GOTO 530
  535 Q=INT(Z(S)/M)-(Z(V)+1)*(V<>S)
  540 IF Q=2 OR Q=4 OR Q=6 THEN R=R+Q:V=V-1-M*(V=1):GOTO 535
  545 IF R>T THEN T=R:U=S
  550 NEXT:IF T>0 THEN 560
  555 U=INT(RND(1)*M/2+1+M/2):IF Z(U)=0 THEN 555
  560 W$="Ich":PRINT AT(21,1);"Ich nehme Feld          "+CHR$(64+U):GOTO 460 
  565 IF X=1 THEN R$=S1$:ELSE R$=S2$
  570 IF W=1 THEN S$=" hat":ELSE S$=" habe":IF X=1 THEN S$=" haben"
  575 PRINT AT(21,1);R$+S$+" keine":PRINT AT(22,1);"Bohnen mehr. ENDE:":N=N+S
  577 PRINT AT(23,15);"PUNKTE"
  580 PRINT AT(23,22);RIGHT$(STR$(N),2):PRINT AT(23,26);RIGHT$(STR$(6*M-N),2)
  585 PRINT AT(24,1);"Neues Spiel?"
  590 A$=INKEY$:IF A$="J"THEN 100
  595 IF A$<>"N"THEN 590:ELSE END
