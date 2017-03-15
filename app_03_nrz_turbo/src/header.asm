        .module header
 
        .area _CODE
        .area _INITIALIZED
        .area _DATA
        .area _DATA_ENDS

        .globl s__DATA

        .area _CODE
; **********************************
; *                                *
; * .KCC85/2 HEADER                *
; *                                *
; **********************************
header_start:
        .ascii 'TSAVE4  COM'
        .ds 5
        .db 2               ; no autostart - 2 arguments only
        .dw header_ends
        .dw s__DATA         ; first free byte after the program
        .dw 0               ; start address
header_free_space:
        .rept   128-(header_free_space-header_start)
            .byte 0x00                    
        .endm                   
header_ends:

        .area _DATA_ENDS
isr_area_free::
