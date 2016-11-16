;
; functions that are not specific to KC85, but to Z80
;

;
;extern unsigned char reg_r( void);
;
_reg_r::
    ld  a, r
    ld  l, a
    ret

