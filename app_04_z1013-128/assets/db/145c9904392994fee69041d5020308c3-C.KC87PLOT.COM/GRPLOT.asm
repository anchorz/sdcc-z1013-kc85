; File Name   :	GRPLOT.rom
; Format      :	Binary File
; Base Address:	0000h Range: 9800h - A800h Loaded length: 1000h


	cpu	Z80

BASVER 	EQU	'OS'	; f¸r Z9001-OS (original)
;BASVER 	EQU	'CPM'	; Ampassung f¸r CPM


; lokale Speicher
unk_234		equ	0234h
unk_239		equ	0239h
unk_23B		equ	023Bh
unk_23D		equ	023Dh
unk_23F		equ	023Fh
unk_241		equ	0241h	; 2 Byte x-Offset	(?)
unk_243		equ	0243h	; 2 Byte y-Offset	(?)
unk_245		equ	0245h	; 2 Byte x-Position	(?)
unk_247		equ	0247h	; 2 Byte y-Position	(?)
unk_249		equ	0249h
unk_24A		equ	024Ah
unk_24B		equ	024Bh
unk_24C		equ	024Ch
unk_24D		equ	024Dh
unk_24E		equ	024Eh
unk_24F		equ	024Fh
unk_250		equ	0250h
unk_252		equ	0252h
unk_254		equ	0254h
unk_256		equ	0256h
unk_258		equ	0258h
unk_25A		equ	025Ah
unk_25C		equ	025Ch
unk_25E		equ	025Eh
unk_260		equ	0260h
unk_261		equ	0261h
unk_262		equ	0262h
unk_263		equ	0263h
unk_264		equ	0264h
unk_265		equ	0265h
unk_266		equ	0266h
unk_267		equ	0267h
unk_268		equ	0268h
unk_26A		equ	026Ah
unk_26D		equ	026Dh
unk_273		equ	0273h
unk_278		equ	0278h
unk_27B		equ	027Bh
unk_27C		equ	027Ch
unk_27D		equ	027Dh	; SCALE x-Faktor
unk_27F		equ	027Fh
unk_281		equ	0281h	; Scale y-Faktor
unk_283		equ	0283h
unk_285		equ	0285h
unk_286		equ	0286h
unk_287		equ	0287h
unk_288		equ	0288h
unk_289		equ	0289h
unk_28A		equ	028Ah
unk_28B		equ	028Bh
unk_28D		equ	028Dh
unk_28E		equ	028Eh
unk_28F		equ	028Fh
unk_291		equ	0291h
unk_292		equ	0292h
unk_293		equ	0293h
unk_296		equ	0296h
unk_297		equ	0297h
unk_29A		equ	029Ah
unk_29B		equ	029Bh


	IF BASVER='OS'

; Betriebssystem
SYSBDS		equ	0005h 
atrib		equ	0027h		; aktuelles Farbattribut
PRNST		equ	0F3E2h		; BIOS PRNST

;DATEN AUS BASIC KERN

WINJP		equ	035Ah
WRA1		equ	03E5h		; ARITHMETIKREGISTER 1

;ADRESSEN AUS BASIC KERN

CPREG		equ	0C689h
IOTEST		equ	0C697h
unk_C69C	equ	IOTEST + 5
FOR1		equ	0C7F2h
unk_C806	equ	FOR1 + 14h
TCHAR		EQU	0C8BDh
TCHAR1		equ	0C8BEh
CPCOMM		equ	0C8D6h
EPRVL4		equ	0C96Ch
EPRVL3		equ	0C96Fh
SNALY		equ	0CD3Ah
FRE3		equ	0D0B1h
LEN1		equ	0D330h
ARGVL1		equ	0D421h
ADD2		equ	0D461h
ADD3		equ	0D466h
ADD5		equ	0D46Fh
MUL1		equ	0D59Ah
DIV1		equ	0D5F5h
OPARST		equ	0D6C8h
OPKOP		equ	0D6DDh
OPKOP1		equ	0D6E0h
OPLAD		equ	0D6EEh
OPTRAN		equ	0D6F7h
SQR		equ	0D91Fh
COS		equ	0DA70h
SIN		equ	0DA76h
COSL		equ	0DABAh

;ADRESSEN AUS BASIC ERWEITERUNG

err1		equ	0E144H
err2		equ	0E14BH

	ELSEIF BASVER='CPM'

; Betriebssystem
SYSBDS		equ	0F314h		; entspricht call 5 des Z9001-Systems
atrib		equ	0027h		; aktuelles Farbattribut
PRNST		equ	0F3E2h		; BIOS PRNST

;DATEN AUS BASIC KERN

WINJP		equ	2B5AH
WRA1		equ	2BE5H		; ARITHMETIKREGISTER 1

;ADRESSEN AUS BASIC KERN

CPREG		equ	0098Ch
IOTEST		equ	0099Ah
unk_C69C	equ	IOTEST + 5
FOR1		equ	00AF5h
unk_C806	equ	FOR1 + 14h
TCHAR		EQU	00BC0h
TCHAR1		equ	00BC1h
CPCOMM		equ	00BD9h
EPRVL4		equ	00C6Ch
EPRVL3		equ	00C6Fh
SNALY		equ	0103Ah
FRE3		equ	013B1h
LEN1		equ	01630h
ARGVL1		equ	01721h
ADD2		equ	01761h
ADD3		equ	01766h
ADD5		equ	0176Fh
MUL1		equ	0189Ah
DIV1		equ	018F5h
OPARST		equ	019C8h
OPKOP		equ	019DDh
OPKOP1		equ	019E0h
OPLAD		equ	019EEh
OPTRAN		equ	019F7h
SQR		equ	01C1Fh
COS		equ	01D70h
SIN		equ	01D76h
COSL		equ	01DBAh

;ADRESSEN AUS BASIC ERWEITERUNG

err1		equ	02441H
err2		equ	02448H
	
	ENDIF

;-----------------------------------------------------------------------------
; physischer Treiber
;-----------------------------------------------------------------------------

		org 9800h

plsv:		ld	b, 0		; Plotter-Sprungverteiler
		dec	c
		push	hl
		ld	hl, plsvret
		push	hl
		ld	a, (WINJP)
		bit	0, a
		jr	nz, plsv1
		ld	hl, plsvtab1
		jr	plsv2
plsv1:		ld	hl, plsvtab2
plsv2:		add	hl, bc
		add	hl, bc
		ld	a, (hl)
		inc	hl
		ld	h, (hl)
		ld	l, a
		jp	(hl)
;
plsvret:	pop	hl
		ret

; Sprungverteiler f¸r SCREEN 0 (Vollgrafik)
plsvtab1:	dw locret_A32B
		dw locret_A32B
		dw locret_A32B
		dw locret_A32B
		dw locret_A32B
		dw locret_A32B
		dw locret_A32B
		dw locret_A32B
		dw locret_A32B
		dw locret_A32B
		dw locret_A32B
		dw locret_A32B

; Sprungverteiler f¸r SCREEN 1 (PLOTTER)
plsvtab2:	dw pl_pset
		dw pl_line
		dw pl_circle
		dw pl_paint		; pl_paint ist nicht implementiert
		dw pl_label
		dw pl_size
		dw pl_zero
		dw pl_home
		dw pl_gcls
		dw pl_point
		dw pl_xpos
		dw pl_ypos

;-----------------------------------------------------------------------------
; 
;-----------------------------------------------------------------------------

pl_pset:	ex	de, hl
		ld	a, (hl)
		dec	a
		inc	hl
		call	pl_pset2
		ld	a, (hl)
		jr	z, pl_pset1
		and	a
		jp	z, sub_9B2D
		jp	loc_9B49
pl_pset1:	and	a
		jp	z, sub_9ACF
		jp	loc_9B28

pl_pset2:	ld	e, (hl)
		inc	hl
		ld	d, (hl)
		inc	hl
		ld	c, (hl)
		inc	hl
		ld	b, (hl)
		inc	hl
		ret

;-----------------------------------------------------------------------------
; 
;-----------------------------------------------------------------------------

pl_line:	push	de
		pop	ix
		ld	a, (ix+0)
		and	a
		push	ix
		pop	hl
		inc	hl
		jr	z, pl_line1
		call	pl_pset2
		dec	a
		jr	z, pl_line2
		call	sub_9B2D
pl_line1:	ld	hl, (unk_245)
		ld	de, (unk_241)
		and	a
		sbc	hl, de
		ld	(ix+1),	l
		ld	(ix+2),	h
		ld	hl, (unk_247)
		ld	de, (unk_243)
		and	a
		sbc	hl, de
		ld	(ix+3),	l
		ld	(ix+4),	h
		jr	pl_line3
pl_line2:	call	sub_9ACF
pl_line3:	ld	a, (ix+5)
		dec	a
		jr	z, pl_line4
		ld	hl, (unk_245)
		ld	de, (unk_241)
		and	a
		sbc	hl, de
		ld	e, (ix+6)
		ld	d, (ix+7)
		add	hl, de
		ld	(ix+6),	l
		ld	(ix+7),	h
		ld	hl, (unk_247)
		ld	bc, (unk_243)
		and	a
		sbc	hl, bc
		ld	c, (ix+8)
		ld	b, (ix+9)
		add	hl, bc
		ld	(ix+8),	l
		ld	(ix+9),	h
