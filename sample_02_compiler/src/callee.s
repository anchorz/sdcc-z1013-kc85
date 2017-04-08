;since SDCC 3.6.5 set __z88dk_callee as unimplemented
; we have to implement the function from assembly side
;void OUTSTR_CALLEE(int c1, int c2, int c3) __z88dk_callee;

_OUTSTR_CALLEE::
        pop iy; //return address
        pop hl
        call _put_char_int
        pop hl
        call _put_char_int
        pop hl
        call _put_char_int
        push iy
        ret


