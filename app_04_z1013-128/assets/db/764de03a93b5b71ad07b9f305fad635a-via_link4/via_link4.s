   49        ORG  210H
   50 INT:   DB   0E7H
   51        DB   2
   52        DB   'HALLO!!!'
   53        DB   8DH
   54        RETI 
   60 INIT:  DI   
   70        LD   A,3FH
   80        OUT  1
   90        LD   HL,(INTRU)
  100        LD   A,H
  110        LD   I,A
  120        LD   A,L
  130        OUT  1
  140        LD   A,83H
  150        OUT  1
  160        IM2  
  170        EI   
  180        RET  
  190 BYTE:  OUT  0
  191        HALT 
  193        RET  
  200 START: CALL INIT
  210        LD   A,40H
  220        CALL BYTE
