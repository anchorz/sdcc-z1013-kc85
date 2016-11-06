;--------------------------------------------------------------------------
;  z9001.inc
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

;
; speicheradressen (...soweit verwendet und getestet) 
;
Z9001_WBOOT = 0x0000 ; Sprung zum Warmstart
Z9001_BOS   = 0x0005 ; BOS Sprungverteiler
Z9001_SYSB  = 0xEFC0 ; Systembyte (siehe z9_os.pdf) 
Z9001_MAPAR = 0xEFC1 ; 64-bit Vektor je 1K Speicher 0-ROM/1-RAM  
Z9001_BIOS  = 0xF000 ; BIOS ROM 

Z9001_SCTOP = 0xEC00 ; Zeichenspeicher
Z9001_SCLEN = (0xEFC0-0xEC00) 

;
; Farben
;
COLOR_DEFAULT   = (COLOR_FG_WHITE|COLOR_BG_BLACK)
COLOR_BG_BLACK  = 0x00
COLOR_FG_WHITE  = 0x70

;
; IO-Ports 
;
Z9001_GR_CTRL   = 0xb8

Z9001_KRT_ON    = 0x08
Z9001_KRT_OFF   = 0x00
Z9001_KRT_BANK0 = 0x00
Z9001_KRT_BANK1 = 0x01
Z9001_KRT_BANK2 = 0x02
Z9001_KRT_BANK3 = 0x03
Z9001_KRT_BANK4 = 0x04
Z9001_KRT_BANK5 = 0x05
Z9001_KRT_BANK6 = 0x06
Z9001_KRT_BANK7 = 0x07

; Unterprogramme
UP_CONSO        = 0x02
