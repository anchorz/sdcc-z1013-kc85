;--------------------------------------------------------------------------
;  caos.inc - definitaions on KC85(5)
;--------------------------------------------------------------------------


; jump distribution (Sprungverteiler)
PV1   = 0xf003 ; parameter in regs, PVnr after call
PV2   = 0xf006 ; return params in AF, PVnr on ARGC
PV3   = 0xf009 ; like PV2, but PVnr in reg E
PV4   = 0xf00c ; like PV3, but with IRM
PVrel = 0xf00f ; relavite call
PV5   = 0xf015 ; PV3 with IRM and setting SP to  SYSP
PV6   = 0xf01e ; like PV5, bit PVnr on ARGC

; system cells
CASS  = 0xb700 ; buffer for tape operations
ARGC  = 0xb780 ; up nr for PV2 and PV6
ARGN  = 0xb781 ; nr of argument
ARG1  = 0xb782 ; argument 1
ARG2  = 0xb784 ; argument 2
ARG3  = 0xb786 ; argument 3
ARG10 = 0xb794 ; argument 10

COLOR = 0xb7a3 ; color byte

HOR   = 0xb7d3 ; horizontal graphic position
VERT  = 0xb7d5 ; vertical graphic position
FARB  = 0xb7d6 ; graphic color


; functions numbers
FNCRT   = 0x00
FNKBD   = 0x04
FNLOOP  = 0x12
FNHLHX  = 0x1a
FNAHEX  = 0x1c
FNCUCP  = 0x25
FNSPACE = 0x2b
FNCRLF  = 0x2c
FNHOME  = 0x2d
FNCSTBT = 0x42
FNZKOUT = 0x45

