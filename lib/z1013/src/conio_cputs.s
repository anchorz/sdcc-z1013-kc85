    .module conio_cputs

    .include 'z1013.inc'

    .area   _CODE
_cputs::
    pop de
    ex (sp),hl
    push de
again:
    ld a,(hl)
    or a
    jr z,end
    rst     0x20
    .db     OUTCH
    inc  hl
    jr   again
end:
    ret