pl_line4:	ld	a, (ix+0Bh)
		and	a
		ld	b, (ix+0Ah)
		jr	nz, pl_line5
		ld	a, b
		and	a
		jr	z, pl_line6
		call	pl_line7
		jp	sub_9B23
pl_line5:	ld	a, b
		and	a
		jr	z, pl_line6
		ld	e, (ix+6)
		ld	d, (ix+7)
		push	de
		ld	c, (ix+3)
		ld	b, (ix+4)
		call	sub_9B23
		pop	de
		ld	c, (ix+8)
		ld	b, (ix+9)
		push	bc
		call	sub_9B23
		pop	bc
		ld	e, (ix+1)
		ld	d, (ix+2)
		push	de
		call	sub_9B23
		pop	de
		ld	c, (ix+3)
		ld	b, (ix+4)
		call	sub_9B23
pl_line6:	call	pl_line7
		jr	pl_home1
pl_line7:	ld	e, (ix+6)
		ld	d, (ix+7)
		ld	c, (ix+8)
		ld	b, (ix+9)
		ret

;-----------------------------------------------------------------------------
; 
;-----------------------------------------------------------------------------

pl_zero:	ex	de, hl
		ld	a, (hl)
		dec	a
		inc	hl
		call	pl_pset2
		jr	z, pl_zero1
		ld	hl, (unk_241)
		add	hl, de
		ld	(unk_241), hl
		ld	hl, (unk_243)
		add	hl, bc
		ld	(unk_243), hl
		ret
pl_zero1:	ld	(unk_241), de
		ld	(unk_243), bc
		ret

;-----------------------------------------------------------------------------
; 
;-----------------------------------------------------------------------------

sub_995A:	ld	bc, 0
		ld	d, b
		ld	e, c
		ret

pl_gcls:	call	sub_995A
		call	pl_zero1

;-----------------------------------------------------------------------------
; 
;-----------------------------------------------------------------------------

pl_home:	call	sub_995A
pl_home1:	jp	sub_9ACF

;-----------------------------------------------------------------------------
; 
;-----------------------------------------------------------------------------

pl_paint:	ret

;-----------------------------------------------------------------------------
; 
;-----------------------------------------------------------------------------

pl_circle:	ex	de, hl
		ld	a, (hl)
		dec	a
		push	af
		inc	hl
		call	pl_pset2
		ld	hl, (unk_247)
		jr	nz, pl_circle1
		ld	hl, 0
pl_circle1:	add	hl, bc
		ld	(unk_288), hl
		pop	af
		push	hl
		ld	hl, (unk_245)
		jr	nz, pl_circle2
		ld	hl, 0
pl_circle2:	add	hl, de
		ld	(unk_286), hl
		ex	de, hl
		pop	bc
		ld	a, (unk_28E)
		or	a
		jp	z, sub_9ACF
		ld	hl, unk_28A
		call	OPKOP
		call	SQR
		ld	bc, 8240h
		ld	de, 0
		call	DIV1
		ld	hl, unk_29B
		call	OPTRAN
		xor	a
		ld	(unk_285), a
		inc	a
		ld	c, a
		ld	hl, unk_28F
		call	loc_A2E1
		push	de
		ld	c, 80h ; 'Ä'
		ld	hl, unk_293
		call	loc_A2E1
		pop	hl
		xor	a
		ex	de, hl
		call	CPREG
		jr	nc, pl_circle3
		ld	hl, unk_293
		push	hl
		call	OPKOP
		ld	bc, 8349h
		ld	de, 0FDBh
		call	ADD5
		pop	hl
		call	OPTRAN
pl_circle3:	call	sub_9A5A
		push	bc
		push	de
		ld	a, (unk_285)
		rra
		jr	nc, pl_circle4
		ld	bc, (unk_288)
		ld	de, (unk_286)
		call	sub_9ACF
		pop	de
		pop	bc
		call	sub_9B23
		jr	pl_circle5
pl_circle4:	pop	de
		pop	bc
		call	sub_9ACF
pl_circle5:	ld	hl, unk_28F
		call	OPKOP
		ld	hl, unk_29B
		call	OPLAD
		call	ADD5
		ld	hl, unk_293
		call	OPLAD
		ld	hl, WRA1+3
		ld	a, b
		cp	(hl)
		jr	nz, pl_circle6
		dec	hl
		ld	a, c
		cp	(hl)
		jr	nz, pl_circle6
		dec	hl
		ld	a, d
		cp	(hl)
		jr	nz, pl_circle6
		dec	hl
		ld	a, e
		cp	(hl)
pl_circle6:	push	af
		jr	nc, pl_circle7
		call	OPKOP1
pl_circle7:	ld	hl, unk_28F
		call	OPTRAN
		call	sub_9A5A
		call	sub_9B23
		pop	af
		jr	z, pl_circle8
		jr	nc, pl_circle5
pl_circle8:	ld	a, (unk_285)
		rla
		ld	bc, (unk_288)
		ld	de, (unk_286)
		jr	nc, pl_circle9
		call	sub_9B23
		jr	pl_circle10
pl_circle9:	call	sub_9ACF
pl_circle10:	ret

sub_9A5A:	ld	hl, unk_28F
		call	OPKOP
		call	SIN
		ld	hl, unk_28A
		call	OPLAD
		call	MUL1
		ld	a, (unk_29A)
		cp	81h ; 'Å'
		push	af
		jr	nc, loc_9A7D
		ld	hl, unk_297
		call	OPLAD
		call	MUL1
loc_9A7D:	call	EPRVL3
		ld	hl, (unk_288)
		add	hl, de
		ex	(sp), hl
		push	hl
		ld	hl, unk_28F
		call	OPKOP
		call	COS
		ld	hl, unk_28A
		call	OPLAD
		call	MUL1
		pop	af
		jr	c, loc_9AA9
		call	OPARST
		ld	hl, unk_297
		call	OPKOP
		pop	bc
		pop	de
		call	DIV1
loc_9AA9:	call	EPRVL3
		ld	hl, (unk_286)
		add	hl, de
		ex	de, hl
		pop	bc
		ret

;-----------------------------------------------------------------------------
; 
;-----------------------------------------------------------------------------

pl_xpos:	ld	hl, (unk_245)
		ld	de, (unk_241)
pl_xpos1:	and	a
		sbc	hl, de
		ld	b, l
		ld	a, h
pl_xpos2:	jp	FRE3

;-----------------------------------------------------------------------------
; 
;-----------------------------------------------------------------------------

pl_ypos:	ld	hl, (unk_247)
		ld	de, (unk_243)
		jr	pl_xpos1

;-----------------------------------------------------------------------------
; 
;-----------------------------------------------------------------------------

pl_point:	xor	a
		ld	b, a
		jr	pl_xpos2

sub_9ACF:	ld	a, 0
		ld	l, a
		ld	h, a
loc_9AD3:	push	hl
		call	sub_9F01
		pop	hl
		ld	(unk_24C), hl
		ld	hl, (unk_241)
		add	hl, de
		ld	(unk_250), hl
		ld	hl, (unk_243)
loc_9AE5:	add	hl, bc
		ld	(unk_252), hl
		xor	a
		ld	(unk_254), a
		ld	hl, unk_250
		call	sub_9CF6
loc_9AF3:	ld	a, (unk_254)
		and	a
		jr	nz, loc_9B05
		ld	a, (unk_24C)
		and	a
		ret	z
		call	sub_9EE7
		xor	a
		jp	sub_9EE7

loc_9B05:	ld	de, 5958h	; "YX"
		cp	3
		jr	z, loc_9B12
		ld	e, 20h ; ' '	; "Y "
		rrca
		jr	nc, loc_9B12
		dec	d		; "X "
loc_9B12:	ld	(unk_234), de
		ld	de, unk_234
		call	PRNST		; BIOS PRNST
		ld	de, aOutOfRange	; " OUT OF RANGE\r\n"
		call	PRNST		; BIOS PRNST
		ret

sub_9B23:	call	sub_9B4E
		jr	loc_9AD3

loc_9B28:	ld	hl, 80h	; 'Ä'
		jr	loc_9AD3

sub_9B2D:	ld	hl, 0
loc_9B30:	push	hl
		call	sub_9F01
		pop	hl
		ld	(unk_24C), hl
		ld	hl, (unk_245)
		add	hl, de
		ld	(unk_250), hl
		ld	hl, (unk_247)
		jr	loc_9AE5

unk_xxx1:	call	sub_9B4E
		jr	loc_9B30

loc_9B49:	ld	hl, 80h	; 'Ä'
		jr	loc_9B30

sub_9B4E:	call	sub_9F01
		ld	hl, (unk_24A)
		ld	l, 0
		ret

;-----------------------------------------------------------------------------
; 
;-----------------------------------------------------------------------------

pl_size:	call	sub_9F01
		ex	de, hl
		ld	bc, 8
		ld	de, unk_239
		ldir
		ld	a, (hl)
		ld	(unk_249), a
		ret

;-----------------------------------------------------------------------------
; 
;-----------------------------------------------------------------------------

