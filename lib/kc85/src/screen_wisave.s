; some functions provided by SCREEN

; sdcc calling conventions:
; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'screen.inc'



; WISAVE  Retten eines Fensters. Es werden ASCII-, Pixel- und Farb-RAM gerettet
;    A   Fensternummer

.globl _wisave
_wisave::
    ld hl,#2
    add hl, sp
    ld a, (hl)  ; A = Fensternummer

    call SCREEN_PV
    .db FNWISAVE
    ret
