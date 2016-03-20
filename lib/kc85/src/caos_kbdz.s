; some functions provided by the CAOS (=monitor program)

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



; Tastenstatusabfrage mit Quittierung 
; der Taste (Autorepeat)
; out:
;  Register A - Zeichencode (ASCII)
;  Register F - CY = 1, Taste gedrückt
.globl _kbdz
_kbdz::
    push    af
    call PV1
    .db FNKBDZ
    
    push af
    pop hl

    ;ld  a, 0x01
    .db 0x3e
    .db 0x01
    and l
    ld  l, a
    
    pop af

    ret
