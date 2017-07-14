;--------------------------------------------------------------------------
;  bios.s
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

        .module exit
        .area   _CODE

_bios::
        pop     iy
        ld      hl,(1)   ; base+1 = addr of jump table + 3
        dec     hl
        dec     hl
        dec     hl
        pop     de
        ld      a,e
        add     a
        add     e
        ld      e,a
        ld      d,#0
        add     hl,de
        pop     bc
        pop     de
        push    iy
        push    hl
        ld      hl,#retadr
        ex      (sp),hl
        jp      (hl)
retadr:
        ld      l,a
        ld      h,#0
        ret
