;--------------------------------------------------------------------------
;  putchar.s
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

        .module putchar
        .include 'z9001.inc'

UNIX_STYLE_NEW_LINE = 0x0a
VK_NEW_LINE         = 0x0a
VK_ENTER            = 0x0d

        .area   _CODE
_putchar::

        ld      hl, #2
        add     hl, sp
        ld      a, (hl)
        cp      a, #UNIX_STYLE_NEW_LINE
        jr      NZ, print_character$

        ld      c,#UP_CONSO
        ld      e, #VK_ENTER
        call    Z9001_BOS
        ld      a, #VK_NEW_LINE
print_character$:
        ld      c,#UP_CONSO
        ld      e,a
        call    Z9001_BOS
        ret
