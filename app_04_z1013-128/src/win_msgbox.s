;--------------------------------------------------------------------------
;  win_msgbox.s
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
        .module win_msgbox
        .include 'z1013.inc'
;
; Annahmen testen
;
.if ne(BWS_BYTES_PER_LINE-32)
        .error nur die Zeilenbreite 32 wird unterstützt
.endif

        .area   _CODE
;
; extern void win_msgbox(unsigned char x, unsigned char y, unsigned char w, unsigned char h) __z88dk_callee;
;
_win_msgbox::
        pop     hl      ; hl == return
        pop     de      ; d(y) e(x)
        ex      (sp),hl ; h(h) l(w)
        ld      b,h     ; b(h)
        ld      c,l     ; c(w)
        xor     a
        ld      h,d     ; D frei
        ld      d,#0xec
        srl     h
        rra
        srl     h
        rra
        srl     h
        rra
        ld      l,a
        add     hl,de
        ld      (hl),#0xc1
        ld      d,b     ; d(h)
        ld      e,c     ; e(w)

        ld      a,#0x9e
        ld      c,#0x89
        call    fill_line$
        ld      (hl),#0xb3
        inc     d
next_line$:
        call    correct_address$

        dec     d
        jr      z,lines_done$

        ld      (hl),#0x9f
        ld      a,#0x20
        ld      c,#0xc0
        call    fill_line$

        ld      (hl),#0xb4
        jr      next_line$
lines_done$:
        ld      (hl),#0x88
        ld      a,#0xf8
        ld      c,#0xc8
        call    fill_line$
        ld      (hl),#0xb4
        call    correct_address$

        ld      (hl),#0xb1
        inc     e
        ld      a,#0xb6
        ld      c,#0xb0
        call    fill_line$
        ret

fill_line$:
        ld      b,e
fill_spaces$:
        inc     hl
        ld      (hl),a
        djnz    fill_spaces$
        inc     hl
        ld      (hl),c
        inc     hl
        ret

correct_address$:
        ld      a,e
        neg
        add     #32-2
        ld      c,a
        add     hl,bc
        ret
