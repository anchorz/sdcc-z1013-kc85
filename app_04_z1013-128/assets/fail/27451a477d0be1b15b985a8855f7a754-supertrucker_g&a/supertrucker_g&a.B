Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

    1!PROGRAMM AUS COMODORE WELT
    2!12/89 S.88 (C)C.-D.HEINECK
    3!AENDERUNGEN U.ANPASSUNG
    4!DURCH GUIDO & AICKE
    5!DESSAU,4500(SUPERGRAFIK)
    6 WINDOW:CLS:PRINT "*** DIE GROSSE TRUCKFAHRT ***":PRINT
    7 PRINT:PRINT "DU HAST EINEN TRUCK AUF KREDIT"
    8 PRINT:PRINT "GEKAUFT.DIESEN MUSST DU AN DIE"
    9 PRINT:PRINT "BANK, IN DER STADT NEW YORK"
   10 PRINT:PRINT "ZURUECKZAHLEN.GEWINN BRINGEN"
   11 PRINT:PRINT "DIR DIE VERSCHIEDENEN PREISE"
   12 PRINT:PRINT "IN 7 VERSCHIEDENEN STAEDTEN."
   13 PRINT:PRINT "ES LAUERN GEFAHREN !"
   14 PRINT:PRINT "DIE BANK KASSIERT"
   15 PRINT:PRINT "ZINSEN.BEI 20000 DOLLAR SCHULDEN"
   16 PRINT:PRINT "WIRD DEIN TRUCK GEPFAENDET."
   17 PRINT:PRINT "VIEL GLUECK !"
   18 PRINT:PRINT "'?'=WEITER MIT 'ENTER'BZW.ZAHL"
   19 PRINT:PRINT "EINGEBEN (WENN NOETIG)."
   20 PRINT:INPUT "       >ENTER<";A$
   21 R1=0 
   22 GOSUB 363
   23 G=10*INT(RND(1)*90):SC=100*INT(RND(1)*100)
   24 IF SC<4000 OR SC>9000 THEN 23
   25 A=0:W=0:K=0:R=0:E=0:RU=0:LP=25:KE=0:XG=0:SE$="Y"
   26 GOSUB 355
   27 GOSUB 349
   28 CLS
   29 PRINT:PRINT "WILLST DU"
   30 PRINT:PRINT "KAUFEN     K"
   31 PRINT "VERKAUFEN  V"
   32 PRINT "FAHREN     F"
   33 IF SE$<>"Y"THEN 35
   34 PRINT:PRINT "ZUR BANK   B"
   35 PRINT AT(4,20);S$
   36 PRINT AT(3,10);G
   37 PRINT AT(5,10);SC
   38 PRINT AT(6,28);LP
   39 PRINT AT(11,29);D
   40 PRINT AT(13,29);W
   41 PRINT AT(15,29);K
   42 PRINT AT(17,29);R
   43 PRINT AT(19,29);J
   44 PRINT AT(11,10);P1
   45 PRINT AT(13,10);P2
   46 PRINT AT(15,10);P3
   47 PRINT AT(17,10);P4
   48 PRINT AT(19,10);P5
   49 D$=INKEY$
   50 IF SE$<>"Y"AND D$="B"THEN 49
   51 IF D$="K"AND LP>0 GOTO 56
   52 IF D$="V"AND LP<25 GOTO 82
   53 IF D$="F"GOTO 110
   54 IF D$="B"GOTO 139
   55 GOTO 49
   56 CLS:PRINT:PRINT "WAS WILLST DU":PRINT:PRINT "KAUFEN?"
   57 PRINT:PRINT "  D/W/K/R/J"
   58 K$=INKEY$:IF K$="D"OR K$="W"OR K$="K"OR K$="R"OR K$="J" THEN 59 ELSE 58
   59 IF K$="D"THEN P=P1
   60 IF K$="W"THEN P=P2
   61 IF K$="K"THEN P=P3
   62 IF K$="R"THEN P=P4
   63 IF K$="J"THEN P=P5         
   64 PRINT:PRINT "WIEVIEL WILLST":PRINT:PRINT "DU KAUFEN?"
   65 PRINT:INPUT KA
   66 IF KA>25 THEN 64
   67 IF KA>LP THEN 80
   68 IF(KA*P)>G THEN 77
   69 G=G-(KA*P)
   70 LP=LP-KA
   71 IF K$="D"THEN D=D+KA
   72 IF K$="W"THEN W=W+KA
   73 IF K$="K"THEN K=K+KA
   74 IF K$="R"THEN R=R+KA
   75 IF K$="J"THEN J=J+KA
   76 GOTO 28
   77 CLS
   78 PRINT:PRINT "DU HAST NICHT":PRINT:PRINT "GENUG GELD !"
   79 PAUSE(30):GOTO 64
   80 CLS:PRINT "DU HAST KEINEN":PRINT:PRINT "PLATZ FUER";KA;"!"
   81 PAUSE 30:GOTO 64
   82 CLS
   83 PRINT "WAS WILLST DU":PRINT:PRINT "VERKAUFEN ?"
   84 PRINT:PRINT "D/W/K/R/J"
   85 V$=INKEY$:IF V$="" THEN 85
   86 IF V$="D"THEN P=P1:GOTO 91
   87 IF V$="W"THEN P=P2:GOTO 91
   88 IF V$="K"THEN P=P3:GOTO 91
   89 IF V$="R"THEN P=P4:GOTO 91
   90 IF V$="J"THEN P=P5
   91 PRINT
   92 PRINT "WIEVIEL WILLST DU":PRINT:PRINT "VERKAUFEN ?"
   93 INPUT VN
   94 IF VN>25 THEN 91
   95 IF V$="D"AND VN>D THEN 108
   96 IF V$="W"AND VN>W THEN 108
   97 IF V$="K"AND VN>K THEN 108
   98 IF V$="J"AND VN>J THEN 108
   99 IF V$="R"AND VN>R THEN 108
  100 G=G+(P*VN):LP=LP+VN
  101 IF V$="D"THEN D=D-VN
  102 IF V$="W"THEN W=W-VN
  103 IF V$="K"THEN K=K-VN
  104 IF V$="R"THEN R=R-VN
  105 IF V$="J"THEN J=J-VN
  106 IF G>1000000 THEN 336
  107 GOTO 28
  108 CLS:PRINT:PRINT "DU HAST KEINE":PRINT:PRINT VN;"AN BORD !"
  109 PAUSE(40):GOTO 91
  110 RU=RU+1
  111 XG=0
  112 CLS
  113 PRINT:PRINT "*** STAEDTE ***"
  114 PRINT:PRINT "NEW YORK     Y"
  115 PRINT "NEW JERSEY   J"
  116 PRINT "LOS ANGELES  L"
  117 PRINT "LAS VEGAS    V"
  118 PRINT "PHOENIX      P"
  119 PRINT "DENVER       D"
  120 PRINT "MIAMI        M"
  121 SE$=INKEY$
  122 IF SE$<>"Y"AND SE$<>"J"AND SE$<>"L"AND SE$<>"V"AND SE$<>"P"THEN 124
  123 GOTO 125
  124 IF SE$<>"D"AND SE$<>"M"THEN 121
  125 IF S$="NEW YORK     "AND SE$="Y"THEN 121
  126 GOSUB 384
  127 GOSUB 355
  128 IF RU=5 OR RU=10 OR RU=15 THEN 313
  129 IF RND(1)>.22 AND RND(1)<.3 THEN 223
  130 IF RND(1)<.15 THEN 266
  131 IF RND(1)>.55 AND RND(1)<.65 THEN 286
  132 IF RND(1)>.45 AND RND(1)<.55 THEN 167
  133 IF RND(1)>.35 AND RND(1)<.45 THEN 208
  134 IF RND(1)>.80 AND SC>0 THEN 302:GOTO 128
  135 GOSUB 363
  136 SC=INT(1.12*SC)
  137 IF SC>20000 THEN 379
  138 GOTO 27
  139 CLS:PRINT "WILLST DU DEN":PRINT:PRINT "KREDIT TILGEN   T"
  140 PRINT:PRINT "ODER LEIHEN     L":PRINT
  141 LZ$=INKEY$
  142 IF LZ$<>"L"AND LZ$<>"T"THEN 141
  143 IF LZ$="L"AND XG>0 THEN 152
  144 IF LZ$="L"THEN 156
  145 CLS
  146 PRINT "WIEVIEL WILLST DU":PRINT:PRINT "ZURUECKZAHLEN"
  147 PRINT:INPUT ZU
  148 IF ZU>G OR ZU>SC THEN 145
  149 SC=SC-ZU
  150 G=G-ZU
  151 GOTO 28
  152 CLS
  153 PRINT "DU KANNST PRO FAHRT":PRINT:PRINT "NUR EINMAL LEIHEN!"
  154 PAUSE(40)
  155 GOTO 28
  156 CLS
  157 PRINT "WIEVIEL WILLST DU":PRINT:PRINT "LEIHEN";:INPUT LE
  158 XG=XG+1
  159 LI=100*INT(RND(1)*50)+1000
  160 IF LE>LI THEN 163
  161 SC=SC+LE:G=G+LE
  162 GOTO 28
  163 PRINT:PRINT "DAS LIMIT SIND":PRINT:PRINT LI;"DOLLAR !"
  164 PAUSE(40)
  165 SC=SC+LI:G=G+LI
  166 GOTO 28
  167 WINDOW 3,31,0,31:CLS:PRINT TAB(224)"    P O L I Z E I !   "
  168 PAUSE(20):PRINT:PRINT 
  169 IF KE=1 THEN 182
  170 IF RND(1)>.5 THEN 202
  171 IF LP=25 THEN 177
  172 PRINT:PRINT:PRINT
  173 PRINT "POLIZEI HAT IHRE LADUNG      "
  174 PRINT:PRINT "BESCHLAGNAHMT UND ERLEGT EIN"
  175 PAUSE(20)
  176 LP=25:D=0:W=0:R=0:K=0:J=0
  177 X=INT(RND(1)*10)+3
  178 PRINT:PRINT "BUSSGELD VON";X*75;"DOLLAR."
  179 INPUT A$
  180 G=G-75*X:IF G<0 THEN 193
  181 GOTO 135
  182 PRINT "DEIN BEIFAHRER HAT EINEN RA-"
  183 PRINT:PRINT "DARWARNER VOM SCHARZMARKT .":PAUSE(20)
  184 IF RND(1)>.25 THEN 188
  185 PRINT:PRINT "DER WARNER IST LEIDER KAPUTT !"
  186 PAUSE(20)
  187 KE=0:GOTO 172
  188 PRINT:PRINT "MIT DEM WARNER KONNTEST DU"
  189 PRINT:PRINT "DEN BULLEN ENTKOMMEN."
  190 PRINT:PRINT "GUT GEMACHT,TRUCKER !"
  191 PAUSE(30)
  192 GOTO 135
  193 PRINT:PRINT:PRINT "DA DU NICHT GENUG GELD FUER"
  194 PRINT:PRINT "DIE POLIZEI HATTEST,VERLORST":PRINT:PRINT "DU DEINEN TRUCK,"
  195 PRINT:PRINT "UM DIE RECHNUNG BEZAHLEN ZU"
  196 PRINT:PRINT "KOENNEN."
  197 PRINT:PRINT "NIMM'S LEICHT !"
  198 PRINT:INPUT "          >ENTER<";A$
  199 CLS:PRINT TAB(224)"     E  N  D  E"
  200 PRINT
  201 GOTO 343
  202 PRINT:PRINT:PRINT
  203 PRINT "DIE POLIZEI HAT UNS NICHT"
  204 PRINT:PRINT "ERWISCHT, DU KANNST DEINE"
  205 PRINT:PRINT "FAHRT FORTSETZEN."
  206 PAUSE(30)
  207 GOTO 135
  208 WINDOW 3,31,0,31:CLS:PRINT TAB(224)"    SCHLAGLOCH    ":PRINT
  209 PAUSE(10)
  210 IF RND(1)>.5 OR LP=25 THEN 219
  211 PRINT
  212 PRINT "DIE TUER IST AUFGEGANGEN UND"
  213 PRINT:PRINT "DIE HALBE LADUNG FLOG RUNTER."
  214 PRINT:PRINT "! SCHADE !"
  215 D=D-INT(D/2):W=W-INT(W/2):K=K-INT(K/2):R=R-INT(R/2):J=J-INT(J/2)
  216 LP=25-D-W-K-R-J
  217 PRINT:INPUT "         >ENTER<";A$
  218 GOTO 135
  219 PRINT:PRINT "DU KONNTEST AUSWEICHEN"
  220 PRINT:PRINT "UND DU KANNST WEITERFAHREN."
  221 PAUSE(20)
  222 GOTO 135
  223 WINDOW 3,31,0,31:CLS:PRINT TAB(224)"***  R A S T S T A E T T E ***" 
  224 PAUSE(20)
  225 IF RND(1)>.2 THEN 242
  226 IF R>0 AND RND(1)>.3 THEN 237
  227 TR=INT(RND(1)*3100):IF TR<500 THEN 227
  228 PRINT:PRINT "WAEHREND DES ESSENS HABEN"
  229 PRINT:PRINT "DIR TRICKBETRUEGER";TR;"DOLLAR":PRINT:PRINT "ABGENOMMEN!"
  230 PRINT:INPUT "        >ENTER<";A$
  231 G=G-TR:IF G<0 THEN 233
  232 GOTO 135
  233 PRINT:PRINT:PRINT "DU BIST JETZT PLEITE":PRINT:PRINT "UND MUSST DIE FAHRT"
  234 PRINT:PRINT "BEENDEN !"
  235 PAUSE(20)
  236 GOTO 197
  237 PRINT:PRINT:PRINT "WAEHREND EINES STADTBUMMELS"
  238 PRINT:PRINT "HABEN DEINE ZUFALLSBEKANNTEN "
  239 PRINT:PRINT "DEN GANZEN RUM AUSGETRUNKEN!"
  240 PAUSE(30)
  241 LP=LP+R:R=0:GOTO 135
  242 PRINT:PRINT:PRINT "WAEHREND EINES STADTBUMMELS "
  243 PRINT:PRINT "KOMMST DU AN EINER KNEIPE"
  244 PRINT:PRINT "VORBEI UND GEHST HINEIN."
  245 PAUSE(20)
  246 PRINT:PRINT "DU WIRST ZU EINEM GLUECKSSPIEL"
  247 PRINT:PRINT "AUFGEFORDERT.MACHST DU MIT ?":PRINT:PRINT "  (J/N)"
  248 MM$=INKEY$:IF MM$<>"J"AND MM$<>"N"THEN 248
  249 IF MM$="N"THEN 135
  250 GV=INT(RND(1)*10100):IF GV<1000 THEN 250
  251 GZ=INT(RND(1)*6)-1:IF GZ<=0 THEN 251
  252 PRINT:PRINT "WAEHLE ZWISCHEN DEN ZAHLEN":PRINT:PRINT "   1 UND 5 !"
  253 WN$=INKEY$:WN=VAL(WN$)
  254 IF WN< 1 OR WN > 5 THEN 253
  255 IF WN<>GZ THEN 260
  256 PRINT:PRINT "DU HAST RICHTIG GERATEN UND"
  257 PRINT:PRINT "SOMIT";GV;"DOLLAR GEWONNEN !"
  258 PAUSE(30)
  259 G=G+GV:GOTO 135
  260 PRINT:PRINT "FALSCH !! DU HAST";INT(GV/5);"DOLLAR"
  261 PRINT:PRINT "VERLOREN."
  262 PRINT:INPUT "           >ENTER<";A$
  263 G=G-INT(GV/5)
  264 IF G<0 GOTO 233
  265 GOTO 135
  266 PK=INT(RND(1)*10100)
  267 IF PK<1000 THEN 266
  268 IF KE=1 THEN 135
  269 WINDOW 3,31,0,31:CLS:PRINT TAB(224)
  270 PRINT "<<<   DER SCHWARZMARKT    >>>"
  271 PAUSE(20)
  272 PRINT:PRINT:PRINT:PRINT "AUF DEM SCHWARZMARKT BIETET DIR "
  273 PRINT "EINER EINEN RADARWARNER GEGEN ":PRINT:PRINT "POLIZEI AN."
  274 PRINT:PRINT "ER KOSTET";PK;"DOLLAR."
  275 PRINT:PRINT "MOECHTEST DU ?(J/N)"
  276 KK$=INKEY$
  277 IF KK$="J"AND G<PK THEN 283
  278 IF KK$="N"GOTO 135
  279 IF KK$="J"GOTO 281
  280 GOTO 276
  281 KE=1:G=G-PK
  282 GOTO 135
  283 PRINT:PRINT:PRINT:PRINT "DU HAST ZUWENIG GELD !"
  284 PAUSE(30)
  285 GOTO 135
  286 WINDOW 3,31,0,31:CLS:PRINT TAB(224)"+++     TRUCK IN SICHT    +++" 
  287 PRINT:PRINT "WILLST DU NAEHER HERANFAHREN":PRINT:PRINT "(J/N)"
  288 HF$=INKEY$
  289 IF HF$<>"J"AND HF$<>"N"THEN 288
  290 IF HF$="N"THEN 135
  291 IF RND(1)>.4 THEN 167
  292 VD=INT(RND(1)*10100)
  293 IF VD<1000 THEN 292
  294 PRINT
  295 PRINT:PRINT "ES IST EIN TRUCKERFREUND VON  "
  296 PRINT:PRINT "DIR.ER SCHULDETE DIR GELD"
  297 PRINT:PRINT "UND ZAHLT ES ZURUECK."
  298 PRINT:PRINT "DU BEKOMMST";VD;"DOLLAR"
  299 PRINT:INPUT A$
  300 G=G+VD
  301 GOTO 135
  302 WINDOW 3,31,0,31:CLS:PRINT:PRINT "=====    EIN GOENNER    ====="
  303 PAUSE(20)
  304 GR=100*INT(RND(1)*101)
  305 IF GR<1000 THEN 304
  306 IF GR>SC THEN GR=SC
  307 PRINT:PRINT "EIN UNBEKANNTER HAT";GR;"DOLLAR"
  308 PRINT:PRINT "VON DEINEN SCHULDEN ABBEZAHLT !"
  309 PAUSE(30)
  310 IF SC<GR THEN 312
  311 SC=SC-GR:GOTO 135
  312 SC=0:GOTO 135
  313 WINDOW 3,31,0,31:CLS:PRINT:PRINT:PRINT "-----      WERKSTATT     -----"
  314 MR=INT(RND(1)*5100)
  315 IF MR<500 OR MR>2000 THEN 314
  316 SR=INT(RND(1)*5100)
  317 IF SR<500 OR SR>2000 THEN 316
  318 RR=INT(RND(1)*5100)
  319 IF RR<200 OR RR>2000 THEN 318
  320 GR=MR+SR+RR
  321 PRINT:PRINT:PRINT "DEIN TRUCK MUSS REPARIERT"
  322 PRINT "WERDEN."
  323 PRINT:PRINT "MOTOR   ";MR
  324 PRINT "KARROSSE";SR
  325 PRINT "REIFEN  ";RR:PRINT "-------------"
  326 PRINT "GESAMT  ";GR 
  327 PRINT "============="
  328 PAUSE(30)
  329 G=G-GR
  330 IF G<0 THEN 332
  331 GOTO 135
  332 PRINT:PRINT "DA DU ZUWENIG GELD HAST,DIE"
  333 PRINT:PRINT "RECHNUNG ZU BEZAHLEN,MUSST DU"
  334 PRINT:PRINT "DIE FAHRT BEENDEN !!!"
  335 GOTO 197
  336 WINDOW:CLS:PRINT STRING$(32,"")
  337 PRINT:PRINT:PRINT "    HERZLICHEN GLUECKWUNSCH !"
  338 PRINT:PRINT:PRINT STRING$(32,"")
  339 PRINT:PRINT "DA DU UEBER 1000000 DOLLAR"
  340 PRINT:PRINT "VERDIENT HAST,KANNST DU DICH"
  341 PRINT:PRINT "ZUR RUHE SETZEN !"
  342 PRINT:PRINT "GENAUER SPIELSTAND:";G;"DOLLAR"
  343 PRINT:PRINT:PRINT "NOCH EIN SPIEL ? (J/N)":PRINT
  344 NS$=INKEY$
  345 IF NS$<>"J"AND NS$<>"N"THEN 344
  346 IF NS$="J"THEN RUN
  347 PRINT:PRINT "AUF WIEDERSEHEN !"
  348 END
  349 P1=5*INT(RND(1)*16):IF P1<5 THEN 349
  350 P2=10*INT(RND(1)*21):IF P2<50 THEN 350
  351 P3=10*INT(RND(1)*100):IF P3<300 THEN 351
  352 P4=100*INT(RND(1)*31):IF P4<500 THEN 352
  353 P5=100*INT(RND(1)*100):IF P5<1000 THEN 353
  354 RETURN
  355 IF SE$="Y"THEN S$="NEW YORK     "
  356 IF SE$="J"THEN S$="NEW JERSEY   "
  357 IF SE$="L"THEN S$="LOS ANGELES  "
  358 IF SE$="V"THEN S$="LAS VEGAS    "
  359 IF SE$="P"THEN S$="PHOENIX      "
  360 IF SE$="D"THEN S$="DENVER      "
  361 IF SE$="M"THEN S$="MIAMI       "
  362 RETURN
  363 WINDOW:CLS:WINDOW 22,31,0,31
  364 PRINT AT(0,1);"    SPEDITION FUER Z 1013"
  365 PRINT AT(1,1);"     TRUCKER" 
  366 PRINT AT(21,0);STRING$(32,"")
  367 PRINT AT(3,21);"STADT:"
  368 PRINT AT(3,1);"GUTHABEN:"
  369 PRINT AT(5,1);"SCHULDEN:"
  370 PRINT AT(6,19);"LADEPLATZ:"
  371 PRINT AT(9,1);"***PREISE***
  372 PRINT AT(9,20);"***LADUNG***
  373 PRINT AT(11,1);"DIVERSES:":PRINT AT(11,20);"DIVERSES:" 
  374 PRINT AT(13,1);"WAFFEN  :":PRINT AT(13,20);"WAFFEN  :
  375 PRINT AT(15,1);"KOHLE   :":PRINT AT(15,20);"KOHLE   :
  376 PRINT AT(17,1);"RUM     :":PRINT AT(17,20);"RUM     :
  377 PRINT AT(19,1);"JUWELEN :":PRINT AT(19,20);"JUWELEN :
  378 RETURN
  379 WINDOW:CLS:PRINT TAB(255)
  380 PRINT:PRINT "WEIL DU UEBER 20000 DOLLAR"
  381 PRINT:PRINT "SCHULDEN HAST, WIRD DEIN TRUCK"
  382 PRINT:PRINT "GEPFAENDET.ENDE DER FAHRT"
  383 GOTO 343
  384 WINDOW:CLS:R1=R1+1
  385 IF R1=5 THEN 386 ELSE 127
  386 FOR Q=1 TO 31:POKE(-5120+Q),255:POKE(-4128+Q),255 
  387 POKE(-5120+(32*Q)),255:POKE(-5089+(32*Q)),255:NEXT Q
  388 RESTORE 391:FOR Q1=1 TO 228:READ X,Y,Z
  389 PRINT AT(X,Y);CHR$(Z):NEXT Q1
  390 PRINT AT(7,23);SE$:PAUSE 66:CLS:GOSUB 425:RETURN
  391 DATA 4,4,174,4,5,158,4,6,158,4,7,158,4,8,158,4,9,158,4,10,158
  392 DATA 4,11,158,4,12,158,4,13,158,4,14,158,4,15,158,4,16,158,4,17,158
  393 DATA 4,18,158,4,19,158,4,20,158,4,21,158,4,22,158,4,23,158,4,24,158
  394 DATA 4,25,158,4,26,158,4,27,173,5,27,192,6,27,192,7,27,192,8,27,192
  395 DATA 9,27,192,10,27,192,11,27,192,12,27,192,13,27,192,14,27,172
  396 DATA 14,26,248,14,25,248,14,24,248,14,23,248,14,22,248,14,21,248
  397 DATA 14,20,248,14,19,248,14,18,248,14,17,248,14,16,248,14,15,248
  398 DATA 14,14,248,14,13,248,14,12,248,14,11,192,13,11,192,12,11,173
  399 DATA 12,10,158,12,9,158,12,8,158,12,7,174,13,7,159,14,7,159,15,7,159
  400 DATA 16,7,171,16,8,248,16,9,248,16,10,248,16,11,172,15,11,192,14,6,248
  401 DATA 14,5,248,14,4,171,13,4,159,12,4,159,11,4,159,10,4,159,9,4,159,8,4
  402 DATA 159,7,4,159,6,4,159,5,4,159,13,10,173,14,10,192,15,10,172,15,9,248
  403 DATA 15,8,171,14,8,159,13,8,174,13,9,158,6,28,145,7,29,158,7,30,158
  404 DATA 11,30,248,11,29,248,11,28,192,10,28,192,9,28,192,8,28,192,7,28,192
  405 DATA 12,28,144,6,3,144,7,3,159,8,3,159,9,3,159,10,3,159,11,3,159,12,2,158
  406 DATA 12,1,158,7,1,158,7,2,158,12,3,145,14,9,201,13,5,144,12,6,144,11,7
  407 DATA 144,10,8,144,9,9,144,8,10,144,7,11,144,6,12,144,5,13,144,13,26
  408 DATA 145,12,25,145,11,24,145,10,23,145,9,22,145,7,20,145
  409 DATA 6,19,145,5,18,145,5,20,168,5,21,160,5,22,160,5,23,160,5,24,160
  410 DATA 5,25,160,5,26,169,6,26,161,7,26,161,8,26,161,9,26,170,9,25,164,9,24
  411 DATA 160,9,23,160,9,22,160,9,21,164,9,20,167,8,20,161,7,20,161,6,20
  412 DATA 161,10,25,161,10,21,161,16,5,141,16,13,141,16,14,139,16,15,139,16,16
  413 DATA 138,15,17,255,15,18,255,15,19,255,15,20,255,15,21,255,16,21,255,16
  414 DATA 20,169,16,19,164,16,18,168,16,17,255,17,17,255,17,18,255,17,19,161
  415 DATA 17,20,255,17,21,255,18,21,255,18,20,255,18,19,161,18,18,255,18,17
  416 DATA 255,19,17,255,19,18,255,19,19,161,19,20,255,19,21,255,20,19,161,21
  417 DATA 19,161,22,19,255,23,19,255,22,18,174,22,20,173,23,18,159,23,20,192
  418 DATA 17,9,255,18,9,255,19,9,255,20,9,255,21,9,255,22,9,255,23,9,255,22,7
  419 DATA 255,23,7,255,22,11,255,23,11,255,22,13,255,23,13,255,22,14,181,23,14
  420 DATA 181,22,15,180,23,15,180,11,10,144,10,11,144,10,12,158,10,13,158,10
  421 DATA 14,158,9,14,21,10,15,158,10,16,158,10,17,145,11,18,145,12,19,145,13
  422 DATA 20,145,14,21,145,11,13,144,11,14,161,11,15,145,13,17,145,13,14,161
  423 DATA 12,14,161,4,12,194,4,13,195,4,14,195,5,15,180,6,15,180,8,15,180
  424 DATA 9,15,180
  425 R1=0:RETURN
