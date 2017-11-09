0100  31 B0 00         LD      SP,00B0H
0103  18 48            JR      014DH
0105  0A               LD      A,(BC)
0106  1D               DEC     E
0107  1E 41            LD      E,41H
0109  4E               LD      C,(HL)
010A  46               LD      B,(HL)
010B  2E 20            LD      L,20H
010D  45               LD      B,L
010E  4E               LD      C,(HL)
010F  44               LD      B,H
0110  45               LD      B,L
0111  20 53            JR      NZ,0166H
0113  54               LD      D,H
0114  41               LD      B,C
0115  52               LD      D,D
0116  54               LD      D,H
0117  20 54            JR      NZ,016DH
0119  59               LD      E,C
011A  50               LD      D,B
011B  20 20            JR      NZ,013DH
011D  20 20            JR      NZ,013FH
011F  4E               LD      C,(HL)
0120  41               LD      B,C
0121  4D               LD      C,L
0122  45               LD      B,L
0123  0D               DEC     C
0124  5F               LD      E,A
0125  5F               LD      E,A
0126  5F               LD      E,A
0127  5F               LD      E,A
0128  5F               LD      E,A
0129  5F               LD      E,A
012A  5F               LD      E,A
012B  5F               LD      E,A
012C  5F               LD      E,A
012D  5F               LD      E,A
012E  5F               LD      E,A
012F  5F               LD      E,A
0130  5F               LD      E,A
0131  5F               LD      E,A
0132  5F               LD      E,A
0133  5F               LD      E,A
0134  5F               LD      E,A
0135  5F               LD      E,A
0136  5F               LD      E,A
0137  5F               LD      E,A
0138  5F               LD      E,A
0139  5F               LD      E,A
013A  5F               LD      E,A
013B  5F               LD      E,A
013C  5F               LD      E,A
013D  5F               LD      E,A
013E  5F               LD      E,A
013F  5F               LD      E,A
0140  5F               LD      E,A
0141  5F               LD      E,A
0142  5F               LD      E,A
0143  5F               LD      E,A
0144  5F               LD      E,A
0145  5F               LD      E,A
0146  5F               LD      E,A
0147  5F               LD      E,A
0148  5F               LD      E,A
0149  0A               LD      A,(BC)
014A  0A               LD      A,(BC)
014B  0D               DEC     C
014C  14               INC     D
014D  CD EB FF         CALL    0FFEBH
0150  E7               RST     20H
0151  02               DB      02H               ;PRST7
0152  0C 0D 0D         DB      0CH,0DH,0DH
0155  4E 65 75 65 20   DB      'Neue '
015A  4B 61 73 73 65   DB      'Kasse'
015F  74 74 65 3F 20   DB      'tte? '
0164  28 4A 29 3A      DB      '(J):'
0168  A0               DB      80H+' '
0169  E7               RST     20H
016A  01               DB      01H               ;INCH
016B  FE 03            CP      03H
016D  CC 38 00         CALL    Z,0038H
0170  FE 4A            CP      4AH
0172  F5               PUSH    AF
0173  E7               RST     20H
0174  02               DB      02H               ;PRST7
0175  0D 8D            DB      0DH,8DH
0177  F1               POP     AF
0178  20 65            JR      NZ,01DFH
017A  2A 2B 00         LD      HL,(002BH)
017D  22 16 00         LD      (0016H),HL
0180  E7               RST     20H
0181  02               DB      02H               ;PRST7
0182  53 65 69 74 65   DB      'Seite'
0187  3A               DB      ':'
0188  A0               DB      80H+' '
0189  E7               RST     20H
018A  01               DB      01H               ;INCH
018B  E7               RST     20H
018C  00               DB      00H               ;OUTCH
018D  E7               RST     20H
018E  02               DB      02H               ;PRST7
018F  20 20 4B 61 73   DB      '  Kas'
0194  73 65 74 74 65   DB      'sette'
0199  3A               DB      ':'
019A  A0               DB      80H+' '
019B  E7               RST     20H
019C  01               DB      01H               ;INCH
019D  FE 0D            CP      0DH
019F  28 09            JR      Z,01AAH
01A1  FE 03            CP      03H
01A3  CA 38 00         JP      Z,0038H
01A6  E7               RST     20H
01A7  00               DB      00H               ;OUTCH
01A8  18 F1            JR      019BH
01AA  3E 11            LD      A,11H
01AC  CD E8 FF         CALL    0FFE8H
01AF  3E 0D            LD      A,0DH
01B1  CD E8 FF         CALL    0FFE8H
01B4  3E 1C            LD      A,1CH
01B6  CD E8 FF         CALL    0FFE8H
01B9  2A 16 00         LD      HL,(0016H)
01BC  ED 5B 2B 00      LD      DE,(002BH)
01C0  7E               LD      A,(HL)
01C1  23               INC     HL
01C2  CD E8 FF         CALL    0FFE8H
01C5  B7               OR      A
01C6  E5               PUSH    HL
01C7  D5               PUSH    DE
01C8  EB               EX      DE,HL
01C9  ED 52            SBC     HL,DE
01CB  D1               POP     DE
01CC  E1               POP     HL
01CD  20 F1            JR      NZ,01C0H
01CF  21 05 01         LD      HL,0105H
01D2  01 48 00         LD      BC,0048H
01D5  41               LD      B,C
01D6  7E               LD      A,(HL)
01D7  23               INC     HL
01D8  F5               PUSH    AF
01D9  CD E8 FF         CALL    0FFE8H
01DC  F1               POP     AF
01DD  10 F7            DJNZ    01D6H
01DF  E7               RST     20H
01E0  02               DB      02H               ;PRST7
01E1  0D 0D            DB      0DH,0DH
01E3  53 54 41 52 54   DB      'START'
01E8  20 54 41 50 45   DB      ' TAPE'
01ED  21               DB      '!'
01EE  A0               DB      80H+' '
01EF  E7               RST     20H
01F0  04               DB      04H               ;INKEY
01F1  FE 03            CP      03H
01F3  CC 00 F0         CALL    Z,0F000H
01F6  CD 6D 02         CALL    026DH
01F9  CD 17 F4         CALL    0F417H
01FC  20 F1            JR      NZ,01EFH
01FE  06 03            LD      B,03H
0200  21 ED 00         LD      HL,00EDH
0203  7E               LD      A,(HL)
0204  FE D3            CP      0D3H
0206  23               INC     HL
0207  20 E6            JR      NZ,01EFH
0209  10 F8            DJNZ    0203H
020B  E7               RST     20H
020C  02               DB      02H               ;PRST7
020D  8D               DB      8DH
020E  06 03            LD      B,03H
0210  FD 2A 2B 00      LD      IY,(002BH)
0214  11 E0 00         LD      DE,00E0H
0217  1A               LD      A,(DE)
0218  6F               LD      L,A
0219  13               INC     DE
021A  1A               LD      A,(DE)
021B  67               LD      H,A
021C  13               INC     DE
021D  E7               RST     20H
021E  07               DB      07H               ;OUTHL
021F  E7               RST     20H
0220  0E               DB      0EH               ;OUTSP
0221  10 F4            DJNZ    0217H
0223  FD E5            PUSH    IY
0225  E1               POP     HL
0226  06 10            LD      B,10H
0228  3E 11            LD      A,11H
022A  CD E8 FF         CALL    0FFE8H
022D  7E               LD      A,(HL)
022E  CD E8 FF         CALL    0FFE8H
0231  23               INC     HL
0232  10 F9            DJNZ    022DH
0234  E7               RST     20H
0235  02               DB      02H               ;PRST7
0236  0D 8D            DB      0DH,8DH
0238  21 EC 00         LD      HL,00ECH
023B  06 14            LD      B,14H
023D  3E 20            LD      A,20H
023F  CD E8 FF         CALL    0FFE8H
0242  7E               LD      A,(HL)
0243  FE 7F            CP      7FH
0245  38 02            JR      C,0249H
0247  3E 2E            LD      A,2EH
0249  23               INC     HL
024A  F5               PUSH    AF
024B  CD E8 FF         CALL    0FFE8H
024E  F1               POP     AF
024F  E7               RST     20H
0250  00               DB      00H               ;OUTCH
0251  10 EF            DJNZ    0242H
0253  E7               RST     20H
0254  02               DB      02H               ;PRST7
0255  0D 8D            DB      0DH,8DH
0257  3E 1E            LD      A,1EH
0259  CD E8 FF         CALL    0FFE8H
025C  3E 14            LD      A,14H
025E  CD E8 FF         CALL    0FFE8H
0261  18 8C            JR      01EFH
0263  21 E0 00         LD      HL,00E0H
0266  11 1B 00         LD      DE,001BH
0269  01 04 00         LD      BC,0004H
026C  C9               RET
026D  21 FF 00         LD      HL,00FFH
0270  22 1D 00         LD      (001DH),HL
0273  21 E0 00         LD      HL,00E0H
0276  22 1B 00         LD      (001BH),HL
0279  C9               RET
027A  53               LD      D,E
027B  20 4E            JR      NZ,02CBH
027D  41               LD      B,C
027E  4D               LD      C,L
027F  45               LD      B,L
0280  4E               LD      C,(HL)
0281  53               LD      D,E
0282  42               LD      B,D
0283  4C               LD      C,H
0284  4F               LD      C,A
0285  43               LD      B,E
0286  4B               LD      C,E
0287  53               LD      D,E
0288  1E 09            LD      E,09H
028A  49               LD      C,C
028B  4E               LD      C,(HL)
028C  43               LD      B,E
028D  09               ADD     HL,BC
028E  44               LD      B,H
028F  45               LD      B,L
0290  09               ADD     HL,BC
