    .module conio_putch

    .include 'z1013.inc'

    .area   _CODE
;
;  extern void putch(char)  __z88dk_fastcall;
;
_putch::
    ld a,l
    ld hl,(#CURSR)
again:
    ld (hl),a
    inc hl
    ld (#CURSR),hl
    ret
