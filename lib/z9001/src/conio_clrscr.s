;--------------------------------------------------------------------------
;  conio_clrscr.s
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
		.module conio_clrscr
		.include 'z9001.inc'
    
		.globl _clrscr

		.area   _CODE
_clrscr:
		xor		a
		ld		h,a
		ld		l,a
		add 	hl,sp
		ld		d,#VT_SPACE
		ld		e,d
		di
		ld 		sp,#(Z9001_SCTOP+Z9001_SCLEN)
		
		ld      b,#(Z9001_SCLEN/16)
		ld		c,b
fill16$:
        push    de
        push    de
        push    de
        push    de
        push    de
        push    de
        push    de
        push    de
        djnz    fill16$;
		
		ld 		
		ld 		sp,#(Z9001_SCCOL+Z9001_SCLEN)
		
		ld		d,#COLOR_DEFAULT
		ld		e,d
		ld      b,c
fill17$:
        push    de
        push    de
        push    de
        push    de
        push    de
        push    de
        push    de
        push    de
        djnz    fill17$;
	
	
	
		ld		sp,hl
		ei
		ret
