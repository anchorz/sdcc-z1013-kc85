SYSTEM_BASE .equ 0x0000
SYSTEM_LEN  .equ 0x0100
BWS         .equ 0xec00

RAM0        .equ 0x00
RAM1        .equ 0x40

MEMORY_CONF .equ 0x04

    .area _GSINIT

    ld hl,#program_start
    ld de,#BWS
    ld bc,#program_length
    ldir
    jp BWS
weiter:

    .area _CODE
program_start:
    ld hl,#SYSTEM_BASE
    ld de,#BWS+0x100
    ld bc,#SYSTEM_LEN
    ldir
    ld a,#RAM1
    out (MEMORY_CONF),a
    ld hl,#BWS+0x100
    ld de,#SYSTEM_BASE
    ld bc,#SYSTEM_LEN
    ldir
    ld a,#RAM0
    out (MEMORY_CONF),a
    jp weiter
program_length .equ .-program_start
