Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 OUTCH: EQU  0E7H
   20 INCH:  EQU  1E7H
   30 PRST7: EQU  2E7H
   40 INHEX: EQU  3E7H
   50 INKEY: EQU  4E7H
   60 INLIN: EQU  5E7H
   70 OUTA:  EQU  6E7H
   80 OUTHL: EQU  7E7H
   90 MEM:   EQU  0AE7H
  100 WINDW: EQU  0BE7H
  110 OUTHS: EQU  0CE7H
  120 OUTDP: EQU  0DE7H
  130 OUTSP: EQU  0EE7H
  140 INSTR: EQU  10E7H
  150 SOIL:  EQU  16H
  151 PAR1:  EQU  1BH
  152 PAR2:  EQU  1DH
  153 PAR3:  EQU  23H
  510        ORG  2000H
  515        PUSH HL
  516        PUSH BC
  520        LD   HL,357H
  530        LD   DE,355H
  540        LD   BC,3EH
  550        LDIR 
  560        LD   HL,35EH
  570        LD   DE,35DH
  580        LD   BC,37H
  590        LDIR 
  600        LD   HL,365H
  610        LD   DE,362H
  620        LD   BC,30H
  630        LDIR 
  640        LD   DE,355H
  650        POP  BC
  660        POP  HL
  670        RET  
