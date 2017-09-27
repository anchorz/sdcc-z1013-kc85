; File Name   :	c:\user\hobby\hobby0\z1013 ramtest\ramtest_1900.rom
; Format      :	Binary file
; Base Address:	0000h Range: 1900h - 2000h Loaded length: 0700h

; reass. + kommentiert: V. Pohlers 10.02.2010


		cpu	Z80

		org 1900h

;------------------------------------------------------------------------------
; Initialisierung der RST-UP
;------------------------------------------------------------------------------

begin:		jp	init
		db    0

;------------------------------------------------------------------------------
; Beginn RAM-Test
;-----------------------------------------------------------------------------

ramtst:		call	prep
		call	anz0
		jp	test

;------------------------------------------------------------------------------
; Ausgabe (DE), bis Bit7 gesetzt
;------------------------------------------------------------------------------

j_prst7DE:	jp	prst7DE

		db    0
		db    0
		db    0
		db    0
		ret

;------------------------------------------------------------------------------
;
;------------------------------------------------------------------------------

sub_1915:	ld	hl, unk_1F57
loc_1918:	rst	8		; INCH
		cp	8
		jr	z, loc_192C
		cp	3
		jr	z, loc_1936
		rst	10h		; OUTCH
		ld	(hl), a
		inc	hl
		cp	0Dh
		ret	z
		ld	a, l
		cp	5Ch ; '\'
		jr	nz, loc_1918
loc_192C:	ld	a, l
		cp	57h ; 'W'
		jr	z, loc_1918
		dec	hl
		rst	18h		; PRST7
aI:		db 	88h
		jr	loc_1918
loc_1936:	rst	18h		; PRST7
		db  	8Dh
		jp	0F000h		; Sprung ins OS

;------------------------------------------------------------------------------
; Eingabe J/N, J->A=FF,	N->A=0
;------------------------------------------------------------------------------

jninput:	call	j_prst7DE	; Ausgabe (DE), bis Bit7 gesetzt
		rst	18h		; PRST7
		db " (J/N) ?",0A0h
		rst	8		; INCH
		push	af
		rst	10h		; OUTCH
		rst	18h		; PRST7
		db  	8Dh
		pop	af
		cp	'N'
		ld	a, 0FFh
		ret	nz
		xor	a
jninput1:	ret


;------------------------------------------------------------------------------
; Eingabe Hex-Zahl nach	HL
;------------------------------------------------------------------------------

hexinput:	call	sub_1915
		ld	de, unk_1F57
		ld	hl, 0
hexinput1:	ld	a, (de)
		sub	30h ; '0'
		jr	c, jninput1
		cp	0Ah
		jr	c, hexinput2
		sub	7
		cp	0Ah
		jr	c, jninput1
		cp	10h
		jr	nc, jninput1
hexinput2:	add	hl, hl
		add	hl, hl
		add	hl, hl
		add	hl, hl
		add	a, l
		ld	l, a
		inc	de
		jr	hexinput1

;------------------------------------------------------------------------------
; Texte
;------------------------------------------------------------------------------

aRichtic:	db 0Dh,"richti",0E7h
aBuffChipTes:	db "Buff/Chip-Tes",0F4h
aPeakTestA:	db "Peak-Test    ",0A0h
aValleyTestA:	db "Valley-Test  ",0A0h
aWorstcaseRWa:	db "Worstcase-R/W",0A0h
aRefreshTestA:	db "Refresh-Test ",0A0h
aRefreshDelaya:	db "Refresh-Delay",0A0h
aM1TestA:	db "M1-Test      ",0A0h


;------------------------------------------------------------------------------
; Einstellungen
;------------------------------------------------------------------------------

prep:		rst	18h		; PRST7
		db 0Ch,"RAM-Test Y21SO  adaption y56ya   ",0Dh,8Dh
