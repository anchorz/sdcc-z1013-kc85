Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 Z=1;IFPE.(3088)#201Z=0
   20 IFZ=0O.12
   30 S=-1;G=0;E='';F=-5027;U=32;L=0
   40 GOS.200
   50 IFZ=0G.550
   60 GOS.940;G.590
  200 IFZ#0C.3137
  210 P.;P.;P.
  220 P."  #####    #   ###   #  #####"
  230 P."      #   ##  #   # ##     #"
  240 P."     #     #  #  ##  #    #"
  250 P."    #      #  # # #  #     #"
  260 P."   #       #  ##  #  #      #"
  270 P."  #        #  #   #  #  #   #"
  280 P."  #####   ###  ###  ###  ###"
  290 P.;P.;P.;GOS.930
  300 P."   B A S I C P R O G R A M M"
  310 P.;P.;P.;GOS.930
  320 P."    +++++ +      +++  +   +"
  330 P."    +     +     +   + +   +"
  340 P."    +     +     +   + +   +"
  350 P."    ++++  +     +   + +++++"
  360 P."    +     +     +   + +   +"
  370 P."    +     +     +   + +   +"
  380 P."    +     +++++  +++  +   +"
  390 P.;P.;P.;GOS.930
  400 F.A=-5088TO-5058
  410 PO.A,42
  420 GOS.2660;N.A
  430 F.A=-5026TO-4290ST.32
  440 PO.A,42
  450 GOS.2660;N.A
  460 F.A=-4291TO-4320ST.-1
  470 PO.A,42
  480 GOS.2660;N.A
  490 F.A=-4352TO-5056ST.-32
  500 PO.A,42
  510 GOS.2660;N.A
  515 RET.
  550 P." Bitte machen Sie das Tonband    zum Einlesen bereit."
  560 P." Bei Testton Enter.",
  570 IFI.#13G.570
  575 P.
  580 C.2572;C.271;C.2585;C.271;Z=1
  590 C.3137
  600 F.A=0TO32;P.;N.A
  610 P."Hier bin ich wieder.";P.
  620 GOS.930
  630 P."Wer sind Sie ? Bitte geben Sie  mir ihren Namen ein."
  640 P.;P." >  ",
  650 F.A=0TO400
  660 C.3078;C.3652
  670 B=PE.(1)
  680 IFB#0G.710
  690 N.A;G.10
  710 @(1)=B;A=2;O.B
  730 C.3652;B=I.
  740 G.750+(40*(B=8))+(50*(B=9))
  750 @(A)=B;A=A+1
  760 O.B
  770 IFB#13G.730
  775 GOS.5000
  776 IFA='J'G.1130
  780 GOS.930;A=0;G.830
  790 A=A-1;G.760
  800 A=A+1;G.760
  810 A=A+1;IF@(A)#32RET.
  820 G.810
  830 GOS.810;IF@(A)='I'G.850
  840 G.1000
  850 GOS.810;IF@(A)='C'G.870
  860 G.1000
  870 GOS.810;IF@(A)='H'G.890
  880 G.1000
  890 P."Mit mir selbst spiele ich nicht!"
  900 GOS.940;G.10
  910 GOS.1030;G.930
  920 Y=6000;G.970
  930 Y=4000;G.970
  940 Y=9000;G.970
  970 IFZ#0C.3652
  980 F.A=0TOY
  990 N.A;RET.
 1000 P.;P."Ich heisse Sie willkommen "
 1005 GOS.1410;GOS.930
 1010 P.;P."Wollen Sie mit mir spielen ?"
 1020 G.1110
 1025 GOS.930
 1030 P.;P."  >  ",;C.3652;B=I.
 1050 G.1060+(30*(B='J'))+(40*(B='N'))
 1060 O.B;P.
 1070 P."Diese Vokabel habe ich nicht ge-speichert."
 1080 G.1025
 1090 P."Ja";P.;RET.
 1100 P."Nein";P.;RET.
 1110 GOS.910;IFB='N'G.10
 1130 P."Kennen Sie das Flohspiel ?"
 1140 GOS.910;IFB='J'G.1360
 1160 P." W a s ?  ",;GOS.930
 1180 P."-  N e i n ? ! ? !";P.;GOS.930
 1200 P." Nicht moeglich !!!";P.
 1205 GOS.930
 1210 P." Dann muss ich es Ihnen ganz     schnell erklaeren :";P.;
      P.
 1220 P."Stellen Sie sich vor, Sie solleneinen Floh auf einen LKW Typ    Wa⇘
      ckelpritsche verladen. Dabei"
 1230 P."muessen Sie verschiedene Hinder-nisse ueberwinden. Sie koennen  Ih⇘
      ren Floh nach links '<-', nach",
 1240 P."rechts '->' und nach obene'U'   springen lassen. Gelangt der    Fl⇘
      oh auf eine Leiter, so"
 1250 P."Klettert er nach oben. Die      Sprungweite wird aus der Zeit   be⇘
      rechnet, inder Sie die"
 1255 P."Richtungstaste beetaetigen."
 1260 P.;P.;GOS.930
 1280 P."   Verstanden ?"
 1290 GOS.910;IFB='J'G.1390
 1310 P."Na dann noch einmal."
 1320 GOS.930;G.1220
 1360 P."Wuenschen Sie Instruktionen ?"
 1370 GOS.910;IFB='J'G.1205
 1390 P.;P.
 1400 P."Also dann spiele ich jetzt mit  Ihnen ",
 1405 G.1445
 1410 A=1
 1420 O.@(A);A=A+1
 1440 IF@(A)#13G.1420
 1442 P.;RET.
 1445 GOS.1410
 1450 P."Dazu wuensche ich viel Erfolg   und eine ruhige Hand.";P.
 1460 P.;GOS.930
 1470 C.3072
 1480 PO.3658,122;C.3660
 1490 X=0
 1500 D=5;C=8;GOS.2000
 1600 C.3089
 1610 C=PE.(1);D=PE.(0)/6
 1620 GOS.2000
 1630 L=L+1
 1640 GOS.2300;IFX=1G.3000
 1650 GOS.2300;IFX=1G.3000
 1700 G.1600
 2000 H=0+(1*(C=9))-(1*(C=8))
 2010 V=0-(32*(C='U'))
 2015 IFV=-32G.2080
 2020 F.A=0TOD
 2030 IFPE.(F+H)=0G.2200
 2040 F=F+H;U=PE.(F)
 2050 PO.F,E;PO.(F-H),W;W=U
 2060 N.A;G.2200
 2080 F.A=0TOD
 2100 IFPE.(F+V)=0G.2200
 2110 F=F+V;U=PE.(F)
 2120 PO.F,E;PO.(F-V),W;W=U
 2130 N.A
 2140 H=S;D=2;G.2020
 2200 H=0;V=32
 2210 IFPE.(F+V)=0RET.
 2220 F=F+V;U=PE.(F)
 2230 PO.F,E;PO.(F-V),W;W=U
 2240 G.2210
 2300 G.2310+(100*G)
 2310 IFF<-4992RET.
 2320 S=1;G=1;RET.
 2410 IFF=-4744G=0;D=8
 2420 IFF=-4950G=0;D=2
 2430 IFF>-4721G=2
 2450 IFG=1RET.
 2460 S=-1
 2490 C='U';IFG=0G.2000
 2500 RET.
 2510 IFF<-4736G=1;S=1
 2520 IFF>-4481G=3;S=1
 2550 RET.
 2610 IFF=-4308G=2;S=-1;D=8;C='U';G.2000
 2620 IFF>-4257X=1;RET.
 2640 IFF<-4512S=-1;G=2
 2660 RET.
 3000 B=122
 3010 F.A=1TO25
 3020 B=B-1;PO.3658,B
 3030 C.3660;GOS.2660;N.A
 3060 GOS.200
 3070 P."Mit",L," Versuchen."
 3080 IFL>40G.3200
 3090 P."Sie sind ein Meister! Darauf    duerfen Sie sich einen genehmi- ge⇘
      n!"
 3100 G.4300
 3200 IFL>75G.3400
 3210 P."Na - auf einen Sack Floehe auf- zupassen ist doch nicht so ein- fa⇘
      ch. Uebung macht den Meister."
 3300 G.4300
 3400 IFL>100G.3600
 3410 P."Noch sind Sie kein hoffnungs-   loser Fall. Aber jetzt bitte    ni⇘
      cht zuschlagen.(Bildroehre!)"
 3500 G.4300
 3600 IFL>140G.3630
 3610 P."Sie scheinen heute mit dem      falschen Bein aufgestanden zu   se⇘
      in."
 3620 G.4300
 3630 IFL>160G.3800
 3640 P."Bei Ihrer Spielweise muessen Sieaufpassen, dass der Floh nicht  au⇘
      s dem Bildschirm springt!"
 3700 G.4300
 3800 IFL>180G.3930
 3810 P."Haben Sie eine Brille, Ueberge- wicht, zu grosse Schuhe oder    Li⇘
      ebeskummer ?"
 3820 G.4300
 3930 IFL>200G.4000
 3940 P."Kaufen Sie sich eine Schachtel  Floehe und trainieren Sie zu    Ha⇘
      use!"
 3950 G.4300
 4000 IFL>220G.4200
 4010 P."Sie sind nicht das Allerletzte!         -------"
 4100 G.4300
 4200 P."Achtung! Der Tag hat nur 24 h!  Das gilt auch heute !!!"
 4300 P."Noch einmal ? (J/N)",
 4310 IFI.='J'G.10
 4320 TAB(1050);P.
 4330 P."   Leben Sie wohl."
 4340 GOS.920;O.12;GOS.930
 4350 IFI.='R'G.4370
 4360 G.4350
 4370 IFI.='U'G.4390
 4380 G.4350
 4390 IFI.='N'G.10
 4400 G.4350
 5000 IFRND(6)#3RET.
 5010 P.;P.
 5020 P."Ihr Name gefaellt mir nicht,    aber wir koennen ja auch so     zu⇘
      sammen spielen."
 5030 GOS.930
 5040 P."Wollen Sie ?"
 5050 GOS.910;A=B
 5060 IFB='J'RET.
 5070 P.;P."Ich habe es doch gewusst Ihr    Name klinkt gleich so besch....⇘
      ."
 5080 GOS.940;G.4320
