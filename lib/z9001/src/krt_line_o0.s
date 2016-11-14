;--------------------------------------------------------------------------
;  krt_line_o0.s
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
        .module krt_line_o0
        .include 'krt.inc'
;
; Annahmen testen
;
.if ne(KRT_BYTES_PER_LINE-40)
.if ne(KRT_BYTES_PER_LINE-32)
        .error nur die Zeilenbreite 32 und 40 wird unterstützt
.endif
.endif
;
; void krt_line( unsigned int x0, unsigned int y0,unsigned int x1, unsigned int y1);
;
        .area   _CODE

Lx0     = 0
Hx0     = 1
Ly0     = 2
Hy0     = 3
Lx1     = 4
Hx1     = 5
Ly1     = 6
Hy1     = 7

PIXEL_WIDTH = 320
PIXEL_HEIGHT = 192

krt_line_o0::
        ld      d,#0
        ld      e,c  ; DE is dy

        ld      c,l
        ld      b,h ; BC is dx & count
        push    bc

        srl     h
        rr      l   ; HL is error
        exx

        ld      a,Ly0(iy)
        ld      c,a
        and     #0x7
        or      #KRT_BANK0
        ld      e,a      ; bank
        ld      d,#0x80  ; bit mask DE set

        ld      a,c
        and     #0xf8
        rrca
        rrca
        rrca

        ; mul SCR_WIDTH==40
        ld      c,a
        ld      b,#0
        ld      l,c
        ld      h,b
.if eq(KRT_BYTES_PER_LINE-40)
        add     hl,hl
        add     hl,hl
        add     hl,bc
        add     hl,hl
        add     hl,hl
        add     hl,hl
.endif
.if eq(KRT_BYTES_PER_LINE-32)
        add     hl, hl
        add     hl, hl
        add     hl, hl
        add     hl, hl
        add     hl, hl
.endif
        ld      bc,#KRT_BWS_START ; bws
        add     hl,bc
        ; set bitmask
        ld      a,Lx0(iy)
        ld      c,a
        and     #0x7
        jr      z,bit_mask_is_ok$
        ld      b,a
        ld      a,d
find_bit_mask$:
        rrca
        djnz    find_bit_mask$
        ld      d,a
bit_mask_is_ok$:
        ld      b,Hx0(iy)
        srl     b
        rr      c
        srl     c  ; bit in B is 0 max 0...319
        srl     c
        add     hl,bc

        ld      a,e
        KRT_SET_BANK
        pop     bc ; count

        ld      a,b
        ld      b,c
        ld      c,a
        inc     c

        ld      a,(hl)
        or      d
        ld      (hl),a ; - 18


        ld      a,b
        or      b    ; if B ==0
        jr      z,dec_counter_high$  ;  == dec C

next_bit$:

        rrc     d
        jr      nc,no_offset_change$
        inc     hl
no_offset_change$:

        exx
        ; error=error - dy
        xor     a,a
        sbc     hl,de
        jp    p,still_ok$

        exx
        inc     e
.if eq(KRT_BANK0-8)
        ; range for z9001 is from 0xf down to 0x8
        bit     4,e
        jr      z,no_address_change$
.else
        ; range for z1013 is from 0x7 down to 0x0
        bit     3,e
        jr      z,no_address_change$
.endif
        ld      a,l
        add     #KRT_BYTES_PER_LINE
        ld      l,a
        ld      a,h
        adc     #0
        ld      h,a
        ld      e,#KRT_BANK0 ; BANK
no_address_change$:
        ld      a,e
        KRT_SET_BANK

        exx
        ; error=error
        ;            + dx
        add     hl,bc
still_ok$:
        exx
        ld      a,(hl)
        or      d
        ld      (hl),a

        djnz    next_bit$
dec_counter_high$:
        dec     c; B is 0
        jr      nz,next_bit$
        ret