prep1:		rst	18h		; PRST7
		db 0Dh,"RAM-Test Anfang ",0BAh
		call	hexinput	; Eingabe Hex-Zahl nach	HL
		ld	(ranf),	hl	; Beginn Test-RAM
		push	hl
		rst	18h		; PRST7
		db "RAM-Test Ende   ",0BAh
		call	hexinput	; Eingabe Hex-Zahl nach	HL
		ld	(rend),	hl	; Ende Test-RAM
		pop	de
		xor	a
		sbc	hl, de
		jr	c, prep2
		inc	hl
		ld	(rsize), hl	; Groesse Test-RAM
		push	hl
		rst	18h
		db "--> Bytezahl    ",0BAh
		rst	20h		; OUTHL	(OUT HL-Register hexadezimal)
		db    7
		nop
		ld	hl, (ranf)	; Beginn Test-RAM
		ld	de, unk_1F6E	; Programmende (vp: label ist falsch!)
		and	a
		sbc	hl, de
		jr	nc, prep4
		add	hl, de
		ld	de, 0FFFh
		sbc	hl, de
		jr	c, prep2
		ld	de, begin	; Programmanfang
		ld	hl, (rend)	; Ende Test-RAM
		sbc	hl, de
		jr	c, prep4

prep2:		rst	18h		; PRST7
		db 0Dh,"** kein Test-RAM !! *",0AAh
		pop	hl
prep3:		jp	prep1

prep4:		rst	18h		; PRST7
		db 0Dh,"Blocklaenge     ",0BAh
		call	hexinput	; Eingabe Hex-Zahl nach	HL
		ld	(blocklen), hl	; Blocklaenge
		ld	c, 0
		ex	de, hl
		pop	hl
		xor	a
prep5:		inc	c
		jr	z, prep8
		sbc	hl, de
		jr	z, prep6
		jr	nc, prep5
		rst	18h
		db 0Dh,"** Block falsch *",0AAh
		jr	prep3
prep6:		ld	a, c
		ld	(byte_1F64), a
		ld	b, a
		rst	18h		; PRST7
		db "--> Blockanzahl ",0BAh
		xor	a
prep7:		inc	a
		daa
		djnz	prep7
		rst	20h		; OUTA (OUT A-Register hexadeziamal)
		db    6
		nop
		ld	a, 20h ; ' '
		sub	4
		sub	c
		jr	nc, prep9

prep8:		rst	18h		; PRST7
		db 0Dh,"** zu viele Bloecke *",0AAh
		jr	prep3

prep9:		rst	18h		; PRST7
		db 0Dh,"Welche Test",27h,"s ?",0Dh,8Dh
		ld	de, aBuffChipTes ; "Buff/Chip-Tesô"
		call	jninput		; Eingabe J/N, J->A=FF,	N->A=0
		ld	(bBuffChipTest), a
		ld	de, aPeakTestA	; "Peak-Test	 "
		call	jninput		; Eingabe J/N, J->A=FF,	N->A=0
		ld	(bPeakTest), a
		ld	de, aValleyTestA ; "Valley-Test	  "
		call	jninput		; Eingabe J/N, J->A=FF,	N->A=0
		ld	(bValleyTest), a
		ld	de, aWorstcaseRWa ; "Worstcase-R/W "
		call	jninput		; Eingabe J/N, J->A=FF,	N->A=0
		ld	(bWorstCaseTest), a
		ld	de, aRefreshTestA ; "Refresh-Test  "
		call	jninput		; Eingabe J/N, J->A=FF,	N->A=0
		ld	(bRefreshTest),	a
		ld	de, aM1TestA	; "M1-Test	 "
		call	jninput		; Eingabe J/N, J->A=FF,	N->A=0
		ld	(bM1Test), a
		ld	de, aRichtic	; "\rrichtiç"
		call	jninput		; Eingabe J/N, J->A=FF,	N->A=0
		jp	z, prep
		ret

;------------------------------------------------------------------------------
;
;------------------------------------------------------------------------------

testtab:	db 'M'
		db 'R'
		db 'W'
		db 'V'
		db 'P'
		db 'B'

;------------------------------------------------------------------------------
; Anzeige
;------------------------------------------------------------------------------


anz:		rst	18h		; PRST7
		db 	0Ch,"Adr. D",0C2h
		nop
		nop
		ld	b, 8
		nop

anz1:		ld	a, '0'-1
		add	a, b
		rst	10h		; OUTCH
		ld	c, 2
anz11:		rst	18h		; PRST7
		db 	0A0h
                dec     c
                jr      nz, anz11
		djnz	anz1
		ld	a, 0Dh
		rst	10h		; OUTCH
		ld	b, 1Dh

anz2:		rst	18h		; PRST7
		db 	0ADh
		djnz	anz2
		ld	hl, (ranf)	; Beginn Test-RAM
		ld	de, (blocklen)	; Blocklaenge
		ld	a, (byte_1F64)
		ld	b, a

