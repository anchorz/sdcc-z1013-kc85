E000  C3 E9 E0         JP      0E0E9H
E003  C3 1B E0         JP      0E01BH
E006  C3 DB E0         JP      0E0DBH
E009  C3 18 E0         JP      0E018H
E00C  C3 D8 E1         JP      0E1D8H
E00F  C3 9C E2         JP      0E29CH
E012  C3 AF E1         JP      0E1AFH
E015  C3 3E E0         JP      0E03EH
E018  FD 26 00         *LD     IYH,00H
E01B  FE 3A            CP      3AH
E01D  C4 3E E0         CALL    NZ,0E03EH
E020  E7               RST     20H
E021  02               DB      02H               ;PRST7
E022  8D               DB      8DH
E023  CD 18 E2         CALL    0E218H
E026  ED B0            LDIR
E028  21 E0 00         LD      HL,00E0H
E02B  CD 91 E2         CALL    0E291H
E02E  2A E0 00         LD      HL,(00E0H)
E031  CD 0B E3         CALL    0E30BH
E034  CD 91 E2         CALL    0E291H
E037  CD 6C E0         CALL    0E06CH
E03A  CD 80 E0         CALL    0E080H
E03D  C9               RET
E03E  CD 18 E2         CALL    0E218H
E041  EB               EX      DE,HL
E042  ED B0            LDIR
E044  2A 23 00         LD      HL,(0023H)
E047  22 E4 00         LD      (00E4H),HL
E04A  21 ED 00         LD      HL,00EDH
E04D  3E D3            LD      A,0D3H
E04F  06 03            LD      B,03H
E051  77               LD      (HL),A
E052  23               INC     HL
E053  10 FC            DJNZ    0E051H
E055  CD 22 E2         CALL    0E222H
E058  FD 7C            *LD     A,IYH
E05A  32 EC 00         LD      (00ECH),A
E05D  2A 16 00         LD      HL,(0016H)
E060  01 10 00         LD      BC,0010H
E063  11 F0 00         LD      DE,00F0H
E066  ED B0            LDIR
E068  E7               RST     20H
E069  02               DB      02H               ;PRST7
E06A  8D               DB      8DH
E06B  C9               RET
E06C  EB               EX      DE,HL
E06D  2A E2 00         LD      HL,(00E2H)
E070  A7               AND     A
E071  ED 52            SBC     HL,DE
E073  EB               EX      DE,HL
E074  D8               RET     C
E075  22 25 00         LD      (0025H),HL
E078  CD 96 E2         CALL    0E296H
E07B  CD 0B E3         CALL    0E30BH
E07E  18 EC            JR      0E06CH
E080  E7               RST     20H
E081  02               DB      02H               ;PRST7
E082  76 65 72 69 66   DB      'verif'
E087  79 3F 20 28 59   DB      'y? (Y'
E08C  29               DB      ')'
E08D  BA               DB      80H+':'
E08E  E7               RST     20H
E08F  01               DB      01H               ;INCH
E090  FE 59            CP      59H
E092  3F               CCF
E093  C0               RET     NZ
E094  E7               RST     20H
E095  02               DB      02H               ;PRST7
E096  20 72 65 77 69   DB      ' rewi'
E09B  6E 64 20         DB      'nd '
E09E  BC               DB      80H+'<'
E09F  E7               RST     20H
E0A0  01               DB      01H               ;INCH
E0A1  E7               RST     20H
E0A2  02               DB      02H               ;PRST7
E0A3  0D 8D            DB      0DH,8DH
E0A5  CD CF E0         CALL    0E0CFH
E0A8  20 FB            JR      NZ,0E0A5H
E0AA  3E E0            LD      A,0E0H
E0AC  BB               CP      E
E0AD  20 F6            JR      NZ,0E0A5H
E0AF  AF               XOR     A
E0B0  BA               CP      D
E0B1  20 F2            JR      NZ,0E0A5H
E0B3  CD CF E0         CALL    0E0CFH
E0B6  C4 71 E2         CALL    NZ,0E271H
E0B9  C0               RET     NZ
E0BA  62               LD      H,D
E0BB  6B               LD      L,E
E0BC  CD 0B E3         CALL    0E30BH
E0BF  3A 25 00         LD      A,(0025H)
E0C2  BB               CP      E
E0C3  20 EE            JR      NZ,0E0B3H
E0C5  3A 26 00         LD      A,(0026H)
E0C8  BA               CP      D
E0C9  20 E8            JR      NZ,0E0B3H
E0CB  CD 1F E3         CALL    0E31FH
E0CE  C9               RET
E0CF  3E FF            LD      A,0FFH
E0D1  32 1E 00         LD      (001EH),A
E0D4  21 00 EC         LD      HL,0EC00H
E0D7  CD 2D E3         CALL    0E32DH
E0DA  C9               RET
E0DB  2A 16 00         LD      HL,(0016H)
E0DE  23               INC     HL
E0DF  23               INC     HL
E0E0  23               INC     HL
E0E1  7E               LD      A,(HL)
E0E2  FD 6F            *LD     IYL,A
E0E4  2B               DEC     HL
E0E5  FD 26 00         *LD     IYH,00H
E0E8  7E               LD      A,(HL)
E0E9  21 15 00         LD      HL,0015H
E0EC  36 00            LD      (HL),00H
E0EE  FE 4E            CP      4EH
E0F0  E5               PUSH    HL
E0F1  CC 22 E2         CALL    Z,0E222H
E0F4  E1               POP     HL
E0F5  2A 1B 00         LD      HL,(001BH)
E0F8  22 23 00         LD      (0023H),HL
E0FB  CD AF E1         CALL    0E1AFH
E0FE  E7               RST     20H
E0FF  02               DB      02H               ;PRST7
E100  8D               DB      8DH
E101  06 03            LD      B,03H
E103  2A E0 00         LD      HL,(00E0H)
E106  22 25 00         LD      (0025H),HL
E109  21 E1 00         LD      HL,00E1H
E10C  E7               RST     20H
E10D  0C               DB      0CH               ;OTHLS
E10E  23               INC     HL
E10F  23               INC     HL
E110  23               INC     HL
E111  23               INC     HL
E112  10 F8            DJNZ    0E10CH
E114  E7               RST     20H
E115  02               DB      02H               ;PRST7
E116  0D 8D            DB      0DH,8DH
E118  21 EC 00         LD      HL,00ECH
E11B  ED 5B 2B 00      LD      DE,(002BH)
E11F  01 14 00         LD      BC,0014H
E122  ED B0            LDIR
E124  13               INC     DE
E125  ED 53 2B 00      LD      (002BH),DE
E129  FD 7C            *LD     A,IYH
E12B  FE 21            CP      21H
E12D  38 09            JR      C,0E138H
E12F  21 EC 00         LD      HL,00ECH
E132  BE               CP      (HL)
E133  C4 84 E2         CALL    NZ,0E284H
E136  20 C3            JR      NZ,0E0FBH
E138  3A 15 00         LD      A,(0015H)
E13B  47               LD      B,A
E13C  B7               OR      A
E13D  28 13            JR      Z,0E152H
E13F  21 F0 00         LD      HL,00F0H
E142  ED 5B 16 00      LD      DE,(0016H)
E146  1A               LD      A,(DE)
E147  BE               CP      (HL)
E148  23               INC     HL
E149  13               INC     DE
E14A  C4 84 E2         CALL    NZ,0E284H
E14D  C2 FB E0         JP      NZ,0E0FBH
E150  10 F4            DJNZ    0E146H
E152  2A 23 00         LD      HL,(0023H)
E155  AF               XOR     A
E156  B4               OR      H
E157  28 17            JR      Z,0E170H
E159  ED 4B E0 00      LD      BC,(00E0H)
E15D  22 E0 00         LD      (00E0H),HL
E160  E7               RST     20H
E161  07               DB      07H               ;OUTHL
E162  E7               RST     20H
E163  0E               DB      0EH               ;OUTSP
E164  ED 42            SBC     HL,BC
E166  ED 4B E2 00      LD      BC,(00E2H)
E16A  09               ADD     HL,BC
E16B  22 E2 00         LD      (00E2H),HL
E16E  E7               RST     20H
E16F  07               DB      07H               ;OUTHL
E170  E7               RST     20H
E171  02               DB      02H               ;PRST7
E172  0D 8D            DB      0DH,8DH
E174  CD 18 E2         CALL    0E218H
E177  ED B0            LDIR
E179  08               EX      AF,AF'
E17A  F5               PUSH    AF
E17B  CC 74 E2         CALL    Z,0E274H
E17E  F1               POP     AF
E17F  C8               RET     Z
E180  2A E0 00         LD      HL,(00E0H)
E183  CD 0B E3         CALL    0E30BH
E186  CD D8 E1         CALL    0E1D8H
E189  EB               EX      DE,HL
E18A  2A E2 00         LD      HL,(00E2H)
E18D  B7               OR      A
E18E  ED 52            SBC     HL,DE
E190  EB               EX      DE,HL
E191  30 F0            JR      NC,0E183H
E193  2A E2 00         LD      HL,(00E2H)
E196  CD 0B E3         CALL    0E30BH
E199  CD 1F E3         CALL    0E31FH
E19C  2A E4 00         LD      HL,(00E4H)
E19F  22 23 00         LD      (0023H),HL
E1A2  3A EC 00         LD      A,(00ECH)
E1A5  FE 43            CP      43H
E1A7  3F               CCF
E1A8  C0               RET     NZ
E1A9  FD 7D            *LD     A,IYL
E1AB  FE 20            CP      20H
E1AD  C0               RET     NZ
E1AE  E9               JP      (HL)
E1AF  E7               RST     20H
E1B0  04               DB      04H               ;INKEY
E1B1  FE 03            CP      03H
E1B3  20 05            JR      NZ,0E1BAH
E1B5  E7               RST     20H
E1B6  02               DB      02H               ;PRST7
E1B7  8D               DB      8DH
E1B8  F1               POP     AF
E1B9  C9               RET
E1BA  3E FF            LD      A,0FFH
E1BC  32 1D 00         LD      (001DH),A
E1BF  21 E0 00         LD      HL,00E0H
E1C2  CD 2D E3         CALL    0E32DH
E1C5  20 E8            JR      NZ,0E1AFH
E1C7  7A               LD      A,D
E1C8  B3               OR      E
E1C9  08               EX      AF,AF'
E1CA  06 03            LD      B,03H
E1CC  21 ED 00         LD      HL,00EDH
E1CF  7E               LD      A,(HL)
E1D0  FE D3            CP      0D3H
E1D2  23               INC     HL
E1D3  20 DA            JR      NZ,0E1AFH
E1D5  10 F8            DJNZ    0E1CFH
E1D7  C9               RET
E1D8  CD 2D E3         CALL    0E32DH
E1DB  28 1D            JR      Z,0E1FAH
E1DD  CD 71 E2         CALL    0E271H
E1E0  E7               RST     20H
E1E1  01               DB      01H               ;INCH
E1E2  FE 03            CP      03H
E1E4  28 30            JR      Z,0E216H
E1E6  E7               RST     20H
E1E7  02               DB      02H               ;PRST7
E1E8  0D 8D            DB      0DH,8DH
E1EA  01 20 00         LD      BC,0020H
E1ED  A7               AND     A
E1EE  ED 42            SBC     HL,BC
E1F0  CD 2D E3         CALL    0E32DH
E1F3  20 F5            JR      NZ,0E1EAH
E1F5  7A               LD      A,D
E1F6  A3               AND     E
E1F7  3C               INC     A
E1F8  28 1C            JR      Z,0E216H
E1FA  E5               PUSH    HL
E1FB  2A 25 00         LD      HL,(0025H)
E1FE  EB               EX      DE,HL
E1FF  ED 52            SBC     HL,DE
E201  E1               POP     HL
E202  28 0A            JR      Z,0E20EH
E204  38 E4            JR      C,0E1EAH
E206  CD 7A E2         CALL    0E27AH
E209  CD 84 E2         CALL    0E284H
E20C  18 D2            JR      0E1E0H
E20E  E5               PUSH    HL
E20F  21 20 00         LD      HL,0020H
E212  19               ADD     HL,DE
E213  22 25 00         LD      (0025H),HL
E216  E1               POP     HL
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
E246  2A 2B 00         LD      HL,(002BH)
E249  22 16 00         LD      (0016H),HL
E24C  0E FF            LD      C,0FFH
E24E  0C               INC     C
E24F  E7               RST     20H
E250  01               DB      01H               ;INCH
E251  FE 03            CP      03H
E253  CA 1C E3         JP      Z,0E31CH
E256  FE 08            CP      08H
E258  20 05            JR      NZ,0E25FH
E25A  0D               DEC     C
E25B  FA 4E E2         JP      M,0E24EH
E25E  0D               DEC     C
E25F  E7               RST     20H
E260  00               DB      00H               ;OUTCH
E261  FE 0D            CP      0DH
E263  79               LD      A,C
E264  32 15 00         LD      (0015H),A
E267  C8               RET     Z
E268  3E 10            LD      A,10H
E26A  B9               CP      C
E26B  3E 08            LD      A,08H
E26D  20 DF            JR      NZ,0E24EH
E26F  18 ED            JR      0E25EH
E271  CD 1F E3         CALL    0E31FH
E274  E7               RST     20H
E275  02               DB      02H               ;PRST7
E276  62 61 64         DB      'bad'
E279  A0               DB      80H+' '
E27A  E7               RST     20H
E27B  02               DB      02H               ;PRST7
E27C  72 65 63 6F 72   DB      'recor'
E281  64               DB      'd'
E282  A0               DB      80H+' '
E283  C9               RET
E284  E7               RST     20H
E285  02               DB      02H               ;PRST7
E286  6E 6F 74 20 66   DB      'not f'
E28B  6F 75 6E 64      DB      'ound'
E28F  8D               DB      8DH
E290  C9               RET
E291  11 00 10         LD      DE,1000H
E294  18 03            JR      0E299H
E296  11 0E 00         LD      DE,000EH
E299  E5               PUSH    HL
E29A  DD E1            POP     IX
E29C  06 70            LD      B,70H
E29E  10 FE            DJNZ    0E29EH
E2A0  CD 04 E3         CALL    0E304H
E2A3  1B               DEC     DE
E2A4  7B               LD      A,E
E2A5  B2               OR      D
E2A6  20 F4            JR      NZ,0E29CH
E2A8  0E 02            LD      C,02H
E2AA  06 35            LD      B,35H
E2AC  10 FE            DJNZ    0E2ACH
E2AE  CD 04 E3         CALL    0E304H
E2B1  0D               DEC     C
E2B2  20 F6            JR      NZ,0E2AAH
E2B4  DD E5            PUSH    IX
E2B6  D1               POP     DE
E2B7  06 12            LD      B,12H
E2B9  10 FE            DJNZ    0E2B9H
E2BB  CD E3 E2         CALL    0E2E3H
E2BE  06 0F            LD      B,0FH
E2C0  10 FE            DJNZ    0E2C0H
E2C2  0E 10            LD      C,10H
E2C4  5E               LD      E,(HL)
E2C5  23               INC     HL
E2C6  56               LD      D,(HL)
E2C7  DD 19            ADD     IX,DE
E2C9  23               INC     HL
E2CA  C5               PUSH    BC
E2CB  CD E3 E2         CALL    0E2E3H
E2CE  C1               POP     BC
E2CF  0D               DEC     C
E2D0  28 06            JR      Z,0E2D8H
E2D2  06 0E            LD      B,0EH
E2D4  10 FE            DJNZ    0E2D4H
E2D6  18 EC            JR      0E2C4H
E2D8  DD E5            PUSH    IX
E2DA  D1               POP     DE
E2DB  06 10            LD      B,10H
E2DD  10 FE            DJNZ    0E2DDH
E2DF  CD E3 E2         CALL    0E2E3H
E2E2  C9               RET
E2E3  0E 10            LD      C,10H
E2E5  CB 3A            SRL     D
E2E7  CB 1B            RR      E
E2E9  30 07            JR      NC,0E2F2H
E2EB  06 03            LD      B,03H
E2ED  10 FE            DJNZ    0E2EDH
E2EF  00               NOP
E2F0  18 03            JR      0E2F5H
E2F2  CD 04 E3         CALL    0E304H
E2F5  06 19            LD      B,19H
E2F7  10 FE            DJNZ    0E2F7H
E2F9  CD 04 E3         CALL    0E304H
E2FC  0D               DEC     C
E2FD  C8               RET     Z
E2FE  06 15            LD      B,15H
E300  10 FE            DJNZ    0E300H
E302  18 E1            JR      0E2E5H
E304  DB 02            IN      A,(02H)
E306  EE 80            XOR     80H
E308  D3 02            OUT     (02H),A
E30A  C9               RET
E30B  D5               PUSH    DE
E30C  E5               PUSH    HL
E30D  ED 5B 2B 00      LD      DE,(002BH)
E311  E7               RST     20H
E312  07               DB      07H               ;OUTHL
E313  2A 2B 00         LD      HL,(002BH)
E316  36 20            LD      (HL),20H
E318  ED 53 2B 00      LD      (002BH),DE
E31C  E1               POP     HL
E31D  D1               POP     DE
E31E  C9               RET
E31F  E5               PUSH    HL
E320  2A 2B 00         LD      HL,(002BH)
E323  23               INC     HL
E324  23               INC     HL
E325  23               INC     HL
E326  23               INC     HL
E327  23               INC     HL
E328  22 2B 00         LD      (002BH),HL
E32B  E1               POP     HL
E32C  C9               RET
E32D  CD D8 E3         CALL    0E3D8H
E330  CD E2 E3         CALL    0E3E2H
E333  0E 07            LD      C,07H
E335  11 10 09         LD      DE,0910H
E338  3E 07            LD      A,07H
E33A  3D               DEC     A
E33B  20 FD            JR      NZ,0E33AH
E33D  CD D8 E3         CALL    0E3D8H
E340  CD D8 E3         CALL    0E3D8H
E343  20 E8            JR      NZ,0E32DH
E345  15               DEC     D
E346  20 F8            JR      NZ,0E340H
E348  0D               DEC     C
E349  28 0C            JR      Z,0E357H
E34B  DB 02            IN      A,(02H)
E34D  A8               XOR     B
E34E  CB 77            BIT     6,A
E350  20 E3            JR      NZ,0E335H
E352  1D               DEC     E
E353  20 F6            JR      NZ,0E34BH
E355  18 D6            JR      0E32DH
E357  CD E2 E3         CALL    0E3E2H
E35A  3E 44            LD      A,44H
E35C  3D               DEC     A
E35D  20 FD            JR      NZ,0E35CH
E35F  CD D8 E3         CALL    0E3D8H
E362  20 F3            JR      NZ,0E357H
E364  CD E2 E3         CALL    0E3E2H
E367  3E 1E            LD      A,1EH
E369  3D               DEC     A
E36A  20 FD            JR      NZ,0E369H
E36C  CD B9 E3         CALL    0E3B9H
E36F  ED 53 13 00      LD      (0013H),DE
E373  D5               PUSH    DE
E374  DD E1            POP     IX
E376  3E 1A            LD      A,1AH
E378  0E 10            LD      C,10H
E37A  3D               DEC     A
E37B  20 FD            JR      NZ,0E37AH
E37D  CD B9 E3         CALL    0E3B9H
E380  DD 19            ADD     IX,DE
E382  C5               PUSH    BC
E383  4D               LD      C,L
E384  44               LD      B,H
E385  2A 1D 00         LD      HL,(001DH)
E388  AF               XOR     A
E389  ED 42            SBC     HL,BC
E38B  69               LD      L,C
E38C  60               LD      H,B
E38D  C1               POP     BC
E38E  38 05            JR      C,0E395H
E390  73               LD      (HL),E
E391  23               INC     HL
E392  72               LD      (HL),D
E393  18 06            JR      0E39BH
E395  3E 01            LD      A,01H
E397  3D               DEC     A
E398  20 FD            JR      NZ,0E397H
E39A  23               INC     HL
E39B  23               INC     HL
E39C  0D               DEC     C
E39D  28 07            JR      Z,0E3A6H
E39F  3E 12            LD      A,12H
E3A1  3D               DEC     A
E3A2  20 FD            JR      NZ,0E3A1H
E3A4  18 D7            JR      0E37DH
E3A6  3E 12            LD      A,12H
E3A8  3D               DEC     A
E3A9  20 FD            JR      NZ,0E3A8H
E3AB  CD B9 E3         CALL    0E3B9H
E3AE  EB               EX      DE,HL
E3AF  DD E5            PUSH    IX
E3B1  C1               POP     BC
E3B2  ED 42            SBC     HL,BC
E3B4  2A 13 00         LD      HL,(0013H)
E3B7  EB               EX      DE,HL
E3B8  C9               RET
E3B9  E5               PUSH    HL
E3BA  2E 10            LD      L,10H
E3BC  CD D8 E3         CALL    0E3D8H
E3BF  20 03            JR      NZ,0E3C4H
E3C1  AF               XOR     A
E3C2  18 01            JR      0E3C5H
E3C4  37               SCF
E3C5  CB 1A            RR      D
E3C7  CB 1B            RR      E
E3C9  CD E2 E3         CALL    0E3E2H
E3CC  2D               DEC     L
E3CD  28 07            JR      Z,0E3D6H
E3CF  3E 1E            LD      A,1EH
E3D1  3D               DEC     A
E3D2  20 FD            JR      NZ,0E3D1H
E3D4  18 E6            JR      0E3BCH
E3D6  E1               POP     HL
E3D7  C9               RET
E3D8  DB 02            IN      A,(02H)
E3DA  A8               XOR     B
E3DB  CB 77            BIT     6,A
E3DD  F5               PUSH    AF
E3DE  A8               XOR     B
E3DF  47               LD      B,A
E3E0  F1               POP     AF
E3E1  C9               RET
E3E2  DB 02            IN      A,(02H)
E3E4  A8               XOR     B
E3E5  CB 77            BIT     6,A
E3E7  28 F9            JR      Z,0E3E2H
E3E9  C9               RET
E3EA  F9               LD      SP,HL
E3EB  C9               RET
E3EC  F9               LD      SP,HL
E3ED  C9               RET
E3EE  21 FA E3         LD      HL,0E3FAH
E3F1  11 B0 00         LD      DE,00B0H
E3F4  01 06 00         LD      BC,0006H
E3F7  ED B0            LDIR
E3F9  FF               RST     38H
E3FA  4C               LD      C,H
E3FB  06 E0            LD      B,0E0H
E3FD  53               LD      D,E
E3FE  09               ADD     HL,BC
E3FF  E0               RET     PO
