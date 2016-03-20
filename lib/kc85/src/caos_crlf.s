; some functions provided by the CAOS (=monitor program)

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



; Ausgabe von „NEWLINE“ (Codes 0DH=CR und 0AH=LF)
.globl _crlf
_crlf::
    call PV1
    .db FNCRLF
    ret
