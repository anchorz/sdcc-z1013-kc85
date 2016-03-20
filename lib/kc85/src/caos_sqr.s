; some functions provided by the CAOS (=monitor program)

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



; Berechnen der Quadratwurzel
.globl _sqr
_sqr::
    ld hl,#2
    add hl, sp
    ld	e, (hl)
    inc hl
    ld	d, (hl)
    ex de, hl
    call PV1
    .db FNSQR
    ld  l, a
    ret
