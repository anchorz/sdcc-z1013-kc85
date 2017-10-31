Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 OUTC.12
   15 G.1050
   20 PR.;PR.;PR.".........BREAKOUT.........";PR.;PR.
   30 PR."ZERSCHIESSEN SIE DIE MAUER";PR.
   40 PR."MIT 3 BAELLEN!";PR.
   50 PR."BEWEGEN SIE DEN SCHLAEGER MIT      <-  UND  ->";PR.
   60 PR."BALLEINGABE MIT DER LEERTASTE";PR.
   70 PR."ALLES KLAR? DANN GEBEN SIE DIE";PR.
   80 PR."SCHLAEGERGROESSE UND DEN";PR.
   85 PR."ERSTEN BALL EIN";PR.
   90 INP."SCHLAEGERGROESSE(3-7)"R
  100 IF R>7 G.90
  110 IF R<3 G.90
  120 OUTC.12
  121 F.I=0 TO 24
  122 PR.
  123 N.I
  124 PR."PUNKTE :     0"
  125 PR.;PR."BAELLE : 3"
  130 F.I=0 TO 31
  140 PO.H.(EC00)+I,183
  150 N.I
  160 F.I=0 TO 576 STEP 32
  170 PO.H.(EC20)+I,181;PO.H.(EC3F)+I,180
  180 N.I
  190 F.I=0 TO31
  200 PO.H.(EE80)+I,182
  210 N.I
  230 X=14;C=8;M=3;P=0
  240 F.I=0 TOR-1
  241 G.500
  242 F.J=0 TO 96 STEP 32
  244 F.I=0 TO 29
  245 PO.H.(EC21)+I+J,188
  246 N.I
  248 N.J
  250 B=323+RND(22)
  260 L=INC.
  270 IF L#32 G.250
  280 L=RND(5)
  290 IF L>3 W=1;G.310
  300 W= (-1)
  310 L=RND(5)
  320 IF L>3 S=1;G.340
  330 S=(-1)
  340 GOS.1000
  350 GOS.3000
  360 IF K=182 M=M-1;G.380
  370 G.340
  380 IF M=0 G.410
  390 PO.H.(EF69),48+M
  400 G. 250
  410 OUTC.12
  420 PR.;PR."ENDSTAND";PR.;PR.
  425 OUT(0)=H.(C1)
  430 PR."SIE HABEN",P,;PR." PUNKTE ERREICHT"
  440 PR."WUENSCHEN SIE NEUES  SPIEL(J) ?";L=INC.
  445 OUT(0)=15
  450 IF L=74 G.90
  460 STOP
  500 PO.H.(EE60)+I+X,253
  510 N.I
  520 G.242
 1000 C.H.(00C1)
 1010 C=PE.(H.(00C0))
 1020 IF C>0 GOS.2000
 1030 RE.
 1050 @(1)=H.(CD);@(2)=H.(30); @(3)=H.(F1);@(4)= H.(32)
 1060 @(5)=H.(C0);@(6)=0;@(7)=H.(C9);X=H.(00C0)
 1070 F.I=1 TO7
 1080 PO.X+I,@(I)
 1090 N.I;OUT(1)=H.(0F);OUT(1)=H.(03);G.20
 2000 OUT(0)=H.(D6)
 2030 IF C=8 G.2060
 2040 IF C=9 G.2100
 2050 RE.
 2060 IF X<2 RE.
 2070 PO.H.(EE60)+X+R-1,32;X=X-1
 2075 OUT(0)=15
 2080 PO.H.(EE60)+X,253;RE.
 2100 IF X+R>29 RE.
 2110 PO.H.(EE60)+X,32;X=X+1
 2115 OUT(0)=15
 2120 PO.H.(EE60)+X+R-1,253;RE.
 3000 N=B+S*(32+W)
 3010 K=PE.(H.(EC21)+N)
 3020 IF K=188 GOS.4000
 3030 IF K=181 W=S;G.3070
 3040 IF K=180 W=S*(-1);G.3070
 3050 IF K=183 S=1;W=S*W*(-1);G.3070
 3060 IF K=253 S=(-1);W=S*W;G.3070
 3063 PO.H.(EC21)+B,32
 3064 IF K=182 RE.
 3065 B=N;PO.H.(EC21)+B,255
 3066 GOS.1000
 3067 RE.
 3070 GOS.1000
 3080 PO.H.(EC21)+B,32
 3090 IF K=182 RE.
 3100 B=B+S*(32+W)
 3110 PO.H.(EC21)+B,255
 3120 IF K=188 GOS.4000
 3130 RE.
 4000 P=P+25;A=P
 4005 OUT(0)=H.(86)
 4010 GOS.1000
 4020 F.I=0 TO3
 4030 D=A-(A/10)*10
 4040 PO.H.(EF30)-I,48+D
 4050 A=A/10
 4060 N.I
 4065 OUT(0)=15
 4070 RE.
53792 (+~0(.(6E#6+6-/</0:#p#w#qt#e⇘
      'd!!xm8NyUp⇘
      |"+"+Y8;:+vpv!Ha⇘
      l!J@.tpO.wnz*|P~⇘
      ~#=o!+]!<+!+w#O⇘
      :+<2+!`Oa{YOO6+F6!+4~ w!<+w+w+wh⇘
      Fhiuh!aIpl!f7^⇘
      !a!Id&X4#]Ivp⇘
      :+QY!f!!J;xn{/|t1}=Z}~L~l⇘
      I(l!G8(GK0K))))o{
 7767 6# *+[V+RR( O G +}  _