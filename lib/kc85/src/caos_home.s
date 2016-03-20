; some functions provided by the CAOS (=monitor program)

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



; Ausgabe des Steuerzeichens „HOME“ (Code 10H)
.globl _home
_home::
    call PV1
    .db FNHOME
    ret
