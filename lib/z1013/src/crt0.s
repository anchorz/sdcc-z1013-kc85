;--------------------------------------------------------------------------
;  crt0.s - adapted for a Z1013
;
;  Copyright (C) 2014, Andreas Ziermann
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

	.module crt0
	.globl	_main

	.area	_HEADER (ABS)
	
	;preparing "headersave" file header attached to the final rom image as loadable .z80 format
	.org 0xe0
	.dw s__CODE
	.dw start_of_stackframe
	.dw init
	.ascii 'sdcc80'
	.ascii 'C'
	.db 0xd3,0xd3,0xd3
	.ascii '                '
	
	;; Ordering of segments for the linker.
	.area	_HOME
	.area	_CODE
	.area	_INITIALIZER
	.area _GSINIT
	.area _GSFINAL
	.area _GSEXIT
	.area _GSEXITFINAL
	.area	_DATA
	.area	_INITIALIZED
	.area	_BSEG
	.area _BSS
	.area _STACK
	.area _HEAP
	.area _CODE
	
_monitor_entry .equ 0xf05f
	
init:
	;; Stack at the top of memory.
	ld	sp,#end_of_stackframe
	; mark stack frame
	ld  hl,#0xbbbb
    ld (#start_of_stackframe),hl
	push hl
	
  ;; Initialise global variables
  call  gsinit
	call	_main
	call  	gsexit
	ld    	sp,#0x00b0
	ld 	a,h
	or 	a,l
	jr	nz,error_exit
	jp    	_monitor_entry
error_exit:
	rst     0x38

	.area   _GSINIT
gsinit::
	ld	bc, #l__INITIALIZER
	ld	a, b
	or	a, c
	jr	Z, gsinit_next
	ld	de, #s__INITIALIZED
	ld	hl, #s__INITIALIZER
	ldir
gsinit_next:

	.area   _GSFINAL
	ret

	.area   _GSEXIT
gsexit::

	.area   _GSEXITFINAL
	ret


  .area   _STACK
  ;For now just allocate 1k for stack.
  ; stack frame marker - top
start_of_stackframe:
  .ds     2 ; marker 0xbbbb
  .ds     1024
  ; stack frame marker - bottom
  .ds     2
  ; z1013 has predecrement stack
end_of_stackframe:
