Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

    1 GOS.250;OUTC.12
    2 F.I=1TO15;P.;N.I;G.111
    3 OUTC.12
    4 F.I=1TO13;P.;N.I
    5 A=0
   10 P."Tastaturanalyse"
   20 P."---------------"
   21 P.
   25 M=0
   40 G.50
   41 GOS.200
   50 P."ASCII : ",
   55 IFA<14P." ",;G.70
   60 OUTC.A
   70 P."  HEX : ",
   80 BYTE(A)
   90 P."  DEZ : ",
  100 P.#3,A,
  101 IFM='A'G.110
  102 CALLD;A=INC.
  106 IFM#'A'G.41
  110 RET.
  111 P."Analyse oder Liste (A/L) ?",
  112 CALLD;M=INC.;IF(M#'A')*(M#'L')*(M#'Q')G.112
  113 IFM='A'G.3
  114 I=0;Q=0
  115 OUTC.12
  116 IFM='Q'OUTC.12;STOP
  120 F.I=ITOI+15
  125 IFQ=IP.;G.130
  126 P.;P.
  130 A=I;M='A';GOS.50
  135 IFI=255I=I+1;G.146
  140 N.I
  145 Q=I
  146 CALLD
  160 T=INC.;IFT='R'I=I-32;Q=I
  161 IFI<1I=I+256;Q=I
  162 IFT='Q'G.1
  165 IFI<255G.115
  166 G.114
  170 OUTC.12
  180 STOP
  200 F.X=1TO30;OUTC.8;N.X
  210 RET.
  250 D=HEX(3FF0)
  260 @(1)=42;@(2)=43;@(3)=0;@(4)=62
  270 @(5)=32;@(6)=119;@(7)=201
  280 F.I=0TO6;PO.D+I,@(I+1);N.I
  290 RET.
