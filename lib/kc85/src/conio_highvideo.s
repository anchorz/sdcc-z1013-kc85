; functions for conio.h

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



;; highvideo - Used to select the highlighted character. 
.globl _highvideo
_highvideo::
    ld hl, #COLOR
    res 6, (HL)
    ret
