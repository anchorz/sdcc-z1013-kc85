; some functions provided by the CAOS (=monitor program)

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



; Modulsteuerung
;   = Lesen des Modultyps (Register A < 2)
;   = Aussenden des Steuercodes (Register A ≥ 2)
; in:
;   A   - Anzahl der Parameter
;   L   - Steckplatz
;   D   - Steuerbyte
; out:
;   H   - Modultyp (Strukturbyte)
;   D   - Modulsteuerbyte
.globl _modu
_modu::
    ld  hl, #2
    add hl, sp
    ld  a, (hl)
    inc hl
    ld  e, (hl)
    inc hl
    ld  d, (hl)

    ld  l, e
    call PV1
    .db FNMODU

    ld  l, d

    ret
