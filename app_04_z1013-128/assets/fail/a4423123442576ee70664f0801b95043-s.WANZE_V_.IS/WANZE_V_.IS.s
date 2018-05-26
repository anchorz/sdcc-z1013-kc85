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
  160        LD   (4),A
  170        EXX  
  180        DA   OUTCH
  190        DA   OUTSP
  200        LD   A,(4)
  210        DA   OUTA
  220        DA   OUTSP
  230        DA   PRST7
  240        DB   ' (SP)'
  250        DB   80H+':'
  260        LD   (SOIL),SP
  270        LD   HL,(SOIL)
  280        INC  HL
  290        CALL STOUT
  300        CALL STOUT
  310        CALL STOUT
  320        CALL STOUT
  330        DA   PRST7
  340        DB   '           '
  350        DB   0A0H
  360        CALL STOUT
  370        CALL STOUT
  380        EXX  
  385        LD   A,(4)
  390        RET  
  400 STOUT: DA   OUTHS
  410        INC  HL
  420        INC  HL
  430        INC  HL
  440        INC  HL
  450        RET  
