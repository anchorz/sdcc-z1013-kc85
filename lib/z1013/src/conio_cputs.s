    .module conio_cputs

    .include 'z1013.inc'

    .area   _CODE
;
;  extern unsigned char cputs(const char *str) __z88dk_fastcall;
;
_cputs::
    ld de,(#CURSR)
again:
    ld a,(hl)
    or a
    jr z,end
    ldi
    jr   again
end:
    ld (#CURSR),de
    ret
