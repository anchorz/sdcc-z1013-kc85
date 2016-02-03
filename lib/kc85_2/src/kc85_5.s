; some functions provided by the CAOS (=monitor program)

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'

; Zeichenausgabe auf Bildschirm
; in:
;  Register A - Zeichencode (ASCII)
.globl _crt
_crt::
    ld hl,#2
    add hl, sp
    ld	a, (hl)

    call PV1;
    .db FNCRT
    ret


; Tasteneingabe mit Einblendung des Cursors, 
; wartet, bis Taste gedrückt bzw. liefert die 
; Codefolge von vorher betätigter F-Taste
; out:
;  Register A - Zeichencode (ASCII)
.globl _kbd
_kbd::
    call PV1;
    .db FNKBD
    ld  l, a
    ret


; Ausgabe des Wertes des Registers HL als Hexzahl
; und danach ein Leerzeichen
; in:
;  Register HL
.globl _hlhx
_hlhx::
    ld hl,#2
    add hl, sp
    ld	e, (hl)
    inc hl
    ld	d, (hl)
    ex de, hl
    call PV1;
    .db FNHLHX
    ret


; Ausgabe Register A als Hexzahl
; in:
;  Register A 
.globl _ahex
_ahex::
    ld hl,#2
    add hl, sp
    ld	a, (hl)

    call PV1;
    .db FNAHEX
    ret


; Komplementiere Cursor
.globl _cucp
_cucp::
    call PV1;
    .db FNCUCP
    ret


; Ausgabe eines Leerzeichens über UP-Nr. 24H
.globl _space
_space::
    call PV1;
    .db FNSPACE
    ret


; Ausgabe von „NEWLINE“ (Codes 0DH=CR und 0AH=LF)
.globl _crlf
_crlf::
    call PV1;
    .db FNCRLF
    ret


; Ausgabe des Steuerzeichens „HOME“ (Code 10H)
.globl _home
_home::
    call PV1;
    .db FNHOME
    ret


; Zeichenausgabe mit Negation des Bits 3 des Steuerbytes (STBT) 
; des  Bildschirmprogramms (Ausführung der Steuerzeichen/
; Abbildung der Steuerzeichen)
; in:
;  Register A - Zeichencode (ASCII)
.globl _cstbt
_cstbt::
    ld hl,#2
    add hl, sp
    ld	a, (hl)

    call PV1;
    .db FNCSTBT
    ret


; Ausgabe einer über Register HL adressierten Zeichenkette
; in:
;  Register HL = Anfang der Zeichenkette
.globl _zkout
_zkout::
    ld hl,#2
    add hl, sp
    ld	e, (hl)
    inc hl
    ld	d, (hl)
    ex de, hl
    call PV1;
    .db FNZKOUT
    ret
