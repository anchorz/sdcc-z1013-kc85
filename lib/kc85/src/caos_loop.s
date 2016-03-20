; some functions provided by the CAOS (=monitor program)

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'

; Rückgabe der Steuerung an CAOS ohne Speicherinitialisierung
.globl _loop
_loop::
    call PV1
    .db FNLOOP
    ret
