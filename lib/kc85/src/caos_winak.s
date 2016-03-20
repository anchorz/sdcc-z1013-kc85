; some functions provided by the CAOS (=monitor program)

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



; Aufruf eines Fensters über seine Nummer 
; mit Abspeicherung des aktuellen Fenstervektors
;  in:
;   A - Fensternummer
;  out:
;   F - CY = 1, Fehler
.globl _winak
_winak::
    ld hl,#2
    add hl, sp
    ld a, (hl)  ; A = Fensternummer

    call PV1
    .db FNWINAK

    push af
    pop hl
    ret
