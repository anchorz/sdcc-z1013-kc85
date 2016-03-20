; some functions provided by the CAOS (=monitor program)

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



; Initialisieren mehrerer E/A-Kaenale ueber Tabelle(n)
; in:
;  Register HL - Anfangsadresse der Tabelle
;  Register  D - Anzahl der Kanaele
.globl _inime
_inime::
    ld hl,#2
    add hl, sp
    ld	e, (hl)
    inc hl
    ld	d, (hl)
    inc hl
    ld	a, (hl)
    ex de, hl
    ld  d, a
    call PV1
    .db FNINIME
    ret

