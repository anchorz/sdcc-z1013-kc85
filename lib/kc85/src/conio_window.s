; functions for conio.h

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



; window - Defines the active text mode window. 
; 
; ist
; sp + 2 = links
; sp + 3 = oben
; sp + 4 = rechts
; sp + 5 = unten
;
; soll
; H = oben
; L = links
; D = unten - oben
; E = rechts - links
;
.globl _window
_window::
    ld hl, #2
    add hl, sp
    ld c, (hl)  ; C = links
    inc hl
    ld b, (hl)  ; B = oben
    inc hl
    ld e, (hl)  ; E = rechts
    inc hl
    ld d, (hl)  ; D = unten

    ld a, e
    sub c
    ld e, a     ; E = rechts - links

    ld a, d
    sub b
    ld d, a     ; D = unten - oben

    ld h, b     ; H = oben
    ld l, c     ; L = links
    xor a       ; win nr = 0

    call PV1
    .db FNWININ
    ret


