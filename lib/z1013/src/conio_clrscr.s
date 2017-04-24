        .module conio_clrscr
        .include 'z1013.inc'
        .include 'codes.inc'

        .area   _CODE
_clrscr::
        ld a,#CLRSCR
        rst 0x20
        .db OUTCH

        ;cursor_off()
        ld      hl,(#CURSR)
        ld      a,(#CURSR_CHAR)
        ld      (hl),a
        ret
