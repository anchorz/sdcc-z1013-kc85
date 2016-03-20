; functions for conio.h

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



; textmode - Changes screen mode (in text mode)
.globl _textmode
_textmode::
    call PV1
    .db FNOSTR
    .db 0x1b
    .db 'A'
    .db 0x00
    ret
