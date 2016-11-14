; keine platformabhängige .includes verwenden
; ein Programm, dass krt.inc verwendet soll ja Platformunabhänig sein.

; demnach sind Z9... sind private Deklarationen und sollen nicht in einem 
; KRT Programm verwendet werden

;
; speicheradressen (...soweit verwendet und getestet) 
;
Z9_COTOP = 0xE800 ; Farbspeicher
Z9_SCTOP = 0xEC00 ; Zeichenspeicher
Z9_SCLEN = (0xEFC0-0xEC00) 

;
; IO-Port 
;
Z9_GR_CTRL   = 0xb8

Z9_KRT_ON    = 0x08
Z9_KRT_OFF   = 0x00
Z9_KRT_BANK0 = 0x00
Z9_KRT_BANK7 = 0x07

;
; public interface 
;
COLOR_DEFAULT   = (COLOR_FG_WHITE|COLOR_BG_BLACK)
COLOR_BG_BLACK  = 0x00
COLOR_FG_WHITE  = 0x70

KRT_COLOR_DEFAULT = COLOR_DEFAULT

KRT_BANK0 = (Z9_KRT_ON|Z9_KRT_BANK0)
KRT_BANK7 = (Z9_KRT_ON|Z9_KRT_BANK7)
KRT_BANK_COUNT = 0x08

KRT_BWS_START = Z9_SCTOP
KRT_BWS_LEN = Z9_SCLEN
; wenn KRT_COLOR_OFFSET == 0 ist, wird der dazugehörige Code
; nicht mit assembliert
KRT_COLOR_OFFSET= (Z9_SCTOP-Z9_COTOP)

KRT_BYTES_PER_LINE = 40
KRT_PIXEL_WIDTH = 320
KRT_PIXEL_HEIGHT = 192

FONT_HEIGHT           = 8 ; bytes pro Zeichen
FONT_WIDTH            = 1 ; in bytes
FONT_CHARACTERS       = 256; normaler Zeichensatz 0x00-0xff
FONT_EXTRA_CHARACTERS = 32 ; extra Zeichen für UTF-8 codes

.macro KRT_SET_BANK
        out     (Z9_GR_CTRL),a
.endm

.macro KRT_OS_INIT
        .globl  _krt_os_init
        call    _krt_os_init
.endm

.macro KRT_SWITCH_OFF
       ld       a,#(Z9_KRT_OFF|Z9_KRT_BANK0)
       out      (Z9_GR_CTRL),a
.endm

.macro KRT_SWITCH_ON
       ld       a,#(Z9_KRT_ON|Z9_KRT_BANK0)
       out      (Z9_GR_CTRL),a
.endm
