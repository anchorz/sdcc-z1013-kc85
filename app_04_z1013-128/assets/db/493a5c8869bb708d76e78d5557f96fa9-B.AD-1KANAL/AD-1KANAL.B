Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10!Programm laeuft mit Grundspeicher 16K
   20!Das E/A Modul ist fuer dieses Programm erforderlich!
   30 CLS
   40 PRINT AT(3,8);"Digitalvoltmeter" 
   50 PRINT AT(6,10);"1 Kanal" 
   60!AD-Wandlerroutine nach RFE4/88 ;vor AD7 Transfer von HL(MW) nach 3F80  
   70 GOSUB 250
   90!Aufruf AD-Wandler
  100 CALL* 3F00
  110!Messwert wird aus Speicher-Adr 3F80 geholt
  120 M=PEEK(16256):N=PEEK(16257)
  130!Meswert wird umgerechnet
  140 N=N*256:MW=M+N
  160 PRINT AT(9,9);"       "
  165!Messwert wird ausgegeben und ensprechen dem Messbereich umgerechnet
  170 PRINT AT(9,0);"Messwert":PRINT AT(9,9);MW/1000 
  180 PRINT AT(9,18);"Volt"
  185 IF MW>19999 THEN PRINT AT(12,4);"Messbereichsueberschreitung"          
  186 IF MW<20000 THEN PRINT AT(12,4);"                            " 
  200 PRINT AT(16,3);"Messung wird wiederholt": 
  210 PRINT AT(18,3);"Unterbrechen mit S4/K!":GOTO 100
  240!Uebersetzung der AD-Wandlerroutine in Data-Anweisungen   
  250 DATA 213,197,183,245,71,62,207,211,49,211,51,62,255,211,49,62
  260 DATA 48,211,51,120,230,131,211,50,6,5,16,254,203,247,211,50
  270 DATA 219,50,203,111,40,250,219,50,203,111,32,250,203,103,40,59
  280 DATA 33,0,0,1,80,5,203,127,40,1,5,41,84,93,41,41 
  290 DATA 25,219,48,87,230,112,185,32,248,62,15,0,162,95,22,0
  300 DATA 25,121,214,16,79,16,228,219,48,203,127,40,7,235,33,0
  310 DATA 0,183,253,82,34,128,63,241,193,209,201,33,32,78,203,127
  320 DATA 40,3,33,208,7,241,55,245,24,221,0,0,0,0,0,0
  330 FOR I=16128 TO 16255
  340 READ C:POKE I,C
  350 NEXT I
  360 RETURN
