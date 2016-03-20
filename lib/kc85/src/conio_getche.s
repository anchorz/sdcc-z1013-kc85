; functions for conio.h

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



;; getche - Reads a character directly from the console without buffer, but with echo.
.globl _getche
_getche::
    call PV1
    .db FNKBD
    ld  l, a
    call PV1
    .db FNCRT
    ret
