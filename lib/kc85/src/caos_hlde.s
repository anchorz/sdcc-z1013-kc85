; some functions provided by the CAOS (=monitor program)

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



; Ausgabe der Register HL und DE als Hexzahlen
; in:
;  Register HL, DE
.globl _hlde
_hlde::
    ld hl,#2
    add hl, sp
    ld	b, (hl)
    inc hl
    ld	c, (hl)
    inc hl
    ld	e, (hl)
    inc hl
    ld	d, (hl)
    ex de, hl
    ld h, b
    ld l, c
    call PV1
    .db FNHLDE
    ret

