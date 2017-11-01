Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

 9000 REM HEX-DUMP-INPUT-MC
 9010 WINDOW:CLS:G=32768:PRINT        "MC-PROGRAMM-ERSTELLER":        PRINT
 9020 DEF FN I(I)=ASC(MID$(A$,I,1     ))-48+7*(MID$(A$,I,1)>"9")
 9030 INPUT                           "STARTADRESSE (HEX.) :";A$
 9040 GOSUB 9350:ST=AD
 9050 INPUT                           "ENDADRESSE   (HEX.) :";A$
 9060 GOSUB 9350:EN=AD:PRINT
 9070 FOR AD=ST TO EN
 9080 D=AD:AB=D:H$=" "
 9090 FOR I=3 TO 0 STEP -1
 9100  H=INT(D/16^I):                  D=D-H*16^I
 9110  H$=H$+CHR$(48-7*(H>9)+H)
 9120 NEXT I
 9130 PRINT CHR$(8);H$;" ";:           SU=0
 9140 FOR B=0 TO 7:BY=0
 9150  FOR Z=1 TO 2
 9160   A$=INKEY$:                      IF A$<"0" THEN 9160
 9170   BY=FN I(1)+16*BY:               PRINT A$;
 9180  NEXT Z
 9190  IF BY>255 THEN 9290
 9200  IF AD<G THEN POKE AD,BY:                     GOTO 9220
 9220  AD=AD+1:SU=SU+BY
 9230 NEXT B:PRINT "   ";
 9232 FOR B=8 TO 1 STEP -1:            B1=PEEK(AD-B)
 9234  IF B1<32 OR B1>127               THEN B1=46
 9236  PRINT CHR$(B1);:               NEXT B
 9238 PRINT SPC(18);"-> ";:            PS=0
 9240 FOR Z=1 TO 3
 9250  A$=INKEY$:                      IF A$<"0" THEN 9250
 9260  PS=FN I(1)+16*PS:               PRINT A$;
 9270 NEXT Z
 9280 PRINT:IF PS=SU THEN 9310
 9290 PRINT:PRINT TAB(5);             "--- ERROR ---"
 9300 AD=AB:GOTO 9080
 9310 AD=AD-1
 9320 NEXT AD
 9330 PRINT:PRINT "--- ENDE ---":      PRINT:END
 9340 REM (C) 1988                    Dr. H. Gutzer/S. Wendt
 9350! s. FUNKAMATEUR 2/88                 Seite 68
 9360 FOR I=1 TO LEN(A$)
 9370 AD=FN I(I)+16*AD
 9380 NEXT I
 9390 RETURN
