; some functions provided by the CAOS (=monitor program)

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



; Zeichnen eines Kreises mit dem eingestellten Linientyp
; auf dem Bildschirm mit Mittelpunkt XM/YM und Radius R
; in:
;   (ARG1) - XM = X-Koordinate-Mittelpunkt
;   (ARG2) - YM = Y-Koordinate-Mittelpunkt
;   (ARG3) - R  = Radius
;   (FARB)  Bit 0 = 1 XOR-Funktion
;           Bit 1 = 1 Linie löschen
;           Bit 3 - 7 Farbe (Vordergrund)
.globl _circle
_circle::
    ld  hl, #2
    add hl, sp
    ld  de, #ARG1
    ld  bc, #6
    ldir
    ld  de, #FARB
    ldi
    call PV1
    .db FNCIRCLE
    ret