pl_label:	ex	de, hl
		ld	a, (hl)
		inc	hl
		inc	hl
		ld	e, (hl)
		inc	hl
		ld	d, (hl)
		inc	a
		push	af
		push	de
		call	sub_9F01
		ld	hl, 0
		ld	(unk_24C), hl
		ld	hl, (unk_245)
		ld	(unk_256), hl
		ld	(unk_25A), hl
		ld	hl, (unk_247)
		ld	(unk_258), hl
		ld	(unk_25C), hl
pl_label1:	pop	hl
		pop	de
		dec	d
		jp	z, loc_9CED
		ld	a, (hl)
		push	de
		push	hl
		cp	0Dh
		jp	z, pl_label17
		cp	18h
		jr	c, pl_label2
		cp	80h ; 'Ä'
		jr	c, pl_label3
pl_label2:	ld	a, 20h ; ' '
pl_label3:	sub	10h
		ld	hl, labeltab
		ld	b, 0
		ld	d, a
pl_label4:	ld	a, (hl)
		and	8Fh ; 'è'
		inc	a
		rlca
		sra	a
		dec	d
		jr	z, pl_label6
		jr	nc, pl_label5
		inc	hl
pl_label5:	ld	c, a
		add	hl, bc
		jr	pl_label4
pl_label6:	ld	e, b
		jr	nc, pl_label7
		inc	e
pl_label7:	ld	d, a
		ex	de, hl
		ld	(unk_265), hl
		pop	hl
		push	hl
		ld	a, (hl)
		cp	18h
		jr	nz, pl_label8
		inc	hl
		ld	a, (hl)
		ld	c, 3
		ld	hl, umlauttab
		cpir
pl_label8:	ld	a, (de)
		push	de
		jr	nz, pl_label9
		or	50h ; 'P'
pl_label9:	ld	d, b
		ld	e, b
		rlca
		rlca
		jr	nc, pl_label10
		ld	d, 0FCh	; '¸'
pl_label10:	rlca
		jr	nc, pl_label11
		ld	e, 0FDh	; '˝'
pl_label11:	ld	hl, unk_249
		and	(hl)
		rlca
		jr	nc, pl_label12
		dec	e
pl_label12:	ex	de, hl
		ld	(unk_263), hl
pl_label13:	ld	hl, unk_266
		dec	(hl)
		pop	hl
		inc	hl
		jr	z, pl_label14
		push	hl
		ld	a, (hl)
		push	af
		rlca
		rlca
		rlca
		rlca
		and	7
		ld	hl, unk_263
		add	a, (hl)
		call	sub_9CB4
		pop	af
		push	af
		and	0Fh
		ld	hl, unk_264
		add	a, (hl)
		call	sub_9CD0
		ld	hl, (unk_258)
		add	hl, de
		ld	(unk_252), hl
		ld	hl, (unk_256)
		pop	de
		add	hl, de
		ld	(unk_250), hl
		pop	af
		ld	hl, unk_24C
		or	(hl)
		dec	hl
		and	(hl)
		ld	(unk_24D), a
		ld	hl, unk_250
		call	sub_9CF6
		ld	a, (unk_24B)
		call	sub_9EE7
		xor	a
		ld	(unk_24C), a
		jr	pl_label13
pl_label14:	ld	a, (unk_265)
		and	a
		jr	z, pl_label15
		ld	a, (hl)
		and	80h ; 'Ä'
		ld	(unk_24C), a
		ld	a, (hl)
		and	7Fh ; ''
		jp	pl_label3
pl_label15:	xor	a
		call	sub_9EE7
		pop	hl
		push	hl
		ld	a, (hl)
		cp	20h ; ' '
		jr	c, pl_label16
		ld	a, (unk_263)
		add	a, a
		add	a, 8
		call	sub_9CB4
		ld	hl, (unk_256)
		add	hl, bc
		ld	(unk_256), hl
		ld	hl, (unk_258)
		add	hl, de
		ld	(unk_258), hl

pl_label16:	pop	hl
		inc	hl
		push	hl
		ld	c, 0Bh		;CSTS, Abfrage Status CONST
		call	SYSBDS
		cp	3
		jp	nz, pl_label1
		ld	hl, unk_256
		call	sub_9CF6
		ld	a, 0E2h	; '‚'
		out	(0B8h),	a
		jp	unk_C806	; ??? mittenrein in einen Befehl von FOR ???
pl_label17:	ld	a, (unk_24F)
		ld	de, 0
		ld	b, d
		ld	c, d
		call	sub_9CD0
		ld	hl, (unk_25C)
		add	hl, de
		ld	(unk_258), hl
		ld	(unk_25C), hl
		pop	de
		ld	hl, (unk_25A)
		add	hl, de
		ld	(unk_256), hl
		ld	(unk_25A), hl
		jr	pl_label16

sub_9CB4:	push	af
		ld	hl, (unk_239)
		call	loc_9E95
		ld	a, 6
		call	sub_9E6A
		ld	b, h
		ld	c, l
		pop	af
		ld	hl, (unk_23B)
		call	loc_9E95
		ld	a, 6
		call	sub_9E6A
		ex	de, hl
		ret

sub_9CD0:	push	af
		ld	hl, (unk_23F)
		call	loc_9E95
		ld	a, 0Ah
		call	sub_9E6A
		add	hl, de
		ex	de, hl
		pop	af
		ld	hl, (unk_23D)
		call	loc_9E95
		ld	a, 0Ah
		call	sub_9E6A
		add	hl, bc
		ex	(sp), hl
		jp	(hl)

loc_9CED:	ld	hl, unk_256
		call	sub_9CF6
		jp	loc_9AF3

sub_9CF6:	push	hl
		call	sub_9F01
		ld	de, unk_26A
		ld	hl, loc_9F85
		ld	bc, 11h
		ldir
		ld	a, 3Dh ; '='
		ld	(unk_27B), a
		ld	de, (unk_245)
		pop	hl
		push	hl
		ld	bc, 0F60Ah
		call	sub_9E26
		ld	(unk_268), hl
		ex	de, hl
		ex	(sp), hl
		push	hl
		ld	hl, unk_254
		or	(hl)
		ld	(hl), a
		ld	h, b
		ld	a, c
		xor	2
		ld	l, a
		ld	(unk_26D), hl
		ld	de, (unk_247)
		pop	hl
		inc	hl
		inc	hl
		ld	bc, 0F8F8h
		call	sub_9E26
		ld	(unk_273), hl
		rlca
		ld	hl, unk_254
		or	(hl)
		ld	(hl), a
		ld	(unk_278), bc
		call	sub_9EC5
		ld	bc, unk_24D
		ld	hl, unk_26D
		ld	a, (bc)
		or	(hl)
		ld	(hl), a
		ld	a, (bc)
		ld	hl, unk_278
		or	(hl)
		ld	(hl), a
		pop	hl
		push	hl
		or	a
		sbc	hl, de
		pop	hl
		jp	p, loc_9D5F
		ex	de, hl
loc_9D5F:	push	hl
		push	de
		ld	hl, unk_273
		ld	de, unk_268
		ld	b, 7
		call	m, sub_9EBB
		ld	hl, (unk_268)
		ex	de, hl
		ld	hl, (unk_262)
		ld	h, 0
		add	hl, hl
		add	hl, hl
		push	hl
		add	hl, hl
		pop	hl
		jr	c, loc_9DCB
		add	hl, de
loc_9D7D:	ld	(unk_25E), hl
		pop	hl
		call	sub_9E61
		ex	de, hl
		pop	bc
		ld	hl, 0
		push	hl
		di
loc_9D8B:	ld	hl, unk_268
		call	sub_9DD3
		xor	a
		pop	hl
		add	hl, de
		or	h
		ld	a, (unk_261)
		push	hl
		jp	p, loc_9DA7
		add	hl, bc
		ex	(sp), hl
		ld	hl, unk_273
		call	sub_9DD3
		ld	a, (unk_260)
loc_9DA7:	dec	a
		jr	nz, loc_9DA7
		ld	hl, unk_25E
		inc	(hl)
		jr	nz, loc_9DB9
		inc	hl
		inc	(hl)
		jr	nz, loc_9DB9
		ld	a, 3Ch ; '<'
		ld	(unk_27B), a
loc_9DB9:	push	bc
		ld	hl, unk_xxx2-1
		ld	a, (unk_262)
		ld	b, 0
		ld	c, a
		add	hl, bc
		pop	bc
		ld	a, (hl)
loc_9DC6:	dec	a
		jr	nz, loc_9DC6
		jr	loc_9D8B
loc_9DCB:	ex	de, hl
		ld	a, 2
		call	sub_9E6A
		jr	loc_9D7D

sub_9DD3:	inc	(hl)
		ld	a, (hl)
		inc	hl
		jr	nz, loc_9DDB
		inc	(hl)
		jr	z, loc_9E04
loc_9DDB:	rrca
		ret	nc
		rrca
		ret	nc
		inc	hl
		push	de
		ld	e, (hl)
		inc	hl
		ld	d, (hl)
		inc	hl
		push	de
		push	hl
		ex	de, hl
		ld	e, (hl)
		inc	hl
		ld	d, (hl)
		ld	hl, loc_9DF0
		ex	(sp), hl
		jp	(hl)

loc_9DF0:	pop	hl
		ld	(hl), e
		inc	hl
		ld	(hl), d
		pop	de
