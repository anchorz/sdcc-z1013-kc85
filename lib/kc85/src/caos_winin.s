; some functions provided by the CAOS (=monitor program)

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



; Initialisierung eines neuen Fensters
;  in:
;   H - links
;   L - oben
;   D - Zeilen
;   E - Spalten
;   A - Fensternummer
;  out:
;   F - CY = 1, Fehler
.globl _winin
_winin::
    ld hl,#2
    add hl, sp
    ld c, (hl)  ; C = links
    inc hl
    ld b, (hl)  ; B = oben
    inc hl
    ld e, (hl)  ; E = Spalten
    inc hl
    ld d, (hl)  ; D = Zeilen
    inc hl
    ld a, (hl)  ; A = Fensternummer

    push bc
    pop hl

    call PV1
    .db FNWININ

    push af
    pop hl
    ret