anz3:		ld	a, 0Dh
		rst	10h		; OUTCH
		rst	20h		; OUTHL
		db    	7
		nop
		rst	18h		; PRST7
		db 	' ',0A0h
		push	bc
		ld	b, 8

anz4:		rst	20h		; PRST7
		db    	2
		db " .",0A0h
		nop
		nop
		nop
		nop
		djnz	anz4
		pop	bc
		add	hl, de
		djnz	anz3
		ret

;------------------------------------------------------------------------------
;
;------------------------------------------------------------------------------


sub_1BB5:	push	af
		push	bc
		push	de
		push	hl
		ld	hl, (ranf)	; Beginn Test-RAM
		dec	hl
		dec	ix
		ld	de, (blocklen)	; Blocklaenge
		ld	b, 0E0h
loc_1BC5:	add	hl, de
		inc	b
		ex	de, hl
		push	hl
		push	ix
		pop	hl
		sbc	hl, de
		pop	hl
		ex	de, hl
		jr	nc, loc_1BC5
		ccf
		sbc	hl, de
		ld	a, b
		inc	a
		push	iy
		pop	bc
		ld	e, a
		ld	a, b
		ld	b, 8
		ld	d, 3
		rlca
loc_1BE1:	jr	nc, loc_1C03
		push	de
		push	bc
		push	af
		ld	b, 1
		ld	hl, testtab
loc_1BEB:	ld	a, c
		cp	(hl)
		jr	z, loc_1BF5
		inc	hl
		jr	loc_1BEB
		jp	0F000h		; OS

loc_1BF5:	ld	a, b
		add	a, d
		ld	d, a
		call	sub_1F36
		ld	a, c
		rst	28h		; OUTCH+DELCU
		call	sub_1F36
		pop	af
		pop	bc
		pop	de
loc_1C03:	push	af
		push	bc
		ld	b, 3
		ld	a, b
		pop	bc
		add	a, d
		ld	d, a
		pop	af
		sla	a
		djnz	loc_1BE1
		pop	hl
		pop	de
		pop	bc
		pop	af
		inc	ix
		ret

;------------------------------------------------------------------------------
; M1-Test
;------------------------------------------------------------------------------


aM1BlockZuKlein:db "-->M1-Block zu klein    ",0Dh,0Dh,' ',88h

unk_1C33:	db    0
		db  88h
		db    1
		db  7Fh
		db    0
		db  88h
		db    0
		db    4
		db  88h
		db    0
		db    8
		db    0
		db    8
		db    0
		db  10h
		db    2
		db  0Eh
		db    8
		db    4
		db  88h
		db  2Dh
		db  88h
		db    0
		db    8
		db  80h
		db    0
		db    0

; als Code

;unk_1C33:       nop
;                adc     a, b
;                ld      bc, 7Fh
;                adc     a, b
;                nop
;                inc     b
;                adc     a, b
;                nop
;                ex      af, af'
;                nop
;                ex      af, af'
;                nop
;                djnz    loc_1C45
;                ld      c, 8
;loc_1C45:       inc     b
;                adc     a, b
;                dec     l
;                adc     a, b
;                nop
;                ex      af, af'
;                add     a, b
;                nop
;                nop

;------------------------------------------------------------------------------
;
;------------------------------------------------------------------------------

sub_1C4E:	push	de
		ld	d, a
		ld	a, (akttest)	; Aktueller Test
		ld	e, a
		push	de
		pop	iy
		push	hl
		pop	ix
		call	sub_1BB5
		pop	de
		ret

;------------------------------------------------------------------------------
;
;------------------------------------------------------------------------------

sub_1C5F:	push	af
		push	de
		ld	d, 0
		ld	a, (byte_1F64)
		add	a, 2
		ld	e, a
		ld	a, 20h ; ' '
		sub	e
		jp	c, 0F000h	; OS
		call	sub_1F36
		pop	de
		call	j_prst7DE	; Ausgabe (DE), bis Bit7 gesetzt
		pop	af
		ret

