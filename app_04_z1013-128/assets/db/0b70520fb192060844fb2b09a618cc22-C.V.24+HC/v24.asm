E800  E5               PUSH    HL
E801  21 0F E8         LD      HL,0E80FH
E804  22 21 00         LD      (0021H),HL
E807  21 00 EC         LD      HL,0EC00H
E80A  22 FE EB         LD      (0EBFEH),HL
E80D  E1               POP     HL
E80E  FF               RST     38H
E80F  E3               EX      (SP),HL
E810  F5               PUSH    AF
E811  7E               LD      A,(HL)
E812  32 03 00         LD      (0003H),A
E815  23               INC     HL
E816  F1               POP     AF
E817  E3               EX      (SP),HL
E818  E5               PUSH    HL
E819  D5               PUSH    DE
E81A  C5               PUSH    BC
E81B  F5               PUSH    AF
E81C  3A 03 00         LD      A,(0003H)
E81F  FE 00            CP      00H
E821  28 16            JR      Z,0E839H
E823  FE 02            CP      02H
E825  28 12            JR      Z,0E839H
E827  FE 06            CP      06H
E829  28 0E            JR      Z,0E839H
E82B  FE 07            CP      07H
E82D  28 0A            JR      Z,0E839H
E82F  FE 0C            CP      0CH
E831  28 06            JR      Z,0E839H
E833  FE 0D            CP      0DH
E835  28 02            JR      Z,0E839H
E837  18 0F            JR      0E848H
E839  F5               PUSH    AF
E83A  3A 6E 00         LD      A,(006EH)
E83D  CB 47            BIT     0,A
E83F  20 03            JR      NZ,0E844H
E841  F1               POP     AF
E842  18 49            JR      0E88DH
E844  F1               POP     AF
E845  18 1E            JR      0E865H
E847  00               NOP
E848  FE 01            CP      01H
E84A  28 02            JR      Z,0E84EH
E84C  18 3F            JR      0E88DH
E84E  CD 19 F1         CALL    0F119H
E851  FE 00            CP      00H
E853  28 F9            JR      Z,0E84EH
E855  FE 10            CP      10H
E857  20 09            JR      NZ,0E862H
E859  C3 A0 E8         JP      0E8A0H
E85C  00               NOP
E85D  00               NOP
E85E  C3 8C E8         JP      0E88CH
E861  00               NOP
E862  C3 8D E8         JP      0E88DH
E865  2A FE EB         LD      HL,(0EBFEH)
E868  54               LD      D,H
E869  5D               LD      E,L
E86A  2A 2B 00         LD      HL,(002BH)
E86D  22 FE EB         LD      (0EBFEH),HL
E870  ED 52            SBC     HL,DE
E872  28 19            JR      Z,0E88DH
E874  06 00            LD      B,00H
E876  7B               LD      A,E
E877  E6 1F            AND     1FH
E879  4F               LD      C,A
E87A  1A               LD      A,(DE)
E87B  CB BF            RES     7,A
E87D  CD 00 EA         CALL    0EA00H
E880  0C               INC     C
E881  0A               LD      A,(BC)
E882  FE C3            CP      0C3H
E884  28 40            JR      Z,0E8C6H
E886  13               INC     DE
E887  7D               LD      A,L
E888  3D               DEC     A
E889  6F               LD      L,A
E88A  20 EE            JR      NZ,0E87AH
E88C  00               NOP
E88D  F1               POP     AF
E88E  C1               POP     BC
E88F  D1               POP     DE
E890  E1               POP     HL
E891  C3 DE F0         JP      0F0DEH
E894  00               NOP
E895  F5               PUSH    AF
E896  3E 0D            LD      A,0DH
E898  CD 00 EA         CALL    0EA00H
E89B  F1               POP     AF
E89C  AF               XOR     A
E89D  4F               LD      C,A
E89E  18 E6            JR      0E886H
E8A0  3A 6E 00         LD      A,(006EH)
E8A3  CB 47            BIT     0,A
E8A5  28 04            JR      Z,0E8ABH
E8A7  CB 87            RES     0,A
E8A9  18 02            JR      0E8ADH
E8AB  CB C7            SET     0,A
E8AD  2A 2B 00         LD      HL,(002BH)
E8B0  22 FE EB         LD      (0EBFEH),HL
E8B3  32 6E 00         LD      (006EH),A
E8B6  3E 0D            LD      A,0DH
E8B8  CD 00 EA         CALL    0EA00H
E8BB  3E 08            LD      A,08H
E8BD  CD 58 F2         CALL    0F258H
E8C0  C3 F0 E8         JP      0E8F0H
E8C3  00               NOP
E8C4  00               NOP
E8C5  00               NOP
E8C6  F5               PUSH    AF
E8C7  3E 0D            LD      A,0DH
E8C9  CD 00 EA         CALL    0EA00H
E8CC  F1               POP     AF
E8CD  13               INC     DE
E8CE  7A               LD      A,D
E8CF  FE F0            CP      0F0H
E8D1  28 05            JR      Z,0E8D8H
E8D3  AF               XOR     A
E8D4  4F               LD      C,A
E8D5  1B               DEC     DE
E8D6  18 AE            JR      0E886H
E8D8  21 E0 FF         LD      HL,0FFE0H
E8DB  19               ADD     HL,DE
E8DC  EB               EX      DE,HL
E8DD  21 01 00         LD      HL,0001H
E8E0  ED 53 FE EB      LD      (0EBFEH),DE
E8E4  18 ED            JR      0E8D3H
E8E6  00               NOP
E8E7  00               NOP
E8E8  00               NOP
E8E9  00               NOP
E8EA  00               NOP
E8EB  00               NOP
E8EC  00               NOP
E8ED  00               NOP
E8EE  00               NOP
E8EF  00               NOP
E8F0  C5               PUSH    BC
E8F1  01 00 00         LD      BC,0000H
E8F4  03               INC     BC
E8F5  78               LD      A,B
E8F6  3C               INC     A
E8F7  20 FB            JR      NZ,0E8F4H
E8F9  C1               POP     BC
E8FA  C3 8D E8         JP      0E88DH
E8FD  00               NOP
E8FE  00               NOP
E8FF  00               NOP
E900  21 00 EC         LD      HL,0EC00H
E903  01 20 00         LD      BC,0020H
E906  7E               LD      A,(HL)
E907  00               NOP
E908  CD 00 EA         CALL    0EA00H
E90B  23               INC     HL
E90C  0D               DEC     C
E90D  79               LD      A,C
E90E  00               NOP
E90F  00               NOP
E910  20 F4            JR      NZ,0E906H
E912  CD 20 E9         CALL    0E920H
E915  7C               LD      A,H
E916  FE EF            CP      0EFH
E918  00               NOP
E919  20 E8            JR      NZ,0E903H
E91B  C3 53 F0         JP      0F053H
E91E  00               NOP
E91F  00               NOP
E920  3E 0D            LD      A,0DH
E922  CD 00 EA         CALL    0EA00H
E925  C9               RET
E926  00               NOP
E927  00               NOP
E928  00               NOP
E929  00               NOP
E92A  00               NOP
E92B  00               NOP
E92C  00               NOP
E92D  00               NOP
E92E  00               NOP
E92F  00               NOP
E930  3E 0D            LD      A,0DH
E932  CD 00 EA         CALL    0EA00H
E935  C3 00 E9         JP      0E900H
E938  00               NOP
E939  00               NOP
E93A  00               NOP
E93B  00               NOP
E93C  00               NOP
E93D  00               NOP
E93E  00               NOP
E93F  00               NOP
E940  00               NOP
E941  00               NOP
E942  00               NOP
E943  00               NOP
E944  00               NOP
E945  00               NOP
E946  00               NOP
E947  00               NOP
E948  00               NOP
E949  00               NOP
E94A  00               NOP
E94B  00               NOP
E94C  00               NOP
E94D  00               NOP
E94E  00               NOP
E94F  00               NOP
E950  00               NOP
E951  00               NOP
E952  00               NOP
E953  00               NOP
E954  00               NOP
E955  00               NOP
E956  00               NOP
E957  00               NOP
E958  00               NOP
E959  00               NOP
E95A  00               NOP
E95B  00               NOP
E95C  00               NOP
E95D  00               NOP
E95E  00               NOP
E95F  00               NOP
E960  00               NOP
E961  00               NOP
E962  00               NOP
E963  00               NOP
E964  00               NOP
E965  00               NOP
E966  00               NOP
E967  00               NOP
E968  00               NOP
E969  00               NOP
E96A  00               NOP
E96B  00               NOP
E96C  00               NOP
E96D  00               NOP
E96E  00               NOP
E96F  00               NOP
E970  00               NOP
E971  00               NOP
E972  00               NOP
E973  00               NOP
E974  00               NOP
E975  00               NOP
E976  00               NOP
E977  00               NOP
E978  00               NOP
E979  00               NOP
E97A  00               NOP
E97B  00               NOP
E97C  00               NOP
E97D  00               NOP
E97E  00               NOP
E97F  00               NOP
E980  00               NOP
E981  00               NOP
E982  00               NOP
E983  00               NOP
E984  00               NOP
E985  00               NOP
E986  00               NOP
E987  00               NOP
E988  00               NOP
E989  00               NOP
E98A  00               NOP
E98B  00               NOP
E98C  00               NOP
E98D  00               NOP
E98E  00               NOP
E98F  00               NOP
E990  00               NOP
E991  00               NOP
E992  00               NOP
E993  00               NOP
E994  00               NOP
E995  00               NOP
E996  00               NOP
E997  00               NOP
E998  00               NOP
E999  00               NOP
E99A  00               NOP
E99B  00               NOP
E99C  00               NOP
E99D  00               NOP
E99E  00               NOP
E99F  00               NOP
E9A0  00               NOP
E9A1  00               NOP
E9A2  00               NOP
E9A3  00               NOP
E9A4  00               NOP
E9A5  00               NOP
E9A6  00               NOP
E9A7  00               NOP
E9A8  00               NOP
E9A9  00               NOP
E9AA  00               NOP
E9AB  00               NOP
E9AC  00               NOP
E9AD  00               NOP
E9AE  00               NOP
E9AF  00               NOP
E9B0  00               NOP
E9B1  00               NOP
E9B2  00               NOP
E9B3  00               NOP
E9B4  00               NOP
E9B5  00               NOP
E9B6  00               NOP
E9B7  00               NOP
E9B8  00               NOP
E9B9  00               NOP
E9BA  00               NOP
E9BB  00               NOP
E9BC  00               NOP
E9BD  00               NOP
E9BE  00               NOP
E9BF  00               NOP
E9C0  00               NOP
E9C1  00               NOP
E9C2  00               NOP
E9C3  00               NOP
E9C4  00               NOP
E9C5  00               NOP
E9C6  00               NOP
E9C7  00               NOP
E9C8  00               NOP
E9C9  00               NOP
E9CA  00               NOP
E9CB  00               NOP
E9CC  00               NOP
E9CD  00               NOP
E9CE  00               NOP
E9CF  00               NOP
E9D0  00               NOP
E9D1  00               NOP
E9D2  00               NOP
E9D3  00               NOP
E9D4  00               NOP
E9D5  00               NOP
E9D6  00               NOP
E9D7  00               NOP
E9D8  00               NOP
E9D9  00               NOP
E9DA  00               NOP
E9DB  00               NOP
E9DC  00               NOP
E9DD  00               NOP
E9DE  00               NOP
E9DF  00               NOP
E9E0  00               NOP
E9E1  00               NOP
E9E2  00               NOP
E9E3  00               NOP
E9E4  00               NOP
E9E5  00               NOP
E9E6  00               NOP
E9E7  00               NOP
E9E8  00               NOP
E9E9  00               NOP
E9EA  00               NOP
E9EB  00               NOP
E9EC  00               NOP
E9ED  00               NOP
E9EE  00               NOP
E9EF  00               NOP
E9F0  FE 1E            CP      1EH
E9F2  28 04            JR      Z,0E9F8H
E9F4  C3 00 EA         JP      0EA00H
E9F7  00               NOP
E9F8  3E 0D            LD      A,0DH
E9FA  00               NOP
E9FB  00               NOP
E9FC  00               NOP
E9FD  00               NOP
E9FE  00               NOP
E9FF  00               NOP
EA00  FE 0D            CP      0DH
EA02  20 05            JR      NZ,0EA09H
EA04  CD 09 EA         CALL    0EA09H
EA07  3E 0A            LD      A,0AH
EA09  C5               PUSH    BC
EA0A  E5               PUSH    HL
EA0B  B7               OR      A
EA0C  E2 11 EA         JP      PO,0EA11H
EA0F  C6 80            ADD     A,80H
EA11  F5               PUSH    AF
EA12  3E CF            LD      A,0CFH
EA14  D3 35            OUT     (35H),A
EA16  3E FE            LD      A,0FEH
EA18  D3 35            OUT     (35H),A
EA1A  CD 7B EA         CALL    0EA7BH
EA1D  21 6E 00         LD      HL,006EH
EA20  ED 5F            LD      A,R
EA22  E2 29 EA         JP      PO,0EA29H
EA25  CB D6            SET     2,(HL)
EA27  18 02            JR      0EA2BH
EA29  CB 96            RES     2,(HL)
EA2B  F3               DI
EA2C  3E 00            LD      A,00H
EA2E  D3 34            OUT     (34H),A
EA30  CD 72 EA         CALL    0EA72H
EA33  CD 72 EA         CALL    0EA72H
EA36  CD 75 EA         CALL    0EA75H
EA39  06 08            LD      B,08H
EA3B  06 08            LD      B,08H
EA3D  F1               POP     AF
EA3E  0F               RRCA
EA3F  F5               PUSH    AF
EA40  DA 48 EA         JP      C,0EA48H
EA43  3E 00            LD      A,00H
EA45  C3 4D EA         JP      0EA4DH
EA48  3E 01            LD      A,01H
EA4A  C3 4D EA         JP      0EA4DH
EA4D  D3 34            OUT     (34H),A
EA4F  CD 72 EA         CALL    0EA72H
EA52  CD 72 EA         CALL    0EA72H
EA55  13               INC     DE
EA56  13               INC     DE
EA57  1B               DEC     DE
EA58  1B               DEC     DE
EA59  00               NOP
EA5A  10 E1            DJNZ    0EA3DH
EA5C  CD 76 EA         CALL    0EA76H
EA5F  3E 01            LD      A,01H
EA61  D3 34            OUT     (34H),A
EA63  21 6E 00         LD      HL,006EH
EA66  CB 56            BIT     2,(HL)
EA68  28 03            JR      Z,0EA6DH
EA6A  FB               EI
EA6B  18 01            JR      0EA6EH
EA6D  F3               DI
EA6E  F1               POP     AF
EA6F  E1               POP     HL
EA70  C1               POP     BC
EA71  C9               RET
EA72  C5               PUSH    BC
EA73  C1               POP     BC
EA74  00               NOP
EA75  C9               RET
EA76  ED 78            IN      A,(C)
EA78  DB 34            IN      A,(34H)
EA7A  C9               RET
EA7B  DB 34            IN      A,(34H)
EA7D  CB 67            BIT     4,A
EA7F  C8               RET     Z
EA80  0E 00            LD      C,00H
EA82  21 FF 0F         LD      HL,0FFFH
EA85  2B               DEC     HL
EA86  CB 7C            BIT     7,H
EA88  28 FB            JR      Z,0EA85H
EA8A  DB 34            IN      A,(34H)
EA8C  CB 67            BIT     4,A
EA8E  C8               RET     Z
EA8F  0D               DEC     C
EA90  20 F0            JR      NZ,0EA82H
EA92  E7               RST     20H
EA93  02               DB      02H               ;PRST7
EA94  0D 0D            DB      0DH,0DH
EA96  2A 20 50 52 49   DB      '* PRI'
EA9B  4E 54 45 52 20   DB      'NTER '
EAA0  3F               DB      '?'
EAA1  8D               DB      8DH
EAA2  DB 34            IN      A,(34H)
EAA4  CB 67            BIT     4,A
EAA6  C8               RET     Z
EAA7  18 F9            JR      0EAA2H
EAA9  FF               RST     38H
EAAA  FF               RST     38H
EAAB  FF               RST     38H
EAAC  FF               RST     38H
EAAD  FF               RST     38H
EAAE  FF               RST     38H
EAAF  FF               RST     38H
EAB0  00               NOP
EAB1  00               NOP
EAB2  00               NOP
EAB3  00               NOP
EAB4  00               NOP
EAB5  00               NOP
EAB6  00               NOP
EAB7  00               NOP
EAB8  00               NOP
EAB9  00               NOP
EABA  00               NOP
EABB  00               NOP
EABC  00               NOP
EABD  00               NOP
EABE  00               NOP
EABF  00               NOP
EAC0  00               NOP
EAC1  00               NOP
EAC2  00               NOP
EAC3  00               NOP
EAC4  00               NOP
EAC5  00               NOP
EAC6  00               NOP
EAC7  00               NOP
EAC8  00               NOP
EAC9  00               NOP
EACA  00               NOP
EACB  00               NOP
EACC  00               NOP
EACD  00               NOP
EACE  00               NOP
EACF  00               NOP
EAD0  00               NOP
EAD1  00               NOP
EAD2  00               NOP
EAD3  00               NOP
EAD4  00               NOP
EAD5  00               NOP
EAD6  00               NOP
EAD7  00               NOP
EAD8  00               NOP
EAD9  00               NOP
EADA  00               NOP
EADB  00               NOP
EADC  00               NOP
EADD  00               NOP
EADE  00               NOP
EADF  00               NOP
EAE0  00               NOP
EAE1  00               NOP
EAE2  00               NOP
EAE3  00               NOP
EAE4  00               NOP
EAE5  00               NOP
EAE6  00               NOP
EAE7  00               NOP
EAE8  00               NOP
EAE9  00               NOP
EAEA  00               NOP
EAEB  00               NOP
EAEC  00               NOP
EAED  00               NOP
EAEE  00               NOP
EAEF  00               NOP
EAF0  00               NOP
EAF1  00               NOP
EAF2  00               NOP
EAF3  00               NOP
EAF4  00               NOP
EAF5  00               NOP
EAF6  00               NOP
EAF7  00               NOP
EAF8  00               NOP
EAF9  00               NOP
EAFA  00               NOP
EAFB  00               NOP
EAFC  00               NOP
EAFD  00               NOP
EAFE  00               NOP
EAFF  00               NOP

