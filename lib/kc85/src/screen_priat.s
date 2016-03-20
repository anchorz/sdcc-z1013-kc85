; some functions provided by SCREEN

; sdcc calling conventions:
; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'screen.inc'



; PRIAT   Ausgabe auf festgelegter Position (analog PRINT AT in BASIC)
;     H   Zeile
;     L   Spalte
;     DE  Adresse des Textes
.globl _priat
_priat::
    ld hl,#2
    add hl, sp
    ld c, (hl)  ; C = links
    inc hl
    ld b, (hl)  ; B = oben
    inc hl
    ld e, (hl)  ;
    inc hl
    ld d, (hl)  ; DE = Adresse

    push bc
    pop hl

    call SCREEN_PV
    .db FNPRIAT
    ret
