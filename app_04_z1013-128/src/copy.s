;--------------------------------------------------------------------------
;  copy.s
;
;  Copyright (C) 2017, Andreas Ziermann
;
;  This library is free software; you can redistribute it and/or modify it
;  under the terms of the GNU General Public License as published by the
;  Free Software Foundation; either version 2, or (at your option) any
;  later version.
;
;  This library is distributed in the hope that it will be useful,
;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;  GNU General Public License for more details.
;
;  You should have received a copy of the GNU General Public License
;  along with this library; see the file COPYING. If not, write to the
;  Free Software Foundation, 51 Franklin Street, Fifth Floor, Boston,
;   MA 02110-1301, USA.
;
;  As a special exception, if you link this library with other files,
;  some of which are compiled with SDCC, to produce an executable,
;  this library does not by itself cause the resulting executable to
;  be covered by the GNU General Public License. This exception does
;  not however invalidate any other reasons why the executable file
;   might be covered by the GNU General Public License.
;--------------------------------------------------------------------------
        .module copy
        .include 'z1013.inc'

BWS_SWITCH  .equ 0x10
ROM8000     .equ 0x20
RAM1        .equ 0x40

MEMORY_CONF .equ 0x04
ROM_BANK    .equ 0x14

.macro BANK_SWITCH_A
    ; METHOD 1 - write to EPROM
    ;   ld (hl),a
    ; METHOD 2 - IOSEL
    out   (ROM_BANK),a
.endm

.macro BANK_GET_NEXT_A
    ; either inc 
    ;   inc a
    ; or add 4 - because the socket does bank switching in 8KB steps
    add a,#0x04 
.endm

    .area _GSINIT
    
    .area _INITIALIZER
__xinit_banked_copy:
    BANK_SWITCH_A
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
    BANK_GET_NEXT_A
    BANK_SWITCH_A
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
    BANK_GET_NEXT_A
    BANK_SWITCH_A
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

