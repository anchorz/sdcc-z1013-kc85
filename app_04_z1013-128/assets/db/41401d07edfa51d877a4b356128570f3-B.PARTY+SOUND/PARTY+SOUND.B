Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

    2 REM***      PARTY     *****
    4 REM***VON A.SCHROEDER *****
    6 REM***  HAUPTSTR.53   *****
    8 REM*** BERTSDORF/8801 *****
   10 REM************************
   12 CLEAR
   14 WINDOW:CLS
   16 GOSUB 648
   18 PRINT AT(15,15);"":PAUSE 10
   20 FOR I=1 TO 15:PRINT AT(15,16-I);"":PRINT AT(15,16+I-1);"":NEXT I
   22 PAUSE 10
   24 FOR I=0 TO 15:PRINT AT(15-I,1);""
   26 PRINT AT(15+I,1);"":NEXT I
   28 PAUSE 10
   30 FOR I=0 TO 9:PRINT AT(1+I,1);""
   32 PRINT AT(0+I,0);"                                "
   34 PRINT AT(30-I,1);""
   36 PRINT AT(31-I,1);"                               "
   38 NEXT I
   40 FOR I=10 TO 21:PRINT AT(I,0);"":PRINT AT(I,31);"":NEXT I
   42 PAUSE 10
   44 FOR I=20 TO 11 STEP-1:PRINT AT(I,1);"                              ":PAUSE 1
   46 NEXT I
   48 WINDOW 13,20,3,29
   50 PRINT "      "
   52 PRINT "              "
   54 PRINT "      "
   56 PRINT "             "
   58 PRINT "             "
   60 WINDOW
   62 GOSUB 648
   64 FOR I=0 TO 7:PRINT AT(6,0);STRING$(31,CHR$(248+I)):PAUSE 2:NEXT I
   66 PAUSE 5
   68 PRINT AT(6,0);"   -> Ein Dialogprogramm <-    " :PAUSE 5
   70 FOR I=0 TO 7:PRINT AT(8,0);STRING$(31,CHR$(248+I)):PAUSE 2:NEXT I
   72 PAUSE 5
   74 PRINT AT(8,0);"    -> von  A.Schroeder <-     "
   76 PRINT AT(31,22);"> Enter <"
   78 IF INKEY$<>CHR$(13)THEN 78
   80 CLS
   82 PRINT:PRINT "GUTEN TAG!"
   84 INPUT "Gib Jahreszahl ein:";J
   86 PRINT "GIB DEINE PKZ EIN!"
   88 INPUT " ";PK$
   90 IF LEN(PK$)<>12 THEN 86
   92 GD$=LEFT$(PK$,6)
   94 GS$=MID$(PK$,7,1)
   96 GS=VAL(GS$):GJ=VAL(MID$(GD$,5,2)):AL=J-GJ
   98 CLS
  100 PRINT
  102 PRINT
  104 IF AL<16 THEN PRINT AT(15,4);"Du bist noch zu jung!!":GOSUB 648:PAUSE 80:END
  106 IF GS<5 THEN GOTO 114
  108 PRINT "Eigentlich duerfen nur Maenner"
  110 PRINT "an der Party teilnehmen!"
  112 PRINT "Ich druecke mal ein Auge zu!"
  114 PRINT:PRINT TAB(8);"alles okay !"
  116 GOSUB 648:PAUSE 50
  118 CLS
  120 CLEAR
  122 PRINT "*******************************"
  124 PRINT "**    HERZLICH WILLKOMMEN    **"  
  126 PRINT "**  auf unserer tollen Fete  **"  
  128 PRINT STRING$(31,"*")
  130 GOSUB 648:GOSUB 590:PAUSE 20:CLS
  132 WINDOW 0,31,0,25:CLS:GOSUB 516
  134 PRINT
  136 PRINT "Bist du eingeladen?":GOSUB 506
  138 IF IN$="N"THEN PRINT:PRINT "Na macht nichts"
  140 PRINT:PRINT "K O M M  R E I N !!"
  142 PRINT:PRINT "Hast du etwas mitgebracht?":GOSUB 506
  144 IF IN$="N"THEN PRINT "Du bist mir gleich unsym- patisch gewesen!":GOTO 148
  146 PRINT "Ich bedanke mich!"
  148 PRINT:PRINT "Willst du was drinken?":GOSUB 506
  150 IF IN$="J"THEN GOSUB 526:GOTO 156
  152 GOSUB 608:PRINT "Du wirkst ziemlich gelang-weilt !"
  154 PRINT "Wenn dir etwas nicht passt,dann kannst du auch      wieder gehen!"
  156 PRINT "Fuehlst du dich wohl?":GOSUB 506
  158 IF IN$="J"AND ALK=0 THEN 178
  160 IF IN$="J"AND ALK>0 THEN 166
  162 IF IN$="N"THEN PRINT "Ich frage mich,was du"
  164 PRINT "da auf der Party willst!":PAUSE 10:GOTO 178
  166 PRINT "Kommt das vom Alkohol?":GOSUB 506
  168 IF IN$="N"THEN 178
  170 IF IN$="J"THEN PRINT "Dann trink doch noch was!":PRINT
  172 PRINT "Willst du?":GOSUB 506
  174 IF IN$="N"THEN PRINT "Na dann nicht!":GOSUB 608:GOTO 178
  176 IF IN$="J"THEN GOSUB 526
  178 PAUSE 30:ANL=ANL+1:WINDOW 0,31,0,25:CLS:PRINT:PRINT TAB(5);ANL;". Anlauf"
  180 FOR I=0 TO 25:PRINT AT(2,I);"=":PAUSE 2:BEEP:NEXT I:WINDOW 3,31,0,25
  182 KK=0:AR=0:KT=0:KG=0
  184 PRINT "Hast du dich schon um-     gesehen?":GOSUB 506;
  186 IF IN$="J"THEN 192
  188 IF IN$="N"THEN PRINT "Dann wird es Zeit-oder    glaubst du,dass dir die"
  190 PRINT "Frauen von allein zu-     fliegen?!"
  192 PRINT:PRINT "Hast du schon ein tolles  Girl gesehen?":GOSUB 506
  194 GOSUB 654
  196 IF IN$="J"THEN GOTO 268
  198 PRINT "Sag bloss,die Girls ge-   fallen dir nicht!"
  200 PRINT "Das ist alles Importware!!"
  202 PRINT "Am besten du drinkst was! Willst du?":GOSUB 506
  204 IF IN$="J"THEN GOSUB 526:GOTO 212
  206 GOSUB 608
  208 PRINT "Ich glaube,du solltest dirueberlegen,ob du nicht"
  210 PRINT "lieber die Party velaesst!"
  212 PRINT "Also ich frage dich noch- mal: Gibt es ein Girl,
  214 PRINT "welches dir gefaellt?":GOSUB 506
  216 IF IN$="J"THEN 250
  218 GOSUB 654
  220 IF IN$="N"THEN PRINT "Das gibts doch nicht! Na  gut,ich werde ";
  222 PRINT "versuchen,  ein paar andere Maedchen  aufzutreiben!"
  224 PRINT "Es wird aber etwas dauern! Willst du inzwischen";
  226 PRINT "noch was drinken?":GOSUB 506
  228 IF IN$="J"THEN GOSUB 526:GOTO 238
  230 GOSUB 608
  232 PRINT "Auch nicht,wenn ich dir einen ausgebe?":GOSUB 506
  234 IF IN$="N"THEN PRINT "Aaaach l... mich!!":GOTO 238
  236 PRINT "Geizhals!!":GOSUB 526
  238 GOSUB 648:PAUSE 20:GOSUB 674:GOSUB 516:GOSUB 546
  240 PRINT "Ich konnte leider nichts  besseres auftreiben!"
  242 PRINT "Du musst also mit dem zu- frieden sein,was ich dir  ";
  244 PRINT "angeboten habe!":PRINT "Also ziehr dich nicht so!"
  246 PRINT:PRINT "Hast du dich nun endlich  fuer ein Girl ";
  248 PRINT "entschieden?":GOSUB 506
  250 IF IN$="J"THEN PRINT "e n d l i c h !!":GOTO 268
  252 PRINT "Das darf doch nicht wahr  sein!!"
  254 PRINT "Am besten du drinkst noch was.Ich geb dir auch";
  256 PRINT " einenaus.Willst du?":GOSUB 506
  258 IF IN$="J"THEN GOSUB 526:GOTO 266
  260 GOSUB 608
  262 PRINT "Mit dir ist wirklich nichtviel los!"
  264 PRINT "Na gut-Ich versuch's noch-mal mit dir!"
  266 GOTO 246
  268 PRINT:PRINT "Na dann schmeiss dich mal ran! Viel Erfolg!!"
  270 PRINT "Hast du genug Mut sie anzusprechen?":GOSUB 506
  272 IF IN$="J"THEN 282
  274 PRINT "Dann nehm erst noch einen! Willst du?":GOSUB 506
  276 IF IN$="J"THEN GOSUB 526
  278 IF IN$="N"THEN GOSUB 608
  280 PRINT "Wie steht's jetzt?":GOTO 270
  282 PRINT:PRINT "Dann sprich sie an! Laesstsie sich auf ein";
  284 PRINT " Ge-      schpraech ein?":GOSUB 506
  286 IF IN$="J"THEN 304
  288 PRINT "Du musst schon etwas      Geduld haben!"
  290 PRINT "Biete ihr doch einen Drink an! Will sie?"
  292 GOSUB 506
  294 IF IN$="J"THEN GOSUB 526:GOTO 304
  296 PRINT "Tja,da kann man nichts    machen! Lass sie sausen ";
  298 PRINT "  oder willst du's nochmal  versuchen?":GOSUB 506
  300 IF IN$="J"THEN GOTO 282
  302 PRINT "Okay! Dann auf ein neues!":GOTO 178
  304 PRINT "Na also das scheint zu    laufen.Jetzt bloss nicht";
  306 PRINT "  locker lassen!"
  308 PRINT "Fordere sie zum Tanz auf! Willst du?":GOSUB 506
  310 T=INT(3*RND(1)+1)
  312 IF IN$="N"THEN PRINT "Jetzt ziehr dich nicht so!":GOTO 308
  314 IF T=1 THEN PRINT "Du hast Glueck sie will   auch!":GOTO 330
  316 IF T=2 THEN PRINT "Pech!Ihr gefaellt das Liednicht!"
  318 IF T=3 THEN PRINT "Sie kann nicht tanzen!"
  320 IF T=2 OR T=3 THEN:KT=KT+1
  322 IF KT>3 THEN PRINT "Sie will nichts von dir!  Lass sie sausen!":PAUSE 30
  324 IF KT>3 THEN 178
  326 PRINT "Veruch es nochmal!"
  328 GOTO 308
  330 PRINT "Dann nichts wie drauf auf die Bretter,die das"
  332 PRINT "Bett bedeuten!":GOSUB 570
  334 PRINT:PRINT "Das schwierigste hast du  hinter dir.Hast du wenigs-tens";
  336 PRINT " versucht sie zu      kuessen?":GOSUB 506
  338 IF IN$="J"THEN PRINT "Du gehst ja ganz schoen   ran!":GOTO 356
  340 PRINT "Wenn du in dem Tempo wei- termachst wird das nichts!"
  342 PRINT "Versuch sie zu kuessen!   Will sie?":GOSUB 506
  344 IF IN$="J"THEN PRINT "Na bitte,der Weg in's Heiabettchen ist geebnet!"
  346 IF IN$="J"THEN 356
  348 KK=KK+1:IF KK=3 THEN PRINT "Aaach vergiss es! Die will nie!":PAUSE 10:GOTO 178
  350 PRINT "Biete ihr einen Drink an! Will sie?":GOSUB 506
  352 IF IN$="J"THEN GOSUB 526
  354 GOTO 342
  356 PRINT "Leg deinen Arm um ihre    Schultern.Hat sie was     dagegen?"
  358 GOSUB 506
  360 IF IN$="N"THEN PRINT "Du hast Glueck-sie faehrt voll auf dich ab!"
  362 IF IN$="N"THEN 368
  364 AR=AR+1:IF AR=3 THEN PRINT "Die kannst du vergessen.":GOTO 178
  366 PRINT "Versuch es nochmal!":PRINT:GOTO 356
  368 PRINT "Jetzt fahre mit der Hand  langsam nach unten,bis ";
  370 PRINT "sieauf ihrem strammen Hinternliegt! Hat sie was dage-  gen?"
  372 AR=0:GOSUB 506
  374 IF IN$="J"THEN 380
  376 IF IN$="N"THEN PRINT "Lass deine Hand die       Rundungen spueren!";
  378 PRINT "Ist das nicht herrlich.":GOTO 388
  380 PRINT "Du musst dir mehr Zeit nehmen! Biete ihr einen Drink an!"
  382 PRINT "Will sie?":GOSUB 506
  384 IF IN$="J"THEN GOSUB 526
  386 PRINT "Versuch es gleich nochmal!":GOTO 356
  388 PRINT "Jetzt versuche ihre       Brueste zu streicheln!"
  390 PRINT "Fuehlst du sie?":GOSUB 506
  392 IF IN$="N"THEN PRINT "Also so klein sind sie ja nun auch nicht!":GOTO 400
  394 PRINT:PRINT "K L A T S C H !!!":PRINT
  396 PRINT "Die hat gesessen.Haettest du das lieber fuehr spaeter ";
  398 PRINT "aufgehoben.Nun bist du sie los!":GOSUB 648:PAUSE 50:GOTO 178
  400 PRINT "Aber heb dir das lieber   auf fuehr spaeter!"
  402 PRINT "Frag sie,ob sie mit zu dir kommen wuerde! Will sie?":GOSUB 506
  404 IF IN$="J"THEN 424
  406 IF IN$="N"THEN PRINT "Ja so leicht macht sie es dir nicht!"
  408 PRINT "Biete ihr einen Drink an! Will sie?":GOSUB 506
  410 IF IN$="J"THEN GOSUB 526:GOTO 402
  412 PRINT "Frag sie ob sie tanzen moechte! Will sie?":GOSUB 506
  414 IF IN$="J"THEN GOSUB 570:GOTO 402
  416 PRINT "Ich glaube du kannst es abblasen! Oder versucht du es nochmal?"
  418 GOSUB 506
  420 IF IN$="J"THEN 402
  422 GOTO 178
  424 PRINT "Du hast Glueck,es faehrt  gerade ein Taxi vor!"
  426 PRINT "Na dann viel Spass!":GOSUB 648:PAUSE 50
  428 GOSUB 834:GOSUB 516:GOSUB 544
  430 PRINT:PRINT "        ZU HAUSE":PRINT STRING$(26,"="):WINDOW 3,31,0,25
  431 ZH=1
  432 PRINT "Frag sie,ob ihr die Woh-  nung gefaellt! Gefaellt   sie ihr?"
  434 GOSUB 506
  436 IF IN$="N"THEN 442
  438 IF IN$="J"THEN PRINT "Jetzt muss ihr nur noch   dein Bett gefallen!"
  440 GOTO 446
  442 PRINT "Na macht auch nichts.     Schliesslich wollt ihr    euch ja ";
  444 PRINT "bestimmt nicht die Wohnung angucken.Oder?"
  446 PRINT:PRINT "Biete ihr etwas zu trinken an,das enthaemmt!"
  448 PRINT "Will sie einen Drink?":GOSUB 506
  450 IF IN$="J"THEN GOSUB 526:GOTO 456
  452 PRINT "Sie will warscheinlich    einen kuehlen Kopf behal- ten.";
  454 PRINT "Das ist verdaechtig!"
  456 PRINT "Biete ihr einen Platz an. Am besten auf dem Sofa!"
  458 PRINT "Mach etwas schoene Musik  an.":GOSUB 570
  460 PRINT "Gefaellt sie ihr?":GOSUB 506
  462 IF IN$="J"THEN PRINT "Du scheinst dich auszukennen!":GOTO 468
  464 PRINT "Leg lieber was anderes auf sonst zieht es ihr noch  die";
  466 PRINT " Schuhe aus!"
  468 PRINT:PRINT "Jetzt versuch sie zu befummeln! Hat sie was dagegen?"
  470 GOSUB 506
  472 IF IN$="N"THEN 482
  474 GOSUB 770:PRINT "Nimm deinen Ring ab und versuch es nochmal!"
  476 PRINT "Laesst sie sich jetzt be- fummeln?":GOSUB 506
  478 IF IN$="J"THEN PRINT "Da hast du ja nochmal Glueck gehabt":GOTO 482
  480 PRINT "Stell dich doch nicht so bloed an!!":GOTO 476
  482 PRINT "Zieh ihr die Bluse aus!   Straeubt sie sich?":GOSUB 506
  484 IF IN$="N"THEN 488
  486 PRINT "Das ist alles bloss Getue!"
  488 PRINT "Versuch ihr die Hosen aus-zuziehen! Wehrt sie sich?":GOSUB 506
  490 IF IN$="N"THEN 494
  492 PRINT "Lass dir ruhig Zeit,du    hast sie gleich so weit!"
  494 PRINT:PRINT "Frag sie,ob sie die Pille nimmt! Nimmt sie sie?":GOSUB 506
  496 IF IN$="J"THEN 500
  498 GOSUB 806
  500 PRINT "Jetzt nichts wie rein ins Bett!!":PAUSE 30
  502 WINDOW:CLS:GOSUB 860
  504 END
  506!INPUT
  508 INPUT "->";IN$
  510 IF IN$="J"OR IN$="N"THEN 514
  512 GOTO 508
  514 PRINT:RETURN
  516!ALKOHOL 1
  518 FOR I=0 TO 31:PRINT AT(I,26);"":NEXT I
  520 PRINT AT(29,27);"":PRINT AT(30,27);"Alk.%"
  522 PRINT AT(31,27);""
  524 RETURN
  526!DRINK
  528 PRINT "Willst du Alkohol?":GOSUB 506
  530 IF IN$="N"THEN K=1:GOSUB 608
  531 IF IN$<>"N"THEN K=0
  532 DATA 6,0,6,255,6,2,6,255,6,4,6,255,6,6,6,255,6,8,6,255,6,10,6,255
  534 DATA 6,12,6,255,6,14,6,255,6,16,6,255,6,18,6,255,0,0,0,0
  536 RESTORE 532:FOR I=1 TO 44:READ A:POKE 28816+I-1,A:NEXT I
  538 CALL*7000
  540 IF K=1 THEN GOTO 568
  542 ALK=ALK+1
  544 IF ALK<2 THEN PRINT AT(28,30);"":GOTO 552
  546 FOR I=1 TO ALK
  548 PRINT AT(29-I,30);"":NEXT I
  550 IF ALK>15 THEN 562
  552 IF ALK<15 THEN 568
  553 IF K=1 THEN 563
  554 FOR I=1 TO 5:PRINT AT(14,28);"  ":BEEP:PAUSE 2
  556 PRINT AT(14,28);"->":BEEP:PAUSE 2:NEXT I
  558 PRINT:PRINT "DU HAST GENUG!!"
  560 PRINT "AB SOFORT NUR NOCH LIMO!!":GOTO 568
  562 PRINT "Ich habe dich gewarnt!!":GOSUB 648:PAUSE 30:WINDOW:CLS:GOTO 564 
  563 CLS:PRINT "Du hast zuviel getrunken und bist eingeschlafen!":PAUSE 50
  564 GOSUB 744:CLS:PRINT AT(15,8);"AUF WIEDERSEHEN!":GOSUB 648
  566 GOSUB 618:END
  568 RETURN
  570!TANZ
  572 DATA 96,0,24,255,96,0,24,255,96,0,24,255,96,10,24,255
  574 DATA 96,18,24,255,96,14,1,255,96,10,11,255
  576 DATA 96,14,176,255,96,0,24,255,96,0,24,255,96,0,24,255
  578 DATA 96,10,24,255,96,18,24,255,96,14,11,255,96,10,11,255
  580 DATA 96,14,176,255,96,18,11,255,96,10,11,255,96,14,11,255
  582 DATA 96,18,11,255
  584 RESTORE 572:FOR I=1 TO 81:READ B:POKE 28816+I-1,B:NEXT I
  586 CALL*7000
  588 RETURN
  590!SOUND3
  592 DATA 48,0,6,255,48,2,6,255,48,4,6,255,48,6,6,255
  594 DATA 48,8,6,255,48,10,6,255,48,12,6,255,48,14,6,255
  596 DATA 48,16,6,255,48,18,6,255,6,18,6,255,6,18,6,255
  598 DATA 6,18,6,255,6,18,6,255,96,24,6,255,96,24,6,255
  600 DATA 96,0,6,255,96,0,18,255,96,4,6,255,0
  602 RESTORE 592:FOR I=1 TO 77:READ A:POKE 28816+I-1,A:NEXT
  604 CALL*7000
  606 RETURN
  608!KA
  610 KA=KA+1
  612 IF KA=3 THEN PRINT:PRINT "Du trinkst wohl bloss Limonade?!":PRINT
  614 IF KA=4 THEN PRINT "In deinem Alter kannst du ruhig mal was drinken!":PRINT
  616 RETURN
  618!HAENSCHEN KLEIN...
  620 DATA 96,14,48,255,112,8,16,255,112,8,48,255,96,12,48,255
  622 DATA 112,4,16,255,112,4,48,255,96,0,16,255,96,4,10,255
  624 DATA 96,8,16,255,96,10,16,255,96,14,16,255,96,14,16,255
  626 DATA 96,14,16,255,0
  628 RESTORE 620:FOR I=1 TO 53:READ A:POKE 28816+I-1,A:NEXT I
  630 CALL*7000
  632 RETURN
  634!SANDMANN..
  636 DATA 176,14,48,255,176,14,48,255,112,2,24,255,112,4,24,255
  638 DATA 176,12,48,255,176,12,48,255,176,6,48,255,192,6,24,255
  640 DATA 112,12,24,255,112,4,24,255,112,12,24,255,192,0,24,255,0
  642 RESTORE 636:FOR I=1 TO 49:READ A:POKE 28816+I-1,A:NEXT I
  644 CALL*7000
  646 RETURN
  648!KURSOR ENTF.
  650 POKE(DEEK(43)),32
  652 RETURN
  654!KEIN GIRL
  656 IF IN$="J"AND KG<>0 THEN PRINT "Jetzt hat er's!":GOTO 672
  658 IF IN$="J"THEN 672
  660 KG=KG+1
  662 IF KG<2 THEN 672
  664 IF KG=2 THEN PRINT:PRINT "Bist du falsch gepolt?":GOSUB 506
  666 IF IN$="N"THEN PRINT "Dann musst du blind sein!!":GOTO 672
  668 IF IN$="J"THEN PRINT "Ich bin verpflichtet,dich hinauszuwerfen"
  670 PAUSE 50:GOSUB 648:GOSUB 618:CLS:END
  672 RETURN
  674!AUTO
  676 WINDOW:CLS:GOSUB 648
  678 RESTORE 734
  680 FOR I=1 TO 4:READ A$:PRINT AT(19+I,9);A$:NEXT I
  682 PRINT AT(21,16);CHR$(145)
  684 PRINT AT(24,0);STRING$(31,"")
  686 PAUSE 10
  688 FOR I=31 TO 20 STEP-1
  690 PRINT AT(21,I);" "
  692 PRINT AT(22,I);" "
  694 PRINT AT(23,I);CHR$(157)," ":BEEP
  696 PAUSE 2:I=I-1
  698 PRINT AT(21,I);" "
  700 PRINT AT(22,I);" "
  702 PRINT AT(23,I);" ":BEEP
  704 PAUSE 2:NEXT I
  706 PAUSE 5
  708 PRINT AT(21,20);" ":PRINT AT(22,20);" ":PRINT AT(23,20);" "
  710 PRINT AT(21,12);""
  712 PAUSE 5
  714 FOR I=1 TO 19:CALL*7200:PRINT AT(24,0);STRING$(31,""):PAUSE 1:NEXT I
  716 PAUSE 20:PRINT AT(31,7);"30 Minuten spaeter.":PAUSE 30 
  718 PRINT AT(31,7);STRING$(19," ")
  720 RESTORE 734
  722 FOR I=1 TO 4:READ A$:PRINT AT(19+I,0);A$:NEXT I 
  724 PRINT AT(21,7);CHR$(145):PRINT AT(21,6);""
  726 FOR I=1 TO 18:CALL*721A:PAUSE 1:PRINT AT(24,0);STRING$(31,""):NEXT I
  728 PRINT AT(21,24);" "
  730 PRINT AT(21,30);"":PRINT AT(22,30);"":PRINT AT(23,30);CHR$(157)
  732 GOTO 742
  734 DATA "   "
  736 DATA "     "
  738 DATA " "
  740 DATA ""
  742 PAUSE 20:CLS:WINDOW 0,31,0,25:RETURN
  744!ZU VIEL ALKOHOL
  746 PRINT AT(28,0);STRING$(31,"")
  747 PRINT AT(30,8);"Da geht er dahin..."
  748 FOR I=30 TO 3 STEP-1
  750 J=J+1:IF J<>5 THEN 756:ELSE J=0:PRINT AT(25,I+1);" ":PRINT AT(26,I+1);" "
  752 PRINT AT(27,I-2);" ":RESTORE 532:FOR K=1 TO 44:READ A:POKE 28816+K-1,A
  754 NEXT K:CALL*7000:PRINT AT(27,I-2);"   ":GOTO 760
  756 PRINT AT(25,I);" ":PRINT AT(26,I);" ":PRINT AT(27,I-2);"   ":BEEP
  758 PAUSE 2:I=I-1
  760 PRINT AT(25,I);" ":PRINT AT(26,I);" ":PRINT AT(27,I);CHR$(157)," "
  762 PAUSE 2
  764 BEEP:NEXT I
  766 PAUSE 20
  768 RETURN
  770!HAND
  772 CLS:GOSUB 648
  774 PRINT AT(8,5);"   "
  776 PRINT AT(9,5);"   "
  778 PRINT AT(10,5);"   "
  780 PRINT AT(11,5);"   "
  782 PRINT AT(12,5);"  "
  784 PRINT AT(13,5);" ",CHR$(159),""
  786 PRINT AT(14,5);"     ",CHR$(155),"",CHR$(158),""
  788 PRINT AT(15,5);"           ",CHR$(144)
  790 PRINT AT(16,5);"          "
  792 PRINT AT(17,5);" ",CHR$(155),"        "
  794 PRINT AT(18,5); " ",CHR$(156),"       ",CHR$(153) 
  796 FOR I=1 TO 5:PRINT AT(12,10);"  ":PAUSE 2:BEEP:PRINT AT(12,10);"<-":PAUSE 2
  798 NEXT I
  800 PRINT AT(28,0);"Ich weiss,warum es"
  802 PRINT AT(29,0);"nicht klappt!"
  804 GOSUB 648:PAUSE 30:CLS:RETURN
  806!MONDO
  808 CLS:GOSUB 648
  810 FOR I=3 TO 24
  812 PRINT AT(I,7);"        "
  814 PRINT AT(I+1,7);"  "
  816 PRINT AT(I+2,7);"      "
  818 PRINT AT(I+3,7);"MONDOS"
  820 PRINT AT(I+4,7);"------"
  822 PRINT AT(I+5,7);"feucht"
  824 PRINT AT(I+6,7);"      "
  826 PRINT AT(I+7,8);STRING$(6,CHR$(158))
  828 IF I>2 THEN PRINT TAB(3);"NICHT VERGESSEN!":GOSUB 648
  830 PAUSE 2:GOSUB 648:BEEP:NEXT I
  832 GOSUB 590:PAUSE 30:CLS:RETURN
  834!TAXI
  836 WINDOW:CLS
  838 GOSUB 648:RESTORE 734
  840 FOR I=1 TO 4:READ A$:PRINT AT(19+I,20);A$:NEXT I
  842 PRINT AT(21,27);CHR$(145)
  844 PRINT AT(24,0);STRING$(31,"")
  846 FOR J=1 TO 2
  848 PRINT AT(21,30);"":PRINT AT(22,30);"":PRINT AT(23,30);CHR$(157):PAUSE 20
  850 FOR I=21 TO 23:PRINT AT(I,30);" ":NEXT I
  852 IF J=1 THEN PRINT AT(21,26);"":ELSE PRINT AT(21,23);""
  854 PAUSE 10:NEXT J
  856 FOR I=1 TO 30:CALL*7200:PAUSE 1:PRINT AT(24,0);STRING$(31,""):NEXT I:CLS
  858 RETURN
  860!BETT
  862 B=0:Z=0:O=0:WINDOW:CLS:PRINT AT(31,5);"Dann legt mal los!":GOSUB 648
  864 PRINT AT(14,12);"" 
  866 PRINT AT(15,13);CHR$(145)
  868 PRINT AT(16,10);" "
  870 PRINT AT(17,10);"",CHR$(158),""
  872 Z=Z+1:IF Z=200 THEN PAUSE 20:GOTO 932
  874 B$=INKEY$:IF B$<>CHR$(13)THEN 872
  876 BEEP
  878 PRINT AT(15,13);CHR$(159):PRINT AT(16,13);CHR$(171),""
  880 IF INKEY$=CHR$(13)THEN 880
  882 B=B+1
  884 BEEP
  886 IF B=50 THEN B=0:GOTO 910
  888 O=O+1
  890 IF O=10 THEN A$="MMM   "
  892 IF O=15 THEN A$="OOOHHH"
  894 IF O=20 THEN A$="AAAHHH"
  896 IF O=25 THEN A$="MEHR! "
  898 IF O=30 THEN A$="JAAAA "
  900 IF O=35 THEN A$="AAAHHH"
  902 IF O=40 THEN A$="MMMMMM"
  904 IF O=49 THEN A$="AAAAAA"
  905 IF O<10 THEN A$="      "
  906 PRINT AT(12,10);A$
  908 GOTO 864
  910 RESTORE 532:FOR I=1 TO 44:READ A:POKE 28816+I-1,A:NEXT I
  912 CALL*7000
  914 FOR I=1 TO 50
  916 X=INT(30*RND(1)):Y=INT(30*RND(1)):PRINT AT(X,Y);CHR$(203)
  918 PAUSE 1:NEXT I
  920 PAUSE 20:CLS
  922 PRINT "Kannst du noch?":GOSUB 506
  924 IF IN$="N"THEN 936
  926 S=INT(4*RND(1)+1)
  928 IF S=1 OR S=3 THEN PRINT "Aber sie kann nicht mehr-Du hastPech!":GOTO 936
  930 PRINT "Du hast Glueck sie will auch    nochmal!":PAUSE 30:GOTO 860
  932 CLS:PRINT "Du hast dir zu viel zeit gelas- sen.";
  934 PRINT "Sie hat keine Lust mehr!"
  936 GOSUB 648:PAUSE 70:CLS:PRINT AT(15,2);"Na dann schlaft mal schoen!"
  938 GOSUB 648:GOSUB 634:END
