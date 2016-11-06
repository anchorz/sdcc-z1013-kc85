; specific header to automatic generate KCC format 
; (which is used by simulator, disk, tape, USB, etc...)

        .module header
        .area   _HEADER (ABS)

        .globl init
        .globl s__CODE
        .globl s__STACK

        .dw s__CODE
        .dw s__STACK
        .dw init

        .ascii 'sdcc80'
        .ascii 'C'
        .db 0xd3,0xd3,0xd3
        .ascii '                '


