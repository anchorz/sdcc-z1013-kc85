; functions for conio.h

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



;; getch - prompts the user to press a character
.globl _getch
_getch::
    call PV1
    .db FNKBD
    ld  l, a
    ret
