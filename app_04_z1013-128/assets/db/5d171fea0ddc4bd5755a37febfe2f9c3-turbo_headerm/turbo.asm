E000  C3 D9 E0         JP      0E0D9H
E003  C3 0C E0         JP      0E00CH
E006  C3 CB E0         JP      0E0CBH
E009  FD 26 00         *LD     IYH,00H
E00C  FE 3A            CP      3AH
E00E  C4 2F E0         CALL    NZ,0E02FH
E011  E7               RST     20H
E012  02               DB      02H               ;PRST7
E013  8D               DB      8DH
E014  CD 18 E2         CALL    0E218H
E017  ED B0            LDIR
E019  21 E0 00         LD      HL,00E0H
E01C  CD 93 E2         CALL    0E293H
E01F  2A E0 00         LD      HL,(00E0H)
E022  CD 0C E3         CALL    0E30CH
E025  CD 93 E2         CALL    0E293H
E028  CD 5D E0         CALL    0E05DH
E02B  CD 71 E0         CALL    0E071H
E02E  C9               RET
E02F  CD 18 E2         CALL    0E218H
E032  EB               EX      DE,HL
E033  ED B0            LDIR
E035  2A 23 00         LD      HL,(0023H)
E038  22 E4 00         LD      (00E4H),HL
E03B  21 ED 00         LD      HL,00EDH
E03E  3E D3            LD      A,0D3H
E040  06 03            LD      B,03H
E042  77               LD      (HL),A
E043  23               INC     HL
E044  10 FC            DJNZ    0E042H
E046  CD 22 E2         CALL    0E222H
E049  FD 7C            *LD     A,IYH
E04B  32 EC 00         LD      (00ECH),A
E04E  2A 16 00         LD      HL,(0016H)
E051  01 10 00         LD      BC,0010H
E054  11 F0 00         LD      DE,00F0H
E057  ED B0            LDIR
E059  E7               RST     20H
E05A  02               DB      02H               ;PRST7
E05B  8D               DB      8DH
E05C  C9               RET
E05D  EB               EX      DE,HL
E05E  2A E2 00         LD      HL,(00E2H)
E061  A7               AND     A
E062  ED 52            SBC     HL,DE
E064  EB               EX      DE,HL
E065  D8               RET     C
E066  22 25 00         LD      (0025H),HL
E069  CD 98 E2         CALL    0E298H
E06C  CD 0C E3         CALL    0E30CH
E06F  18 EC            JR      0E05DH
E071  E7               RST     20H
E072  02               DB      02H               ;PRST7
E073  76 65 72 69 66   DB      'verif'
E078  79 3F 20 28 59   DB      'y? (Y'
E07D  29               DB      ')'
E07E  BA               DB      80H+':'
E07F  E7               RST     20H
E080  01               DB      01H               ;INCH
E081  FE 59            CP      59H
E083  C0               RET     NZ
E084  E7               RST     20H
E085  02               DB      02H               ;PRST7
E086  20 72 65 77 69   DB      ' rewi'
E08B  6E 64 20         DB      'nd '
E08E  BC               DB      80H+'<'
E08F  E7               RST     20H
E090  01               DB      01H               ;INCH
E091  E7               RST     20H
E092  02               DB      02H               ;PRST7
E093  0D 8D            DB      0DH,8DH
E095  CD BF E0         CALL    0E0BFH
E098  20 FB            JR      NZ,0E095H
E09A  3E E0            LD      A,0E0H
E09C  BB               CP      E
E09D  20 F6            JR      NZ,0E095H
E09F  AF               XOR     A
E0A0  BA               CP      D
E0A1  20 F2            JR      NZ,0E095H
E0A3  CD BF E0         CALL    0E0BFH
E0A6  C4 73 E2         CALL    NZ,0E273H
E0A9  C0               RET     NZ
E0AA  62               LD      H,D
E0AB  6B               LD      L,E
E0AC  CD 0C E3         CALL    0E30CH
E0AF  3A 25 00         LD      A,(0025H)
E0B2  BB               CP      E
E0B3  20 EE            JR      NZ,0E0A3H
E0B5  3A 26 00         LD      A,(0026H)
E0B8  BA               CP      D
E0B9  20 E8            JR      NZ,0E0A3H
E0BB  CD 20 E3         CALL    0E320H
E0BE  C9               RET
E0BF  3E FF            LD      A,0FFH
E0C1  32 1E 00         LD      (001EH),A
E0C4  21 00 EC         LD      HL,0EC00H
E0C7  CD 2F E3         CALL    0E32FH
E0CA  C9               RET
E0CB  2A 16 00         LD      HL,(0016H)
E0CE  23               INC     HL
E0CF  23               INC     HL
E0D0  23               INC     HL
E0D1  7E               LD      A,(HL)
E0D2  FD 6F            *LD     IYL,A
E0D4  2B               DEC     HL
E0D5  FD 26 00         *LD     IYH,00H
E0D8  7E               LD      A,(HL)
E0D9  21 15 00         LD      HL,0015H
E0DC  36 00            LD      (HL),00H
E0DE  21 0B 00         LD      HL,000BH
E0E1  36 00            LD      (HL),00H
E0E3  FE 4E            CP      4EH
E0E5  CC 22 E2         CALL    Z,0E222H
E0E8  2A 1B 00         LD      HL,(001BH)
E0EB  22 23 00         LD      (0023H),HL
E0EE  08               EX      AF,AF'
E0EF  E7               RST     20H
E0F0  04               DB      04H               ;INKEY
E0F1  FE 03            CP      03H
E0F3  20 04            JR      NZ,0E0F9H
E0F5  E7               RST     20H
E0F6  02               DB      02H               ;PRST7
E0F7  8D               DB      8DH
E0F8  C9               RET
E0F9  3E FF            LD      A,0FFH
E0FB  32 1D 00         LD      (001DH),A
E0FE  21 E0 00         LD      HL,00E0H
E101  CD 2F E3         CALL    0E32FH
E104  08               EX      AF,AF'
E105  FE 41            CP      41H
E107  28 15            JR      Z,0E11EH
E109  08               EX      AF,AF'
E10A  20 E3            JR      NZ,0E0EFH
E10C  57               LD      D,A
E10D  B3               OR      E
E10E  32 0B 00         LD      (000BH),A
E111  06 03            LD      B,03H
E113  21 ED 00         LD      HL,00EDH
E116  7E               LD      A,(HL)
E117  FE D3            CP      0D3H
E119  23               INC     HL
E11A  20 D3            JR      NZ,0E0EFH
E11C  10 F8            DJNZ    0E116H
E11E  E7               RST     20H
E11F  02               DB      02H               ;PRST7
E120  8D               DB      8DH
E121  06 03            LD      B,03H
E123  2A E0 00         LD      HL,(00E0H)
E126  22 25 00         LD      (0025H),HL
E129  21 E1 00         LD      HL,00E1H
E12C  E7               RST     20H
E12D  0C               DB      0CH               ;OTHLS
E12E  23               INC     HL
E12F  23               INC     HL
E130  23               INC     HL
E131  23               INC     HL
E132  10 F8            DJNZ    0E12CH
E134  E7               RST     20H
E135  02               DB      02H               ;PRST7
E136  0D 8D            DB      0DH,8DH
E138  21 EC 00         LD      HL,00ECH
E13B  ED 5B 2B 00      LD      DE,(002BH)
E13F  01 14 00         LD      BC,0014H
E142  ED B0            LDIR
E144  13               INC     DE
E145  ED 53 2B 00      LD      (002BH),DE
E149  FD 7C            *LD     A,IYH
E14B  FE 21            CP      21H
E14D  38 09            JR      C,0E158H
E14F  21 EC 00         LD      HL,00ECH
E152  BE               CP      (HL)
E153  C4 86 E2         CALL    NZ,0E286H
E156  20 97            JR      NZ,0E0EFH
E158  3A 15 00         LD      A,(0015H)
E15B  47               LD      B,A
E15C  B7               OR      A
E15D  28 13            JR      Z,0E172H
E15F  21 F0 00         LD      HL,00F0H
E162  ED 5B 16 00      LD      DE,(0016H)
E166  1A               LD      A,(DE)
E167  BE               CP      (HL)
E168  23               INC     HL
E169  13               INC     DE
E16A  C4 86 E2         CALL    NZ,0E286H
E16D  C2 EF E0         JP      NZ,0E0EFH
E170  10 F4            DJNZ    0E166H
E172  2A 23 00         LD      HL,(0023H)
E175  AF               XOR     A
E176  B4               OR      H
E177  28 17            JR      Z,0E190H
E179  ED 4B E0 00      LD      BC,(00E0H)
E17D  22 E0 00         LD      (00E0H),HL
E180  E7               RST     20H
E181  07               DB      07H               ;OUTHL
E182  E7               RST     20H
E183  0E               DB      0EH               ;OUTSP
E184  ED 42            SBC     HL,BC
E186  ED 4B E2 00      LD      BC,(00E2H)
E18A  09               ADD     HL,BC
E18B  22 E2 00         LD      (00E2H),HL
E18E  E7               RST     20H
E18F  07               DB      07H               ;OUTHL
E190  E7               RST     20H
E191  02               DB      02H               ;PRST7
E192  0D 8D            DB      0DH,8DH
E194  CD 18 E2         CALL    0E218H
E197  ED B0            LDIR
E199  2A E0 00         LD      HL,(00E0H)
E19C  CD 0C E3         CALL    0E30CH
E19F  3A 0B 00         LD      A,(000BH)
E1A2  B7               OR      A
E1A3  F5               PUSH    AF
E1A4  CC 0E E2         CALL    Z,0E20EH
E1A7  F1               POP     AF
E1A8  C4 D0 E1         CALL    NZ,0E1D0H
E1AB  EB               EX      DE,HL
E1AC  2A E2 00         LD      HL,(00E2H)
E1AF  A7               AND     A
E1B0  ED 52            SBC     HL,DE
E1B2  EB               EX      DE,HL
E1B3  30 E7            JR      NC,0E19CH
E1B5  2A E2 00         LD      HL,(00E2H)
E1B8  CD 0C E3         CALL    0E30CH
E1BB  CD 20 E3         CALL    0E320H
E1BE  2A E4 00         LD      HL,(00E4H)
E1C1  22 23 00         LD      (0023H),HL
E1C4  3A EC 00         LD      A,(00ECH)
E1C7  FE 43            CP      43H
E1C9  C0               RET     NZ
E1CA  FD 7D            *LD     A,IYL
E1CC  FE 20            CP      20H
E1CE  C0               RET     NZ
E1CF  E9               JP      (HL)
E1D0  CD 2F E3         CALL    0E32FH
E1D3  28 19            JR      Z,0E1EEH
E1D5  CD 73 E2         CALL    0E273H
E1D8  E7               RST     20H
E1D9  01               DB      01H               ;INCH
E1DA  FE 03            CP      03H
E1DC  CC 38 00         CALL    Z,0038H
E1DF  E7               RST     20H
E1E0  02               DB      02H               ;PRST7
E1E1  0D 8D            DB      0DH,8DH
E1E3  01 20 00         LD      BC,0020H
E1E6  A7               AND     A
E1E7  ED 42            SBC     HL,BC
E1E9  CD 2F E3         CALL    0E32FH
E1EC  20 F5            JR      NZ,0E1E3H
E1EE  E5               PUSH    HL
E1EF  EB               EX      DE,HL
E1F0  A7               AND     A
E1F1  ED 5B 25 00      LD      DE,(0025H)
E1F5  ED 52            SBC     HL,DE
E1F7  E1               POP     HL
E1F8  28 0A            JR      Z,0E204H
E1FA  38 E7            JR      C,0E1E3H
E1FC  CD 7C E2         CALL    0E27CH
E1FF  CD 86 E2         CALL    0E286H
E202  18 D4            JR      0E1D8H
E204  E5               PUSH    HL
E205  21 20 00         LD      HL,0020H
E208  19               ADD     HL,DE
E209  22 25 00         LD      (0025H),HL
E20C  E1               POP     HL
E20D  C9               RET
E20E  CD 2F E3         CALL    0E32FH
E211  C8               RET     Z
E212  FD 6F            *LD     IYL,A
E214  CD 73 E2         CALL    0E273H
E217  C9               RET
E218  21 E0 00         LD      HL,00E0H
E21B  11 1B 00         LD      DE,001BH
E21E  01 04 00         LD      BC,0004H
E221  C9               RET
E222  FD 7C            *LD     A,IYH
E224  B7               OR      A
E225  20 13            JR      NZ,0E23AH
E227  E7               RST     20H
E228  02               DB      02H               ;PRST7
E229  0D               DB      0DH
E22A  74 79 70         DB      'typ'
E22D  BA               DB      80H+':'
E22E  E7               RST     20H
E22F  01               DB      01H               ;INCH
E230  FE 20            CP      20H
E232  30 02            JR      NC,0E236H
E234  3E 20            LD      A,20H
E236  E7               RST     20H
E237  00               DB      00H               ;OUTCH
E238  FD 67            *LD     IYH,A
E23A  E7               RST     20H
E23B  02               DB      02H               ;PRST7
E23C  20 66 69 6C 65   DB      ' file'
E241  6E 61 6D 65      DB      'name'
E245  BA               DB      80H+':'
E246  ED 5B 2B 00      LD      DE,(002BH)
E24A  ED 53 16 00      LD      (0016H),DE
E24E  0E FF            LD      C,0FFH
E250  0C               INC     C
E251  E7               RST     20H
E252  01               DB      01H               ;INCH
E253  FE 03            CP      03H
E255  CC 38 00         CALL    Z,0038H
E258  FE 08            CP      08H
E25A  20 05            JR      NZ,0E261H
E25C  0D               DEC     C
E25D  FA 50 E2         JP      M,0E250H
E260  0D               DEC     C
E261  E7               RST     20H
E262  00               DB      00H               ;OUTCH
E263  FE 0D            CP      0DH
E265  79               LD      A,C
E266  32 15 00         LD      (0015H),A
E269  C8               RET     Z
E26A  3E 10            LD      A,10H
E26C  B9               CP      C
E26D  3E 08            LD      A,08H
E26F  20 DF            JR      NZ,0E250H
E271  18 ED            JR      0E260H
E273  CD 20 E3         CALL    0E320H
E276  E7               RST     20H
E277  02               DB      02H               ;PRST7
E278  62 61 64         DB      'bad'
E27B  A0               DB      80H+' '
E27C  E7               RST     20H
E27D  02               DB      02H               ;PRST7
E27E  72 65 63 6F 72   DB      'recor'
E283  64               DB      'd'
E284  A0               DB      80H+' '
E285  C9               RET
E286  E7               RST     20H
E287  02               DB      02H               ;PRST7
E288  6E 6F 74 20 66   DB      'not f'
E28D  6F 75 6E 64      DB      'ound'
E291  8D               DB      8DH
E292  C9               RET
E293  11 7F 10         LD      DE,107FH
E296  18 03            JR      0E29BH
E298  11 0E 00         LD      DE,000EH
E29B  06 35            LD      B,35H
E29D  10 FE            DJNZ    0E29DH
E29F  CD 05 E3         CALL    0E305H
E2A2  1B               DEC     DE
E2A3  7B               LD      A,E
E2A4  B2               OR      D
E2A5  20 F4            JR      NZ,0E29BH
E2A7  0E 02            LD      C,02H
E2A9  06 18            LD      B,18H
E2AB  10 FE            DJNZ    0E2ABH
E2AD  CD 05 E3         CALL    0E305H
E2B0  0D               DEC     C
E2B1  54               LD      D,H
E2B2  5D               LD      E,L
E2B3  20 F4            JR      NZ,0E2A9H
E2B5  D5               PUSH    DE
E2B6  DD E1            POP     IX
E2B8  06 05            LD      B,05H
E2BA  10 FE            DJNZ    0E2BAH
E2BC  CD E4 E2         CALL    0E2E4H
E2BF  06 02            LD      B,02H
E2C1  10 FE            DJNZ    0E2C1H
E2C3  0E 10            LD      C,10H
E2C5  5E               LD      E,(HL)
E2C6  23               INC     HL
E2C7  56               LD      D,(HL)
E2C8  DD 19            ADD     IX,DE
E2CA  23               INC     HL
E2CB  C5               PUSH    BC
E2CC  CD E4 E2         CALL    0E2E4H
E2CF  C1               POP     BC
E2D0  0D               DEC     C
E2D1  28 06            JR      Z,0E2D9H
E2D3  00               NOP
E2D4  00               NOP
E2D5  00               NOP
E2D6  00               NOP
E2D7  18 EC            JR      0E2C5H
E2D9  DD E5            PUSH    IX
E2DB  D1               POP     DE
E2DC  06 03            LD      B,03H
E2DE  10 FE            DJNZ    0E2DEH
E2E0  CD E4 E2         CALL    0E2E4H
E2E3  C9               RET
E2E4  0E 10            LD      C,10H
E2E6  CB 3A            SRL     D
E2E8  CB 1B            RR      E
E2EA  30 07            JR      NC,0E2F3H
E2EC  06 03            LD      B,03H
E2EE  10 FE            DJNZ    0E2EEH
E2F0  00               NOP
E2F1  18 03            JR      0E2F6H
E2F3  CD 05 E3         CALL    0E305H
E2F6  06 0B            LD      B,0BH
E2F8  10 FE            DJNZ    0E2F8H
E2FA  CD 05 E3         CALL    0E305H
E2FD  0D               DEC     C
E2FE  C8               RET     Z
E2FF  06 07            LD      B,07H
E301  10 FE            DJNZ    0E301H
E303  18 E1            JR      0E2E6H
E305  DB 02            IN      A,(02H)
E307  EE 80            XOR     80H
E309  D3 02            OUT     (02H),A
E30B  C9               RET
E30C  D5               PUSH    DE
E30D  E5               PUSH    HL
E30E  ED 5B 2B 00      LD      DE,(002BH)
E312  E7               RST     20H
E313  07               DB      07H               ;OUTHL
E314  2A 2B 00         LD      HL,(002BH)
E317  36 20            LD      (HL),20H
E319  ED 53 2B 00      LD      (002BH),DE
E31D  E1               POP     HL
E31E  D1               POP     DE
E31F  C9               RET
E320  E5               PUSH    HL
E321  C5               PUSH    BC
E322  2A 2B 00         LD      HL,(002BH)
E325  01 05 00         LD      BC,0005H
E328  09               ADD     HL,BC
E329  22 2B 00         LD      (002BH),HL
E32C  C1               POP     BC
E32D  E1               POP     HL
E32E  C9               RET
E32F  CD DC E3         CALL    0E3DCH
E332  CD E6 E3         CALL    0E3E6H
E335  0E 07            LD      C,07H
E337  11 08 05         LD      DE,0508H
E33A  C3 3F E3         JP      0E33FH
E33D  00               NOP
E33E  00               NOP
E33F  CD DC E3         CALL    0E3DCH
E342  CD DC E3         CALL    0E3DCH
E345  20 E8            JR      NZ,0E32FH
E347  15               DEC     D
E348  20 F8            JR      NZ,0E342H
E34A  0D               DEC     C
E34B  28 0C            JR      Z,0E359H
E34D  DB 02            IN      A,(02H)
E34F  A8               XOR     B
E350  CB 77            BIT     6,A
E352  20 E3            JR      NZ,0E337H
E354  1D               DEC     E
E355  20 F6            JR      NZ,0E34DH
E357  18 D6            JR      0E32FH
E359  CD E6 E3         CALL    0E3E6H
E35C  3E 20            LD      A,20H
E35E  3D               DEC     A
E35F  20 FD            JR      NZ,0E35EH
E361  CD DC E3         CALL    0E3DCH
E364  20 F3            JR      NZ,0E359H
E366  CD E6 E3         CALL    0E3E6H
E369  3E 0D            LD      A,0DH
E36B  3D               DEC     A
E36C  20 FD            JR      NZ,0E36BH
E36E  CD BD E3         CALL    0E3BDH
E371  ED 53 13 00      LD      (0013H),DE
E375  D5               PUSH    DE
E376  DD E1            POP     IX
E378  3E 07            LD      A,07H
E37A  0E 10            LD      C,10H
E37C  3D               DEC     A
E37D  20 FD            JR      NZ,0E37CH
E37F  CD BD E3         CALL    0E3BDH
E382  DD 19            ADD     IX,DE
E384  C5               PUSH    BC
E385  4D               LD      C,L
E386  44               LD      B,H
E387  2A 1D 00         LD      HL,(001DH)
E38A  AF               XOR     A
E38B  ED 42            SBC     HL,BC
E38D  69               LD      L,C
E38E  60               LD      H,B
E38F  C1               POP     BC
E390  38 0A            JR      C,0E39CH
E392  73               LD      (HL),E
E393  23               INC     HL
E394  72               LD      (HL),D
E395  18 06            JR      0E39DH
E397  3E 01            LD      A,01H
E399  3D               DEC     A
E39A  20 FD            JR      NZ,0E399H
E39C  23               INC     HL
E39D  23               INC     HL
E39E  0D               DEC     C
E39F  28 07            JR      Z,0E3A8H
E3A1  C3 A6 E3         JP      0E3A6H
E3A4  00               NOP
E3A5  00               NOP
E3A6  18 D7            JR      0E37FH
E3A8  C3 AD E3         JP      0E3ADH
E3AB  00               NOP
E3AC  00               NOP
E3AD  CD BD E3         CALL    0E3BDH
E3B0  EB               EX      DE,HL
E3B1  DD E5            PUSH    IX
E3B3  C1               POP     BC
E3B4  AF               XOR     A
E3B5  ED 42            SBC     HL,BC
E3B7  EB               EX      DE,HL
E3B8  ED 5B 13 00      LD      DE,(0013H)
E3BC  C9               RET
E3BD  E5               PUSH    HL
E3BE  2E 10            LD      L,10H
E3C0  CD DC E3         CALL    0E3DCH
E3C3  20 03            JR      NZ,0E3C8H
E3C5  AF               XOR     A
E3C6  18 01            JR      0E3C9H
E3C8  37               SCF
E3C9  CB 1A            RR      D
E3CB  CB 1B            RR      E
E3CD  CD E6 E3         CALL    0E3E6H
E3D0  2D               DEC     L
E3D1  28 07            JR      Z,0E3DAH
E3D3  3E 0C            LD      A,0CH
E3D5  3D               DEC     A
E3D6  20 FD            JR      NZ,0E3D5H
E3D8  18 E6            JR      0E3C0H
E3DA  E1               POP     HL
E3DB  C9               RET
E3DC  DB 02            IN      A,(02H)
E3DE  A8               XOR     B
E3DF  CB 77            BIT     6,A
E3E1  F5               PUSH    AF
E3E2  A8               XOR     B
E3E3  47               LD      B,A
E3E4  F1               POP     AF
E3E5  C9               RET
E3E6  DB 02            IN      A,(02H)
E3E8  A8               XOR     B
E3E9  CB 77            BIT     6,A
E3EB  28 F9            JR      Z,0E3E6H
E3ED  C9               RET
E3EE  21 FA E3         LD      HL,0E3FAH
E3F1  11 B6 00         LD      DE,00B6H
E3F4  01 06 00         LD      BC,0006H
E3F7  ED B0            LDIR
E3F9  FF               RST     38H
E3FA  52               LD      D,D
E3FB  06 E0            LD      B,0E0H
E3FD  57               LD      D,A
E3FE  09               ADD     HL,BC
E3FF  E0               RET     PO
