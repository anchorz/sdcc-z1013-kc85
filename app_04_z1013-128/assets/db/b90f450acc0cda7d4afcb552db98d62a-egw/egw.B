5 CLS:
10 PRINT AT(7,6);"      ":PRINT AT(8,6);"          ":
15 PRINT AT(9,6);"   ¿   ":PRINT AT(10,6);"     ¿    ¿":
20 PRINT AT(11,6);"    ¿   ":
25 PRINT AT(13,5);"      ":
30 PRINT AT(14,5);"             ":
35 PRINT AT(15,5);"µ   µ   ¿":
40 PRINT AT(16,5);"ÿ ÿ ÿ   ÿ ÿ ÿ   ÿ ¿ÿÿ":
45 PRINT AT(17,5);"      ¿":
50 PRINT AT(19,7);"           ":PRINT AT(20,7);"           ":
55 PRINT AT(21,7);"          ":PRINT AT(22,7);"          ":
60 PRINT AT(23,7);"       ":
65 PRINT AT(0,0);" ":
70 PAUSE(50): CLS:
75 PRINT AT(3,11);"Willi - Ä"
80 PRINT AT(6,10);"Faenger - "
85 PRINT AT(9,10);"Bewegungen:"
90 PRINT AT(11,13);"Hoch"
95 PRINT AT(13,15);"¡"
100 PRINT AT(15,15);"D"
105 PRINT AT(16,6);"Links   K M   Rechts"
110 PRINT AT(17,15);"T"
115 PRINT AT(19,15);"¡"
120 PRINT AT(21,12);"Runter"
125 PRINT AT(31,24);"<ENTER>"
130 PRINT AT(0,0);" "
135 WINDOW 31,31,31,31:
140 INPUT "";C$:
145 WINDOW: CLS:
146 GOSUB 2030
200 PRINT AT(10,0);" ²··³    µ    ¹   ´   µ    ¶    ":
210 PRINT AT(11,0);"²°       ´  ºÿ´   ¸ºÿ³µ     ¶¶³ ":
220 PRINT AT(12,0);"´        ´ µÿ¼     ÿÿ´ ´      ±³":
230 PRINT AT(13,0);"µ        ´ ±ÿ°     ±¼  ´       ¸":
240 PRINT AT(14,0);"µ        ±·¶ ····   ±··°       µ":
250 PRINT AT(15,0);" ¸        ·¶¶    ¶¶·           µ":
260 PRINT AT(16,0);"  ¸·³   ²¶        ··°         ²°":
270 PRINT AT(17,0);"    ±¶´ µ           ¶¶¶³     ·¶ ":
280 PRINT AT(18,0);"     µ  ±³         ²·· ¶³   ¹³  ":
290 PRINT AT(19,0);"     ´   ±³        ¸·¹  ´    ´  ":
300 PRINT AT(20,0);"    µ   ³ ±¶·³        ·¹     ´  ":
310 PRINT AT(21,0);"    µ   ±·   ±¶¶····¶¶      µ   ":
320 PRINT AT(22,0);"    µ     ¶·³         ²·    ´   ":
330 PRINT AT(23,0);"     ¸      ±¶···  ··¶° ´  ¹    ":
340 PRINT AT(24,0);"     ±··     µ   ¶¶    ¹  ¹     ": 
350 PRINT AT(25,0);"        ¶¸·  µ        µ  ¹      ": 
360 PRINT AT(26,0);"           ¸ µ       ²° ²°      ":
370 PRINT AT(27,0);"            ´ ´¹¸·¹¸³¹  µ       ":
380 PRINT AT(28,0);"            µ µ     ¹   ´       ":
390 PRINT AT(29,0);"             ¸ ¸· ·¹  ·¶        ":
400 PRINT AT(30,0);"              ¶· ¶  ·¶          ":
410 PRINT AT(31,0);"                ¶¶¶¶            ":
1000 PAUSE(50):
1010 CLS: RS=0:
1015 FOR A=0 TO 31
1020 PRINT AT(0,A);"ÿ": BEEP:
1025 PRINT AT(A,0);"": BEEP:
1030 PRINT AT(31-A,31);"": BEEP:
1035 PRINT AT(31,31-A);"": BEEP:
1040 NEXT A
1045 XW=INT(29*RND(1))+1: WW=XW:
1050 YW=INT(29*RND(1))+1: VW=YW:
1055 XF=INT(29*RND(1))+1: WF=XF:
1060 YF=INT(29*RND(1))+1: VF=YF:
1065 PRINT AT(YW,XW);"Ä"
1070 PRINT AT(YF,XF);""
1075 A=INT(4*RND(1))+1:
1080 ON A GOTO 1085,1090,1095,1100:
1085 XW=XW+1: GOTO 1105:
1090 XW=XW-1: GOTO 1105:
1095 YW=YW+1: GOTO 1105:
1100 YW=YW-1:
1105 IF XW=31 THEN XW=1:
1110 IF XW=0 THEN XW=30:
1115 IF YW=31 THEN YW=1:
1120 IF YW=0 THEN YW=30:
1125 PRINT AT(YW,XW);"Ä": BEEP:
1130 PRINT AT(VW,WW);" "
1135 VW=YW: WW=XW:
1136 IF YF=YW AND XF=XW THEN 1220
1140 A$=INKEY$:
1145 IF A$="M" THEN XF=XF+1:
1150 IF A$="T" THEN YF=YF+1:
1155 IF A$="K" THEN XF=XF-1:
1160 IF A$="D" THEN YF=YF-1:
1165 IF XF=31 THEN XF=30:
1170 IF YF=31 THEN YF=30:
1175 IF XF=0  THEN XF=1 :
1180 IF YF=0  THEN YF=1 :
1185 IF VF=YF AND WF=XF THEN 1205
1190 PRINT AT(YF,XF);""
1195 PRINT AT(VF,WF);" "
1200 VF=YF: WF=XF:
1205 IF XW=XF AND YW=YF THEN 1220
1215 GOTO 1075:
1220 PRINT AT(0,0);"                                ":
1225 PRINT AT(0,3);"FEIER": BEEP: PAUSE(5):
1230 PRINT AT(0,8);",FEIER": BEEP: PAUSE(5):
1235 PRINT AT(0,14);",FEIER": BEEP: PAUSE(5):
1240 PRINT AT(0,20);"-BAEHH!!!!"
1245 FOR A=1 TO 100
1250 BEEP:
1255 NEXT A
1256 CLS:
1260 GOSUB 2030
1300 PRINT AT(10,9);"µ    ¹   ´   µ    ¶"
1310 PRINT AT(11,2);"·¹¶    ´  ºÿ´   ¸º³µ     ¶¶·" 
1320 PRINT AT(12,1);"¹       ´ µÿ¼     ´ ´       ¸"
1330 PRINT AT(13,0);"µ        ´ ±°     ±¼  ´       µ"
1340 PRINT AT(14,0);"µ        ±·¶ ····   ±··°       µ"
1350 PRINT AT(15,0);"µ         ·¶¶    ¶¶·           µ"
1360 PRINT AT(16,1);"´   ·³ ²¶        ··°          µ"
1370 PRINT AT(17,1);"µ·¶¶ ´ µ           ¶¶¶³      ²°"
1380 PRINT AT(18,5);"µ  ±³         ²·· ¶³    ¼°"
1390 PRINT AT(19,5);"´   ±³        ¸·¹  ´    ´"
1400 PRINT AT(20,4);"µ     ±¶·³        ·¹     ´"
1410 PRINT AT(21,4);"µ        ±¶¶¶¶¶¶¶¶      µ"
1420 PRINT AT(22,4);"µ      ··¶¶¶¶¶¶··       ´"
1430 PRINT AT(23,5);"¸               ¶°    ¹"
1440 PRINT AT(24,5);"±··                 ²¹"
1450 PRINT AT(25,8);"¶¸·             ²°"
1460 PRINT AT(26,11);"¸           ²°"
1470 PRINT AT(27,12);"¶·³     ·¹¶°"
1480 PRINT AT(28,14);"±¶¶¶¶¶"
1500 PAUSE(20)
1510 FOR A=0 TO 31
1520 PRINT AT(A,8);""
1530 PRINT AT(A,16);""
1540 PRINT AT(A,24);""
1550 PRINT AT(8,A);""
1560 PRINT AT(16,A);""
1570 PRINT AT(24,A);""
1580 BEEP: BEEP: BEEP:
1590 NEXT A
2000 PAUSE(30)
2005 PRINT AT(31,0);"    Noch  einmal ? <ENTER / N>  "
2010 WINDOW 31,31,31,31: INPUT "";O$: WINDOW:
2020 IF O$="N" THEN CLS: END:
2025 GOTO 146:
2030 PRINT AT(0,0);"                                ":
2035 PRINT AT(1,0);"           ² µ   ´ ²°  ³        ":
2040 PRINT AT(2,0);"         ³ µ ´  µ  ¹  µ         ":
2045 PRINT AT(3,0);"         µ      ´   · °  ²°     ":
2050 PRINT AT(4,0);"       µ³µ ²¹¶¸   ²¶ ¸  ²°      ":
2055 PRINT AT(5,0);"        ¸ ²°   ´  ¹·· ´ ¹  ¹    ":
2060 PRINT AT(6,0);"     ±³   ´·¶¶¸º  ¶  ¸µ   ¹     ":
2065 PRINT AT(7,0);"    ³ µ  µ¹²¶¶³    ·· ¶  ¹ ²°   ":
2070 PRINT AT(8,0);"    ±³    ²¶  ´   µ  ¸    ·° ²  ":
2075 PRINT AT(9,0);"     ±    ¹   µ   ´   ¸     ·°  ":
2080 RETURN
