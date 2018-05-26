Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10        JMP  START
   20        ORG  4A3H
   30 BESTA: DB   '90000 ANDREAS'
   31        DB   '80000ZIERMANN'
   32        DB   '70000* AKEN *'
   33        DB   '60000* 4372 *'
   34        DB   '50000DESSAUER'
   35        DB   '40000LANDSTR.'
   36        DB   '30000  25/2  '
   37        DB   '20000PS:Z1013'
   38        DB   '10000->FAN   '
   39        DB   '09000LLKKJJHH'
   40 CURSR: DA   0
   50 TITEL: EQU  0A000H
   60 ZAHL:  EQU  0A3A0H
   70 KOPF:  EQU  ZAHL+54
   80 BEGTI: EQU  KOPF+32
   90 BTAB:  EQU  BEGTI+80
  100 LAUF:  EQU  BTAB+68H
  110 RAUM1: EQU  BTAB+250H
  120 BEGIN: EQU  BTAB+09C4H
  130 BEGI2: EQU  BTAB+11E5H
  140 LEBEN: DB   12
  150 LEBE1: DB   12
  160 PATRO: DB   7
  170 LEVEL: DB   1
  180 SCORE: DA   0
  190 ETAGE: DB   30
  200 BILD:  DB   '    @S::                    '
  210        DB   '   @S::                   '
  220        DB   '   @S:                     '
  230        DB   '    @S:TTTTTTTTTTTTTTTTTTTTT'
  240        DB   '   @S:IIIIIIIIIIIIIIIIIIIII'
  250        DB   ' A  @S:SSSSSSSSSSSSSSSSSSSSS'
  260        DB   '   @S:PPPPPPPPPPPPPPPPPPPPP'
  270        DB   '   @S:LLLLLLLLLLLLLLLLLLLLL'
  280        DB   '   @S:KKKKKKKKKKKKKKKKKKKKK'
  290        DB   '   @S:JJJJJJJJJJJJJJJJJJJJJ'
  300        DB   '   @S:FFFFFFFFFFFFFFFFFFFFF'RRR
  310        DB   '   S:BBBBBBBBBBBBBBBBBBBBB'
  320        DB   '     @S:ZZZZZZZZZZZZZZZZZZZZZ'
  330        DB   '   @S:UUUUUUUUUUUUUUUUUUUUU'
  340        DB   ' Z   @S:VVVVVVVVVVVVVVVVVVVV'
  350        DB   '     @S:XXXXXXXXXXXXXXXXXXXXX'
  360        DB   '   @S:OOOOOOOOOOOOOOOOOOOOO'
  370        DB   '    @S:MMMMMMMMMMMMMMMMMMMMM'
  380        DB   '    @LLLQQQQQQQQQQQQQQQQQQQQ'
  390        DB   '   @S:JJJJJJJJJJJJJJJJJJJJK'
  400 ACTRE: LD   HL,(CURSR)
  410        LD   M,0
  420        INC  HL
  430        LD   A,M
  440        CMP  1
  450        JRZ  B1-#
  460        LD   (CURSR),HL
  470        LD   M,3
  480        CALL ANZRA
  490 B1:    RET  
  500 ACTLI: LD   HL,(CURSR)
  510        LD   M,0
  520        DEC  HL
  530        LD   A,M
  540        CMP  1
  550        JRZ  B2-#
  560        LD   (CURSR),HL
  570        LD   M,4
  580        CALL ANZRA
  590 B2:    RET  
  600 ACTRU: LD   HL,(CURSR)
  610        LD   M,0
  620        LD   BC,64
  630        ADD  HL,BC
  640        LD   A,M
  650        CMP  1
  660        JRZ  B3-#
  670        LD   (CURSR),HL
  680        LD   M,5
  690        CALL ANZRA
  700        LD   HL,ETAGE
  710        INC  M
  720 B3:    RET  
  730 ACTHO: LD   HL,(CURSR)
  740        LD   M,0
  750        LD   BC,-64
  760        ADD  HL,BC
  770        LD   A,M
  780        CMP  1
  790        JRZ  B4-#
  800        LD   (CURSR),HL
  810        LD   M,5
  820        CALL ANZRA
  830        LD   HL,ETAGE
  840        DEC  M
  850 B4:    RET  
  860 SOND:  PUSH DE
  870        EXX  
  880        POP  DE
  890        EXX  
  900        LD   D,H
  910        LD   E,L
  920 S2:    DEC  D
  930        JRNZ S1-#
  940        CALL X1
  950        RZ   
  960        LD   A,B
  970        XOR  80H
  980        OUT  2
  990        LD   B,A
 1000        LD   D,H
 1010        JR   S1-#
 1020 S1:    DEC  E
 1030        JRNZ S2-#
 1040        CALL X1
 1050        RZ   
 1060        LD   A,C
 1070        XOR  80H
 1080        OUT  2
 1090        LD   C,A
 1100        LD   E,L
 1110        JR   S2-#
 1120 X1:    EXX  
 1130        DEC  DE
 1140        LD   A,D
 1150        OR   E
 1160        EXX  
 1170        RET  
 1180 X2:    LD   DE,2500H
 1190 S3:    DEC  DE
 1200        LD   A,D
 1210        OR   E
 1220        JRNZ S3-#
 1230        RET  
 1240 BONUS: LD   A,(LEVEL)
 1250        OR   A
 1260        RZ   
 1270        LD   IX,0EC1EH
 1280        LD   IY,0EF41H
 1290        LD   B,18H
 1300 E6:    LD   A,B
 1310        BIT  0,B
 1320        JRNZ E1-#
 1330        LD   D,0B6H
 1340        LD   E,0B7H
 1350        LD   B,4
 1360 E2:    DEC  IY
 1370        INC  IX
 1380        DJNZ E2-#
 1390        JR   E3-#
 1400 E1:    LD   D,255
 1410        LD   E,D
 1420        LD   B,1CH
 1430 E4:    INC  IY
 1440        DEC  IX
 1450        DJNZ E4-#
 1460 E3:    LD   B,1CH
 1470 E5:    LD   (IX),D
 1480        LD   (IY),E
 1490        INC  IX
 1500        DEC  IY
 1510        DJNZ E5-#
 1520        CALL PAUSE
 1530        LD   B,A
 1540        DJNZ E6-#
 1550        LD   B,1CH
 1560        LD   HL,0EDA2H
 1570 E7:    LD   M,255
 1580        INC  HL
 1590        DJNZ E7-#
 1600        LD   B,10
 1610 E8:    LD   A,B
 1620        CALL PAUSE
 1630        LD   B,A
 1640        DJNZ E8-#
 1650        LD   B,1CH
 1660        LD   HL,0EDA2H
 1670 E9:    LD   M,32
 1680        INC  HL
 1690        DJNZ E9-#
 1700        CALL PAUSE
 1710        LD   B,17H
 1720 E15:   LD   A,B
 1730        BIT  0,B
 1740        JRNZ E10-#
 1750        LD   D,0B6H
 1760        LD   E,0B7H
 1770        LD   B,3CH
 1780 E11:   DEC  IX
 1790        INC  IY
 1800        DJNZ E11-#
 1810        JR   E12-#
 1820 E10:   LD   D,32
 1830        LD   E,D
 1840        LD   B,1CH
 1850 E13:   DEC  IX
 1860        INC  IY
 1870        DJNZ E13-#
 1880 E12:   LD   B,1CH
 1890 E14:   LD   (IX),D
 1900        LD   (IY),E
 1910        INC  IX
 1920        DEC  IY
 1930        DJNZ E14-#
 1940        CALL PAUSE
 1950        LD   B,A
 1960        DJNZ E15-#
 1970        LD   B,4
 1980        LD   HL,BTAB
 1990        LD   DE,0EC43H
 2000 E19:   PUSH BC
 2010        LD   BC,26
 2020        LDIR 
 2030        LD   B,6
 2040 E20:   INC  DE
 2050        DJNZ E20-#
 2060        POP  BC
 2070        DJNZ E19-#
 2080        LD   HL,0EC30H
 2090        LD   A,0D1H
 2100        LD   M,A
 2110        INC  HL
 2120        INC  A
 2130        LD   M,A
 2140        EXX  
 2150        LD   HL,LAUF
 2160        LD   DE,0ECE3H
 2170        LD   BC,26
 2180        LDIR 
 2190        LD   B,10H
 2200 S6:    PUSH BC
 2210        CALL PAUSE
 2220        POP  BC
 2230        DJNZ S6-#
 2240        EXX  
 2250 E23:   EXX  
 2260        LD   HL,LAUF
 2270        LD   DE,0ECE3H
 2280        LD   BC,26
 2290        EXX  
 2300        LD   HL,1A0H
 2310 E21:   PUSH HL
 2320        EXX  
 2330        PUSH BC
 2340        PUSH DE
 2350        PUSH HL
 2360        LDIR 
 2370        POP  HL
 2380        INC  HL
 2390        POP  DE
 2400        POP  BC
 2410        EXX  
 2420        CALL PAUSE
 2430        CALL PAUSE
 2440        CALL INCHA
 2450        POP  HL
 2460        OR   A
 2470        RNZ  
 2480        DEC  HL
 2490        LD   A,H
 2500        OR   L
 2510        JRNZ E21-#
 2520        JR   E23-#
 2530 PAUSE: PUSH AF
 2540        LD   BC,1000H
 2550 EP1:   DEC  BC
 2560        LD   A,B
 2570        OR   C
 2580        JRNZ EP1-#
 2590        POP  AF
 2600        RET  
 2610 INCHA: LD   HL,(2BH)
 2620        LD   M,161
 2630        LD   B,80H
 2640 B5:    CALL 0FFFAH
 2650        DJNZ B5-#
 2660        RET  
 2670 ANZRA: LD   DE,0EC22H
 2680        PUSH DE
 2690        LD   HL,(CURSR)
 2700        LD   BC,-131
 2710        ADD  HL,BC
 2720        PUSH HL
 2730        LD   B,7
 2740 C3:    PUSH BC
 2750        LD   B,5
 2760 C4:    PUSH BC
 2770        LD   A,M
 2780        LD   C,A
 2790        PUSH BC
 2800        LD   BC,64
 2810        ADD  HL,BC
 2820        POP  BC
 2830        PUSH HL
 2840        CALL ZEICH
 2850        POP  HL
 2860        POP  BC
 2870        DJNZ C4-#
 2880        POP  BC
 2890        POP  HL
 2900        JR   S5-#
 2910 S5:    INC  HL
 2920        POP  DE
 2930        INC  DE
 2940        INC  DE
 2950        INC  DE
 2960        INC  DE
 2970        PUSH DE
 2980        PUSH HL
 2990        DJNZ C3-#
 3000        POP  DE
 3010        POP  DE
 3020        RET  
 3030 NEWLV: CALL BONUS
 3040        LD   A,28
 3050        LD   (ETAGE),A
 3060        LD   HL,LEVEL
 3070        INC  M
 3080        LD   A,M
 3090        CMP  2
 3100        JRNZ B6-#
 3110        LD   HL,BEGI2
 3120        LD   (CURSR),HL
 3130        CALL ANZRA
 3140 B6:    CALL ANZLV
 3150        RET  
 3160 ZEICH: LD   HL,BILD
 3170        LD   B,0
 3180        ADD  HL,BC
 3190        LD   B,5
 3200 C2:    PUSH BC
 3210        LD   B,4
 3220 C1:    PUSH BC
 3230        LD   A,M
 3240        LD   BC,32
 3250        ADD  HL,BC
 3260        LD   (DE),A
 3270        INC  DE
 3280        POP  BC
 3290        DJNZ C1-#
 3300        LD   BC,28
 3310        EX   DE,HL
 3320        ADD  HL,BC
 3330        EX   DE,HL
 3340        POP  BC
 3350        DJNZ C2-#
 3360        RET  
 3370 ANZPU: LD   HL,(SCORE)
 3380        XOR  A
 3390        LD   D,A
 3400        LD   B,16
 3410 ZYK:   ADD  HL,HL
 3420        ADC  A
 3430        DAA  
 3440        LD   E,A
 3450        LD   A,D
 3460        ADC  A
 3470        DAA  
 3480        LD   D,A
 3490        RL   C
 3500        LD   A,E
 3510        DJNZ ZYK-#
 3520        EX   DE,HL
 3530        LD   A,C
 3540        PUSH HL
 3550        LD   HL,0EFB8H
 3560        LD   (2BH),HL
 3570        RST  20H
 3580        DB   6
 3590        POP  HL
 3600        RST  20H
 3610        DB   7
 3620        RET  
 3630 ANZET: LD   A,(ETAGE)
 3640        LD   B,A
 3650        XOR  A
 3660 M12:   INC  A
 3670        DAA  
 3680        DJNZ M12-#
 3690        LD   HL,0EFCEH
 3700        LD   M,'0'
 3710        INC  HL
 3720        LD   (2BH),HL
 3730        RST  20H
 3740        DB   6
 3750        LD   HL,0EFD1H
 3760        LD   M,32
 3770        RET  
 3780 ANZLV: LD   A,(LEVEL)
 3790        LD   HL,0EF74H
 3800        LD   DE,30
 3810        CMP  3
 3820        RP   
 3830        CMP  2
 3840        JRZ  LEV2-#
 3850        INC  HL
 3860        LD   M,178
 3870        INC  HL
 3880        INC  HL
 3890        ADD  HL,DE
 3900        LD   M,189
 3910        INC  HL
 3920        ADD  HL,DE
 3930        INC  HL
 3940        LD   M,181
 3950        INC  HL
 3960        ADD  HL,DE
 3970        INC  HL
 3980        LD   M,186
 3990        INC  HL
 4000        LD   M,179
 4010        RET  
 4020 LEV2:  INC  HL
 4030        LD   M,183
 4040        INC  HL
 4050        ADD  HL,DE
 4060        LD   M,177
 4070        INC  HL
 4080        LD   M,32
 4090        INC  HL
 4100        LD   M,180
 4110        ADD  HL,DE
 4120        INC  HL
 4130        LD   M,185
 4140        INC  HL
 4150        ADD  HL,DE
 4160        LD   M,181
 4170        INC  HL
 4180        LD   M,183
 4190        RET  
 4200 ANZLE: LD   DE,0EF62H
 4210        LD   HL,LEBEN
 4220        LD   A,M
 4230        LD   B,A
 4240        LD   A,14
 4250        SUB  B
 4260        INC  HL
 4270        LD   M,A
 4280        LD   B,4
 4290 M6:    LD   C,3
 4300 M5:    DEC  M
 4310        RZ   
 4320        LD   A,' '
 4330        LD   (DE),A
 4340        INC  DE
 4350        DEC  C
 4360        JRNZ M5-#
 4370        LD   C,29
 4380 M7:    INC  DE
 4390        DEC  C
 4400        JRNZ M7-#
 4410        DJNZ M6-#
 4420        RET  
 4430 ANZPA: LD   A,(PATRO)
 4440        LD   B,A
 4450        LD   A,7
 4460        SUB  B
 4470        RZ   
 4480        LD   HL,0EF6CH
 4490        LD   B,A
 4500 M11:   LD   M,' '
 4510        INC  HL
 4520        DJNZ M11-#
 4530        RET  
 4540 A1:    LD   HL,0EC22H
 4550        LD   DE,0ECA2H
 4560        LD   IX,0EF82H
 4570        LD   B,28
 4580 A2:    LD   M,A
 4590        LD   (IX),A
 4600        LD   (DE),A
 4610        INC  HL
 4620        INC  IX
 4630        INC  DE
 4640        DJNZ A2-#
 4650        LD   IX,0EC21H
 4660        LD   DE,32
 4670        LD   B,28
 4680 A3:    LD   (IX),A
 4690        LD   (IX+29),A
 4700        ADD  IX,DE
 4710        DJNZ A3-#
 4720        RET  
 4730 CUWE:  LD   HL,(2BH)
 4740        LD   M,32
 4750        RET  
 4760 ENDE:  DA   2E7H
 4770        DB   12
 4780        DB   'JETZT KOENNEN SIE IHREN RECHNER GETROST AUSSCHALTEN'
 4790        DB   174
 4800        LD   A,255
 4810        OUT  3
 4820        XOR  A
 4830        OUT  3
 4840        DA   1E7H
 4850        JMP  0F029H
 4860 A17:   LD   HL,0ECE3H
 4870        LD   (1BH),HL
 4880        LD   HL,0EF80H
 4890        LD   (1DH),HL
 4900        LD   HL,32
 4910        LD   (23H),HL
 4920        DA   11E7H
 4930        RET  
 4940 KOPI:  CALL A17
 4950        LD   HL,0ECE2H
 4960        LD   (2BH),HL
 4970        LD   HL,KOPF
 4980        LD   DE,0E0H
 4990        LD   BC,32
 5000        LDIR 
 5010        DA   2E7H
 5020        DB   ' BEI <SPACE> GEHTS LOS,SONST     '
 5030        DB   'RUECKKEHR ZUM MENU'
 5040        DB   174
 5050        LD   A,201
 5060        CALL A1
 5070        DA   1E7H
 5080        CMP  32
 5090        JRNZ A13-#
 5100        LD   A,3AH
 5110        CALL 0FFF4H
 5120 A13:   LD   A,32
 5130        JMP  S12
 5140 BEST:  DA   2E7H
 5150        DB   8CH
 5160        LD   IX,0ECA3H
 5170        LD   DE,68
 5180        LD   C,9
 5190 D4:    CALL D1
 5200        ADD  IX,DE
 5210        LD   (IX-33),177
 5220        DEC  C
 5230        JRNZ D4-#
 5240        LD   HL,ZAHL
 5250        LD   DE,0ECA0H
 5260        LD   B,27
 5270 D5:    PUSH BC
 5280        LD   BC,2
 5290        LDIR 
 5300        LD   BC,30
 5310        EX   DE,HL
 5320        ADD  HL,BC
 5330        EX   DE,HL
 5340        POP  BC
 5350        DJNZ D5-#
 5360        LD   HL,0EC21H
 5370        LD   (2BH),HL
 5380        DA   2E7H
 5390        DB   'HIER SEIEN UNSERE BESTEN NOCH-  EINMAL'
 5400        DB   ' ERWAEHNT. DAS VATERLAND        '
 5410        DB   'IST STOLZ AUF SIE.'
 5420        DB   8DH
 5430        LD   IX,0EC01H
 5440        LD   A,160
 5450        LD   B,30
 5460 D7:    LD   (IX),A
 5470        INC  IX
 5480        LD   (IX+7FH),A
 5490        DJNZ D7-#
 5500        LD   IX,0EC20H
 5510        LD   DE,32
 5520        INC  A
 5530        LD   B,3
 5540 D8:    LD   (IX),A
 5550        LD   (IX+31),A
 5560        ADD  IX,DE
 5570        DJNZ D8-#
 5580        LD   (IX-80H),168
 5590        LD   (IX-61H),169
 5600        LD   (IX),167
 5610        LD   (IX+31),170
 5620        LD   B,9
 5630        LD   HL,BESTA
 5640        LD   DE,60H
 5650        LD   IX,0ECC4H
 5660 D9:    LD   A,M
 5670        INC  HL
 5680        LD   (IX),A
 5690        LD   A,M
 5700        INC  HL
 5710        LD   (IX+2),A
 5720        LD   A,M
 5730        INC  HL
 5740        LD   (IX+4),A
 5750        LD   A,M
 5760        INC  HL
 5770        LD   (IX+6),A
 5780        LD   A,M
 5790        INC  HL
 5800        LD   (IX+8),A
 5810        LD   A,M
 5820        INC  HL
 5830        LD   (IX+12),A
 5840        LD   A,M
 5850        INC  HL
 5860        LD   (IX+14),A
 5870        LD   A,M
 5880        INC  HL
 5890        LD   (IX+16),A
 5900        LD   A,M
 5910        INC  HL
 5920        LD   (IX+18),A
 5930        LD   A,M
 5940        INC  HL
 5950        LD   (IX+20),A
 5960        LD   A,M
 5970        INC  HL
 5980        LD   (IX+22),A
 5990        LD   A,M
 6000        INC  HL
 6010        LD   (IX+24),A
 6020        LD   A,M
 6030        INC  HL
 6040        LD   (IX+26),A
 6050        ADD  IX,DE
 6060        DJNZ D9-#
 6070        DA   1E7H
 6080        LD   A,32
 6090        JMP  S12
 6110 D1:    LD   (IX),168
 6120        LD   (IX+32),161
 6130        LD   (IX+64),167
 6140        LD   A,160
 6150        LD   B,14
 6160 D3:    INC  IX
 6170        LD   (IX),A
 6180        LD   (IX+32),32
 6190        LD   (IX+64),A
 6200        INC  IX
 6210        LD   (IX),164
 6220        LD   (IX+32),161
 6230        LD   (IX+64),162
 6240        DJNZ D3-#
 6250        LD   (IX),169
 6260        LD   (IX-18),169
 6270        LD   (IX+64),170
 6280        LD   (IX+46),170
 6290        LD   (IX-17),32
 6300        LD   (IX-16),168
 6310        LD   (IX+47),32
 6320        LD   (IX+48),167
 6330        RET  
 6340 START: LD   HL,TITEL
 6350        LD   DE,0EC00H
 6360        LD   BC,3A0H
 6370        OUT  16
 6380        LDIR 
 6390        LD   A,20H
 6400        LD   B,60H
 6410        LD   HL,0EFA0H
 6420 S4:    LD   M,A
 6430        INC  HL
 6440        DJNZ S4-#
 6450        LD   DE,5B0H
 6460        LD   HL,6342H
 6470        CALL SOND
 6480        CALL X2
 6490        LD   DE,2D0H
 6500        LD   HL,9966H
 6510        CALL SOND
 6520        CALL X2
 6530        LD   DE,180H
 6540        LD   HL,6F4AH
 6550        CALL SOND
 6560        LD   DE,680H
 6570        LD   HL,6342H
 6580        CALL SOND
 6590        LD   HL,0EC48H
 6600        LD   (2BH),HL
 6610        RST  20H
 6620        DB   2
 6630        DB   'PRESS SPACE TO STAR'
 6640        DB   0D4H
 6650        LD   HL,0EC5CH
 6660        LD   M,32
 6670        LD   HL,0EE9AH
 6680 S11:   LD   M,99H
 6690        LD   B,10H
 6700 S13:   PUSH BC
 6710        PUSH HL
 6720        DA   04E7H
 6730        POP  HL
 6740        POP  BC
 6750        OR   A
 6760        JRNZ S12-#
 6770        DJNZ S13-#
 6780        LD   M,86H
 6790        LD   B,10H
 6800 S14:   PUSH BC
 6810        PUSH HL
 6820        DA   04E7H
 6830        POP  HL
 6840        POP  BC
 6850        OR   A
 6860        JRNZ S12-#
 6870        DJNZ S14-#
 6880        JR   S11-#
 6890 S12:   CMP  32
 6900        JRNZ S11-#
 6910        RST  20H
 6920        DB   2
 6930        DB   8CH
 6940        LD   HL,0EC63H
 6950        LD   (2BH),HL
 6960        LD   A,32
 6970        LD   (0EC00H),A
 6980        DA   2E7H
 6990        DB   'PHARAO V3.0 [.90 BETASOFT'
 7000        DB   221
 7010        LD   A,32
 7020        LD   (0EC7DH),A
 7030        LD   HL,BEGTI
 7040        LD   DE,0ECE3H
 7050        LD   B,20
 7060 A4:    PUSH BC
 7070        LD   BC,4
 7080        LDIR 
 7090        LD   BC,28
 7100        EX   DE,HL
 7110        ADD  HL,BC
 7120        EX   DE,HL
 7130        POP  BC
 7140        DJNZ A4-#
 7150        LD   IX,0ED27H
 7160        LD   A,178
 7170        LD   DE,128
 7180        LD   B,5
 7190 S17:   LD   (IX),A
 7200        LD   (IX+1),179
 7210        ADD  IX,DE
 7220        DJNZ S17-#
 7230        LD   HL,0ED29H
 7240        PUSH HL
 7250        LD   DE,80H
 7260        PUSH DE
 7270        LD   (2BH),HL
 7280        DA   2E7H
 7290        DB   'STARTEN DES PROGRAMM'
 7300        DB   211
 7310        POP  DE
 7320        POP  HL
 7330        ADD  HL,DE
 7340        PUSH HL
 7350        PUSH DE
 7360        LD   (2BH),HL
 7370        DA   2E7H
 7380        DB   'BESTENLISTE ANZEIGE'
 7390        DB   206
 7400        CALL CUWE
 7410        POP  DE
 7420        POP  HL
 7430        ADD  HL,DE
 7440        PUSH HL
 7450        PUSH DE
 7460        LD   (2BH),HL
 7470        DA   2E7H
 7480        DB   'KOPIEREN DES SPIEL'
 7490        DB   211
 7500        CALL CUWE
 7510        POP  DE
 7520        POP  HL
 7530        PUSH HL
 7540        PUSH DE
 7550        ADD  HL,DE
 7560        LD   (2BH),HL
 7570        DA   2E7H
 7580        DB   'NACHLADE'
 7590        DB   206
 7600        CALL CUWE
 7610        POP  DE
 7620        POP  HL
 7630        ADD  HL,DE
 7640        ADD  HL,DE
 7650        LD   (2BH),HL
 7660        DA   2E7H
 7670        DB   'DAS PROGRAMM BEENDE'
 7680        DB   206
 7690        CALL CUWE
 7700 A5:    LD   A,201
 7710        CALL A1
 7720        LD   C,16
 7730 A6:    LD   B,0
 7740 A7:    DA   4E7H
 7750        OR   A
 7760        JRNZ A8-#
 7770        DJNZ A7-#
 7780        DEC  C
 7790        JRNZ A6-#
 7800        LD   A,138
 7810        CALL A1
 7820        LD   C,16
 7830 A9:    LD   B,128
 7840 A10:   DA   4E7H
 7850        OR   A
 7860        JRNZ A8-#
 7870        DJNZ A10-#
 7880        DEC  C
 7890        JRNZ A9-#
 7900        JR   A5-#
 7910 A8:    CMP  'E'
 7920        JPZ  ENDE
 7930        CMP  'K'
 7940        JPZ  KOPI
 7950        CMP  'B'
 7960        JPZ  BEST
 7970        CMP  'S'
 7980        JPZ  21B0H
 7990        DA   2E7H
 8000        DB   140
 8010        LD   HL,BEGIN
 8020        LD   (CURSR),HL
 8030        LD   M,4
 8040        LD   A,32
 8050        LD   (0EC00H),A
 8060        LD   HL,0EF78H
 8070        LD   (2BH),HL
 8080        RST  20H
 8090        DB   2
 8100        DB   'PUNKT'
 8110        DB   0C5H
 8120        LD   B,28
 8130        LD   A,160
 8140        LD   HL,0EC02H
 8150        LD   IX,0EF82H
 8160 M1:    LD   (HL),A
 8170        LD   (IX-40H),A
 8180        LD   (IX+60H),A
 8190        INC  HL
 8200        INC  IX
 8210        DJNZ M1-#
 8220        LD   A,161
 8230        LD   DE,32
 8240        LD   IX,0EC21H
 8250        LD   B,25
 8260 M2:    LD   (IX+0),A
 8270        LD   (IX+29),A
 8280        ADD  IX,DE
 8290        DJNZ M2-#
 8300        LD   (IX),163
 8310        LD   A,164
 8320        LD   (IX+4),A
 8330        LD   (IX+10),A
 8340        LD   (IX+18),A
 8350        LD   (IX+22),A
 8360        ADD  IX,DE
 8370        LD   L,1
 8380        LD   M,0A8H
 8390        LD   L,01EH
 8400        LD   M,0A9H
 8410        LD   B,4
 8420        LD   A,161
 8430 M3:    LD   (IX),A
 8440        LD   (IX+4),A
 8450        LD   (IX+10),A
 8460        LD   (IX+18),A
 8470        LD   (IX+22),A
 8480        LD   (IX+29),A
 8490        ADD  IX,DE
 8500        DJNZ M3-#
 8510        LD   A,162
 8520        LD   (IX),167
 8530        LD   (IX+4),A
 8540        LD   (IX+10),A
 8550        LD   (IX+18),A
 8560        LD   (IX+22),A
 8570        LD   HL,0EF5EH
 8580        LD   M,0A5H
 8590        LD   L,0FEH
 8600        LD   M,0AAH
 8610        LD   L,8BH
 8620        LD   M,163
 8630        INC  HL
 8640        LD   B,7
 8650 M4:    LD   M,160
 8660        INC  HL
 8670        DJNZ M4-#
 8680        LD   M,165
 8690        LD   A,0CBH
 8700        LD   B,4
 8710 M8:    LD   (IX-7FH),A
 8720        LD   (IX-7EH),A
 8730        LD   (IX-7DH),A
 8740        LD   (IX-7BH),255
 8750        LD   (IX-7AH),255
 8760        LD   (IX-79H),255
 8770        LD   (IX-78H),255
 8780        LD   (IX-77H),255
 8790        ADD  IX,DE
 8800        DJNZ M8-#
 8810        LD   A,13
 8820        LD   (LEBEN),A
 8830        LD   HL,PATRO
 8840        LD   A,7
 8850        LD   M,A
 8860        LD   HL,0EF6CH
 8870        LD   B,A
 8880 M10:   LD   M,0C9H
 8890        INC  HL
 8900        DJNZ M10-#
 8910        XOR  A
 8920        LD   (LEVEL),A
 8930        CALL NEWLV
 8940        LD   HL,0
 8950        LD   (SCORE),HL
 8960        LD   HL,0EFADH
 8970        LD   (2BH),HL
 8980        RST  20H
 8990        DB   2
 9000        DB   'ETAG'
 9010        DB   0C5H
 9020        LD   HL,(2BH)
 9030        LD   M,20H
 9040        LD   A,'='
 9050        LD   IX,0EF98H
 9060        LD   B,6
 9070 M13:   LD   (IX),A
 9080        LD   (IX+64),A
 9090        INC  IX
 9100        DJNZ M13-#
 9110        CALL ANZRA
 9120        LD   DE,0ED6EH
 9130        LD   C,5
 9140        CALL ZEICH
 9150 M9:    CALL ANZET
 9160        LD   HL,SCORE
 9170        INC  M
 9180        CALL ANZPU
 9190        CALL INCHA
 9200        CMP  9
 9210        CAZ  ACTRE
 9220        CMP  8
 9230        CAZ  ACTLI
 9240        CMP  10
 9250        CAZ  ACTRU
 9260        CMP  11
 9270        CAZ  ACTHO
 9280        LD   A,(ETAGE)
 9290        OR   A
 9300        JRNZ M9-#
 9310        LD   HL,(CURSR)
 9320        LD   M,2
 9330        CALL NEWLV
 9340        CMP  3
 9350        JRNZ M9-#
 9360        RST  20H
 9370        DB   2
 9380        DB   12
 9390        DB   'ENDE'
 9400        DB   160
 9410        OUT  20
