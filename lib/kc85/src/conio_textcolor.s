; functions for conio.h

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



; textcolor - change the color of drawing text
.globl _textcolor
_textcolor::
    ld a, #1
    ld  (#ARGN), a

    ld hl, #2
    add hl, sp
    ld a, (hl)
    ld l, a

    call PV1
    .db FNCOLORUP
    ret
