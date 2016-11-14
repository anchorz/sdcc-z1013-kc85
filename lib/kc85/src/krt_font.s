;--------------------------------------------------------------------------
;  krt_font.s
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
        .module krt_font
        .include 'krt.inc'

FONT_SIZE       = ((FONT_CHARACTERS+FONT_EXTRA_CHARACTERS)*FONT_HEIGHT*FONT_WIDTH)

        .globl  _krt_font_install

;
; Annahmen testen
;
.if ne(FONT_HEIGHT-8)
        .error wir setzen 8 Bytes pro Zeichen vorgegeben voraus
.endif

        .area   _CODE
_krt_font_source:
        .include 'z1013font.inc'

        .area   _DATA
_krt_font::
        .ds FONT_SIZE

        .area   _CODE
_krt_font_init::
        ld      hl,#FONT_CHARACTERS
        push    hl
        ld      hl,#0
        push    hl
        ld      hl,#_krt_font_source
        push    hl
        call    _krt_font_install
        ret
