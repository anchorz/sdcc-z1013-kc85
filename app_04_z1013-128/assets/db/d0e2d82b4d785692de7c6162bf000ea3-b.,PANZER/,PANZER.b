Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

    2 A=16096;PO.A,231;PO.A+1,11;PO.A+2,201;PO.A+3,231;PO.A+4,4
    4 PO.A+5,40;PO.A+6,2;PO.A+7,62;PO.A+8,1;PO.A+9,50;PO.A+10,0
    6 PO.A+11,63;PO.A+12,201
   10 Z=0;Y=0;PO.28,236;GOS.200;OUTC.12;TAB(64)
   12 PR."    "
   13 PR."        "
   14 PR."       ZIELSCHIESSEN   "
   15 PR."        "
   16 PR."    ";TAB(64)
   20 PR."An einem Panzer laeuft in unter-";TAB(32)
   21 PR."schiedlicher Entfernung ein Ziel";TAB(32)
   22 PR."vorbei.Sie koennen das Ziel ver-";TAB(32)
   23 PR."nichten,wenn Sie die 'ENT'-Taste";TAB(32);PR."druecken."
   24 PO.28,239;GOS.200;W=20000;GOS.202;PR."ZIEL :";W=2000
   25 GOS.202;F.A=-4256TO-4225;PO.A,201;W=50;GOS.202;PO.A,32
   26 N.A;OUTC.12;PR."AUFSTELLINIE :";W=2000;GOS.202;A=-4256
   27 GOS.204;GOS.202;OUTC.12;PR."PANZER :";GOS.202;A=-4240
   28 GOS.206;GOS.202;OUTC.12;PR."FERTIG ?";A=INC.;PO.28,236
   40 PO.28,236;PO.30,239;C.16096;OUTC.12;Z=Z+1;IFZ>20G.80
   41 PO.28,239;GOS.200
   42 A=-4384;GOS.204;TAB(64);PR.Z,". Versuch,davon"
   43 H=32;W=3000;GOS.202;P=RND(3);A=-4412+P*6;F=A-128
   44 O=RND(6);T=RND(2)
   45 GOS.206;Q=-5184+64*O;IFT=2T=-1;Q=Q+31
   47 F.B=QTOQ+31*TSTEPT;PO.B,201;PO.F,32;W=5;GOS.202;PO.B,32
   50 C.16099;G.(51-(PE.(16128)-1))
   51 H=42;PO.A-127,152;PO.A-129,156
   52 IFH=32G.78
   53 F=F-64;PO.F,H;IFF<B-1G.78
   54 IFF>B+1G.78
   55 PO.F,140;W=20;GOS.202;PO.F+31,133;PO.F+33,132;PO.F-31,135
   56 PO.F-33,134;GOS.202;PO.F+31,171;PO.F+33,172;PO.F-31,173
   57 PO.F-33,174;W=60;GOS.202;PO.F-30,156;PO.F-34,152
   58 PO.F-63,150;PO.F-65,147;W=80;GOS.202;PO.F-67,144
   59 PO.F-61,145;PO.F-36,153;PO.F-28,155;PO.F-4,152;PO.F+4,156
   60 PO.F,32;PO.F+33,32;PO.F+31,32;PO.F-31,32;PO.F-33,32
   70 Y=Y+1
   76 F.E=0TO9;PO.-4233,32;W=200;GOS.202;PO.-4233,246+E;N.E;G.79
   78 PO.A-127,32;PO.A-129,32;N.B
   79 TAB(18);PR.Y," Treffer";W=999;GOS.202;G.40
   80 PO.28,236;GOS.200;OUTC.12;TAB(128);PR.#3,"Bei",Z-1,
   82 PR." Versuchen sind";TAB(40);PR.Y," Treffer";TAB(64)
   83 Y=Y/4*5;TAB(96);G.(85+Y)
   85 PR."N I C H T  S E H R  V I E L";TAB(64)
   87 PR."Sie sollten weniger trinken !";G.150
   90 PR."    N I C H T   V I E L";TAB(64)
   92 PR."Unter den Blinden ist der";PR."EINAeUGIGE Koenig.";G.150
   95 PR."N U R  D U R C H S C H N I T T";TAB(64)
   97 PR."Lernen,lernen,nochmals lernen !";G.150
  100 PR."   F A S T   G U T";TAB(64)
  102 G.150
  105 PR."      G  U  T";TAB(64)
  107 PR."Fuer Pfeil und Bogen reichts'!";G.150
  150 TAB(96);PR."Noch ein Spiel ?";A=INC.;IFA=74Z=0;Y=0;G.40
  152 TAB(96)
  154 TAB(8);PR.""
  156 TAB(8);PR." AUF  WIEDERSEHEN "
  158 TAB(8);PR."";TAB(64)
  160 STOP
  200 PO.27,0;PO.29,0;PO.30,240;C.16096;RET.
  202 F.X=0TOW;N.X;RET.
  204 F.B=ATOA+31STEP2;PO.B,149;PO.B+1,146;N.B;RET.
  206 PO.A+32,248;PO.A+33,172;PO.A+31,171;PO.A+1,192;PO.A-1,159
  207 PO.A-31,192;PO.A-33,159;PO.A-63,173;PO.A-65,174;PO.A,130
  208 PO.A-32,157;PO.A-64,161;PO.A-96,161;RET.
