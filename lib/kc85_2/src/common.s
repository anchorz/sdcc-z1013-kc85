;
; functions that are not specific to KC85, but to Z80
;

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL


; read from IO range (16 bit)
.globl _in
_in::
    ld  hl, #2
    add hl, sp
    ld  c, (hl)
    inc hl
    ld  b, (hl)

    in  l, (c)  ; read: in l, (bc)
    ret


; write to IO range (16 bit)
.globl _out
_out::
    ld  hl, #2
    add hl, sp
    ld  c, (hl)
    inc hl
    ld  b, (hl)
    inc hl
    ld  a, (hl)

    out (c), a  ; read: out (bc), a
    ret
