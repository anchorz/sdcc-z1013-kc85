; some functions provided by SCREEN

; sdcc calling conventions:
; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'screen.inc'


; TITEL   zeichnet Fenstertitel + Text
; HL Zeiger auf Titeltext
.globl _titel
_titel::
    ld hl,#2
    add hl, sp
    
    ld e, (hl)  ;
    inc hl
    ld d, (hl)  ; DE = Adresse
    
    ex de, hl
    
    call SCREEN_PV
    .db FNTITEL
    ret
