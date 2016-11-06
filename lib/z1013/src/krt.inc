; keine platformabhängige .includes verwenden
; ein Programm, dass krt.inc verwendet soll ja Platformunabhänig sein.

; demnach sind Z9... sind private Deklarationen und sollen nicht in einem 
; KRT Programm verwendet werden

;
; speicheradressen (...soweit verwendet und getestet) 
;
Z1_SCTOP = 0xEC00 ; Zeichenspeicher
Z1_SCLEN = (0xF000-0xEC00) 

;
; IO-Port 
;
Z1_GR_CTRL   = 0x08 ; IOSEL2
Z1_GRFA_ON   = 0x0c ; IOSEL3
Z1_GRFA_OFF  = 0x10 ; IOSEL4

Z1_KRT_BANK0 = 0x00
Z1_KRT_BANK7 = 0x07
Z1_KRT_ON    = 0x08
Z1_KRT_OFF   = 0x09


;
; public interface 
;
COLOR_DEFAULT   = (COLOR_FG_WHITE|COLOR_BG_BLACK)
COLOR_BG_BLACK  = 0x00
COLOR_FG_WHITE  = 0x70

KRT_COLOR_DEFAULT = COLOR_DEFAULT

KRT_BANK0 = (Z1_KRT_BANK0)
KRT_BANK7 = (Z1_KRT_BANK7)
KRT_BANK_COUNT = 0x08

KRT_BWS_START = Z1_SCTOP
KRT_BWS_LEN = Z1_SCLEN
; wenn KRT_COLOR_OFFSET == 0 ist, wird der dazugehörige Code
; nicht mit assembliert
KRT_COLOR_OFFSET=0

KRT_BYTES_PER_LINE = 32

FONT_HEIGHT           = 8 ; bytes pro Zeichen
FONT_WIDTH            = 1 ; in bytes
FONT_CHARACTERS       = 256; normaler Zeichensatz 0x00-0xff
FONT_EXTRA_CHARACTERS = 32 ; extra Zeichen für UTF-8 codes

.macro KRT_SET_BANK
        out     (Z1_GR_CTRL),a
.endm

.macro KRT_OS_INIT
;        .globl  _krt_os_init
;        call    _krt_os_init
.endm

.macro KRT_SWITCH_OFF
       ld       a,#(Z1_KRT_OFF)
       out      (Z1_GR_CTRL),a
       out      (Z1_GRFA_OFF),a
.endm

.macro KRT_SWITCH_ON
       ld       a,#(Z1_KRT_ON)
       out      (Z1_GR_CTRL),a
       out      (Z1_GRFA_ON),a
.endm
