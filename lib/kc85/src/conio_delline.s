; functions for conio.h

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



;; delline - Delete the current line (line on which is cursor)
.globl _delline
_delline::
    ld  a, #0x02 ; clear line
    
    call PV1
    .db FNCRT
    ret
