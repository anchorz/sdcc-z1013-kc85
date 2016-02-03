; see:
; http://www.cpcmania.com/Docs/Programming/Introduction_to_programming_in_SDCC_Compiling_and_testing_a_Hello_World.htm

        .include 'caos.inc'
        
        .area   _CODE

_putchar::
_putchar_rr_s::
        ld      hl, #2
        add     hl, sp

        ld      a,( hl)
        call    PV1
        .db     FNCRT

        ret

_putchar_rr_dbs::
        ld      a,e
        call    PV1
        .db     FNCRT

        ret
