Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 BEGIN: JR   TON-#
   20 SAY1:  DB   0
   30        DB   060H
   40 SAY2:  DB   0
   50        DB   5
   60 TON:   RST  020H
   70        DB   2
   80        DB   13
   90        DB   13
  100        DB   'RECORD (R):'
  110        DB   0A0H
  120        RST  020H
  130        DB   1
  140        LD   HL,(SAY1)
  150        LD   DE,(SAY2)
  160        CMP  052H
  170        JRZ  READ-#
  180 GET:   LD   A,0CFH
  190        OUT  3
  200        LD   A,07FH
  210        OUT  3
  220        LD   B,8
  230 NEXT:  LD   C,(HL)
  240 SAY:   IN   2
  250        SET  7,A
  260        RL   C
  270        JRC  SET-#
  280        RES  7,A
  290 SET:   OUT  2
  300        DJNZ SAY-#
  310        INC  HL
  320        DEC  DE
  330        LD   A,D
  340        OR   E
  350        JRZ  BEGIN-#
  360        JR   NEXT-#
  370 READ:  LD   A,0FFH
  380        OUT  3
  390        OUT  3
  400        LD   B,8
  410 NE2:   IN   2
  420        BIT  7,A
  430        JRZ  YES-#
  440        SLA  M
  450        JR   ETEST-#
  460 YES:   SCF  
  470        RL   M
  480 ETEST: DJNZ NE2-#
  490        INC  HL
  500        DEC  DE
  510        LD   A,D
  520        OR   E
  530        JRZ  BEGIN-#
  540        JR   NE2-#
  550        JR   YYYY-#
