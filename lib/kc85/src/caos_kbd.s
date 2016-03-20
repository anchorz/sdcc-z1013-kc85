; some functions provided by the CAOS (=monitor program)

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



; Tasteneingabe mit Einblendung des Cursors, 
; wartet, bis Taste gedrückt bzw. liefert die 
; Codefolge von vorher betätigter F-Taste
; out:
;  Register A - Zeichencode (ASCII)
.globl _kbd
_kbd::
    call PV1
    .db FNKBD
    ld  l, a
    ret
