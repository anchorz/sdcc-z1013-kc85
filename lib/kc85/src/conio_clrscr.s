; functions for conio.h

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



;; clrscr - Clears the screen.
.globl _clrscr
_clrscr::
    ld  a, #0x0c ; clear screen
    
    call PV1
    .db FNCRT
    ret
