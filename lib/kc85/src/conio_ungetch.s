; functions for conio.h

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



; ungetch - Puts the character c back into the keyboard buffers.
.globl _ungetch
_ungetch::
    bit 0,8 (ix)
    jr z, nokey$

    ld a, #0x1a ; EOF
    ld l, a
    ret

nokey$:
    ld hl, #2
    add hl, sp
    ld a, (hl)

    ; zeichen zurück
    ld 13 (ix), a
    ; und wieder als aktiv kennzeichnen
    set 0, 8 (ix)

    ld l, a
    ret
