Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

    1 OUTCHAR 12
    2 PR.;PR.;PR.;PR.
    3 PR.""
    4 PR."  BLUMENWIESE  "
    5 PR.""
    6 PR.;PR.;PR."SPIELER  MUSS ZUR TURMSPITZE";PR.;PR."GELANGEN",
    7 PR." OHNE AUF DIE BLUMEN (*)";PR."ZU TRETEN !!!";PR.
    8 PR.;PR."ACHTUNG !";PR.;PR."ES KOENNEN AUCH BLUMEN GERADE"
    9 PR.;PR."IM AUFGEHEN SEIN !"
   10 POKE HEX(ED9E),24
   11 POKE HEX(EDBE),26;FORI=1 TO3000;NEXT I
   12 F.I=1TO32;OUTC.160;N.I;PR."SIND SIE STARTKLAR,DANN DRUECKEN"
   13 PR."SIE EINE TASTE AM STEUERGRIFF.";F.I=1TO32;OUTC.160;N.I
   14 W=INCHAR
   15 IF W#13 GOTO 16
   16 OUTCHAR 12
   17 TAB(224);F.I=1TO32;OUTC.166;N.I
   18 TAB(544);F.I=1TO32;OUTC.166;N.I;A=2;B=2
   20 Z=12;S=15
   21 W=24
   25 POKE HEX(EE6F),26
   30 GOSUB 500
   40 Z=A;S=B
   41 W=23
   46 GOSUB 600
   47 IF F=42 GOTO 300
   48 GOSUB 500
   50 FOR I=1 TO 5
   60 X=(RND(17)+1)
   70 Y=(RND(31)+1)
   80 IF X#12 GOTO 100
   90 IF Y=15 GOTO 60
  100 IF X#12 GOTO 120
  110 IF Y=0 GOTO 60
  120 Z=X;S=Y
  121 W=42
  130 GOSUB 500
  140 IF X#A GOTO 160
  150 IF Y=B GOTO 400
  160 NEXT I
  170 E=INC.
  180 IF E=0 GOTO 170
  190 Z=A;S=B
  191 W=120
  200 GOSUB 500
  210 IF E=09 B=B+1
  220 IF E=08 B=B-1
  230 IF E=32 A=A+1
  240 IF E=85 A=A-1
  250 IF A#12 GOTO 270
  260 IF B=15 GOTO 280
  270 GOTO 40
  280 PR.;PR."    HALLO GARTENFREUND   "
  282 PR.;PR."  IHR GEFUEHL FUER BLUMEN IST"
  284 PR.;PR."HERVORRAGEND,SIND SIE VOM FACH ?"
  290 GOSUB 700
  300 PR.;PR."     SIE  TRAMPELTIER    "
  302 PR.;PR." KOENNEN SIE NICHT AUFPASSEN,WO"
  304 PR.;PR."SIE IHRE GEHSTELZEN HINSTELLEN !"
  310 GOSUB 700
  400 PR.;PR."ES TUT MIR JA SOOO... LEI,ABER"
  402 PR.;PR."UNTER IHREM GROSSEN ZEH GING "
  404 PR.;PR."GERADE EIN NEUES ZARTES "
  406 PR.;PR."BLUEMLEIN AUF."
  410 GOSUB 700
  500 POKE((HEX(ECC0))+S+(Z*32)),W
  510 RETURN
  600 F=(PEEK((HEX(ECC0))+S+(Z*32)))
  610 RETURN
  700 FOR I=1 TO 5000
  710 NEXT I
  720 GOTO 12