sub_9DF5:	push	bc
		ld	b, a
		ld	a, (WINJP+1)
		ld	c, a
		ld	a, b
		out	(c), a
		or	4
		out	(c), a
		pop	bc
		ret

loc_9E04:	pop	de
		pop	de
		ei
		ld	a, (unk_254)
		and	a
		ld	a, 80h ; 'Ä'
		jr	z, loc_9E10
		xor	a
loc_9E10:	ld	(unk_24B), a
		ld	hl, 300h
		jp	loc_9EFB

sub_9E19:	ld	hl, unk_262
		push	af
		ld	a, (hl)
		call	unk_27B
		jr	z, loc_9E24
		ld	(hl), a
loc_9E24:	pop	af
		ret

sub_9E26:	push	de
		ld	e, (hl)
		inc	hl
		ld	d, (hl)
		pop	hl
		call	sub_9E61
		add	hl, de
		call	sub_9E5E
		push	hl
		ld	hl, 1301h
		jp	p, loc_9E3C
		ld	hl, 1B00h
loc_9E3C:	ex	(sp), hl
		ld	a, d
		and	a
		ex	de, hl
		jp	m, loc_9E49
		add	hl, bc
		jr	nc, loc_9E5A
		call	sub_9E61
loc_9E49:	add	hl, de
loc_9E4A:	call	sub_9E61
		push	hl
		add	hl, de
		ld	a, l
		or	h
		pop	hl
		add	hl, hl
		add	hl, hl
		dec	hl
		pop	bc
		ret	z
		ld	a, 1
		ret
loc_9E5A:	ld	h, d
		ld	l, e
		jr	loc_9E4A

sub_9E5E:	ld	a, h
		and	a
		ret	p

sub_9E61:	push	af
		xor	a
		sub	l
		ld	l, a
		sbc	a, a
		sub	h
		ld	h, a
		pop	af
		ret

sub_9E6A:	push	bc
		push	de
		ld	c, a
		call	sub_9E5E
		ld	a, c
		push	af
		ld	de, 0
		ld	b, 8
loc_9E77:	ld	a, h
		sub	c
		jr	c, loc_9E7F
		inc	de
		ld	h, a
		jr	loc_9E77
loc_9E7F:	add	hl, hl
		ex	de, hl
		add	hl, hl
		ex	de, hl
		dec	b
		jr	nz, loc_9E77
		ld	a, h
		sub	c
		jr	c, loc_9E8C
		inc	de
		ld	h, a
loc_9E8C:	ld	a, h
		add	a, a
		sub	c
		jr	c, loc_9E92
		inc	de
loc_9E92:	ex	de, hl
		jr	loc_9EB4
loc_9E95:	push	bc
		push	de
		ld	d, a
		xor	h
		ld	a, d
		push	af
		call	sub_9E5E
		ld	e, 0
		ld	b, 7
		ex	de, hl
		call	sub_9E5E
		ld	a, h
		ld	h, l
loc_9EA8:	add	a, a
		jr	nc, loc_9EAC
		add	hl, de
loc_9EAC:	add	hl, hl
		dec	b
		jr	nz, loc_9EA8
		add	a, a
		jr	nc, loc_9EB4
		add	hl, de
loc_9EB4:	pop	af
		call	m, sub_9E61
		pop	de
		pop	bc
		ret

sub_9EBB:	ld	a, (de)
		ld	c, (hl)
		ex	de, hl
		ld	(hl), c
		ld	(de), a
		inc	hl
		inc	de
		djnz	sub_9EBB
		ret

sub_9EC5:	ld	a, (unk_24D)
		ld	hl, 351Ch
		push	af
		ld	a, (unk_254)
		and	a
		jr	z, loc_9ED5
		ld	hl, 018Fh
loc_9ED5:	ld	(unk_261), hl
		ld	c, l
		ld	h, 0
		add	hl, hl
		ld	a, 5
		call	sub_9E6A
		add	hl, bc
		ld	a, l
		ld	(unk_260), a
		pop	af
sub_9EE7:	ld	hl, unk_24E
		cp	(hl)
		ld	(hl), a
		dec	hl
		ld	(hl), a
		push	bc
		ld	b, a
		ld	a, (WINJP+1)
		ld	c, a
		out	(c), b
		pop	bc
		ret	z
		ld	hl, 800h
loc_9EFB:	dec	hl
		ld	a, h
		or	l
		jr	nz, loc_9EFB
		ret

sub_9F01:	push	bc
		push	de
		call	sub_9F24
		jr	z, loc_9F21
		call	sub_9F51
		jr	z, loc_9F21
		ld	de, a_po	; "?PO"
		call	PRNST		; BIOS:	PRNST
		ld	a, 0E2h	; '‚'
		out	(0B8h),	a
		xor	a
		ld	(WINJP), a
		ld	(unk_267), a
		jp	unk_C69C
loc_9F21:	pop	de
		pop	bc
		ret

; Initialisierung E/A-Modul
sub_9F24:	ld	a, (unk_267)
		cp	0CFh ; 'œ'
		jr	z, loc_9F3F
		call	sub_9F98
		ld	a, (WINJP+1)
		inc	a
		inc	a
		ld	c, a
		ld	a, 0CFh	; 'œ'
		out	(c), a
		ld	(unk_267), a
		ld	a, 20h ; ' '
		out	(c), a
loc_9F3F:	ld	a, (WINJP+1)
		ld	c, a
		ld	a, (unk_24E)
		out	(c), a
		or	40h ; '@'
		out	(c), a
		in	a, (c)
		and	20h ; ' '
		ret

sub_9F51:	ld	hl, 7D0h
		xor	a
		ld	(unk_24E), a
loc_9F58:	ld	a, 0
		call	sub_9F7D
		call	sub_9F24
		jr	z, loc_9F69
		dec	hl
		ld	a, h
		or	l
		jr	nz, loc_9F58
		inc	a
		ret
loc_9F69:	ld	hl, 0
		ld	(unk_245), hl
		ld	(unk_247), hl
		ld	c, 0Fh
loc_9F74:	ld	a, 1
		call	sub_9F7D
		dec	c
		jr	nz, loc_9F74
		ret

sub_9F7D:	ld	b, 0FFh
		call	sub_9DF5
loc_9F82:	djnz	$
		ret

loc_9F85:	ld	b, l
		ld	(bc), a
		ld	a, 3
		inc	de
		call	sub_9E19
		ret
		
tab_xxx1:	db    0	;
		db    0	;
		db  47h	; G
		db    2	;
		db  3Eh	; >
		db    1	;
		db  13h	;
		db 0C9h	; …
		db  3Dh	; =
		db 0C9h	; …

sub_9F98:	ld	hl, unk_234
		ld	(hl), 0
		ld	d, h
		ld	e, l
		inc	de
		ld	bc, 34h	; '4'
		ldir
		ld	hl, 5859h
		ld	(unk_234), hl
		ld	a, 18h
		ld	(unk_239), a
		ld	a, 28h ; '('
		ld	(unk_23F), a
		ld	a, 80h ; 'Ä'
		ld	(unk_24B), a
		ld	a, 0EEh	; 'Ó'
		ld	(unk_24F), a
		ld	a, 0C9h	; '…'
		ld	(unk_27C), a
		ret

