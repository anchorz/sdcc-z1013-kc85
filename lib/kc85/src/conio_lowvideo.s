; functions for conio.h

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



;; lowvideo - Used to deselect the highlighted character. 
.globl _lowvideo
_lowvideo::
    ld hl, #COLOR
    set 6, (HL)
    ret
