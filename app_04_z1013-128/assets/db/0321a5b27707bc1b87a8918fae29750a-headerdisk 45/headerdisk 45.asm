D800  C3 E2 D8         JP      0D8E2H
D803  C3 FB D8         JP      0D8FBH
D806  C3 DF D8         JP      0D8DFH
D809  C3 F8 D8         JP      0D8F8H
D80C  C3 88 DB         JP      0DB88H
D80F  C3 51 DB         JP      0DB51H
D812  C3 D7 D9         JP      0D9D7H
D815  C3 65 DC         JP      0DC65H
D818  C3 8D DA         JP      0DA8DH
D81B  C3 7F DE         JP      0DE7FH
D81E  C3 4B D8         JP      0D84BH
D821  00               NOP
D822  00               NOP
D823  C9               RET
D824  98               SBC     A,B
D825  58               LD      E,B
D826  F5               PUSH    AF
D827  06 00            LD      B,00H
D829  3A 24 D8         LD      A,(0D824H)
D82C  32 FD DE         LD      (0DEFDH),A
D82F  78               LD      A,B
D830  32 FE DE         LD      (0DEFEH),A
D833  F1               POP     AF
D834  C9               RET
D835  F5               PUSH    AF
D836  06 01            LD      B,01H
D838  3A 25 D8         LD      A,(0D825H)
D83B  18 EF            JR      0D82CH
D83D  CD D0 D8         CALL    0D8D0H
D840  FE 41            CP      41H
D842  CC 26 D8         CALL    Z,0D826H
D845  FE 42            CP      42H
D847  CC 35 D8         CALL    Z,0D835H
D84A  C9               RET
D84B  CD 3D D8         CALL    0D83DH
D84E  E7               RST     20H
D84F  02               DB      02H               ;PRST7
D850  0D               DB      0DH
D851  44 49 53 4B 3A   DB      'DISK:'
D856  A0               DB      80H+' '
D857  3A FE DE         LD      A,(0DEFEH)
D85A  C6 41            ADD     A,41H
D85C  E7               RST     20H
D85D  00               DB      00H               ;OUTCH
D85E  3E 0D            LD      A,0DH
D860  E7               RST     20H
D861  00               DB      00H               ;OUTCH
D862  CD 06 DB         CALL    0DB06H
D865  DC 6B DE         CALL    C,0DE6BH
D868  D8               RET     C
D869  3E 01            LD      A,01H
D86B  CD A6 D8         CALL    0D8A6H
D86E  CD 12 DB         CALL    0DB12H
D871  38 10            JR      C,0D883H
D873  3A F8 DE         LD      A,(0DEF8H)
D876  47               LD      B,A
D877  C6 03            ADD     A,03H
D879  E6 1F            AND     1FH
D87B  20 02            JR      NZ,0D87FH
D87D  E7               RST     20H
D87E  01               DB      01H               ;INCH
D87F  78               LD      A,B
D880  3C               INC     A
D881  18 E8            JR      0D86BH
D883  11 FF DE         LD      DE,0DEFFH
D886  3E 20            LD      A,20H
D888  06 16            LD      B,16H
D88A  12               LD      (DE),A
D88B  13               INC     DE
D88C  10 FC            DJNZ    0D88AH
D88E  21 EA DE         LD      HL,0DEEAH
D891  01 05 00         LD      BC,0005H
D894  ED B0            LDIR
D896  CD 12 DE         CALL    0DE12H
D899  3E 0D            LD      A,0DH
D89B  12               LD      (DE),A
D89C  AF               XOR     A
D89D  13               INC     DE
D89E  12               LD      (DE),A
D89F  11 FF DE         LD      DE,0DEFFH
D8A2  CD 6B DD         CALL    0DD6BH
D8A5  C9               RET
D8A6  32 F8 DE         LD      (0DEF8H),A
D8A9  11 FF DE         LD      DE,0DEFFH
D8AC  CD C2 DD         CALL    0DDC2H
D8AF  3E 20            LD      A,20H
D8B1  12               LD      (DE),A
D8B2  13               INC     DE
D8B3  CD 73 DD         CALL    0DD73H
D8B6  3E 20            LD      A,20H
D8B8  12               LD      (DE),A
D8B9  13               INC     DE
D8BA  2A E0 00         LD      HL,(00E0H)
D8BD  CD 9F DD         CALL    0DD9FH
D8C0  CD F1 DD         CALL    0DDF1H
D8C3  3E 0D            LD      A,0DH
D8C5  12               LD      (DE),A
D8C6  13               INC     DE
D8C7  AF               XOR     A
D8C8  12               LD      (DE),A
D8C9  11 FF DE         LD      DE,0DEFFH
D8CC  CD 6B DD         CALL    0DD6BH
D8CF  C9               RET
D8D0  2A 16 00         LD      HL,(0016H)
D8D3  23               INC     HL
D8D4  23               INC     HL
D8D5  23               INC     HL
D8D6  7E               LD      A,(HL)
D8D7  FD 6F            *LD     IYL,A
D8D9  2B               DEC     HL
D8DA  FD 26 00         *LD     IYH,00H
D8DD  7E               LD      A,(HL)
D8DE  C9               RET
D8DF  CD 3D D8         CALL    0D83DH
D8E2  CD 98 D9         CALL    0D998H
D8E5  D8               RET     C
D8E6  CD E4 DA         CALL    0DAE4H
D8E9  3A EC 00         LD      A,(00ECH)
D8EC  FE 43            CP      43H
D8EE  C0               RET     NZ
D8EF  FD 7D            *LD     A,IYL
D8F1  FE 20            CP      20H
D8F3  C0               RET     NZ
D8F4  2A E4 00         LD      HL,(00E4H)
D8F7  E9               JP      (HL)
      WRITE_CMD:
