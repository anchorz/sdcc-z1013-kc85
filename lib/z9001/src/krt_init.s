;--------------------------------------------------------------------------
;  krt_init.s
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

;http://hc-ddr.hucki.net/wiki/doku.php/z9001:erweiterungen:krtgrafik
;http://www.sax.de/~zander/z9001/ex/80z.html
;http://www.sax.de/~zander/z9001/ex/pixkrt/pixkrt_s.pdf
;http://www.sax.de/~zander/z9001/ex/80z/krt80z_a.html
        .module krt_init
        .include 'krt.inc'

        .globl  _krt_font_init

        .area   _DATA
_krt_save_sp::
        .ds 2
_krt_cursor::
        .ds 2
_krt_color::
        .ds 1

        .area   _CODE
;
; void krt_init() __z88dk_callee;
;
_krt_init::
        KRT_OS_INIT
        call    _krt_font_init

        KRT_SWITCH_ON

        ld      hl,#KRT_BWS_START
        ld      (#_krt_cursor),hl

        ld      a,#KRT_COLOR_DEFAULT
        ld      (#_krt_color),a

        ret
