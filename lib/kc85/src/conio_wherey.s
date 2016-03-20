; functions for conio.h

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'


; wherey - Return current vertical cursor position 
.globl _wherey
_wherey::
    ld  a, (CURSO_ROW)
    ld  h, #0
    ld  l, a
    ret