D8F8  FD 26 00         *LD     IYH,00H
D8FB  FE 3A            CP      3AH
D8FD  C4 15 D8         CALL    NZ,PREPARE_ARGUMENTS ;0D815H 
D900  11 E6 00         LD      DE,00E6H
D903  21 CF DE         LD      HL,0DECFH
D906  06 06            LD      B,06H
D908  7E               LD      A,(HL)
D909  0F               RRCA
D90A  12               LD      (DE),A
D90B  23               INC     HL
D90C  13               INC     DE
D90D  10 F9            DJNZ    0D908H
D90F  CD ED D9         CALL    0D9EDH
D912  DC 40 DE         CALL    C,0DE40H
D915  C9               RET
D916  CD 3D D8         CALL    0D83DH
D919  47               LD      B,A
D91A  FD 7D            *LD     A,IYL
D91C  FE 47            CP      47H
D91E  CA 8D DA         JP      Z,0DA8DH
D921  78               LD      A,B
D922  CD 98 D9         CALL    0D998H
D925  D8               RET     C
D926  E7               RST     20H
D927  02               DB      02H               ;PRST7
D928  64 65 6C 65 74   DB      'delet'
D92D  65 3F 20 28 59   DB      'e? (Y'
D932  29               DB      ')'
D933  A0               DB      80H+' '
D934  E7               RST     20H
D935  01               DB      01H               ;INCH
D936  FE 59            CP      59H
D938  C0               RET     NZ
D939  2A F0 DE         LD      HL,(0DEF0H)
D93C  22 F3 DE         LD      (0DEF3H),HL
D93F  AF               XOR     A
D940  32 EF DE         LD      (0DEEFH),A
D943  CD 12 DB         CALL    0DB12H
D946  38 2B            JR      C,0D973H
D948  2A F0 DE         LD      HL,(0DEF0H)
D94B  22 F5 DE         LD      (0DEF5H),HL
D94E  AF               XOR     A
D94F  2A F5 DE         LD      HL,(0DEF5H)
D952  CD 84 D9         CALL    0D984H
D955  38 1C            JR      C,0D973H
D957  22 F5 DE         LD      (0DEF5H),HL
D95A  2A F3 DE         LD      HL,(0DEF3H)
D95D  3E 01            LD      A,01H
D95F  CD 84 D9         CALL    0D984H
D962  D8               RET     C
D963  22 F3 DE         LD      (0DEF3H),HL
D966  CD 6D DA         CALL    0DA6DH
D969  6C               LD      L,H
D96A  67               LD      H,A
D96B  ED 5B F5 DE      LD      DE,(0DEF5H)
D96F  ED 52            SBC     HL,DE
D971  20 DB            JR      NZ,0D94EH
D973  2A F3 DE         LD      HL,(0DEF3H)
D976  22 F0 DE         LD      (0DEF0H),HL
D979  AF               XOR     A
D97A  32 EF DE         LD      (0DEEFH),A
D97D  CD 5B DA         CALL    0DA5BH
D980  CD 4E D8         CALL    0D84EH
D983  C9               RET
D984  22 F0 DE         LD      (0DEF0H),HL
D987  21 EF DE         LD      HL,0DEEFH
D98A  36 00            LD      (HL),00H
D98C  21 FF DE         LD      HL,0DEFFH
D98F  06 00            LD      B,00H
D991  CD 8B DB         CALL    0DB8BH
D994  2A F0 DE         LD      HL,(0DEF0H)
D997  C9               RET
D998  FE 4E            CP      4EH
D99A  20 05            JR      NZ,0D9A1H
D99C  CD EA DC         CALL    0DCEAH
D99F  18 03            JR      0D9A4H
D9A1  C4 2F DC         CALL    NZ,0DC2FH
D9A4  D8               RET     C
D9A5  47               LD      B,A
D9A6  C5               PUSH    BC
D9A7  CD D7 D9         CALL    0D9D7H
D9AA  C1               POP     BC
D9AB  DA 51 DE         JP      C,0DE51H
D9AE  78               LD      A,B
D9AF  F5               PUSH    AF
D9B0  2A 1B 00         LD      HL,(001BH)
D9B3  AF               XOR     A
D9B4  B4               OR      H
D9B5  28 14            JR      Z,0D9CBH
D9B7  FD 2E 00         *LD     IYL,00H
D9BA  ED 4B E0 00      LD      BC,(00E0H)
D9BE  22 E0 00         LD      (00E0H),HL
D9C1  ED 42            SBC     HL,BC
D9C3  ED 4B E2 00      LD      BC,(00E2H)
D9C7  09               ADD     HL,BC
D9C8  22 E2 00         LD      (00E2H),HL
D9CB  F1               POP     AF
D9CC  CD 4C DD         CALL    0DD4CH
D9CF  11 FF DE         LD      DE,0DEFFH
D9D2  CD 6B DD         CALL    0DD6BH
D9D5  B7               OR      A
D9D6  C9               RET
      PREPARE_ARGUMENTS:
