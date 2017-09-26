
BWS_SWITCH  .equ 0x10
ROM8000     .equ 0x20
RAM0        .equ 0x00
RAM1        .equ 0x40




MEMORY_CONF .equ 0x04
ROM_BANK    .equ 0x14

    .area _GSINIT
    

    .area _INITIALIZER
__xinit_banked_copy:
    out   (ROM_BANK),a
    ex    af,af
    ld    a,#BWS_SWITCH   ; BWS ausschalten
    out   (MEMORY_CONF),a    
    ld    hl,#-0x20
    add   hl,bc
    push  hl
    ex    de,hl
    ld    de,#0x00e0
    ld    bc,#0x0020
copy_byte:
    ld    a,(hl)
    ld    (de),a
    dec   bc
    inc   de
    inc   hl
    ld    a,h
    or    l
    jr    nz,bank_is_set
    set   7,h ; set HL=0x8000
    ex    af,af
    add   a,#0x04
    out   (ROM_BANK),a
    ex    af,af
bank_is_set: 
    ld    a,c
    or    b
    jr    nz,copy_byte
    ld    de,#0xe0
    push  hl
    ld    a,(de)
    ld    l,a
    inc   de
    ld    a,(de)
    ld    h,a
    ex    de,hl
    pop   hl
    pop   bc
copy_byte2:
    ld    a,(hl)
    ld    (de),a
    dec   bc
    inc   de
    inc   hl
    ld    a,h
    or    l
    jr    nz,bank_is_set2
    set   7,h ; set HL=0x8000
    ex    af,af
    add   a,#0x04
    out   (ROM_BANK),a
    ex    af,af
bank_is_set2: 
    ld    a,c
    or    b
    jr    nz,copy_byte2
    ld    de,#0x00e4
    ld    a,(de)
    ld    l,a
    inc   de
    ld    a,(de)
    ld    h,a
    ld    sp,#0x0090
    ld    a,#ROM8000   ; BWS einschalten, ROM800 ausschalten
    out   (MEMORY_CONF),a    
    
    jp    (hl)
    
__xinit_banked_copy_len .equ .-__xinit_banked_copy
    
    .area _INITIALIZED
_banked_copy:: 
    .ds __xinit_banked_copy_len

