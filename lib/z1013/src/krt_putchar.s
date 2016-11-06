;--------------------------------------------------------------------------
;  krt_putchar.s
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
        .module krt_putchar
        .include 'krt.inc'

        .globl _krt_font

;
; Annahmen testen
;
.if ne(FONT_HEIGHT-8)
        .error wir setzen 8 Bytes pro Zeichen vorgegeben voraus
.endif

        .area   _CODE
_krt_putchar::
    pop iy ; return
    pop de ; destination
    pop hl ; c
    ex (sp),iy ; iyl color
    ld h,#0
    add hl,hl
    add hl,hl
    add hl,hl
    ld bc,#_krt_font
    add hl,bc

    ld a,#KRT_BANK0
    KRT_SET_BANK
    ldi
    dec de
    inc a
    KRT_SET_BANK
    ldi
    dec de
    inc a
    KRT_SET_BANK
    ldi
    dec de
    inc a
    KRT_SET_BANK
    ldi
    dec de
    inc a
    KRT_SET_BANK
    ldi
    dec de
    inc a
    KRT_SET_BANK
    ldi
    dec de
    inc a
    KRT_SET_BANK
    ldi
    dec de
    inc a
    KRT_SET_BANK
    ldi

.if KRT_COLOR_OFFSET
    ; adressiere den Farbspeicher
    .db 0xfd ; IYL
    ld a,l
    ld hl,#-(KRT_COLOR_OFFSET+1) ; korrektur um 1, DE schon auf das nächste Zeichen zeigt
    add hl,de
    ld (hl),a
.endif
    ret