D9D7  5F               LD      E,A
D9D8  D5               PUSH    DE
D9D9  CD 06 DB         CALL    0DB06H
D9DC  D1               POP     DE
D9DD  7B               LD      A,E
D9DE  D8               RET     C
D9DF  FE 01            CP      01H
D9E1  C8               RET     Z
D9E2  3D               DEC     A
D9E3  47               LD      B,A
D9E4  C5               PUSH    BC
D9E5  CD 12 DB         CALL    0DB12H
D9E8  C1               POP     BC
D9E9  D8               RET     C
D9EA  10 F8            DJNZ    0D9E4H
D9EC  C9               RET
D9ED  CD 6D DA         CALL    0DA6DH
D9F0  3C               INC     A
D9F1  CC 8D DA         CALL    Z,0DA8DH
D9F4  ED 5B E0 00      LD      DE,(00E0H)
D9F8  2A E2 00         LD      HL,(00E2H)
D9FB  23               INC     HL
D9FC  B7               OR      A
D9FD  ED 52            SBC     HL,DE
D9FF  EB               EX      DE,HL
DA00  CD 0D DC         CALL    0DC0DH
DA03  D8               RET     C
DA04  21 E0 00         LD      HL,00E0H
DA07  06 20            LD      B,20H
DA09  3E 01            LD      A,01H
DA0B  CD 8B DB         CALL    0DB8BH
DA0E  7A               LD      A,D
DA0F  B2               OR      D
DA10  2A E0 00         LD      HL,(00E0H)
DA13  28 0A            JR      Z,0DA1FH
DA15  06 00            LD      B,00H
DA17  3E 01            LD      A,01H
DA19  CD 8B DB         CALL    0DB8BH
DA1C  15               DEC     D
DA1D  20 F6            JR      NZ,0DA15H
DA1F  AF               XOR     A
DA20  B3               OR      E
DA21  28 06            JR      Z,0DA29H
DA23  43               LD      B,E
DA24  3E 01            LD      A,01H
DA26  CD 8B DB         CALL    0DB8BH
DA29  CD FC DB         CALL    0DBFCH
DA2C  AF               XOR     A
DA2D  32 EF DE         LD      (0DEEFH),A
DA30  CD 5B DA         CALL    0DA5BH
DA33  B7               OR      A
DA34  C9               RET
DA35  F5               PUSH    AF
DA36  2A EF DE         LD      HL,(0DEEFH)
DA39  ED 5B FA DE      LD      DE,(0DEFAH)
DA3D  B7               OR      A
DA3E  ED 52            SBC     HL,DE
DA40  D5               PUSH    DE
DA41  ED 5B 1B 00      LD      DE,(001BH)
DA45  19               ADD     HL,DE
DA46  D1               POP     DE
DA47  1E 02            LD      E,02H
DA49  CD F5 DB         CALL    0DBF5H
DA4C  ED 51            OUT     (C),D
DA4E  0C               INC     C
DA4F  ED 59            OUT     (C),E
DA51  3A FC DE         LD      A,(0DEFCH)
DA54  4F               LD      C,A
DA55  ED 69            OUT     (C),L
DA57  ED 61            OUT     (C),H
DA59  F1               POP     AF
DA5A  C9               RET
DA5B  C5               PUSH    BC
DA5C  CD 7F DA         CALL    0DA7FH
DA5F  3A F1 DE         LD      A,(0DEF1H)
DA62  ED 79            OUT     (C),A
DA64  2A EF DE         LD      HL,(0DEEFH)
DA67  ED 69            OUT     (C),L
DA69  ED 61            OUT     (C),H
DA6B  C1               POP     BC
DA6C  C9               RET
DA6D  C5               PUSH    BC
DA6E  CD 7F DA         CALL    0DA7FH
DA71  ED 78            IN      A,(C)
DA73  32 F1 DE         LD      (0DEF1H),A
DA76  ED 68            IN      L,(C)
DA78  ED 60            IN      H,(C)
DA7A  22 EF DE         LD      (0DEEFH),HL
DA7D  C1               POP     BC
DA7E  C9               RET
DA7F  CD F5 DB         CALL    0DBF5H
DA82  AF               XOR     A
DA83  ED 79            OUT     (C),A
DA85  0C               INC     C
DA86  ED 79            OUT     (C),A
DA88  3A FD DE         LD      A,(0DEFDH)
DA8B  4F               LD      C,A
DA8C  C9               RET
DA8D  E7               RST     20H
DA8E  02               DB      02H               ;PRST7
DA8F  20 64 65 6C 65   DB      ' dele'
DA94  74 65 20 61 6C   DB      'te al'
DA99  6C 3F 20 28 59   DB      'l? (Y'
DA9E  2F 4E 29         DB      '/N)'
DAA1  A0               DB      80H+' '
DAA2  E7               RST     20H
DAA3  01               DB      01H               ;INCH
DAA4  F5               PUSH    AF
DAA5  3E 0D            LD      A,0DH
DAA7  E7               RST     20H
DAA8  00               DB      00H               ;OUTCH
DAA9  F1               POP     AF
DAAA  FE 59            CP      59H
DAAC  C0               RET     NZ
DAAD  CD F5 DB         CALL    0DBF5H
DAB0  61               LD      H,C
DAB1  3A FD DE         LD      A,(0DEFDH)
DAB4  5F               LD      E,A
DAB5  AF               XOR     A
DAB6  57               LD      D,A
DAB7  ED 51            OUT     (C),D
DAB9  0C               INC     C
DABA  69               LD      L,C
DABB  AF               XOR     A
DABC  ED 79            OUT     (C),A
DABE  4B               LD      C,E
DABF  06 00            LD      B,00H
DAC1  3E E5            LD      A,0E5H
DAC3  ED 79            OUT     (C),A
DAC5  10 FC            DJNZ    0DAC3H
DAC7  14               INC     D
DAC8  4C               LD      C,H
DAC9  20 EC            JR      NZ,0DAB7H
DACB  1C               INC     E
DACC  3A FD DE         LD      A,(0DEFDH)
DACF  C6 04            ADD     A,04H
DAD1  BB               CP      E
DAD2  30 E3            JR      NC,0DAB7H
DAD4  21 00 01         LD      HL,0100H
DAD7  22 EF DE         LD      (0DEEFH),HL
DADA  3A FD DE         LD      A,(0DEFDH)
DADD  32 F1 DE         LD      (0DEF1H),A
DAE0  CD 5B DA         CALL    0DA5BH
DAE3  C9               RET
DAE4  ED 5B E0 00      LD      DE,(00E0H)
DAE8  2A E2 00         LD      HL,(00E2H)
DAEB  23               INC     HL
DAEC  B7               OR      A
DAED  ED 52            SBC     HL,DE
DAEF  EB               EX      DE,HL
DAF0  AF               XOR     A
DAF1  B2               OR      D
DAF2  28 09            JR      Z,0DAFDH
DAF4  06 00            LD      B,00H
DAF6  AF               XOR     A
DAF7  CD 8B DB         CALL    0DB8BH
DAFA  15               DEC     D
DAFB  20 F7            JR      NZ,0DAF4H
DAFD  7B               LD      A,E
DAFE  B7               OR      A
DAFF  C8               RET     Z
DB00  43               LD      B,E
DB01  AF               XOR     A
DB02  CD 8B DB         CALL    0DB8BH
DB05  C9               RET
DB06  3A FD DE         LD      A,(0DEFDH)
DB09  32 F1 DE         LD      (0DEF1H),A
DB0C  21 00 00         LD      HL,0000H
DB0F  22 EF DE         LD      (0DEEFH),HL
DB12  CD FC DB         CALL    0DBFCH
DB15  D8               RET     C
DB16  CD F5 DB         CALL    0DBF5H
DB19  3A F0 DE         LD      A,(0DEF0H)
DB1C  ED 79            OUT     (C),A
DB1E  0C               INC     C
DB1F  3E 0D            LD      A,0DH
DB21  ED 79            OUT     (C),A
DB23  06 03            LD      B,03H
DB25  3A F1 DE         LD      A,(0DEF1H)
DB28  4F               LD      C,A
DB29  ED 78            IN      A,(C)
DB2B  FE D3            CP      0D3H
DB2D  20 E3            JR      NZ,0DB12H
DB2F  10 F8            DJNZ    0DB29H
DB31  2A F0 DE         LD      HL,(0DEF0H)
DB34  E5               PUSH    HL
DB35  CD 6D DA         CALL    0DA6DH
DB38  5C               LD      E,H
DB39  57               LD      D,A
DB3A  E1               POP     HL
DB3B  22 F0 DE         LD      (0DEF0H),HL
DB3E  37               SCF
DB3F  EB               EX      DE,HL
DB40  ED 52            SBC     HL,DE
DB42  D8               RET     C
DB43  AF               XOR     A
DB44  32 EF DE         LD      (0DEEFH),A
DB47  21 E0 00         LD      HL,00E0H
DB4A  06 20            LD      B,20H
DB4C  AF               XOR     A
DB4D  CD 8B DB         CALL    0DB8BH
DB50  C9               RET
DB51  DD 23            INC     IX
DB53  DD 7D            *LD     A,IXL
DB55  DD B4            *OR     IXH
DB57  CC 35 DA         CALL    Z,0DA35H
DB5A  CA 29 DA         JP      Z,0DA29H
DB5D  E5               PUSH    HL
DB5E  CD 6D DA         CALL    0DA6DH
DB61  E1               POP     HL
DB62  E5               PUSH    HL
DB63  11 0D 00         LD      DE,000DH
DB66  19               ADD     HL,DE
DB67  06 03            LD      B,03H
DB69  7E               LD      A,(HL)
DB6A  FE D3            CP      0D3H
DB6C  20 0E            JR      NZ,0DB7CH
DB6E  10 F9            DJNZ    0DB69H
DB70  2A EF DE         LD      HL,(0DEEFH)
DB73  22 FA DE         LD      (0DEFAH),HL
DB76  3A F1 DE         LD      A,(0DEF1H)
DB79  32 FC DE         LD      (0DEFCH),A
DB7C  E1               POP     HL
DB7D  3E 01            LD      A,01H
DB7F  06 20            LD      B,20H
DB81  CD 8B DB         CALL    0DB8BH
DB84  CD 5B DA         CALL    0DA5BH
DB87  C9               RET
DB88  AF               XOR     A
DB89  06 20            LD      B,20H
DB8B  32 F7 DE         LD      (0DEF7H),A
DB8E  D5               PUSH    DE
DB8F  3A EF DE         LD      A,(0DEEFH)
DB92  ED 44            NEG
DB94  28 09            JR      Z,0DB9FH
DB96  5F               LD      E,A
DB97  AF               XOR     A
DB98  B0               OR      B
DB99  28 09            JR      Z,0DBA4H
DB9B  7B               LD      A,E
DB9C  B8               CP      B
DB9D  38 05            JR      C,0DBA4H
DB9F  CD AE DB         CALL    0DBAEH
DBA2  D1               POP     DE
DBA3  C9               RET
DBA4  78               LD      A,B
DBA5  93               SUB     E
DBA6  57               LD      D,A
DBA7  43               LD      B,E
DBA8  CD AE DB         CALL    0DBAEH
DBAB  42               LD      B,D
DBAC  18 F1            JR      0DB9FH
DBAE  C5               PUSH    BC
DBAF  CD E7 DB         CALL    0DBE7H
DBB2  3A F1 DE         LD      A,(0DEF1H)
DBB5  4F               LD      C,A
DBB6  3A F7 DE         LD      A,(0DEF7H)
DBB9  B7               OR      A
DBBA  20 04            JR      NZ,0DBC0H
DBBC  ED B2            INIR
DBBE  18 02            JR      0DBC2H
DBC0  ED B3            OTIR
DBC2  F1               POP     AF
DBC3  F5               PUSH    AF
DBC4  E5               PUSH    HL
DBC5  2A EF DE         LD      HL,(0DEEFH)
DBC8  B7               OR      A
DBC9  20 08            JR      NZ,0DBD3H
DBCB  24               INC     H
DBCC  22 EF DE         LD      (0DEEFH),HL
DBCF  28 09            JR      Z,0DBDAH
DBD1  18 11            JR      0DBE4H
DBD3  4F               LD      C,A
DBD4  09               ADD     HL,BC
DBD5  22 EF DE         LD      (0DEEFH),HL
DBD8  30 0A            JR      NC,0DBE4H
DBDA  21 F1 DE         LD      HL,0DEF1H
DBDD  34               INC     (HL)
DBDE  3A FD DE         LD      A,(0DEFDH)
DBE1  C6 04            ADD     A,04H
DBE3  BE               CP      (HL)
DBE4  E1               POP     HL
DBE5  C1               POP     BC
DBE6  C9               RET
DBE7  E5               PUSH    HL
DBE8  2A EF DE         LD      HL,(0DEEFH)
DBEB  CD F5 DB         CALL    0DBF5H
DBEE  ED 61            OUT     (C),H
DBF0  0C               INC     C
DBF1  ED 69            OUT     (C),L
DBF3  E1               POP     HL
DBF4  C9               RET
DBF5  3A FD DE         LD      A,(0DEFDH)
DBF8  C6 06            ADD     A,06H
DBFA  4F               LD      C,A
DBFB  C9               RET
DBFC  21 F0 DE         LD      HL,0DEF0H
DBFF  B7               OR      A
DC00  34               INC     (HL)
DC01  C0               RET     NZ
DC02  21 F1 DE         LD      HL,0DEF1H
DC05  34               INC     (HL)
DC06  3A FD DE         LD      A,(0DEFDH)
DC09  C6 04            ADD     A,04H
DC0B  BE               CP      (HL)
DC0C  C9               RET
DC0D  CD 6D DA         CALL    0DA6DH
DC10  E5               PUSH    HL
DC11  21 F1 DE         LD      HL,0DEF1H
DC14  3A FD DE         LD      A,(0DEFDH)
DC17  C6 02            ADD     A,02H
DC19  BE               CP      (HL)
DC1A  E1               POP     HL
DC1B  D0               RET     NC
DC1C  3F               CCF
DC1D  D5               PUSH    DE
DC1E  11 00 00         LD      DE,0000H
DC21  EB               EX      DE,HL
DC22  ED 52            SBC     HL,DE
DC24  B7               OR      A
DC25  11 20 00         LD      DE,0020H
DC28  ED 52            SBC     HL,DE
DC2A  D1               POP     DE
DC2B  D8               RET     C
DC2C  ED 52            SBC     HL,DE
DC2E  C9               RET
DC2F  E5               PUSH    HL
DC30  D5               PUSH    DE
DC31  C5               PUSH    BC
DC32  E7               RST     20H
DC33  02               DB      02H               ;PRST7
DC34  0D               DB      0DH
DC35  4E 72            DB      'Nr'
DC37  BA               DB      80H+':'
DC38  2A 2B 00         LD      HL,(002BH)
DC3B  22 16 00         LD      (0016H),HL
DC3E  E7               RST     20H
DC3F  01               DB      01H               ;INCH
DC40  FE 03            CP      03H
DC42  37               SCF
DC43  28 1C            JR      Z,0DC61H
DC45  E7               RST     20H
DC46  00               DB      00H               ;OUTCH
DC47  FE 0D            CP      0DH
DC49  20 F3            JR      NZ,0DC3EH
DC4B  21 00 00         LD      HL,0000H
DC4E  ED 5B 16 00      LD      DE,(0016H)
DC52  CD 30 DD         CALL    0DD30H
DC55  28 0A            JR      Z,0DC61H
DC57  E7               RST     20H
DC58  02               DB      02H               ;PRST7
DC59  3C 32 35 35 21   DB      '<255!'
DC5E  A0               DB      80H+' '
DC5F  18 D1            JR      0DC32H
DC61  C1               POP     BC
DC62  D1               POP     DE
DC63  E1               POP     HL
DC64  C9               RET
DC65  21 1B 00         LD      HL,001BH
DC68  11 E0 00         LD      DE,00E0H
DC6B  01 04 00         LD      BC,0004H
DC6E  ED B0            LDIR
DC70  2A 23 00         LD      HL,(0023H)
DC73  22 E4 00         LD      (00E4H),HL
DC76  21 ED 00         LD      HL,00EDH
DC79  3E D3            LD      A,0D3H
DC7B  06 03            LD      B,03H
DC7D  77               LD      (HL),A
DC7E  23               INC     HL
DC7F  10 FC            DJNZ    0DC7DH
DC81  CD 98 DC         CALL    0DC98H
DC84  FD 7C            *LD     A,IYH
DC86  32 EC 00         LD      (00ECH),A
DC89  2A 16 00         LD      HL,(0016H)
DC8C  01 10 00         LD      BC,0010H
DC8F  11 F0 00         LD      DE,00F0H
DC92  ED B0            LDIR
DC94  E7               RST     20H
DC95  02               DB      02H               ;PRST7
DC96  8D               DB      8DH
DC97  C9               RET
DC98  FD 7C            *LD     A,IYH
DC9A  B7               OR      A
DC9B  20 17            JR      NZ,0DCB4H
DC9D  E7               RST     20H
DC9E  02               DB      02H               ;PRST7
DC9F  0D               DB      0DH
DCA0  74 79 70         DB      'typ'
DCA3  BA               DB      80H+':'
DCA4  E7               RST     20H
DCA5  01               DB      01H               ;INCH
DCA6  FE 20            CP      20H
DCA8  30 06            JR      NC,0DCB0H
DCAA  FE 03            CP      03H
DCAC  37               SCF
DCAD  C8               RET     Z
DCAE  3E 20            LD      A,20H
DCB0  E7               RST     20H
DCB1  00               DB      00H               ;OUTCH
DCB2  FD 67            *LD     IYH,A
DCB4  E7               RST     20H
DCB5  02               DB      02H               ;PRST7
DCB6  20 66 69 6C 65   DB      ' file'
DCBB  6E 61 6D 65      DB      'name'
DCBF  BA               DB      80H+':'
DCC0  2A 2B 00         LD      HL,(002BH)
DCC3  22 16 00         LD      (0016H),HL
DCC6  0E FF            LD      C,0FFH
DCC8  0C               INC     C
DCC9  E7               RST     20H
DCCA  01               DB      01H               ;INCH
DCCB  37               SCF
DCCC  FE 03            CP      03H
DCCE  C8               RET     Z
DCCF  FE 08            CP      08H
DCD1  20 05            JR      NZ,0DCD8H
DCD3  0D               DEC     C
DCD4  FA C8 DC         JP      M,0DCC8H
DCD7  0D               DEC     C
DCD8  E7               RST     20H
DCD9  00               DB      00H               ;OUTCH
DCDA  FE 0D            CP      0DH
DCDC  79               LD      A,C
DCDD  32 F9 DE         LD      (0DEF9H),A
DCE0  C8               RET     Z
DCE1  3E 10            LD      A,10H
DCE3  B9               CP      C
DCE4  3E 08            LD      A,08H
DCE6  20 E0            JR      NZ,0DCC8H
DCE8  18 ED            JR      0DCD7H
DCEA  CD 06 DB         CALL    0DB06H
DCED  DC 6B DE         CALL    C,0DE6BH
DCF0  D8               RET     C
DCF1  21 F9 DE         LD      HL,0DEF9H
DCF4  36 00            LD      (HL),00H
DCF6  2B               DEC     HL
DCF7  36 01            LD      (HL),01H
DCF9  CD 98 DC         CALL    0DC98H
DCFC  FD 7C            *LD     A,IYH
DCFE  FE 21            CP      21H
DD00  38 06            JR      C,0DD08H
DD02  21 EC 00         LD      HL,00ECH
DD05  BE               CP      (HL)
DD06  20 1B            JR      NZ,0DD23H
DD08  3A F9 DE         LD      A,(0DEF9H)
DD0B  47               LD      B,A
DD0C  B7               OR      A
DD0D  28 0F            JR      Z,0DD1EH
DD0F  21 F0 00         LD      HL,00F0H
DD12  ED 5B 16 00      LD      DE,(0016H)
DD16  1A               LD      A,(DE)
DD17  BE               CP      (HL)
DD18  23               INC     HL
DD19  13               INC     DE
DD1A  20 07            JR      NZ,0DD23H
DD1C  10 F8            DJNZ    0DD16H
DD1E  3A F8 DE         LD      A,(0DEF8H)
DD21  B7               OR      A
DD22  C9               RET
DD23  CD 12 DB         CALL    0DB12H
DD26  DC 51 DE         CALL    C,0DE51H
DD29  D8               RET     C
DD2A  21 F8 DE         LD      HL,0DEF8H
DD2D  34               INC     (HL)
DD2E  18 CC            JR      0DCFCH
DD30  1A               LD      A,(DE)
DD31  13               INC     DE
DD32  FE 20            CP      20H
DD34  28 12            JR      Z,0DD48H
DD36  FE 2C            CP      2CH
DD38  28 0E            JR      Z,0DD48H
DD3A  D6 30            SUB     30H
DD3C  44               LD      B,H
DD3D  4D               LD      C,L
DD3E  29               ADD     HL,HL
DD3F  29               ADD     HL,HL
DD40  09               ADD     HL,BC
DD41  29               ADD     HL,HL
DD42  06 00            LD      B,00H
DD44  4F               LD      C,A
DD45  09               ADD     HL,BC
DD46  18 E8            JR      0DD30H
DD48  7C               LD      A,H
DD49  B7               OR      A
DD4A  7D               LD      A,L
DD4B  C9               RET
DD4C  11 FF DE         LD      DE,0DEFFH
DD4F  CD C2 DD         CALL    0DDC2H
DD52  CD 85 DD         CALL    0DD85H
DD55  3E 0D            LD      A,0DH
DD57  12               LD      (DE),A
DD58  13               INC     DE
DD59  06 04            LD      B,04H
DD5B  3E 20            LD      A,20H
DD5D  12               LD      (DE),A
DD5E  13               INC     DE
DD5F  10 FC            DJNZ    0DD5DH
DD61  CD 73 DD         CALL    0DD73H
DD64  3E 0D            LD      A,0DH
DD66  12               LD      (DE),A
DD67  AF               XOR     A
DD68  13               INC     DE
DD69  12               LD      (DE),A
DD6A  C9               RET
DD6B  1A               LD      A,(DE)
DD6C  13               INC     DE
DD6D  B7               OR      A
DD6E  C8               RET     Z
DD6F  E7               RST     20H
DD70  00               DB      00H               ;OUTCH
DD71  18 F8            JR      0DD6BH
DD73  3A EC 00         LD      A,(00ECH)
DD76  12               LD      (DE),A
DD77  13               INC     DE
DD78  3E 20            LD      A,20H
DD7A  12               LD      (DE),A
DD7B  13               INC     DE
DD7C  21 F0 00         LD      HL,00F0H
DD7F  01 10 00         LD      BC,0010H
DD82  ED B0            LDIR
DD84  C9               RET
DD85  06 03            LD      B,03H
DD87  DD 21 E0 00      LD      IX,00E0H
DD8B  3E 20            LD      A,20H
DD8D  12               LD      (DE),A
DD8E  13               INC     DE
DD8F  DD 6E 00         LD      L,(IX+00H)
DD92  DD 23            INC     IX
DD94  DD 66 00         LD      H,(IX+00H)
DD97  DD 23            INC     IX
DD99  CD 9F DD         CALL    0DD9FH
DD9C  10 ED            DJNZ    0DD8BH
DD9E  C9               RET
DD9F  F5               PUSH    AF
DDA0  7C               LD      A,H
DDA1  CD AA DD         CALL    0DDAAH
DDA4  7D               LD      A,L
DDA5  CD AA DD         CALL    0DDAAH
DDA8  F1               POP     AF
DDA9  C9               RET
DDAA  F5               PUSH    AF
DDAB  1F               RRA
DDAC  1F               RRA
DDAD  1F               RRA
DDAE  1F               RRA
DDAF  CD B3 DD         CALL    0DDB3H
DDB2  F1               POP     AF
DDB3  F5               PUSH    AF
DDB4  E6 0F            AND     0FH
DDB6  C6 30            ADD     A,30H
DDB8  FE 3A            CP      3AH
DDBA  38 02            JR      C,0DDBEH
DDBC  C6 07            ADD     A,07H
DDBE  12               LD      (DE),A
DDBF  13               INC     DE
DDC0  F1               POP     AF
DDC1  C9               RET
DDC2  F5               PUSH    AF
DDC3  E5               PUSH    HL
DDC4  C5               PUSH    BC
DDC5  FE 64            CP      64H
DDC7  30 04            JR      NC,0DDCDH
DDC9  06 20            LD      B,20H
DDCB  18 0E            JR      0DDDBH
DDCD  FE C8            CP      0C8H
DDCF  30 06            JR      NC,0DDD7H
DDD1  06 31            LD      B,31H
DDD3  D6 64            SUB     64H
DDD5  18 04            JR      0DDDBH
DDD7  06 32            LD      B,32H
DDD9  D6 C8            SUB     0C8H
DDDB  4F               LD      C,A
DDDC  78               LD      A,B
DDDD  12               LD      (DE),A
DDDE  13               INC     DE
DDDF  41               LD      B,C
DDE0  AF               XOR     A
DDE1  B0               OR      B
DDE2  28 06            JR      Z,0DDEAH
DDE4  AF               XOR     A
DDE5  C6 01            ADD     A,01H
DDE7  27               DAA
DDE8  10 FB            DJNZ    0DDE5H
DDEA  CD AA DD         CALL    0DDAAH
DDED  C1               POP     BC
DDEE  E1               POP     HL
DDEF  F1               POP     AF
DDF0  C9               RET
DDF1  D5               PUSH    DE
DDF2  ED 5B E0 00      LD      DE,(00E0H)
DDF6  2A E2 00         LD      HL,(00E2H)
DDF9  AF               XOR     A
DDFA  ED 52            SBC     HL,DE
DDFC  CB 3C            SRL     H
DDFE  CB 1D            RR      L
DE00  CB 3C            SRL     H
DE02  CB 1D            RR      L
DE04  B5               OR      L
DE05  28 01            JR      Z,0DE08H
DE07  24               INC     H
DE08  7C               LD      A,H
DE09  D1               POP     DE
DE0A  CD C2 DD         CALL    0DDC2H
DE0D  3E 4B            LD      A,4BH
DE0F  12               LD      (DE),A
DE10  13               INC     DE
DE11  C9               RET
DE12  D5               PUSH    DE
DE13  CD 6D DA         CALL    0DA6DH
DE16  3A FD DE         LD      A,(0DEFDH)
DE19  47               LD      B,A
DE1A  3A F1 DE         LD      A,(0DEF1H)
DE1D  90               SUB     B
DE1E  47               LD      B,A
DE1F  3E 03            LD      A,03H
DE21  90               SUB     B
DE22  CB 27            SLA     A
DE24  CB 27            SLA     A
DE26  CB 27            SLA     A
DE28  CB 27            SLA     A
DE2A  CB 27            SLA     A
DE2C  CB 27            SLA     A
DE2E  ED 4B EF DE      LD      BC,(0DEEFH)
DE32  21 00 00         LD      HL,0000H
DE35  B7               OR      A
DE36  ED 42            SBC     HL,BC
DE38  CB 3C            SRL     H
DE3A  CB 3C            SRL     H
DE3C  84               ADD     A,H
DE3D  D1               POP     DE
DE3E  18 CA            JR      0DE0AH
DE40  F5               PUSH    AF
DE41  E7               RST     20H
DE42  02               DB      02H               ;PRST7
DE43  20 64 69 73 6B   DB      ' disk'
DE48  20 66 75 6C 6C   DB      ' full'
DE4D  21               DB      '!'
DE4E  8D               DB      8DH
DE4F  18 27            JR      0DE78H
DE51  F5               PUSH    AF
DE52  E7               RST     20H
DE53  02               DB      02H               ;PRST7
DE54  20 66 69 6C 65   DB      ' file'
DE59  20 64 6F 65 73   DB      ' does'
DE5E  20 6E 6F 74 20   DB      ' not '
DE63  65 78 69 73 74   DB      'exist'
DE68  8D               DB      8DH
DE69  18 0D            JR      0DE78H
DE6B  F5               PUSH    AF
DE6C  E7               RST     20H
DE6D  02               DB      02H               ;PRST7
DE6E  20 6E 6F 20 66   DB      ' no f'
DE73  69 6C 65 73      DB      'iles'
DE77  8D               DB      8DH
DE78  C5               PUSH    BC
DE79  01 39 39         LD      BC,3939H
DE7C  C1               POP     BC
DE7D  F1               POP     AF
DE7E  C9               RET
DE7F  21 B0 00         LD      HL,00B0H
DE82  01 1E 00         LD      BC,001EH
DE85  3A BD DE         LD      A,(MonitorExt)
DE88  ED B1            CPIR
DE8A  20 10            JR      NZ,0DE9CH
DE8C  2B               DEC     HL
DE8D  11 BD DE         LD      DE,MonitorExt
DE90  06 12            LD      B,12H
DE92  1A               LD      A,(DE)
DE93  BE               CP      (HL)
DE94  23               INC     HL
DE95  13               INC     DE
DE96  20 04            JR      NZ,0DE9CH
DE98  10 F8            DJNZ    0DE92H
DE9A  18 16            JR      0DEB2H
DE9C  21 CD 00         LD      HL,00CDH
DE9F  11 DF 00         LD      DE,00DFH
DEA2  01 1E 00         LD      BC,001EH
DEA5  ED B8            LDDR
DEA7  21 BD DE         LD      HL,MonitorExt
DEAA  11 B0 00         LD      DE,00B0H
DEAD  01 12 00         LD      BC,0012H
DEB0  ED B0            LDIR
DEB2  2A 39 00         LD      HL,(0039H)
DEB5  01 06 00         LD      BC,0006H
DEB8  09               ADD     HL,BC
DEB9  E5               PUSH    HL
DEBA  C3 1E D8         JP      0D81EH
      
      MonitorExt:              
