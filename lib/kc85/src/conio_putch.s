; functions for conio.h

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



;; putch - Writes a character directly to the console.
.globl _putch
_putch::
    ld      hl, #2
    add     hl, sp

    ld      a,( hl)

    call    PV1
    .db     FNCRT
    
    ;;  wenn CR, dann auch LF
    cp      #0x0a
    ret     nz

    ld      a, #0x0d

    call    PV1
    .db     FNCRT
    
    ret
