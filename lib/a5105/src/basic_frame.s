;--------------------------------------------------------------------------
;  basic_frame.s - generate BASIC program envelope where the C code 
;                  can be embedded
;
;  Copyright (C) 2018, Andreas Ziermann
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
        .module basic_frame

        .globl  save_stack_ptr
        
        ; Ordering of segments for the linker.
        .area   _HOME
        .area   _CODE
        .area   _INITIALIZER
        .area   _GSINIT
        .area   _GSFINAL
        .area   _GSEXIT
        .area   _GSEXITFINAL
        .area   _FOOTER
        .area   _DATA
        .area   _INITIALIZED
        .area   _BSEG
        .area   _BSS
        .area   _STACK
        .area   _HEAP
        
        .area   _CODE
        .db     0xff   ; prefix .BAS file
;
;       10 DEFUSR=&H[init]
;
line_10:
        .dw     line_20
        .dw     10      ; line number is 10
        .db     0x97    ; DEF
        .db     0xdd    ; USR
        .db     0xef    ; =
        .db     0x0c    ; &H
        .dw     prepare_stack
        .db     0x00    ; EOL
line_20:
;
;       20 Z%=USR(0):END
;
        .dw     line_30 ; where the code is embedded
        .dw     20      ; line number is 20
        .ascii  'Z%'    ; integer variable Z%
        .db     0xef    ; =
        .db     0xdd    ; USR
        .ascii  '('
        .db     0x11    ; token 0
        .ascii  '):'
        .db     0x81    ; END
        .db     0x00    ; EOL
line_30:
;
;       30 ! ... here comes the binary data
;
        .dw     basic_ends
        .dw     30      ; line number is 30
        .ascii  '!'     ; REM
prepare_stack:
        di
        ld      (save_stack_ptr),sp
; dont forget to enable interrupts again
; init: this is the address of the init: jump label
; crt0.s will be linked as 2nd object
; after main() is finished jump to label exit: as mentioned exits.s 
; return from there
.area   _FOOTER
        .db     0x00    ; EOL
basic_ends:
        .dw     0x0000
        
.area   _BSS    

save_stack_ptr: 
        .ds     2