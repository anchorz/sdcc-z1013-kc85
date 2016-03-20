; some functions provided by the CAOS (=monitor program)

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



; Test auf Unterbrechungsanforderung
; out:
;  Register A - Zeichencode (ASCII)
;  Register F - CY = 1, Taste BRK gedrückt
.globl _brkt
_brkt::
    call PV1
    .db FNBRKT
    
    push af
    pop hl

    ;ld  a, 0x01
    .db 0x3e
    .db 0x01
    and l
    ld  l, a

    ret
