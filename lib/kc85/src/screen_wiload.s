; some functions provided by SCREEN

; sdcc calling conventions:
; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'screen.inc'



; WILOAD  Laden eines geretteten Fensters
;    A   Fensternummer

.globl _wiload
_wiload::
    ld hl,#2
    add hl, sp
    ld a, (hl)  ; A = Fensternummer

    call SCREEN_PV
    .db FNWILOAD
    ret
