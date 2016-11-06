;--------------------------------------------------------------------------
;  krt_gotoxy.s
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
        .module krt_gotoxy
        .include 'krt.inc'

        .globl  _krt_cursor

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
;void krt_gotoxy(unsigned int x, unsigned int y) __z88dk_callee;
;
_krt_gotoxy::
        pop     hl ; HL return
        pop     bc ; BC x
        ex      (sp),hl; HL y
        ld      d,h
        ld      e,l ; DE y
.if eq(KRT_BYTES_PER_LINE-40)
        add     hl, hl
        add     hl, hl; HL y*4
        add     hl, de; HL y*4+1
        add     hl, hl
        add     hl, hl
        add     hl, hl
.endif
.if eq(KRT_BYTES_PER_LINE-32)
        add     hl, hl
        add     hl, hl
        add     hl, hl
        add     hl, hl
.endif
        ld      de,#KRT_BWS_START
        add     hl,de
        add     hl,bc
        ld      (#_krt_cursor),hl
        ret
