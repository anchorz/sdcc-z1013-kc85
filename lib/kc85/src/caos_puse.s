; some functions provided by the CAOS (=monitor program)

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



; Setzen eines Bildpunktes
; in:
;   (HOR)  = Horizontalkoordinate (0 ... 13FH) 
;   (VERT) = Vertikalkoordinate   (0 ... FFH)
;   (FARB) = Bildpunktfarbe
;       Bit 0     = 1 XOR Fkt.
;           1     = 1 Punkt löschen
;           3 - 7 = Farbe (Vordergrund)
.globl _puse
_puse::
    ld  hl, #2
    add hl, sp
    ld  de, #HOR
    ld  bc, #3
    ldir
    ld  de, #FARB
    ldi
    call PV1
    .db FNPUSE
    push af
    pop hl
    ret
