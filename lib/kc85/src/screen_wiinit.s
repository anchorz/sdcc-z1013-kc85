; some functions provided by SCREEN

; sdcc calling conventions:
; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'screen.inc'



;WIINIT  Initialisieren deines Fensters und Festlegen des Speicherraums
;    HL  links, oben
;    DE  Spalten, Zeilen
;    A   Fensternummer

.globl _wiinit
_wiinit::
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

    call SCREEN_PV
    .db FNWIINIT
    ret
