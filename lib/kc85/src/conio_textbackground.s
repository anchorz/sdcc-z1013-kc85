; functions for conio.h

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



; textbackground - change of current background color 
.globl _textbackground
_textbackground::
    ld a, #2
    ld  (#ARGN), a

    ; hole Vordergundfarbe
    ld a, (#COLOR)
    srl a
    srl a
    srl a
    ld d, a

    ; hole Hintergrundfarbe
    ld hl, #2
    add hl, sp
    ld a, (hl)
    ld e, a
    ld l ,d

    call PV1
    .db FNCOLORUP
    ret
