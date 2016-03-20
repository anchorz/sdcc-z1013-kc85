; some functions provided by the CAOS (=monitor program)

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



; Zeichenausgabe mit Negation des Bits 3 des Steuerbytes (STBT) 
; des  Bildschirmprogramms (Ausführung der Steuerzeichen/
; Abbildung der Steuerzeichen)
; in:
;  Register A - Zeichencode (ASCII)
.globl _cstbt
_cstbt::
    ld hl,#2
    add hl, sp
    ld	a, (hl)

    call PV1;
    .db FNCSTBT
    ret
