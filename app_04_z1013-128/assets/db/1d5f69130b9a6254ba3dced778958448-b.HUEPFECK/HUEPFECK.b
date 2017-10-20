Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

1 GOTO 800
2 P=0
3 P=0
5 W=HEX(EDF0)
6 V=0
7 U=W
10 CALLHEX(3E00)
20 A=PEEK(HEX(3E10))
25 IF V#0 P=P+1
26 IFA=0GOTO40
30 IFA='M'V=-1
31 IFA='E'V=-33
32 IFA='O'V=1
33 IFA='G'V=-31
34 IFA='F'V=-32
35 IFA='W'V=33
36 IFA='V'V=32
37 IFA='U'V=31
38 IFA='N'V=0
40 W=W+V
45 POKEU,32
47 IF(PEEK(W))#32GOTO71
50 POKEW,140
60 U=W
65 POKE(HEX(EBFF)+RND(1024)),201
70 GOTO 10
71 POKEW,32
72 W=W+32
73 IFW<HEX(F000)POKEW,202
80 IFW<HEX(F000)GOTO71
90 FORI=0TO1000;NEXTI
100 O.12;TAB(96)
105 P."Sie haben ",#1,P," Punkte erreicht!"
110 P.
111 P.
115 IFP<MP."Der Rekord liegt in diesen";P.
120 IFP<MP."Spielrunden jedoch bei ",#1,M,"."
125 IFP=MP."Sie haben den alten Rekord er-";P.
130 IFP=MP."reicht."
135 IFP>MP."Das ist neuer Rekord !!!"
140 TAB(128)
145 IF P>M M=P
150 P."Noch ein Versuch ?"
155 P."                            J/N"
160 F=INCHAR
200 IF F='J'GOTO2000
210 O.12
220 STOP
800 O.12
801 P.
802 P.
803 P.
804 P.
805 P.
810 P."                  "
811 P."              "
812 P."             "
813 P."               "
814 P."                    "
815 P."             "
816 P."              "
817 P."             "
818 POKEHEX(EDA0),32
820 FORI=0TO3500;NEXTI
1000 O.12
1010 P."Mit den Tasten E,F,G,M,N,O,U,V"
1012 P."und W koennen Sie das Huepf-Eck"
1014 P."auf dem Bildschirm steuern ."
1016 P.
1018 P."N ist die Notbremse.Mit den an-"
1020 P."deren Tasten koennen Sie das"
1022 P."sich selbstbewegende Huepf-Eck"
1024 P."in der Richtung korrigieren."
1026 P."Die Richtungsgebung der einzel-"
1028 P."nen Tasten ergibt sich aus de-"
1030 P."ren Lage auf der Tastatur.Also"
1032 P."F nach oben,G nach diagonal"
1034 P."rechts oben u.s.w."
1036 P.
1038 P."Jeder Sprung des Huepf-Ecks ist"
1040 P."ein Punkt fuer Sie.Rammen Sie "
1042 P."aber eines der auftauchenden "
1044 P."Hindernisse,ist das Spiel been-"
1046 P."det und es erfolgt die Auswer-"
1048 P."tung."
1050 P.
1052 P.
1054 P."          Alles klar ?"
1056 P."                          Enter"
1060 F=INCHAR
1070 M=0
2000 GOSUB 20000
2005 O.12
2010 FORI=HEX(EC00)TOHEX(EC1F)
2020 POKEI,201
2030 NEXTI
2040 FORI=HEX(EC20)TOHEX(EFE0)STEP32
2050 POKEI,201
2055 POKEI+31,201
2060 NEXT I
2070 FORI=HEX(EFE1)TOHEX(EFFE)
2080 POKEI,201
2090 NEXT I
3000 GOTO 2
20000 W=HEX(3E00)
20010 POKE W,HEX(CD)
20020 POKE W+1,HEX(30)
20030 POKE W+2,HEX(F1)
20040 POKE W+3,HEX(32)
20050 POKE W+4,HEX(10)
20060 POKE W+5,HEX(3E)
20070 POKE W+6,HEX(C9)
20080 RETURN
