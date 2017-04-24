;--------------------------------------------------------------------------
;  conio_putch.s
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
        .module conio_putch
        .include 'z9001.inc'
;
; Annahmen testen
;
.if ne(BWS_BYTES_PER_LINE-40)
       .error nur die Zeilenbreite 40 wird unterstützt
.endif
        .area   _CODE
;
;  extern void putch(char)  __z88dk_fastcall;
;
_putch::
        ld b,l
        ld a,(#Z9001_ATRIB)
        ld c,a
        ld hl,(#Z9001_CURS)
        ld a,#-4
        add h
        ld  h,a
        ld (hl),c
        add #4
        ld  h,a
        ld (hl),b
        inc hl
        ld (#Z9001_CURS),hl
        ret
