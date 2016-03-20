; some functions provided by SCREEN

; sdcc calling conventions:
; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'screen.inc'



; SHIFT   Verschieben eines aktuellen Fensters
;     H   vertikal, Bit 7 = 1 Richtung
;     L   horizontal

.globl _shift
_shift::
    ld  hl,#2
    add hl, sp
    ld  e, (hl)  ; horizontal
    inc hl
    ld  d, (hl)  ; vertikal

    ex  de, hl

    call SCREEN_PV
    .db FNSHIFT
    ret
