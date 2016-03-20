; functions for conio.h

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



;; gotoxy - Moves cursor to the specified position
.globl _gotoxy
_gotoxy::
    ld hl, #2
    add hl, sp

    ld a, (hl)
    ld (CURSO_COL), a

    inc hl
    
    ld a, (hl)
    ld (CURSO_ROW), a

    ret