DEBD  41               DB      'A'
DEBE  26 D8            DA      0D826H
DEC0  42               DB      'B'
DEC1  35 D8            DA      0D835H
DEC3  57               DB      'W'
DEC4  09 D8            DA      0D809H
DEC6  52               DB      'R'
DEC7  06 D8            DA      0D806H
DEC9  4B               DB      'K'
DECA  16 D9            DA      0D916H
DECC  46               DB      'F'
DECD  1E D8            DA      0D81EH
DECF  84               ADD     A,H
DED0  E4 DE DE         CALL    PO,0DEDEH
DED3  D2 CE 28         JP      NC,28CEH
DED6  63               LD      H,E
DED7  29               ADD     HL,HL
DED8  20 62            JR      NZ,0DF3CH
DEDA  79               LD      A,C
DEDB  20 52            JR      NZ,0DF2FH
DEDD  2E 20            LD      L,20H
DEDF  42               LD      B,D
DEE0  72               LD      (HL),D
DEE1  6F               LD      L,A
DEE2  73               LD      (HL),E
DEE3  69               LD      L,C
DEE4  67               LD      H,A
DEE5  20 31            JR      NZ,0DF18H
DEE7  2F               CPL
DEE8  38 39            JR      C,0DF23H
DEEA  66               LD      H,(HL)
DEEB  72               LD      (HL),D
DEEC  65               LD      H,L
DEED  65               LD      H,L
DEEE  3A 00 00         LD      A,(0000H)
DEF1  5D               LD      E,L
DEF2  00               NOP
DEF3  00               NOP
DEF4  00               NOP
DEF5  00               NOP
DEF6  00               NOP
DEF7  01 28 0D         LD      BC,0D28H
DEFA  00               NOP
DEFB  00               NOP
DEFC  00               NOP
DEFD  58               LD      E,B
DEFE  01 20 20         LD      BC,2020H
DF01  20 20            JR      NZ,0DF23H
DF03  20 20            JR      NZ,0DF25H
DF05  20 20            JR      NZ,0DF27H
DF07  20 20            JR      NZ,0DF29H
DF09  20 20            JR      NZ,0DF2BH
DF0B  20 20            JR      NZ,0DF2DH
DF0D  20 20            JR      NZ,0DF2FH
DF0F  20 20            JR      NZ,0DF31H
DF11  20 20            JR      NZ,0DF33H
DF13  20 20            JR      NZ,0DF35H
DF15  66               LD      H,(HL)
DF16  72               LD      (HL),D
DF17  65               LD      H,L
DF18  65               LD      H,L
DF19  3A 20 31         LD      A,(3120H)
DF1C  39               ADD     HL,SP
DF1D  4B               LD      C,E
DF1E  0D               DEC     C
