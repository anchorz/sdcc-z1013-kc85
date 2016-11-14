; functions numbers for z1013 monitor
OUTCH   = 0x00
INCH    = 0x01
PRST7   = 0x02
INHEX   = 0x03
INKEY   = 0x04
INLIN   = 0x05
OUTHX   = 0x06
OUTHL   = 0x07
CSAVE   = 0x08
CLOAD   = 0x09
MEM     = 0x0a
WIND    = 0x0b
OTHLS   = 0x0c
OUTDP   = 0x0d
OUTSP   = 0x0e
TRANS   = 0x0f
INSTR   = 0x10
KILL    = 0x11
HEXUM   = 0x12
ALFA    = 0x13

CURSR_CHAR    = 0x001F ; B Code-Zwischenspeicher fuer OUTCH  
CURSR         = 0x002b ; W aktuelle Cursorposition 
Z1013_BWS     = 0xec00
Z1013_BWS_LEN = 0x0400
; sprungverteiler 
SPVT_POLL     = 0xfffa ; get status

; io ports 

IOSEL_2 = 0x08 ; Tastaturspaltentreiber & KRT Bankumschaltung
IOSEL_3 = 0x0c ; KRT grafik ein
IOSEL_4 = 0x10 ; KRT grafik aus


