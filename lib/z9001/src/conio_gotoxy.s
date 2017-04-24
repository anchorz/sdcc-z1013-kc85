;--------------------------------------------------------------------------
;  conio_gotoxy.s
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
        .module conio_gotoxy
        .include 'z9001.inc'
;
; Annahmen testen
;
.if ne(BWS_BYTES_PER_LINE-40)
        .error nur die Zeilenbreite 40 wird unterstützt
.endif
        .area   _CODE
;
;  extern void gotoxy(unsigned char x, unsigned char y) __z88dk_callee;
;
_gotoxy::
        pop     hl
        ex      (sp),hl
        ld      c,l
        ld      a,h
        rlca
        rlca
        add     h
        ld      l,a
        xor     a
        ld      b,#(Z9001_SCTOP/256)
        ld      h,a
        add     hl,hl
        add     hl,hl
        add     hl,hl
        add     hl,bc

        ld(#Z9001_CURS),hl
        ret
