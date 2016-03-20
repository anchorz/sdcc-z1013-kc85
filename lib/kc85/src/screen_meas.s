; some functions provided by SCREEN

; sdcc calling conventions:
; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'screen.inc'



; MEAS   Laden eines Fensters, nur ASCII-RAM
;    A   Fensternummer

.globl _meas
_meas::
    ld hl,#2
    add hl, sp
    ld a, (hl)  ; A = Fensternummer

    call SCREEN_PV
    .db FNMEAS
    ret
