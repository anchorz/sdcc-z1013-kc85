; some functions provided by the CAOS (=monitor program)

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



; Initialisieren eines E/A-Kanals ueber Tabelle
; in:
;  Register HL - Anfangsadresse der Tabelle
.globl _iniea
_iniea::
    ld hl,#2
    add hl, sp
    ld	e, (hl)
    inc hl
    ld	d, (hl)
    ex de, hl
    call PV1
    .db FNINIEA
    ret

