; functions for conio.h

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



; wherex - Return current horizontal cursor position 
.globl _wherex
_wherex::
    ld  a, (CURSO_COL)
    ld  h, #0
    ld  l, a
    ret
