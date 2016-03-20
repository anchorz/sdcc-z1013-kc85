; some functions provided by the CAOS (=monitor program)

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



; Zeichnen einer Linie mit dem eingestellten Linientyp
; auf dem Bildschirm von X0/Y0 nach X1/ Y1
; in:
;   (ARG1) - X0 = X-Koordinate-Anfang
;   (ARG2) - Y0 = Y-Koordinate-Anfang
;   (ARG3) - X1 = X-Koordinate-Ende
;   (ARG4) - Y1 = Y-Koordinate-Ende
;   (FARB)  Bit 0 = 1 XOR-Funktion
;           Bit 1 = 1 Linie löschen
;           Bit 3 - 7 Farbe (Vordergrund)
.globl _line
_line::
    ld  hl, #2
    add hl, sp
    ld  de, #ARG1
    ld  bc, #8
    ldir
    ld  de, #FARB
    ldi
    call PV1
    .db FNLINE
    ret
