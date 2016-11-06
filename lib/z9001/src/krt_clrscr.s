;--------------------------------------------------------------------------
;  krt_clrscr.s
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
        .module krt_clrscr
        .include 'krt.inc'

        .globl _krt_save_sp

;
; Annahmen testen
;
.if (KRT_BWS_LEN%16)
        .error "KRT_BWS_LEN muss ein Vielfaches von 16 sein"
.endif

.if gt((KRT_BWS_LEN/16)-256)
        .error "Blocklänge passt nicht in ein 8-bit register. Maximum für BWS is 4K"
.endif

        .area   _CODE
;
;void krt_clrscr(unsigned int pixel, unsigned int color)  __z88dk_callee;
;
_krt_clrscr::
        pop     hl      ; return
        pop     de      ; DE pixel
        ex      (sp),hl ; HL color

        di
        ld      (_krt_save_sp),sp

        ld      d,e
        ld      c,#KRT_BANK_COUNT
        ld      a,#KRT_BANK7

next_bank$:
        KRT_SET_BANK
        ld      sp,#(KRT_BWS_START+KRT_BWS_LEN)
        ld      b,#KRT_BWS_LEN/16

fill16$:
        push    de
        push    de
        push    de
        push    de
        push    de
        push    de
        push    de
        push    de
        djnz    fill16$;
        dec     a

        rlc     d
        ld      e,d

        dec     c
        jr      nz,next_bank$

.if KRT_COLOR_OFFSET
        ld      h,l
        ld      sp,#(KRT_BWS_START+KRT_BWS_LEN-KRT_COLOR_OFFSET)
        ld      b,#KRT_BWS_LEN/16

fill16Col$:
        push    hl
        push    hl
        push    hl
        push    hl
        push    hl
        push    hl
        push    hl
        push    hl
        djnz    fill16Col$;
.endif

        ld      sp,(_krt_save_sp)
        ei
        ret
