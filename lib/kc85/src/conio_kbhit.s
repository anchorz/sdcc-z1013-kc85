; functions for conio.h

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



;; kbhit - Determines if a keyboard key was pressed.
.globl _kbhit
_kbhit::
    ld l, #0

    call PV1
    .db FNKBDS
    jr nc, nokbhit$

    ld l, a

nokbhit$:
    ret
