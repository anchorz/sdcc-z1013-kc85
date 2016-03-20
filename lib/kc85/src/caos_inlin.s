; some functions provided by the CAOS (=monitor program)

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



; Eingabe einer Zeile mit Funktion aller Cursortasten, 
; Abschluss mit <ENTER> oder Abbruch <BRK>
; out:
;  Register DE - Adresse des Zeilenanfangs des eingestellten Fensters im Video-RAM
.globl _inlin
_inlin::
    call PV1
    .db FNINLIN
    push de
    pop hl
    ret
