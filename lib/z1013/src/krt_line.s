;--------------------------------------------------------------------------
;  krt_putchar.s
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
        .module krt_line
        .include 'krt.inc'

        .globl krt_line_o6
        .globl krt_line_o7
        .globl krt_line_o0
        .globl krt_line_o1
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

_krt_line::
        ld      iy,#2
        add     iy,sp
        ld      l,Lx1(iy)
        ld      h,Hx1(iy)
        ld      c,Lx0(iy)
        ld      b,Hx0(iy)

        ld      a,l
        sub     a,#(KRT_PIXEL_WIDTH & 0xff)
        ld      a,h
        sbc     #(KRT_PIXEL_WIDTH / 256)
        ret     nc

        ld      a,c
        sub     a,#(KRT_PIXEL_WIDTH & 0xff)
        ld      a,b
        sbc     #(KRT_PIXEL_WIDTH / 256)
        ret     nc

        xor     a,a
        sbc     hl,bc ; HL dx=x1-x0
        jr      c,O2345_dx_less_than_0$
        ; O0167
        ; X1 >= X0
        ld      c,Ly1(iy) ; L = y1
        ld      e,Ly0(iy) ; E = y0
.if lt(KRT_PIXEL_HEIGHT-256)
        ld      a,c
        sub     a, #KRT_PIXEL_HEIGHT
        ret     NC

        ld      a,e
        sub     a, #KRT_PIXEL_HEIGHT
        ret     NC
.endif
        ld      a,e
        sub     a,c
        jr      nc,O67_dy_less_than_0$
        ; O01
        ; X1 >= X0 Y1>=Y0
        neg         ; A=dy HL=dx
        ld      c,a ; C=dy HL=dx
        ld      a,h
        or      a
        jr      nz,O0_dx_greater_than_dy$
        ld      a,c
        sub     l
        jr      c,O0_dx_greater_than_dy$
        jp      krt_line_o1
O0_dx_greater_than_dy$:
        ; O0
        jp      krt_line_o0
O67_dy_less_than_0$:
        ; X1 >= X0 Y1<Y0 A=dy HL=dx
        ld      c,a ; C=dy HL=dx
        ld      a,h
        or      a
        jr      nz,O7_dx_greater_than_dy$
        ld      a,c
        sub     l
        jr      c,O7_dx_greater_than_dy$
        jp      krt_line_o6
O7_dx_greater_than_dy$:
        jp      krt_line_o7
O2345_dx_less_than_0$:
        ; O2345
        ; X1 < X0
        ; xor a
        sub     l ;a ssume a=0
        ld      l,a
        sbc     a,a
        sub     h
        ld      h,a
        ; same as 2 x add hl,bc - but 2 clock cycles shorter
        ; HL dx=x0-x1
        ld      c,Ly1(iy) ; L = y1
        ld      e,Ly0(iy) ; E = y0
.if lt(KRT_PIXEL_HEIGHT-256)
        ld      a,c
        sub     a, #KRT_PIXEL_HEIGHT
        ret     NC

        ld      a,e
        sub     a, #KRT_PIXEL_HEIGHT
        ret     NC
.endif
        ld      a,e
        sub     a,c
        jr      nc,O45_dy_less_than_0$
_krt_line_dbg::
        ;O23
        neg
        ld      c,a ; C=dy HL=dx
        ld      a,h
        or      a
        jr      nz,O3_dx_greater_than_dy$
        ld      a,c
        sub     l
        jr      c,O3_dx_greater_than_dy$
        pop     af ;ret
        ex      af,af
        exx
        pop     hl ;x0
        pop     bc ;y0
        pop     de ;x1
        pop     af ;y1
        push    bc
        push    hl
        push    af
        push    de
        exx
        ex      af,af
        push    af
        jp      krt_line_o6
O3_dx_greater_than_dy$:
        ;O3
        pop     af ;ret
        ex      af,af
        exx
        pop     hl ;x0
        pop     bc ;y0
        pop     de ;x1
        pop     af ;y1
        push    bc
        push    hl
        push    af
        push    de
        exx
        ex      af,af
        push    af
        jp      krt_line_o7
O45_dy_less_than_0$:
        ;O45
        ld      c,a ; C=dy HL=dx
        ld      a,h
        or      a
        jr      nz,O4_dx_greater_than_dy$
        ld      a,c
        sub     l
        jr      c,O4_dx_greater_than_dy$
        ;O5
        pop     af ;ret
        ex      af,af
        exx
        pop     hl ;x0
        pop     bc ;y0
        pop     de ;x1
        pop     af ;y1
        push    bc
        push    hl
        push    af
        push    de
        exx
        ex      af,af
        push    af
        jp      krt_line_o1
O4_dx_greater_than_dy$:
        ;O4
        pop     af ;ret
        ex      af,af
        exx
        pop     hl ;x0
        pop     bc ;y0
        pop     de ;x1
        pop     af ;y1
        push    bc
        push    hl
        push    af
        push    de
        exx
        ex      af,af
        push    af
        jp      krt_line_o0

