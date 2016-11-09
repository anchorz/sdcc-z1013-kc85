;--------------------------------------------------------------------------
;  krt_clear_textarea.s
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
        .module krt_clear_textarea
        .include 'krt.inc'
;
; Annahmen testen
;
.if ne(KRT_BYTES_PER_LINE-40)
.if ne(KRT_BYTES_PER_LINE-32)
        .error nur die Zeilenbreite 32 und 40 wird unterstützt
.endif
.endif

        .area   _CODE
;
;       void krt_clear_textarea(unsigned int x, unsigned int y, unsigned int width, unsigned int height) __z88dk_callee;
;
_krt_clear_textarea::
        ld      iy,#2
        add     iy,sp

xL = 0
xH = 1
yL = 2
yH = 3
wL = 4
wH = 5
Lh = 6
        ld      c,yL(iy)
        ld      b,yH(iy)
        ld      l,c
        ld      h,b
.if eq(KRT_BYTES_PER_LINE-40)
        add     hl, hl
        add     hl, hl; HL y*4
        add     hl, bc; HL y*4+1
        add     hl, hl
        add     hl, hl
        add     hl, hl
.endif
.if eq(KRT_BYTES_PER_LINE-32)
        add     hl, hl
        add     hl, hl
        add     hl, hl
        add     hl, hl
        add     hl, hl
.endif
        ld      bc,#KRT_BWS_START
        add     hl,bc ; HL is destination, BC is free
        ld      e,xL(iy)
        ld      d,xH(iy)
        add     hl,de

        ld      bc,#(KRT_BANK_COUNT*256+KRT_BANK0)
next_segment$:
        ld      a,c
        KRT_SET_BANK
        ld      a,Lh(iy)
        push    bc
        push    hl
next_line$:
        ex      af,af'
        ld      c,wL(iy)
        ld      b,wH(iy)
        push    bc
        ld      a,c
        or      a,b
        jr      z,end_copy$

        xor     a,a
        ld      (hl),a
        dec     bc
        ld      a,c
        or      a,b  ; reset CF - we need that later on
        jr      z,end_copy$

        ld      d,h
        ld      e,l
        inc     de
        ldir
end_copy$:
        pop     bc
        sbc     hl,bc ; assume CF is 0 (before LDIR)
        ld      de,#KRT_BYTES_PER_LINE+1 ; correct also HL by one - because of the left byte after LDIR
        add     hl,de
        ex      af,af'
        dec     a
        jr      z,end_erase_line$

        jp      next_line$
end_erase_line$:
        pop     hl
        pop     bc
        inc     c
        djnz    next_segment$

        pop     hl
        pop     de
        pop     bc
        pop     af
        ex      (sp),hl
        ret
