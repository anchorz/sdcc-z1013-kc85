;
; functions that are not specific to KC85, but to Z80
;

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL


; read from IO range (8 bit)
.globl _in
_in::
    ld  hl, #2
    add hl, sp
    ld  c, (hl)

    in  l, (c)  ; read: in l, (c)
    ret


; write to IO range (8 bit)
.globl _out
_out::
    ld  hl, #2
    add hl, sp
    ld  c, (hl)
    inc hl
    ld  a, (hl)

    out (c), a  ; read: out (c), a
    ret


; read from IO range (16 bit)
.globl _in16
_in16::
    ld  hl, #2
    add hl, sp
    ld  c, (hl)
    inc hl
    ld  b, (hl)

    in  l, (c)  ; read: in l, (bc)
    ret


; write to IO range (16 bit)
.globl _out16
_out16::
    ld  hl, #2
    add hl, sp
    ld  c, (hl)
    inc hl
    ld  b, (hl)
    inc hl
    ld  a, (hl)

    out (c), a  ; read: out (bc), a
    ret


; read r (refresh) register
.globl _reg_r
_reg_r::
    ld  a, r
    ld  l, a
    ret

