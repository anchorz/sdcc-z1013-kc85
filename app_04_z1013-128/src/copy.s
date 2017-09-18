

RAM0        .equ 0x00
RAM1        .equ 0x40

MEMORY_CONF .equ 0x04

    .area _GSINIT
    

    .area _INITIALIZER
__xinit_banked_copy:
    push  de
    push  bc
    ld    de,#0x00e0
    ld    bc,#0x0020
    ldir
    
    pop   bc
    pop   de
    ;set user stack
    jp    0xf000
    
__xinit_banked_copy_len .equ .-__xinit_banked_copy
    
    .area _INITIALIZED
_banked_copy:: 
    .ds __xinit_banked_copy_len

