; some functions provided by the CAOS (=monitor program)

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



; Zeichenausgabe auf Bildschirm
; in:
;  Register A - Zeichencode (ASCII)
.globl _crt
_crt::
    ld hl,#2
    add hl, sp
    ld	a, (hl)

    call PV1
    .db FNCRT
    ret
