; some functions provided by the CAOS (=monitor program)

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



; Farbe einstellen
; in:
;  ARGN - Anzahl der Argumente
;  L    - Vordergrundfarbe
;  E    - Hintergrundfarbe
.globl _colorup
_colorup::
    ld hl,#2
    add hl, sp
    ld	a, (hl)
    ld  (#ARGN), a
    inc hl
    ld	d, (hl)
    inc hl
    ld	e, (hl)
    ld  l, d


    call PV1
    .db FNCOLORUP
    ret