; ???

		db  28h	; (
		db    8
		db  55h	; U

;------------------------------------------------------------------------------
; Schleife für die einzelnen RAM-Tests
;------------------------------------------------------------------------------

test:		nop
		nop
		nop

;------------------------------------------------------------------------------
;BuffChip-Test
;    Der Speicher wird nacheinander geprueft, ob er
;    die Muster 55H und AAH annimmt.
;    Damit lassen sich Aussagen ueber defekte Speicher-IS,
;    Unterbrechungen, fehlerhafte Treiber-IS usw. treffen.
;------------------------------------------------------------------------------

		ld	a, (bBuffChipTest)
		cp	0FFh
		jr	nz, nexttest1

		ld	a, 'B'
		ld	(akttest), a	; Aktueller Test
		ld	de, aBuffChipTes ; "Buff/Chip-Tesô"
		call	sub_1C5F
		ld	b, 8

bt1:		ld	hl, (ranf)	; Beginn Test-RAM
		ld	de, (rsize)	; Groesse Test-RAM

bt2:		ld	a, 55h ; 'U'
		ld	(hl), a
		xor	(hl)
		call	nz, sub_1C4E
		call	j_stop
		ld	a, 0AAh	; 'ª'
		ld	(hl), a
		xor	(hl)
		call	nz, sub_1C4E
		dec	de
		inc	hl
		ld	a, d
		or	e
		jr	nz, bt2
		djnz	bt1

;------------------------------------------------------------------------------
;Peak-Test
;    Der Speicher wird mit allen Bitmustern beschrieben, die
;    die sich ergeben, wenn man eine "1" durch ein Nullbyte
;    schiebt.
;    Ist der Schreibvorgang beendet, wird getestet, ob noch
;    alles vorhanden ist.
;    Damit jede Speicherzelle auch jedes Muster "abbekommt",
;    geschieht dieser Vorgang neunmal, immer um Eins verschoben.
;------------------------------------------------------------------------------


nexttest1:	ld	a, (bPeakTest)
		cp	0FFh
		jr	nz, nexttest2

		ld	a, 'P'
		ld	(akttest), a	; Aktueller Test
		ld	de, aPeakTestA	; "Peak-Test	 "
		call	sub_1C5F
		call	pt1
		call	j_stop
		jr	nexttest2

pt1:		xor	a
		ld	hl, (ranf)	; Beginn Test-RAM
		ld	(hl), a
		ld	b, 9
pt2:		ld	hl, (ranf)	; Beginn Test-RAM
		ld	de, (rsize)	; Groesse Test-RAM
		ld	a, (hl)
		and	a
		jr	nz, pt3
		scf
pt3:		rla
		ld	(hl), a
		ex	af, af'
		inc	hl
		dec	de
		call	j_stop
		ld	a, d
		or	e
		jr	z, pt4
		ex	af, af'
		jr	pt3
pt4:		ld	hl, (ranf)	; Beginn Test-RAM
		ld	de, (rsize)	; Groesse Test-RAM
		ld	a, (hl)
		and	a
		jr	nz, pt5
		scf
pt5:		ld	c, a
		ex	af, af'
		ld	a, c
		xor	(hl)
		call	nz, sub_1C4E
		inc	hl
		dec	de
		call	j_stop
		ld	a, d
		or	e
		jr	z, pt6
		ex	af, af'
		rla
		jr	pt5
pt6:		djnz	pt2
		ret

;------------------------------------------------------------------------------
;Valley-Test
;    Dieser Test funktioniert analog dem vorhergenannten,
;    nur wird hier eine "0" durch ein FFH-Byte geschoben.
;------------------------------------------------------------------------------

nexttest2:	ld	a, (bValleyTest)
		cp	0FFh
		jr	nz, nexttest3
		ld	a, 'V'
		ld	(akttest), a	; Aktueller Test
		ld	de, aValleyTestA ; "Valley-Test	  "
		call	sub_1C5F
		call	vt1
		jr	nexttest3


vt1:		ld	hl, (ranf)	; Beginn Test-RAM
		ld	(hl), 0FFh
		ld	b, 9
vt2:		ld	hl, (ranf)	; Beginn Test-RAM
		ld	de, (rsize)	; Groesse Test-RAM
		ld	a, (hl)
		cp	0FFh
vt3:		rla
		ld	(hl), a
		ex	af, af'
		inc	hl
		dec	de
		call	j_stop
		ld	a, d
		or	e
		jr	z, vt4
		ex	af, af'
		jr	vt3
vt4:		ld	hl, (ranf)	; Beginn Test-RAM
		ld	de, (rsize)	; Groesse Test-RAM
		ld	a, (hl)
		cp	0FFh
vt5:		ld	c, a
		ex	af, af'
		ld	a, c
		xor	(hl)
		call	nz, sub_1C4E
		inc	hl
		dec	de
		call	j_stop
		ld	a, d
		or	e
		jr	z, vt6
		ex	af, af'
		rla
		jr	vt5
vt6:		djnz	vt2
		ret

;------------------------------------------------------------------------------
;Worst-Case-Test
;    Dieser Test basiert auf den hoeheren Anforderungen, die
;    der zyklische Blockladebefehl des U 880D an den Speicher
;    stellt, und zwar meist bei dynamischen RAMs an die Quali-
;    taet der Spannungsversorgung und deren Abblockung.
;    Hier werden Datenbloecke mit Hilfe des LDDR-Befehls im
;    Speicher kopiert.
;------------------------------------------------------------------------------

nexttest3:	ld	a, (bWorstCaseTest)
		cp	0FFh
		jp	nz, nexttest4

		ld	a, 'W'
		ld	(akttest), a	; Aktueller Test
		ld	de, aWorstcaseRWa ; "Worstcase-R/W "
		call	sub_1C5F
		ld	a, 55h
		ld	(byte_1F6C), a
		cpl
		ld	(byte_1F6D), a
		call	wt1
		ld	a, 0AAh
		ld	(byte_1F6C), a
		cpl
		ld	(byte_1F6D), a
		call	wt1
		call	j_stop
		jr	nexttest4

wt1:		ld	hl, (ranf)	; Beginn Test-RAM
		ld	de, (rsize)	; Groesse Test-RAM
wt2:		ld	a, (byte_1F6D)
		ld	(hl), a
		ld	b, 11h
		ld	a, (byte_1F6C)
		ld	c, a
		jr	wt4
wt3:		ld	(hl), c
wt4:		inc	hl
		dec	de
		call	j_stop
		ld	a, d
		or	e
		jr	z, wt5
		djnz	wt3
		jr	wt2
wt5:		ld	b, 10h
wt6:		push	bc
		ld	de, (rend)	; Ende Test-RAM
		push	de
		pop	hl
		dec	hl
		ld	bc, (rsize)	; Groesse Test-RAM
		dec	bc
		lddr
		ld	hl, (ranf)	; Beginn Test-RAM
		ld	a, (byte_1F6C)
		ld	(hl), a
		pop	bc
		call	j_stop
		djnz	wt6
		ld	de, (rsize)	; Groesse Test-RAM
		ld	b, 10h
wt7:		ld	a, (byte_1F6C)
wt8:		xor	(hl)
		call	nz, sub_1C4E
		inc	hl
		dec	de
		call	j_stop
		ld	a, d
		or	e
		ret	z
		djnz	wt7
		ld	a, (byte_1F6D)
		ld	b, 11h
		jr	wt8

;------------------------------------------------------------------------------
;Refresh-Test
;    Der Speicher wird in acht Zyklen jeweils mit einem
;    Muster beschrieben, das sich aus dem vorherigen Inhalt
;    des Speichers ergibt.
;    Dann wird einige Sekunden gewartet, danach geprueft, ob
;    das Muster noch immer im Speicher vorhanden ist.
;------------------------------------------------------------------------------

nexttest4:	ld	a, (bRefreshTest)
		cp	0FFh
		jr	nz, nexttest5

		ld	a, 'R'
		ld	(akttest), a	; Aktueller Test
		ld	de, aRefreshTestA ; "Refresh-Test  "
		call	sub_1C5F
		ld	c, 8Eh
		ld	hl, (ranf)	; Beginn Test-RAM
		ld	(hl), c
		ld	b, 8

rt1:		ld	hl, (ranf)	; Beginn Test-RAM
		ld	de, (rsize)	; Groesse Test-RAM
		ld	c, (hl)
rt2:		rrc	c
		ld	(hl), c
		inc	hl
		dec	de
		call	j_stop
		ld	a, d
		or	e
		jr	nz, rt2
		ld	de, aRefreshDelaya ; "Refresh-Delay "
		call	sub_1C5F
		ld	hl, 0Ah
rt3:		ld	de, 0FFFFh
rt4:		dec	de
		ld	a, d
		or	e
		jr	nz, rt4
		dec	hl
		call	j_stop
		ld	a, h
		or	l
		jr	nz, rt3
		ld	de, aRefreshTestA ; "Refresh-Test  "
		call	sub_1C5F
		ld	hl, (ranf)	; Beginn Test-RAM
		ld	de, (rsize)	; Groesse Test-RAM
		ld	c, (hl)
rt5:		ld	a, c
		xor	(hl)
		call	nz, sub_1C4E
		inc	hl
		dec	de
		call	j_stop
		ld	a, d
		or	e
		jr	z, rt6
		rrc	c
		jr	rt5
rt6:		djnz	rt1

;------------------------------------------------------------------------------
;M1-Test
;    Da der U 880D fuer Befehlslesezyklen eine kuerzere
;    Zugriffszeit des Speichers als bei normalen Lese- oder
;    Schreibzyklen erfordert, kann es vorkommen, dass sich
;    ein Speicher zwar beschreiben und lesen laesst, aber MC-
;    Programme Fehler machen oder ganz abstuerzen.
;    Beim M1-Test wird daher ein kleines MC-Programm in den
;    Speicher geschrieben und gestartet.
;    Es hat die Eigenschaft, Einzelbitfehler zu erkennen und
;    auch bei deren Auftreten zum Testprogramm zurueckzukehren.
;    Dieser Test erfordert Bloecke, die groesser als 20H sind.
;------------------------------------------------------------------------------

nexttest5:	ld	a, (bM1Test)
		cp	0FFh
		jp	nz, test	; Endlos-Schleife: zurueck zum Testanfang

		ld	a, 'M'
		ld	(akttest), a	; Aktueller Test
		ld	de, aM1TestA	; "M1-Test	 "
		call	sub_1C5F
		ld	de, (blocklen)	; Blocklaenge
		ld	hl, 20h		; Mindestgröße Block
		sbc	hl, de
		jr	c, mt1
		ld	de, aM1BlockZuKlein ; "-->M1-Block zu klein    \r\r ˆ"
		call	sub_1C5F
		jp	ende

mt1:		ld	a, (byte_1F64)
		ld	b, a
		ld	hl, (ranf)	; Beginn Test-RAM
mt2:		push	bc
		push	de
		push	hl
		ex	de, hl
		ld	hl, unk_1C33
		ld	bc, sub_1C4E-unk_1C33	; 1Bh Länge
		ldir
		pop	hl
		pop	bc
		add	hl, bc
		push	bc
		push	hl
		sbc	hl, de
mt3:		ld	a, 0C9h
		ld	(de), a
		inc	de
		dec	hl
		ld	a, h
		or	l
		jr	nz, mt3
		pop	hl
		pop	de
		pop	bc
		djnz	mt2
		exx
		ld	bc, 400h
		exx
mt4:		ld	de, (ranf)	; Beginn Test-RAM
		nop
		nop
		nop
		ld	a, (byte_1F64)
		ld	b, a
mt5:		push	de
		push	bc
		ld	hl, mt6
		push	hl
		push	de
		ld	bc, 0
		ld	hl, 80h
		ld	a, 0FFh
		ex	af, af'
		ret

mt6:		jr	nc, mt8
		and	a
		jr	nz, mt8
		ld	a, b
		cp	1
		jr	nz, mt8
		ld	a, l
		cp	7Fh
		jr	nz, mt8
		ld	a, c
		cp	8
		jr	nz, mt8
		pop	bc
		pop	de
mt7:		ld	hl, (blocklen)	; Blocklaenge
		add	hl, de
		ex	de, hl
		djnz	mt5
		exx
		dec	bc
		ld	a, b
		or	c
		exx
		jr	nz, mt4
		jp	test
mt8:		pop	bc
		pop	hl
		ld	a, 0FFh
		call	sub_1C4E
		ex	de, hl
		jr	mt7

;------------------------------------------------------------------------------
;
;------------------------------------------------------------------------------


j_stop:		jp	stop		; Abbruch bei STOP
		ret	z

;------------------------------------------------------------------------------
;
;------------------------------------------------------------------------------

ende:		rst	8
		ld	de, aTestabbruchNeu ; "Testabbruch Neustart ˆ"
		call	sub_1C5F
		dec	de
		call	jninput		; Eingabe J/N, J->A=FF,	N->A=0
		jp	nz, ramtst
		jp	0F000h

aTestabbruchNeu:db "Testabbruch Neustart ",88h

		db  20h
		db  20h
		db  20h
		db  20h
		db  20h
		db  20h
		db  20h
		db  20h
		db  20h
		db  20h
		db  20h

;------------------------------------------------------------------------------
;
;------------------------------------------------------------------------------

sub_1F36:	push	bc
		push	de
		push	hl
		ld	hl, 0EC20h	; Adr. 2. Bildschirmzeile
		ld	a, d
		and	1Fh
		ld	d, a
		ld	a, l
		sub	d
		ld	l, a
		ld	bc, 20h		; Länge Bildzeile
		ld	a, e
		and	1Fh
		jr	z, loc_1F50
loc_1F4B:	add	hl, bc
		nop
		dec	a
		jr	nz, loc_1F4B
loc_1F50:	ld	(002Bh), hl	; CURSR
		pop	hl
		pop	de
		pop	bc
		ret

;------------------------------------------------------------------------------
;
;------------------------------------------------------------------------------

unk_1F57:	db  0Dh
		db  30h	; 0
		db  30h	; 0
		db  30h	; 0
		db  0Dh
ranf:		dw 2000h
					; Beginn Test-RAM
rend:		dw 0
					; Ende Test-RAM
rsize:		dw 100h
					; Groesse Test-RAM
blocklen:	dw 10h
					; Blocklaenge
byte_1F64:	db 10h
bBuffChipTest:	db 0
bPeakTest:	db 0FFh
bValleyTest:	db 0
bWorstCaseTest:	db 0FFh
bRefreshTest:	db 0
bM1Test:	db 0
akttest:	db 50h
					; Aktueller Test
byte_1F6C:	db 0AAh
byte_1F6D:	db 55h
unk_1F6E:	db 0FFh
		db 0FFh

;------------------------------------------------------------------------------
; Einrichten der RST-UP
;------------------------------------------------------------------------------

init:		ld	hl, 0F20Ch
		ld	(9), hl		; RST8h	-> F20C	= INCH
		ld	hl, 0F21Bh
		ld	(11h), hl	; RST10h -> F21B = OUTCH
		ld	hl, 0F2A5h
		ld	(19h), hl	; RST18h -> F2A5 = PRST7
		ld	a, 0C3h
		ld	hl, 8
		ld	(hl), a
		ld	hl, 10h
		ld	(hl), a
		ld	hl, 18h
		ld	(hl), a
		ld	hl, 28h
		ld	(hl), a
		ld	hl, rst28
		ld	(29h), hl	; RST28	-> OUTCH+DELCU
		jp	ramtst

		db 	0FFh

;------------------------------------------------------------------------------
; Ausgabe (DE), bis Bit7 gesetzt
;------------------------------------------------------------------------------

PRST7DE:	ld	a, (de)
		bit	7, a
		jr	z, PRST7DE1
		res	7, a		; letztes Zeichen
		rst	10h		; OUTCH
		ret
;
PRST7DE1:	rst	10h		; OUTCH
		inc	de
		jr	PRST7DE

;------------------------------------------------------------------------------
;
;------------------------------------------------------------------------------

rst28:		rst	20h		; OUTCH
		db   	0
		push	af
		push	hl
		ld	hl, (002Bh)	; CURSR
		ld	a, ' '
		ld	(hl), a		; Cursor löschen
		pop	hl
		pop	af
		ret

; ???
		db 0FFh
		db 0FFh
		db 0FFh
		db 0FFh
		db 0FFh
		db 0FFh
		db 0FFh
		db 0FFh
		rst	20h		; OUTCH
		db    	0
		push	af
		push	hl
		ld	hl, (002Bh)	; CURSR
		ld	a, 20h ; ' '
		ld	(hl), a
		pop	hl
		pop	af
		ret

;------------------------------------------------------------------------------
;
;------------------------------------------------------------------------------


anz0:		call	anz		; Anzeige
		rst	20h		; PRST7
		db    	2
		db	 0Dh,8Dh
		ret

;------------------------------------------------------------------------------
; Abbruch bei STOP
;------------------------------------------------------------------------------

stop:		exx
		ex	af, af'
		push	af
		push	hl
		push	bc
		push	de
		rst	20h		; INKEY
		db    	4
		cp	3		; STOP-Taste gedrueckt?
		jr	z, stop1
		pop	de
		pop	bc
		pop	hl
		pop	af
		ex	af, af'
		exx
		ret
;
stop1:		pop	de
		pop	bc
		pop	hl
		pop	af
		ex	af, af'
		exx
		jp	ende


		end
