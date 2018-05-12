Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10        ORG  0C000H
   20 FBL:   EQU  0EB80H
   30 START: RST  020H
   40        DB   2
   50        DB   12
   60        DB   '    KC'
   70        DB   '85-Kasse'
   80        DB   'ttenint'
   90        DB   'erface'
  100        DB   13
  110        DB   '  '
  120        DB   0A0H
  130        LD   A,'*'
  140        LD   B,25
  150 MA1:   RST  020H
  160        DB   0
  170        DJNZ MA1-#
  180 ST2:   RST  020H
  190        DB   2
  200        DB   08DH
  210        LD   E,'S'
  220        CALL GET
  230        RST  020H
  240        DB   2
  250        DB   'SAV'
  260        DB   0C5H
  270        LD   E,'L'
  280        CALL GET
  290        RST  020H
  300        DB   2
  310        DB   'LOA'
  320        DB   0C4H
  330        LD   E,'V'
  340        CALL GET
  350        RST  020H
  360        DB   2
  370        DB   'VERIF'
  380        DB   0D9H
  390        LD   E,'B'
  400        CALL GET
  410        RST  020H
  420        DB   2
  430        DB   'BLOECKE'
  440        DB   ' LADEN'
  450        DB   0A0H
  460        LD   E,'E'
  470        CALL GET
  480        RST  020H
  490        DB   2
  500        DB   'ENDE'
  510        DB   13
  520        DB   13
  530        DB   08DH
  540        LD   B,26
  550 GLZ:   RST  020H
  560        DB   14
  570        DJNZ GLZ-#
  580        RST  020H
  590        DB   2
  600        DB   '> <'
  610        DB   8
  620        DB   088H
  630        RST  020H
  640        DB   1
  650        PUSH AF
  660        RST  020H
  670        DB   0
  680        RST  020H
  690        DB   2
  700        DB   13
  710        DB   13
  720        DB   08DH
  730        POP  AF
  740        CMP  'E'
  750        JPZ  00038H
  760        CMP  'L'
  770        CAZ  LOAD
  780        CMP  'V'
  790        CAZ  VERIF
  800        CMP  'S'
  810        CAZ  SAVE
  820        CMP  'B'
  830        CAZ  BLAD
  840        JMP  START
  850 ZIEL:  RST  020H
  860        DB   2
  870        DB   'Zieladre'
  880        DB   'sse :'
  890        DB   0A0H
  900        LD   BC,ZADR
  910        CALL PAG2
  920        LD   A,0
  930        JRNC ZAG-#
  940        INC  A
  950 ZAG:   LD   (NZADR),A
  960        RET  
  970 BLAD:  CALL ZIEL
  980        JRC  BLAD-#
  990 FIFR:  RST  020H
 1000        DB   2
 1010        DB   '1. '
 1020        DB   'BLOCK :'
 1040        DB   0A0H
 1050        LD   BC,LSPOS
 1060        CALL PAG2
 1070        JRC  FIFR-#
 1080        LD   A,L
 1090        DEC  A
 1100        LD   (BLNR),A
 1110        XOR  A
 1120        LD   (LVBT),A
 1130        JR   RFNB-#
 1140 LOAD:  CALL ZIEL
 1150        XOR  A
 1160 VERIF: LD   (LVBT),A
 1170        DI   
 1180        LD   HL,FBL
 1190        LD   (LSPOS),HL
 1200 RFB:   CALL LBL
 1210        JRNC RFBL-#
 1220        CALL GBNF
 1230        JR   RFB-#
 1240 RFBL:  LD   A,(BLNR)
 1250        CMP  2
 1260        JRC  RFIL-#
 1270        CALL GBNU
 1280        JR   RFB-#
 1290 RFIL:  CALL RFILE
 1300        LD   A,(NZADR)
 1310        OR   A
 1320        JRZ  RFNB-#
 1330        LD   HL,(BADR+1)
 1340        LD   (ZADR),HL
 1350        JR   RFNB-#
 1360 RFILE: RST  020H
 1370        DB   2
 1380        DB   08DH
 1390        LD   HL,FBL
 1400        LD   B,11
 1410 NEXT:  LD   A,M
 1420        CMP  32
 1430        JRC  NEX2-#
 1440        RST  020H
 1450        DB   0
 1460 NEX2:  INC  HL
 1470        DJNZ NEXT-#
 1480        LD   HL,BADR
 1490        LD   A,(HL)
 1500        DEC  A
 1510        CMP  3
 1520        JRC  PARA-#
 1530        LD   A,1
 1540 PARA:  LD   B,A
 1550        INC  B
 1560 PAR2:  CALL PAGET
 1570        DJNZ PAR2-#
 1580        RST  020H
 1590        DB   2
 1600        DB   08DH
 1610        RET  
 1620 RFNB:  LD   A,(LVBT)
 1630        OR   A
 1640        JRNZ RFVN-#
 1650        LD   HL,(ZADR)
 1660        LD   (LSPOS),HL
 1670 RFVN:  LD   A,(BLNR)
 1680        INC  A
 1690        LD   (BLN2),A
 1700 NLV:   CALL LBL
 1710        JRNC BLOK-#
 1720        CALL GBNF
 1730        JR   NLV-#
 1740 BLOK:  LD   HL,BLN2
 1750        LD   A,(BLNR)
 1760        CMP  M
 1770        JRZ  RBLL-#
 1780        CMP  0FFH
 1790        JRZ  FEND-#
 1800 NGFF:  CALL GBNU
 1810        JR   NLV-#
 1820 RBLL:  CALL GBNR
 1830        LD   HL,(LSPOS)
 1840        LD   DE,00080H
 1850        ADD  HL,DE
 1860        LD   (ZADR),HL
 1870        JR   RFNB-#
 1880 FEND:  LD   A,(BERR)
 1890        OR   A
 1900        JRNZ NGFF-#
 1910        CALL GBNR
 1920        RST  020H
 1930        DB   2
 1940        DB   13
 1950        DB   08DH
 1960        EI   
 1970        RET  
 1980 SAVE:  RST  020H
 1990        DB   2
 2000        DB   'Aktuelle'
 2010        DB   's File s'
 2020        DB   'aven (J)'
 2030        DB   '/N :'
 2040        DB   0A0H
 2050        RST  020H
 2060        DB   1
 2070        PUSH AF
 2080        RST  020H
 2090        DB   0
 2100        RST  020H
 2110        DB   2
 2120        DB   13
 2130        DB   08DH
 2140        POP  AF
 2150        CMP  'J'
 2160        JRZ  COPY-#
 2170        RST  020H
 2180        DB   2
 2190        DB   'Programm'
 2200        DB   'name   :'
 2210        DB   0A0H
 2220        RST  020H
 2230        DB   16
 2240        RST  020H
 2250        DB   2
 2260        DB   08DH
 2270        LD   HL,FBL
 2280        LD   DE,(00016H)
 2290        LD   B,30
 2300 FNGT:  LD   A,(DE)
 2310        LD   (HL),A
 2320        INC  HL
 2330        INC  DE
 2340        DJNZ FNGT-#
 2350 SNAM:  LD   (HL),0
 2360        DEC  HL
 2370        LD   A,(HL)
 2380        CMP  021H
 2390        JRC  SNAM-#
 2400        LD   BC,BADR+1
 2410        RST  020H
 2420        DB   2
 2430        DB   'Anfangsa'
 2440        DB   'dresse :'
 2450        DB   0A0H
 2460        CALL PAG2
 2470        RST  020H
 2480        DB   2
 2490        DB   'Endadres'
 2500        DB   'se     :'
 2510        DB   0A0H
 2520        CALL PAG2
 2530        RST  020H
 2540        DB   2
 2550        DB   'Startadr'
 2560        DB   'esse   :'
 2570        DB   0A0H
 2580        CALL PAG2
 2590        LD   A,2
 2600        JRC  NSTA-#
 2610        INC  A
 2620 NSTA:  LD   (BADR),A
 2630 COPY:  DI   
 2640        LD   HL,(BADR+1)
 2650        LD   (ZADR),HL
 2660        CALL RFILE
 2670        LD   A,1
 2680        LD   HL,FBL
 2690        LD   BC,01770H
 2700        CALL SNBL2
 2710 NBLR:  LD   A,(BLNR)
 2720        INC  A
 2730 LBLR:  CALL SNBL
 2740        LD   HL,(ZADR)
 2750        LD   DE,00080H
 2760        ADD  HL,DE
 2770        LD   (ZADR),HL
 2780        ADD  HL,DE
 2790        LD   DE,(BADR+3)
 2800        SBC  HL,DE
 2810        JRC  NBLR-#
 2820        LD   A,0FFH
 2830        CALL SNBL
 2840        EI   
 2850        RET  
 2860 SNBL:  LD   HL,(ZADR)
 2870        LD   BC,000A0H
 2880 SNBL2: LD   (BLNR),A
 2890        LD   (LSPOS),HL
 2900        CALL SBL
 2910        CALL GBNR
 2920        RET  
 2930 PAG2:  RST  020H
 2940        DB   16
 2950        RST  020H
 2960        DB   2
 2970        DB   08DH
 2980        LD   DE,(00016H)
 2990        LD   A,(DE)
 3000        CMP  '0'
 3010        RC   
 3020        RST  020H
 3030        DB   3
 3040        LD   A,L
 3050        LD   (BC),A
 3060        INC  BC
 3070        LD   A,H
 3080        LD   (BC),A
 3090        INC  BC
 3100        SCF  
 3110        CCF  
 3120        RET  
 3130 SBL:   XOR  A
 3140        LD   (CHS),A
 3150 SVT:   CALL SM2
 3160        CPI  
 3170        JPPE SVT
 3180        CALL SM1
 3190 SBNR:  LD   A,(BLNR)
 3200        CALL SBY
 3210 SBJ:   LD   HL,(LSPOS)
 3220        LD   B,080H
 3230 SNB:   LD   A,M
 3240        CALL SBY
 3250        LD   A,(CHS)
 3260        ADD  M
 3270        LD   (CHS),A
 3280        INC  HL
 3290        DJNZ SNB-#
 3300 SCS:   CALL SBY
 3310        RET  
 3320 SBY:   PUSH BC
 3330        LD   C,A
 3340        LD   B,008H
 3350 SBI:   RRC  C
 3360        PUSH AF
 3370        CAC  SM2
 3380        POP  AF
 3390        CANC SM4
 3400        DJNZ SBI-#
 3410        POP  BC
 3420 SM1:   LD   E,07BH
 3430        JR   SM3-#
 3440 SM4:   LD   E,018H
 3450        JR   SM3-#
 3460 SM2:   LD   E,036H
 3470 SM3:   PUSH DE
 3480        LD   A,080H
 3490        OUT  002H
 3500        CALL WAIT
 3510        POP  DE
 3520        XOR  A
 3530        OUT  002H
 3540        CALL WAIT
 3550        RET  
 3560 WAIT:  DEC  E
 3570        JRNZ WAIT-#
 3580        RET  
 3590 LBL:   LD   B,016H
 3600 LVT:   CALL LBI
 3610        JRC  LBL-#
 3620        CMP  028H
 3630        JRNC LBL-#
 3640        DJNZ LVT-#
 3650        XOR  A
 3660        LD   (CHS),A
 3670 LVT2:  CALL LBI
 3680        CMP  028H
 3690        JRC  LVT2-#
 3700 LBNR:  CALL LBY
 3710        RC   
 3720        LD   (BLNR),A
 3730 LBJ:   LD   B,080H
 3740        LD   HL,(LSPOS)
 3750 LNB:   CALL LBY
 3760        RC   
 3770        LD   M,A
 3780        LD   A,(CHS)
 3790        ADD  M
 3800        LD   (CHS),A
 3810        INC  HL
 3820        DJNZ LNB-#
 3830        CALL LBY
 3840        RC   
 3850        LD   B,A
 3860        LD   A,(CHS)
 3870        CMP  B
 3880        RZ   
 3890        SCF  
 3900        RET  
 3910 LBY:   LD   D,008H
 3920 LM1:   CALL LBI
 3930        CCF  
 3940        JRNC LM2-#
 3950        CMP  028H
 3960        CCF  
 3970        RC   
 3980        SCF  
 3990 LM2:   RR   E
 4000        DEC  D
 4010        JRNZ LM1-#
 4020        CALL LBI
 4030        LD   A,E
 4040        RET  
 4050 LBI:   LD   C,0FFH
 4060 LM3:   IN   002H
 4070        RLCA 
 4080        RLCA 
 4090        JRNC LM3-#
 4100 LM4:   INC  C
 4110        IN   002H
 4120        RLCA 
 4130        RLCA 
 4140        JRC  LM4-#
 4150        LD   A,C
 4160        CMP  014H
 4170        RET  
 4180 GET:   LD   A,13
 4190        RST  020H
 4200        DB   0
 4210        RST  020H
 4220        DB   0
 4230        LD   B,9
 4240 GE2:   RST  020H
 4250        DB   14
 4260        DJNZ GE2-#
 4270        LD   A,E
 4280        RST  020H
 4290        DB   0
 4300        RST  020H
 4310        DB   2
 4320        DB   ' ...'
 4330        DB   0A0H
 4340        RET  
 4350 GBNU:  LD   A,'*'
 4360        JR   GBLN-#
 4370 GBNF:  LD   A,'?'
 4380        JR   GBLN-#
 4390 GBNR:  LD   A,'>'
 4400 GBLN:  PUSH AF
 4410        LD   A,(BLNR)
 4420        RST  020H
 4430        DB   6
 4440        POP  AF
 4450        RST  020H
 4460        DB   0
 4470        CMP  '?'
 4480        JRZ  BEEP-#
 4490        CMP  '>'
 4500        JRNZ DE2-#
 4510        XOR  A
 4520        LD   (BERR),A
 4530 DE2:   LD   A,8
 4540        LD   B,3
 4550 DEC:   RST  020H
 4560        DB   0
 4570        DJNZ DEC-#
 4580        RET  
 4590 BEEP:  LD   (BERR),A
 4600        RST  020H
 4610        DB   14
 4620        LD   BC,08028H
 4630        CALL 0FFDCH
 4640        RET  
 4650 PAGET: RST  020H
 4660        DB   14
 4670        INC  HL
 4680        LD   E,(HL)
 4690        INC  HL
 4700        LD   D,(HL)
 4710        EX   DE,HL
 4720        RST  020H
 4730        DB   7
 4740        EX   DE,HL
 4750        RET  
 4760 BLNR:  DB   0
 4770 BLN2:  DB   0
 4780 CHS:   DB   0
 4790 LVBT:  DB   0
 4800 BERR:  DB   0
 4810 NZADR: DB   0
 4820 LSPOS: DB   0
 4830        DB   0
 4840 ZADR:  DB   0
 4850        DB   0
 4860 BADR:  EQU  FBL+010H
