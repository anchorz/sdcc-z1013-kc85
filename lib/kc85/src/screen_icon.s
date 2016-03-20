; some functions provided by SCREEN

; sdcc calling conventions:
; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'screen.inc'



.globl _icon
_icon::
    ld  hl, #2
    add hl, sp

    ld  a, (hl)  ; A = Iconnummer
    inc hl
    ld  e, (hl)
    inc hl
    ld  d, (hl)
    inc hl
    push de
    ld  e, (hl) ; e = spalte
    inc hl
    ld  d, (hl) ; d = zeile
    pop hl      ; HL = Adresse

    call SCREEN_PV
    .db FNICON
    ret
