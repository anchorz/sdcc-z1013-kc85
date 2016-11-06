;--------------------------------------------------------------------------
;  krt_os_init.s
;
;  Copyright (C) 2016, Andreas Ziermann
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
        .module krt_os_init
        .include 'z9001.inc'

        .globl _krt_save_sp

        .area   _CODE
; Z9001 specific
; kopiere die Arbeitszellen ab 0xEFC0 in den Grafikspeicher
_krt_os_init::
        di
        ld (_krt_save_sp),sp
        ld  c, #8 ; kopiere das ganze 8 mal (jeweils 8 bytes)
        ld sp, #Z9001_SYSB
        ld hl, #Z9001_SYSB+8 ; Stackpointer am Ende des Lesevorganges (8=4x16bit pop)
__next_block$:
        xor a,a
        out (Z9001_GR_CTRL),a ; lese vom Orginalspeicher
        or a,#(Z9001_KRT_ON|Z9001_KRT_BANK0) ; und dann schreibe in die Kopien
        ld  b,#8
        exx
        pop bc
        pop de
        pop hl
        exx
        pop de
__next_bank$:
        out (Z9001_GR_CTRL),a
        push de
        exx
        push hl
        push de
        push bc
        exx
        ld sp,hl
        inc a
        djnz __next_bank$
        ld de,#8; Stackpointer am Ende des Lesevorganges (8=4x16bit pop)
        add hl,de
        dec c
        jr nz,__next_block$
        ld sp,(_krt_save_sp)
        ei
        ret
