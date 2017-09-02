    .module rom_boot.s
    .area _CODE1 (ABS)
    .include 'rom_boot.cfg'
    .org ROM_BASE

BWS_INACTIVE  .equ 0x10
BWS_ACTIVE    .equ 0x00
EPROM_CHANGE  .equ 0x20
EPROM_RESET   .equ 0x00
RAM1          .equ 0x40
RAM0          .equ 0x00
ZG_IBM        .equ 0x80
ZG_ORIG       .equ 0x00

RAM_CONTROL   .equ 0x04

STACK         .equ 0x00b0

    .globl startOfBootApplication
    .globl copy_rom_to_ram0
entry:
    jp  start
table:
startOfBootApplication:
    .dw  start_of_stream
    .dw  0xffff ; zieladdresse
    .dw  0xffff ; länge boot programm
    .dw  0xffff ; startaddresse
    .dw  copy_rom_to_ram0
copy_rom_to_ram0:
    ld hl,#copy_internal
    ld de,#BWS
    ld bc,#copy_internal_len
    ldir
    jp  BWS
copy_internal:
    pop hl ; ignore return
    pop hl
    pop de
    pop bc
    pop iy
copy_next:
    ld a,#(EPROM_RESET|RAM0)
    out (RAM_CONTROL),a
    ld a,(hl)
    ex af,af
    ld  a,#(EPROM_CHANGE|RAM1)
    out (RAM_CONTROL),a
    ex af,af
    ld  (de),a
    inc hl
    inc de
    dec bc
    ld a,c
    or b
    jr nz,copy_next
    ld sp,#STACK
    jp (iy)
copy_internal_len .equ .-copy_internal

start:
    ld hl,#table
    ld sp,hl
    pop hl
    pop de
    pop bc
decode:
    ldir
    ret
start_of_stream:
