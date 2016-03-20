; functions for conio.h

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



;; cputs - Writes a string directly to the console.
.globl _cputs
_cputs::
    pop de
    pop hl
    push hl
    push de
    call PV1;
    .db FNZKOUT
    ret