unk_xxx2:	db    1	;
		db    2	;
		db    2	;
		db    3	;
		db    3	;
		db    4	;
		db    4	;
		db    5	;
		db    5	;
		db    6	;
		db    7	;
		db    8	;
		db    9	;
		db  0Ah	;
		db  0Bh	;
		db  0Ch	;
		db  0Dh	;
		db  0Eh	;
		db  0Fh	;
		db  10h	;
		db  11h	;
		db  12h	;
		db  13h	;
		db  14h	;
		db  15h	;
		db  16h	;
		db  18h	;
		db  1Ah	;
		db  1Ch	;
		db  1Eh	;
		db  20h	;
		db  22h	; "
		db  24h	; $
		db  26h	; &
		db  28h	; (
		db  2Ah	; *
		db  2Ch	; ,
		db  30h	; 0
		db  32h	; 2
		db  34h	; 4
		db  38h	; 8
		db  3Ch	; <
		db  40h	; @
		db  44h	; D
		db  48h	; H
		db  4Ch	; L
		db  50h	; P
		db  54h	; T
		db  58h	; X
		db  5Ch	; 
		db  60h	; '
		db  64h	; d
		db  6Ah	; j
		db  70h	; p

aOutOfRange:	db	" OUT OF RANGE",0Dh,0Ah,0
a_po:		db	"?PO",0

umlauttab:	db  61h	; a
		db  6Fh	; o
		db  75h	; u

labeltab:	db    9	;
		db  25h	; %
		db 0C5h	; ≈
		db 0E6h	; Ê
		db 0E8h	; Ë
		db 0CAh	;  
		db 0AAh	; ™
		db  88h	; à
		db  86h	; Ü
		db 0A5h	; •
		db    9	;
		db  65h	; e
		db 0E9h	; È
		db 0CAh	;  
		db 0AAh	; ™
		db  89h	; â
		db  81h	; Å
		db 0A0h	; †
		db 0C0h	; ¿
		db 0E1h	; ·
		db  15h	;
		db  15h	;
		db 0A6h	; ¶
		db 0C6h	; ∆
		db 0D5h	; ’
		db 0D0h	; –
		db  17h	;
		db  10h	;
		db 0C0h	; ¿
		db 0D1h	; —
		db 0D5h	; ’
		db 0C6h	; ∆
		db 0A6h	; ¶
		db  95h	; ï
		db  0Bh	;
		db  17h	;
		db  88h	; à
		db  89h	; â
		db  9Ah	; ö
		db 0AAh	; ™
		db 0B9h	; π
		db 0B8h	; ∏
		db 0A7h	; ß
		db  97h	; ó
		db    0	;
		db 0EAh	; Í
		db    4	;
		db  20h	;
		db 0AAh	; ™
		db  4Ah	; J
		db 0C0h	; ¿
		db  12h	;
		db  3Ah	; :	
		db 0B0h	; ∞
		db    4	;
		db  2Ch	; ,
		db 0ADh	; ≠
		db  4Dh	; M
		db 0CCh	; Ã
		db  65h	; e
		db    1	;
		db 0E1h	; ·
		db 0E7h	; Á
		db  87h	; á
		db  81h	; Å
		db  65h	; e
		db  31h	; 1
		db 0E4h	; ‰
		db 0B7h	; ∑
		db  84h	; Ñ
		db 0B1h	; ±
		db  64h	; d
		db    2	;
		db 0E2h	; ‚
		db 0B7h	; ∑
		db  82h	; Ç
		db  64h	; d
		db    6	;
		db 0B1h	; ±
		db 0E6h	; Ê
		db  86h	; Ü
		db  64h	; d
		db    4	;
		db 0E4h	; ‰
		db  37h	; 7
		db 0B1h	; ±
		db  64h	; d
		db    1	;
		db 0E7h	; Á
		db    7	;
		db 0E1h	; ·
		db  66h	; f
		db  31h	; 1
		db 0B7h	; ∑
		db  66h	; f
		db  82h	; Ç
		db    6	;
		db 0E2h	; ‚
		db    0	;
		db  14h	;
		db  3Ah	; :
		db 0B3h	; ≥
		db  31h	; 1
		db 0B0h	; ∞
		db    4	;
		db  27h	; '
		db 0AAh	; ™
		db  4Ah	; J
		db 0C7h	; «
		db  84h	; Ñ
		db  17h	;
		db 0D7h	; ◊
		db  53h	; S
		db  93h	; ì
		db  16h	;
		db  8Ah	; ä
		db  67h	; g
		db 0D9h	; Ÿ
		db 0A9h	; ©
		db  87h	; á
		db  86h	; Ü
		db 0E4h	; ‰
		db 0E3h	; „
		db 0C1h	; ¡
		db  91h	; ë
		db  83h	; É
		db  16h	;
		db  89h	; â
		db  40h	; @
		db 0B1h	; ±
		db 0B2h	; ≤
		db 0C3h	; √
		db 0D3h	; ”
		db 0E2h	; ‚
		db 0E1h	; ·
		db 0D0h	; –
		db 0C0h	; ¿
		db  15h	;
		db  0Bh	;
		db  60h	; `
		db  98h	; ò
		db 0AAh	; ™
		db 0CAh	;  
		db 0D8h	; ÿ
		db  94h	; î
		db  91h	; ë
		db 0A0h	; †
		db 0C0h	; ¿
		db 0D4h	; ‘
		db 0E4h	; ‰
		db  12h	;
		db  3Ah	; :
		db 0B8h	; ∏
		db    8	;
		db  4Ah	; J
		db 0BAh	; ∫
		db 0A9h	; ©
		db  97h	; ó
		db  93h	; ì
		db 0A1h	; °
		db 0B0h	; ∞
		db 0C0h	; ¿
		db    8	;
		db  2Ah	; *
		db 0BAh	; ∫
		db 0C9h	; …
		db 0D7h	; ◊
		db 0D3h	; ”
		db 0C1h	; ¡
		db 0B0h	; ∞
		db 0A0h	; †
		db  84h	; Ñ
		db  11h	;
		db 0D7h	; ◊
		db  17h	;
		db 0D1h	; —
		db  2Dh	; -
		db  82h	; Ç
		db  31h	; 1
		db 0B7h	; ∑
		db  2Dh	; -
		db  53h	; S
		db  36h	; 6
		db 0B4h	; ¥
		db 0A3h	; £
		db    2	;
		db    4	;
		db 0E4h	; ‰
		db  11h	;
		db  30h	; 0
		db    2	;
		db    0	;
		db 0EAh	; Í
		db  82h	; Ç
		db  11h	;
		db 0D9h	; Ÿ
		db  4Fh	; O
		db    3	;
		db  19h	;
		db 0DAh	; ⁄
		db 0D0h	; –
		db    8	;
		db    8	;
		db  9Ah	; ö
		db 0CAh	;  
		db 0E8h	; Ë
		db 0E6h	; Ê
		db  82h	; Ç
		db  80h	; Ä
		db 0E0h	; ‡
		db  0Dh	;
		db    2	;
		db  90h	; ê
		db 0C0h	; ¿
		db 0E2h	; ‚
		db 0E4h	; ‰
		db 0C5h	; ≈
		db 0A5h	; •
		db 0C5h	; ≈
		db 0E6h	; Ê
		db 0E8h	; Ë
		db 0CAh	;  
		db  9Ah	; ö
		db  88h	; à
		db    5	;
		db  3Ah	; :
		db  83h	; É
		db 0E3h	; „
		db  5Ah	; Z
		db 0D0h	; –
		db  0Ah	;
		db  6Ah	; j
		db  9Ah	; ö
		db  85h	; Ö
		db 0B6h	; ∂
		db 0D6h	; ÷
		db 0E4h	; ‰
		db 0E2h	; ‚
		db 0C0h	; ¿
		db  90h	; ê
		db  82h	; Ç
		db  0Ch	;
		db  68h	; h
		db 0DAh	; ⁄
		db 0AAh	; ™
		db  88h	; à
		db  82h	; Ç
		db 0A0h	; †
		db 0D0h	; –
		db 0E2h	; ‚
		db 0E4h	; ‰
		db 0D6h	; ÷
		db 0A6h	; ¶
		db  84h	; Ñ
		db    3	;
		db  0Ah	;
		db 0EAh	; Í
		db  90h	; ê
		db  87h	; á
		db  45h	; E
		db 0E4h	; ‰
		db 0E2h	; ‚
		db 0C0h	; ¿
		db 0A0h	; †
		db  82h	; Ç
		db  84h	; Ñ
		db  91h	; ë
		db  0Ch	;
		db    2	;
		db  90h	; ê
		db 0C0h	; ¿
		db 0E2h	; ‚
		db 0E8h	; Ë
		db 0CAh	;  
		db  9Ah	; ö
		db  88h	; à
		db  86h	; Ü
		db  94h	; î
		db 0C4h	; ƒ
		db 0E6h	; Ê
		db  12h	;
		db  35h	; 5
		db  32h	; 2
		db  91h	; ë
		db  34h	; 4
		db  2Ch	; ,
		db    3	;
		db  57h	; W
		db  94h	; î
		db 0D1h	; —
		db    4	;
		db  15h	;
		db 0D5h	; ’
		db  53h	; S
		db  93h	; ì
		db    3	;
		db  17h	;
		db 0D4h	; ‘
		db  91h	; ë
		db  0Ah	;
		db  18h	;
		db  99h	; ô
		db 0AAh	; ™
		db 0CAh	;  
		db 0D9h	; Ÿ
		db 0D7h	; ◊
		db 0B5h	; µ
		db 0B3h	; ≥
		db  31h	; 1
		db 0B0h	; ∞
		db  87h	; á
		db  43h	; C
		db 0C7h	; «
		db 0B7h	; ∑
		db 0A6h	; ¶
		db 0A4h	; §
		db 0B3h	; ≥
		db 0D3h	; ”
		db  92h	; í
		db    5	;
		db    0	;
		db 0BAh	; ∫
		db 0E0h	; ‡
		db  13h	;
		db 0D3h	; ”
		db  0Ch	;
		db    0	;
		db  8Ah	; ä
		db 0CAh	;  
		db 0E8h	; Ë
		db 0E7h	; Á
		db 0C5h	; ≈
		db  85h	; Ö
		db 0C5h	; ≈
		db 0E4h	; ‰
		db 0E2h	; ‚
		db 0C0h	; ¿
		db  80h	; Ä
		db    8	;
		db  61h	; a
		db 0C0h	; ¿
		db 0A0h	; †
		db  82h	; Ç
		db  88h	; à
		db 0AAh	; ™
		db 0CAh	;  
		db 0E9h	; È
		db    7	;
		db    0	;
		db  8Ah	; ä
		db 0CAh	;  
		db 0E8h	; Ë
		db 0E2h	; ‚
		db 0C0h	; ¿
		db  80h	; Ä
		db  81h	; Å
		db  60h	; `
		db 0C6h	; ∆
		db    5	;
		db    0	;
		db  8Ah	; ä
		db 0DAh	; ⁄
		db    5	;
		db 0D5h	; ’
		db    9	;
		db  35h	; 5
		db 0E5h	; Â
		db 0E0h	; ‡
		db 0A0h	; †
		db  82h	; Ç
		db  88h	; à
		db 0AAh	; ™
		db 0CAh	;  
		db 0E9h	; È
		db    6	;
		db    0	;
		db  8Ah	; ä
		db    5	;
		db 0E5h	; Â
		db  6Ah	; j
		db 0E0h	; ‡
		db  94h	; î
		db  20h	;
		db 0C0h	; ¿
		db  2Ah	; *
		db 0CAh	;  
		db  17h	;
		db    5	;
		db    2	;
		db  90h	; ê
		db 0C0h	; ¿
		db 0E2h	; ‚
		db 0EAh	; Í
		db    5	;
		db    0	;
		db  8Ah	; ä
		db  5Ah	; Z
		db  85h	; Ö
		db 0E0h	; ‡
		db    3	;
		db  0Ah	;
		db  80h	; Ä
		db 0E0h	; ‡
		db    5	;
		db    0	;
		db  8Ah	; ä
		db 0B5h	; µ
		db 0EAh	; Í
		db 0E0h	; ‡
		db    4	;
		db    0	;
		db  8Ah	; ä
		db 0E0h	; ‡
		db 0EAh	; Í
		db    9	;
		db  40h	; @
		db 0A0h	; †
		db  82h	; Ç
		db  88h	; à
		db 0AAh	; ™
		db 0CAh	;  
		db 0E8h	; Ë
		db 0E2h	; ‚
		db 0C0h	; ¿
		db    7	;
		db    0	;
		db  8Ah	; ä
		db 0CAh	;  
		db 0E9h	; È
		db 0E6h	; Ê
		db 0C5h	; ≈
		db  85h	; Ö
		db  82h	; Ç
		db  42h	; B
		db 0E0h	; ‡
		db  4Fh	; O
		db  82h	; Ç
		db  45h	; E
		db 0E0h	; ‡
		db  50h	; P
		db  0Ah	;
		db    2	;
		db  90h	; ê
		db 0C0h	; ¿
		db 0E2h	; ‚
		db 0E4h	; ‰
		db  86h	; Ü
		db  88h	; à
		db 0AAh	; ™
		db 0DAh	; ⁄
		db 0E8h	; Ë
		db    4	;
		db  0Ah	;
		db 0EAh	; Í
		db  3Ah	; :	
		db 0B0h	; ∞
		db    6	;
		db  0Ah	;
		db  82h	; Ç
		db 0A0h	; †
		db 0C0h	; ¿
		db 0E2h	; ‚
		db 0EAh	; Í
		db    3	;
		db  0Ah	;
		db 0B0h	; ∞
		db 0EAh	; Í
		db    5	;
		db  0Ah	;
		db  90h	; ê
		db 0B6h	; ∂
		db 0D0h	; –
		db 0EAh	; Í
		db  82h	; Ç
		db  0Ah	;
		db 0E0h	; ‡
		db  2Fh	; /
		db    5	;
		db  0Ah	;
		db 0B5h	; µ
		db 0EAh	; Í
		db  35h	; 5
		db 0B0h	; ∞
		db    4	;
		db  1Ah	;
		db 0EAh	; Í
		db  80h	; Ä
		db 0E0h	; ‡
		db    4	;
		db  5Ah	; Z
		db 0AAh	; ™
		db 0A0h	; †
		db 0D0h	; –
		db    2	;
		db  0Ah	;
		db 0E0h	; ‡
		db    4	;
		db  1Ah	;
		db 0CAh	;  
		db 0C0h	; ¿
		db  90h	; ê
		db    3	;
		db  16h	;
		db 0B9h	; π
		db 0D6h	; ÷
		db    2	;
		db    0	;
		db 0E0h	; ‡
		db  12h	;
		db  3Ah	; :	
		db 0C8h	; »
		db  1Ah	;
		db  53h	; S
		db 0C4h	; ƒ
		db 0A4h	; §
		db  93h	; ì
		db  91h	; ë
		db 0A0h	; †
		db 0D0h	; –
		db 0D5h	; ’
		db 0C6h	; ∆
		db  96h	; ñ
		db  91h	; ë
		db  1Ah	;
		db  94h	; î
		db  17h	;
		db  55h	; U
		db 0C6h	; ∆
		db 0A6h	; ¶
		db  95h	; ï
		db  91h	; ë
		db 0A0h	; †
		db 0D0h	; –
		db  92h	; í
		db  50h	; P
		db 0DAh	; ⁄
		db  63h	; c
		db  92h	; í
		db  13h	;
		db 0D3h	; ”
		db 0E3h	; „
		db  56h	; V
		db  1Ah	;
		db 0CAh	;  
		db  4Eh	; N
		db 0BEh	; æ
		db 0ADh	; ≠
		db 0A1h	; °
		db 0D4h	; ‘
		db  11h	;
		db 0C1h	; ¡
		db 0D3h	; ”
		db 0DAh	; ⁄
		db  63h	; c
		db  92h	; í
		db  10h	;
		db  9Ah	; ö
		db  13h	;
		db  16h	;
		db  10h	;
		db 0C0h	; ¿
		db  30h	; 0
		db 0B6h	; ∂
		db  96h	; ñ
		db  38h	; 8
		db  56h	; V
		db  11h	;
		db 0A1h	; °
		db 0B3h	; ≥
		db 0BAh	; ∫
		db  9Ah	; ö
		db  3Ch	; <
		db  15h	;
		db  10h	;
		db  9Ah	; ö
		db  56h	; V
		db  93h	; ì
		db 0D0h	; –
		db  93h	; ì
		db  10h	;
		db 0C0h	; ¿
		db  1Ah	;
		db  97h	; ó
		db  0Ch	;
		db    0	;
		db  86h	; Ü
		db    5	;
		db  96h	; ñ
		db 0A6h	; ¶
		db 0B5h	; µ
		db 0B0h	; ∞
		db  35h	; 5
		db 0C6h	; ∆
		db 0D6h	; ÷
		db 0E5h	; Â
		db 0E0h	; ‡
		db  92h	; í
		db  10h	;
		db  96h	; ñ
		db  13h	;
		db  19h	;
		db  11h	;
		db  95h	; ï
		db 0A6h	; ¶
		db 0C6h	; ∆
		db 0D5h	; ’
		db 0D1h	; —
		db 0C0h	; ¿
		db 0A0h	; †
		db  91h	; ë
		db 0D2h	; “
		db  11h	;
		db  9Ah	; ö
		db  14h	;
		db 0D2h	; “
		db  51h	; Q
		db 0DAh	; ⁄
		db  63h	; c
		db  15h	;
		db  20h	;
		db 0A6h	; ¶
		db  25h	; %
		db 0C6h	; ∆
		db 0D5h	; ’
		db  1Ah	;
		db  11h	;
		db 0A0h	; †
		db 0C0h	; ¿
		db 0D1h	; —
		db 0D2h	; “
		db  94h	; î
		db  95h	; ï
		db 0A6h	; ¶
		db 0C6h	; ∆
		db 0D5h	; ’
		db  16h	;
		db  16h	;
		db 0C6h	; ∆
		db  28h	; (
		db 0A1h	; °
		db 0B0h	; ∞
		db 0C0h	; ¿
		db  15h	;
		db  16h	;
		db  91h	; ë
		db 0A0h	; †
		db 0D0h	; –
		db 0D6h	; ÷
		db  13h	;
		db  16h	;
		db 0B0h	; ∞
		db 0D6h	; ÷
		db    5	;
		db    6	;
		db  90h	; ê
		db 0B4h	; ¥
		db 0D0h	; –
		db 0E6h	; Ê
		db  14h	;
		db  10h	;
		db 0D6h	; ÷
		db  16h	;
		db 0D0h	; –
		db  55h	; U
		db  11h	;
		db 0A1h	; °
		db 0DAh	; ⁄
		db  1Ah	;
		db 0B4h	; ¥
		db  14h	;
		db  16h	;
		db 0D6h	; ÷
		db  90h	; ê
		db 0D0h	; –
		db    9	;
		db  5Ah	; Z
		db 0CAh	;  
		db 0B9h	; π
		db 0B6h	; ∂
		db  95h	; ï
		db 0B4h	; ¥
		db 0B1h	; ±
		db 0C0h	; ¿
		db 0D0h	; –
		db  14h	;
		db  3Ah	; :	
		db 0B7h	; ∑
		db  33h	; 3
		db 0B0h	; ∞
		db    9	;
		db  1Ah	;
		db 0AAh	; ™
		db 0B9h	; π
		db 0B6h	; ∂
		db 0D5h	; ’
		db 0B4h	; ¥
		db 0B1h	; ±
		db 0A0h	; †
		db  90h	; ê
		db    6	;
		db    4	;
		db  95h	; ï
		db 0A5h	; •
		db 0C3h	; √
		db 0D3h	; ”
		db 0E4h	; ‰
		db  0Ch	;
		db  10h	;
		db  99h	; ô
		db 0AAh	; ™
		db 0CAh	;  
		db 0D9h	; Ÿ
		db 0D7h	; ◊
		db 0B6h	; ∂
		db 0D5h	; ’
		db 0E4h	; ‰
		db 0E2h	; ‚
		db 0D1h	; —
		db 0B0h	; ∞

loc_A2E1:	push	hl
		push	bc
		call	OPKOP
		pop	bc
		ld	de, 0
		ld	hl, WRA1+3
		ld	a, (hl)
		or	a
		jp	z, loc_A329
		dec	hl
		ld	a, (hl)
		or	a
		jp	p, loc_A306
		and	7Fh ; ''
		ld	(hl), a
		ld	hl, unk_285
		ld	a, (hl)
		or	c
		ld	(hl), a
		pop	hl
		call	OPTRAN
		push	hl
loc_A306:	ld	bc, 7E22h
		ld	de, 0F983h
		call	MUL1
		ld	hl, WRA1+3
		ld	a, 81h ; 'Å'
		cp	(hl)
		jp	c, err2
		call	OPARST
		xor	a
		ld	b, 8
		call	FRE3
		pop	bc
		pop	de
		call	MUL1
		call	EPRVL3
loc_A329:	pop	hl
		ret
locret_A32B:	ret



;-----------------------------------------------------------------------------
; BASIC-Interface
;-----------------------------------------------------------------------------


;-----------------------------------------------------------------------------
; PSET(x,y)[,stift]
;-----------------------------------------------------------------------------

pset:		ld	a, (hl)		
		cp	0ABh ; '´'      ; Token fuer STEP
		ld	b, 0FFh
		jr	nz, pset1
		call	TCHAR
		jr	pset2
pset1:		ld	b, 1
pset2:		ld	de, unk_285
		push	de
		ld	a, b
		ld	(de), a
		inc	de
		call	point3
		jr	nz, pset3
		inc	a
		jr	pset4
pset3:		call	CPCOMM
		call	sub_A7B2
pset4:		ld	(de), a
		pop	de
		ld	c, 1
		jp	plsv		; Plotter-Sprungverteiler

;-----------------------------------------------------------------------------
; LINE [(x1,y1)]-(x2,y2)[,[stift][,B]]
;-----------------------------------------------------------------------------

line:		ld	b, 1
		ld	a, (hl)
		cp	0ADh ; '≠'      ; Token fuer '-'
		jr	z, line1
		cp	0ABh ; '´'      ; TOKEN fuer STEP
		jr	nz, line2
		dec	b
line1:		dec	b
		call	TCHAR
line2:		ld	de, unk_285
		push	de
		ld	a, b
		ld	(de), a
		inc	de
		and	a
		jr	nz, line3
		ld	de, unk_28A
		jr	line4
line3:		call	point3
		cp	0ADh ; '≠'      ; Token fuer '-'
		jr	nz, circle3
		call	TCHAR
line4:		ld	a, (hl)
		cp	0ABh ; '´'      ; Token fuer STEP
		jr	nz, line5
		ld	b, 0FFh
		call	TCHAR
		jr	line6
line5:		ld	b, 1
line6:		ld	a, b
		ld	(de), a
		inc	de
		call	point3
		jr	nz, line7
		ld	a, 1
		jr	line11
line7:		cp	2Ch ; ','
		jr	nz, circle3
		call	TCHAR
		cp	2Ch ; ','
		jr	nz, line8
		ld	a, 1
		ld	(de), a
		inc	de
		jr	line9
line8:		call	sub_A7B2
		ld	(de), a
		inc	de
		dec	hl
		call	TCHAR
		jr	z, line12
		cp	2Ch ; ','
		jr	nz, circle3
line9:		ld	b, 0
		call	TCHAR
		cp	42h ; 'B'
		jr	nz, circle3
		inc	b
		call	TCHAR
		cp	46h ; 'F'
		jr	nz, line10
		call	TCHAR
		inc	b
		ld	a, b
		jr	line13
line10:		ld	a, b
		jr	line13
line11:		ld	(de), a
		inc	de
line12:		xor	a
line13:		ld	(de), a
		pop	de
		ld	c, 2
		jp	plsv		; Plotter-Sprungverteiler

;-----------------------------------------------------------------------------
; CIRCLE(x,y),radius[,stift[,anf-winkel[,end-winkel[,ellip]]]]
; CIRCLE(x,y),radius[,stift],[anf-winkel],[end-winkel],ellip
;-----------------------------------------------------------------------------

circle:		ld	a, (hl)
		cp	0ABh ; '´'      ; Token fuer STEP
		ld	b, 0FFh
		jr	nz, circle1
		call	TCHAR
		jr	circle2
circle1:	ld	b, 1
circle2:	ld	de, unk_285
		push	de
		ld	a, b
		ld	(de), a
		inc	de
		call	point3
		cp	2Ch ; ','
circle3:	jp	nz, err1
		call	TCHAR
		call	SNALY
		ld	de, unk_28A
		call	size7
		call	TCHAR1
		jr	z, circle10
		cp	2Ch ; ','
		jr	nz, circle3
		call	TCHAR
		cp	2Ch ; ','
		jr	nz, circle4
		ld	de, unk_28E
		call	sub_A4DA
		jr	circle5
circle4:	call	sub_A7B2
		ld	(de), a
		call	TCHAR1
		jr	z, circle11
circle5:	call	TCHAR
		cp	2Ch ; ','
		jr	nz, circle6
		call	sub_A4DF
		jr	circle7
circle6:	call	SNALY
		ld	de, unk_28F
		call	size7
		call	TCHAR1
		jr	z, circle12
		cp	2Ch ; ','
		jr	nz, circle3
circle7:	call	TCHAR
		cp	2Ch ; ','
		jr	nz, circle8
		call	sub_A4E5
		jr	circle9
circle8:	call	SNALY
		ld	de, unk_293
		call	size7
		call	TCHAR1
		jr	z, circle13
		cp	2Ch ; ','
		jr	nz, circle3
circle9:	call	TCHAR
		call	SNALY
		push	hl
		ld	hl, WRA1+2
		bit	7, (hl)
		jp	nz, err2
		ld	hl, WRA1+3
		ld	a, (hl)
		and	a
		jp	z, err2
		pop	hl
		ld	de, unk_297
		call	size7
		jr	circle14
circle10:	call	sub_A4DA
circle11:	call	sub_A4DF
circle12:	call	sub_A4E5
circle13:	call	sub_A4F6
circle14:	push	hl
		ld	hl, unk_27D
		call	OPKOP
		ld	hl, unk_297
		push	hl
		call	OPLAD
		call	DIV1
		ld	hl, unk_281
		call	OPLAD
		call	MUL1
		ld	hl, WRA1+2
		ld	a, (hl)
		and	7Fh ; ''
		ld	(hl), a
		pop	hl
		call	OPTRAN
		ld	hl, unk_27D
		ld	a, (WRA1+3)
		cp	81h ; 'Å'
		jr	c, circle15
		ld	hl, unk_281
circle15:	call	OPKOP
		ld	hl, unk_28A
		push	hl
		call	OPLAD
		call	MUL1
		pop	hl
		call	OPTRAN
		pop	hl
		pop	de
		ld	c, 3
		jp	plsv		; Plotter-Sprungverteiler

sub_A4DA:	ld	a, 1
		ld	(de), a
		inc	de
		ret

sub_A4DF:	ld	de, unk_292
		xor	a
		ld	(de), a
		ret

sub_A4E5:	push	hl
		ld	hl, unk_293
		ld	(hl), 0DBh ; '€'
		inc	hl
		ld	(hl), 0Fh
		inc	hl
		ld	(hl), 49h ; 'I'
		inc	hl
		ld	(hl), 83h ; 'É'
		pop	hl
		ret

sub_A4F6:	ld	de, unk_297
		xor	a
		ld	(de), a
		inc	de
		ld	(de), a
		inc	de
		ld	(de), a
		inc	de
		ld	a, 81h ; 'Å'
		ld	(de), a
		ret

;-----------------------------------------------------------------------------
; 
;-----------------------------------------------------------------------------

paint:		ld	a, (hl)
		cp	0ABh ; '´'      ; Token fuer STEP
		ld	b, 0FFh
		jr	nz, paint1
		call	TCHAR
		jr	paint2
paint1:		ld	b, 1
paint2:		ld	de, unk_285
		push	de
		ld	a, b
		ld	(de), a
		inc	de
		call	point3
		jr	z, paint5
		cp	2Ch ; ','
		jp	nz, err1
		call	TCHAR
		cp	2Ch ; ','
		jr	nz, paint3
		ld	a, 1
		ld	(de), a
		inc	de
		jr	paint4
paint3:		call	sub_A7B2
		ld	(de), a
		inc	de
		ld	a, (hl)
		and	a
		jr	z, paint6
		cp	2Ch ; ','
		jp	nz, err1
paint4:		call	TCHAR
		push	de
		call	ARGVL1
		pop	de
		jr	paint7
paint5:		ld	a, 1
		ld	(de), a
		inc	de
paint6:		ld	a, 1
paint7:		ld	(de), a
		pop	de
		ld	c, 4
		jp	plsv		; Plotter-Sprungverteiler

;-----------------------------------------------------------------------------
; LABEL	string
;-----------------------------------------------------------------------------

label:		call	SNALY
		push	hl
		call	LEN1
		ld	de, unk_285
		ld	bc, 4
		ldir
		pop	hl
		dec	hl
		call	TCHAR
		jr	z, label1
		cp	2Ch ; ','
		jp	nz, err1
		call	TCHAR
		call	sub_A7B2
		jr	label2
label1:	ld	a, 1
label2:	ld	(de), a
		ld	de, unk_285
		ld	c, 5
		jp	plsv		; Plotter-Sprungverteiler

;-----------------------------------------------------------------------------
; SIZE b,l[,r[,s[,a]]]
; SIZE b,l,[r],[s],a
;-----------------------------------------------------------------------------

size:		push	hl
		ld	hl, unk_28E
		ld	(hl), 0
		ld	de, unk_28F
		ld	bc, 0Bh
		ldir
		pop	hl
		call	SNALY
		ld	de, unk_28E
		call	size7
		call	CPCOMM
		call	SNALY
		ld	de, unk_292
		call	size7
		call	TCHAR1
		jr	z, size1
		call	CPCOMM
		call	TCHAR1
		cp	2Ch ; ','
		jr	z, size1
		call	SNALY
		ld	de, unk_296
		call	size7
size1:		push	hl
		ld	hl, unk_296
		call	size8
		call	COS
		ld	hl, unk_28E
		call	size9
		ld	(unk_285), hl
		ld	hl, unk_296
		call	size8
		call	SIN
		ld	hl, unk_28E
		call	size9
		ld	(unk_287), hl
		pop	hl
		call	TCHAR1
		jr	z, size2
		call	CPCOMM
		call	TCHAR1
		cp	2Ch ; ','
		jr	nz, size3
size2:		xor	a
		ld	(unk_291), a
		jr	size4
size3:		call	SNALY
		ld	de, unk_28E
		call	size7
size4:		push	hl
		ld	hl, unk_28E
		call	size8
		ld	hl, unk_296
		call	ADD3
		ld	hl, COSL
		call	ADD2
		ld	de, unk_28E
		call	size7
		call	COS
		ld	hl, unk_292
		call	size9
		ld	(unk_289), hl
		ld	hl, unk_28E
		call	size8
		call	SIN
		ld	hl, unk_292
		call	size9
		ld	(unk_28B), hl
		pop	hl
		call	TCHAR1
		jr	z, size5
		call	CPCOMM
		call	sub_A7B2
		jr	z, size5
		ld	a, 80h ; 'Ä'
		jr	size6
size5:		xor	a
size6:		ld	(unk_28D), a
		ld	de, unk_285
		ld	c, 6
		jp	plsv		; Plotter-Sprungverteiler

size7:		push	hl
		ld	hl, WRA1	; ARITHMETIKREGISTER 1
		ld	bc, 4
		ldir
		pop	hl
		ret

size8:		ld	de, WRA1	; ARITHMETIKREGISTER 1
		ld	bc, 4
		ldir
		ret

size9:		call	OPLAD
		call	MUL1
		call	EPRVL3
		ex	de, hl
		ret

;-----------------------------------------------------------------------------
; ZERO (x,y)
;-----------------------------------------------------------------------------

zero:		ld	a, (hl)		
		cp	0ABh ; '´'      ; Token fuer STEP
		ld	b, 0FFh
		jr	nz, zero1
		call	TCHAR
		jr	zero2
zero1:		ld	b, 1
zero2:		ld	de, unk_285
		push	de
		ld	a, b
		ld	(de), a
		inc	de
		call	point3
		pop	de
		ld	c, 7
		jr	ypos1

;-----------------------------------------------------------------------------
; HOME
;-----------------------------------------------------------------------------

home:		ld	c, 8		
		jr	ypos1

;-----------------------------------------------------------------------------
; GCLS
;-----------------------------------------------------------------------------

gcls:		ld	c, 9		
		call	sub_A6C6
		jr	ypos1

;-----------------------------------------------------------------------------
; 
;-----------------------------------------------------------------------------

xpos:		ld	c, 0Bh
		jr	ypos1
		
;-----------------------------------------------------------------------------
; 
;-----------------------------------------------------------------------------

ypos:		ld	c, 0Ch
		jr	ypos1
ypos1:		jp	plsv		; Plotter-Sprungverteiler

;-----------------------------------------------------------------------------
; SCALE	xfaktor,yfaktor
;-----------------------------------------------------------------------------

scale:		call	SNALY
		ld	de, unk_27D
		call	size7
		ld	a, (hl)
		cp	2Ch ; ','
		jp	nz, err1
		call	TCHAR
		call	SNALY
		ld	de, unk_281
		call	size7
		ret

sub_A6C6:	ex	de, hl
		ld	hl, 0
		ld	(unk_27D), hl
		ld	(unk_281), hl
		ld	h, 81h ; 'Å'
		ld	(unk_27F), hl
		ld	(unk_283), hl
		ex	de, hl
		ret

;-----------------------------------------------------------------------------
; SCREEN [0],plotter
;-----------------------------------------------------------------------------

unk_A6DA:	db  89h	; Plotter 1 - E/A-Buchse
		db 0C8h	; Plotter 2 - E/-Modul, Adr. 0C8h, Port A
		db 0C9h	; Plotter 2 - E/-Modul, Adr. 0C8h, Port B
		db 0CCh	; Plotter 2 - E/-Modul, Adr. 0CCh, Port A
		db 0CBh	; Plotter 2 - E/-Modul, Adr. 0CCh, Port B

screen:	ld	a, (WINJP)
		bit	7, a
		set	7, a
		call	z, sub_A6C6
		call	TCHAR1
		jr	z, screen5
		cp	2Ch ; ','
		jr	nz, screen1
		call	screen10
		jr	screen4
screen1:	call	sub_A7B2
		jr	nz, screen2
		call	screen10
		jr	screen3
screen2:	call	screen11
screen3:	call	TCHAR1
		jr	z, screen6
		cp	2Ch ; ','
		jp	nz, err1
screen4:	call	TCHAR
		call	ARGVL1
		and	a
		jr	z, screen7
		cp	6
		jp	nc, err2
		dec	a
		ld	c, a
		ld	b, 0
		ex	de, hl
		ld	hl, unk_A6DA
		add	hl, bc
		ld	a, (hl)
		ex	de, hl
		ld	(WINJP+1), a
		and	a
		jr	screen7
screen5:	call	screen10
screen6:	xor	a
screen7:	ld	a, (WINJP)
		jr	z, screen8
		set	0, a
		jr	screen9
screen8:	res	0, a
screen9:	ld	(WINJP), a
		ret
screen10:	ld	a, 0E2h	; '‚'
		jr	screen12
screen11:	ld	a, (atrib)	; aktuelles Farbattribut
		or	88h ; 'à'
screen12:	out	(0B8h),	a
		ret

;-----------------------------------------------------------------------------
; POINT(X,Y),c[,d] ??
;-----------------------------------------------------------------------------

point:		ld	a, (hl)
		cp	0ABh ; '´'      ; Token fuer STEP
		ld	b, 0FFh
		jr	nz, point1
		call	TCHAR
		jr	point2
point1:		ld	b, 1
point2:		ld	de, unk_285
		push	de
		ld	a, b
		ld	(de), a
		inc	de
		call	point3
		pop	de
		ld	c, 0Ah
		jp	plsv		; Plotter-Sprungverteiler

point3:		ld	a, (hl)
		cp	28h ; '('
		jp	nz, err1
		call	TCHAR
		push	de
		call	SNALY
		push	hl
		ld	hl, unk_27D
		call	size9
		ex	de, hl
		pop	hl
		ex	(sp), hl
		ld	(hl), e
		inc	hl
		ld	(hl), d
		inc	hl
		ex	(sp), hl
		call	CPCOMM
		call	SNALY
		push	hl
		ld	hl, unk_281
		call	size9
		ex	de, hl
		pop	hl
		ex	(sp), hl
		ld	(hl), e
		inc	hl
		ld	(hl), d
		inc	hl
		pop	de
		ex	de, hl
		ld	a, (hl)
		cp	29h ; ')'
		jp	nz, err1
		call	TCHAR
		ret

unk_xxx3:	push	de
		call	EPRVL4
		ex	(sp), hl
		ld	(hl), e
		inc	hl
		ld	(hl), d
		inc	hl
		ex	(sp), hl
		pop	de
		ret


sub_A7B2:	push	de
		call	ARGVL1
		pop	de
		and	a
		ret	z
		dec	a
		jp	nz, err2
		inc	a
		ret
; End of function sub_A7B2

;;		db 0FFh	;
;;		db 0FFh	;
;;		db 0FFh	;
;;		db 0FFh	;
;;		db 0FFh	;
;;		db 0FFh	;
;;		db 0FFh	;
;;		db 0FFh	;
;;		db 0FFh	;
;;		db 0FFh	;
;;		db 0FFh	;
;;		db 0FFh	;
;;		db 0FFh	;
;;		db 0FFh	;
;;		db 0FFh	;
;;		db 0FFh	;
;;		db 0FFh	;
;;		db 0FFh	;
;;		db 0FFh	;
;;		db 0FFh	;
;;		db 0FFh	;
;;		db 0FFh	;
;;		db 0FFh	;

;-----------------------------------------------------------------------------
; Sprungverteiler f¸r BASIC, vorgegeben in BM608 (2K-Erweiterung f. Grafik)
;-----------------------------------------------------------------------------

		org 0A7D6H
		
		jp	pset
		jp	line
		jp	circle
		jp	paint
		jp	label
		jp	size
		jp	zero
		jp	home
		jp	gcls
		jp	scale
		jp	screen
		jp	point
		jp	xpos
		jp	ypos

		end
