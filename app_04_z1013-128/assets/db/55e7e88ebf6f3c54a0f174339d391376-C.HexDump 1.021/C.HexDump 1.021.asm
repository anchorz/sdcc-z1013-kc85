; z80dasm 1.1.4
; command line: z80dasm -l -o C.HexDump 1.021.asm C.HexDump 1.021.hex

	org	00100h

	jp 0d62eh
	and a	
	jp 0dfbeh
	ret	
	jp 0ffebh
	ret	
	jr z,l0151h
	add hl,hl	
	jr nz,$+89
	ld l,042h
	ld h,l	
	ld (hl),d	
	ld l,(hl)	
	ld l,b	
	ld h,c	
	ld (hl),d	
	ld h,h	
	ld (hl),h	
	jr nz,$+88
	ld l,020h
	ld sp,0302eh
	ld (02031h),a
	ld sp,02e39h
	ld sp,02e30h
	jr c,$+58
	nop	
	rst 20h	
	ld (bc),a	
	inc c	
	ex af,af'	
	ex af,af'	
	and b	
	ld hl,0ddc0h
	ld de,0ec69h
	ld bc,0000eh
	ldir
	ld hl,0defdh
	ld de,0eca3h
	ld bc,0001ah
	ldir
	ld de,0ed02h
	ld a,02ah
	ld b,01ch
l0151h:
	ld (de),a	
	inc de	
	djnz l0151h
	ld hl,0df17h
	ld de,0ed8dh
	ld bc,00007h
	ldir
	ld hl,0df1eh
	ld de,0edcdh
	ld bc,00005h
	ldir
	ld hl,0df23h
	ld de,0ee0dh
	ld bc,00003h
	ldir
	ld de,0ef62h
	ld a,02ah
	ld b,01ch
l017dh:
	ld (de),a	
	inc de	
	djnz l017dh
	ld hl,0df26h
	ld de,0efa2h
	ld bc,0003ch
	ldir
l018ch:
	ld hl,0defbh
	ld de,0ed8ah
	ld bc,00002h
	ldir
	ld a,001h
	ld (0ddadh),a
	nop	
l019dh:
	rst 20h	
	ld bc,l0afeh
	jr z,l01b1h
	cp 00bh
	jr z,l0202h
	cp 00dh
	jp z,0d752h
	call 0dd90h
	jr l019dh
l01b1h:
	ld a,(0ddadh)
	ld hl,0ed8ah
	ld de,00040h
	push hl	
	push de	
	cp 001h
	jr nz,l01cch
	inc a	
	ld (0ddadh),a
	ld de,0ed8ah
	call 0d6f9h
	jr l01ebh
l01cch:
	cp 002h
	jr nz,l01e1h
	inc a	
	ld (0ddadh),a
	ld de,0edcah
	call 0d6f9h
	pop de	
	pop hl	
	add hl,de	
	push hl	
	push de	
	jr l01ebh
l01e1h:
	ld de,0ee0ah
	call 0d6f9h
	pop de	
	pop hl	
	jr l018ch
l01ebh:
	pop de	
	pop hl	
	add hl,de	
	ex de,hl	
	ld hl,0defbh
	ld bc,00002h
	ldir
	jr l019dh
	ld hl,0ddceh
	ld bc,00002h
	ldir
	ret	
l0202h:
	ld a,(0ddadh)
	ld hl,0ee0ah
	ld de,00040h
	push hl	
	push de	
	cp 003h
	jr nz,l021dh
	dec a	
	ld (0ddadh),a
	ld de,0ee0ah
	call 0d6f9h
	jr l0242h
l021dh:
	cp 002h
	jr nz,l0233h
	dec a	
	ld (0ddadh),a
	ld de,0edcah
	call 0d6f9h
	pop de	
	pop hl	
	sbc hl,de
	push hl	
	push de	
	jr l0242h
l0233h:
	ld a,003h
	ld (0ddadh),a
	ld de,0ed8ah
	call 0d6f9h
	pop de	
	pop hl	
	jr l0246h
l0242h:
	pop de	
	pop hl	
	sbc hl,de
l0246h:
	ex de,hl	
	ld hl,0defbh
	ld bc,00002h
	ldir
	jp 0d69dh
	ld a,(0ddadh)
	cp 001h
	jp z,0d9bah
	cp 002h
	jr z,l0270h
	cp 003h
	jr l0268h
	call 0dd90h
	jp 0d69dh
l0268h:
	ld a,00ch
	nop	
	rst 20h	
	nop	
	jp 00038h
l0270h:
	ld bc,0ec00h
	ld (0001bh),bc
	ld bc,0f000h
	ld (0001dh),bc
	nop	
	rst 20h	
	dec bc	
	nop	
	rst 20h	
	ld (bc),a	
	inc c	
	ex af,af'	
	ex af,af'	
	and b	
	ld hl,0ddc0h
	ld de,0ec20h
	ld bc,0000eh
	ldir
	ld hl,0df62h
	ld de,0ec33h
	ld bc,0000dh
	ldir
	ld hl,0de20h
	ld de,0ec80h
	ld bc,00020h
	ldir
	ld hl,0de20h
	ld de,0ef80h
	ld bc,0002eh
	ldir
	ld hl,0ded4h
	ld de,0efb5h
	ld bc,0000ah
	ldir
	ld hl,0efaeh
	ld (0002bh),hl
	call 0d9e8h
	ld (0001bh),hl
	ld hl,0de16h
	ld de,0efc0h
	ld bc,00004h
	ldir
	ld hl,0de44h
	ld de,0efc4h
	ld bc,00009h
	ldir
	ld hl,0efceh
	ld (0002bh),hl
	call 0d9e8h
	ld (0dda7h),hl
	ld hl,0ed2fh
	ld (0002bh),hl
	ld de,(0dda7h)
	ld hl,(0001bh)
	ld (0dda9h),hl
	ex de,hl	
	scf	
	sbc hl,de
	jp c,0d907h
	ld de,00011h
	ld hl,(0dda7h)
	add hl,de	
	ld (0dda7h),hl
	ld hl,0df82h
	ld de,0ed20h
	ld bc,0000ah
	ldir
	nop	
l031ah:
	rst 20h	
	ld bc,0e700h
	nop	
	cp 003h
	jp z,0d770h
	cp 00dh
	jr z,l032ah
	jr l031ah
l032ah:
	ld hl,0ed2fh
	ld de,0df8ch
	ld bc,00010h
	ldir
	ld hl,0ed93h
	ld (0002bh),hl
	ld hl,0df6fh
	ld de,0ed40h
	ld bc,00013h
	ldir
	ld bc,0eca0h
	ld (0001bh),bc
	ld bc,0ef80h
	ld (0001dh),bc
	nop	
	rst 20h	
	dec bc	
	nop	
	rst 20h	
	ld bc,0afcbh
	cp 059h
	jp nz,0d770h
	push de	
	push hl	
	push bc	
	ld hl,0dfa4h
	ld de,0efe0h
	ld bc,00012h
	ldir
	pop bc	
	pop hl	
	pop de	
	ld de,(0dda7h)
	ld a,00ch
	nop	
	rst 20h	
	nop	
	call 0d994h
	jp c,0d770h
	ld a,01eh
	call 0d941h
	jp c,00084h
	nop	
	rst 20h	
	nop	
	ld b,01ah
	ld hl,0df82h
l0391h:
	ld a,(hl)	
	call 0d603h
	jr c,l040ah
	nop	
	rst 20h	
	nop	
	inc hl	
	djnz l0391h
	ld a,01eh
	call 0d941h
	jr c,l040ah
	nop	
	rst 20h	
	nop	
	ld hl,(0dda9h)
l03aah:
	ld a,01eh
	call 0d941h
	jr c,l040ah
	nop	
	rst 20h	
	nop	
	call 0d90dh
	jr c,l040ah
	ld b,010h
l03bbh:
	ld a,020h
	nop	
	rst 20h	
	nop	
	call 0d603h
	jr c,l040ah
	ld a,(hl)	
	call 0d91ch
	jr c,l040ah
	inc hl	
	djnz l03bbh
	ld b,010h
l03d0h:
	dec hl	
	djnz l03d0h
	ld b,010h
	ld a,020h
	call 0d603h
	jr c,l040ah
	nop	
	rst 20h	
	nop	
l03dfh:
	ld a,(hl)	
	cp 020h
	jr c,l03eah
	cp 07fh
	jr nc,l03eah
	jr l03edh
l03eah:
	and a	
	ld a,02eh
l03edh:
	call 0d603h
	jr c,l040ah
	nop	
	rst 20h	
	nop	
	inc hl	
	djnz l03dfh
	push de	
	ex de,hl	
	scf	
	sbc hl,de
	ex de,hl	
l03feh:
	pop de	
	jr nc,l03aah
	call 0d994h
	jp 0d770h
	call 0dd90h
l040ah:
	jp 0d770h
	push af	
	ld a,h	
	and a	
	call 0d91ch
	jr c,l043eh
	ld a,l	
	and a	
	call 0d91ch
	pop af	
	ret	
	push af	
	rra	
	rra	
	rra	
	rra	
	call 0d927h
	jr c,l043eh
	pop af	
	push af	
	and 00fh
	add a,030h
	cp 03ah
	jr c,l0432h
	add a,007h
l0432h:
	and a	
	call 0d603h
	jr c,l043eh
	nop	
	rst 20h	
	nop	
	pop af	
	and a	
	ret	
l043eh:
	pop af	
	scf	
	ret	
	cp 01eh
	jr nz,l044eh
	ld a,00ah
	call 0d603h
	jr c,l0463h
	ld a,00dh
l044eh:
	call 0d603h
	jr c,l0463h
	ex af,af'	
	ld a,(00035h)
	add a,001h
	cp 03eh
	jr z,l0465h
	and a	
	ld (00035h),a
	ex af,af'	
	ret	
l0463h:
	scf	
	ret	
l0465h:
	and a	
	call 0d994h
	jr c,l0491h
	push hl	
	push bc	
	push de	
	ld hl,0df9ch
	ld de,0eff6h
	ld bc,00008h
	ldir
	nop	
	rst 20h	
	ld bc,0b621h
	rst 18h	
	ld de,0eff6h
	ld bc,00008h
	ldir
	pop de	
	pop bc	
	pop hl	
	cp 04eh
	jr z,l0491h
	and a	
	ex af,af'	
	ret	
l0491h:
	ex af,af'	
	scf	
	ret	
	call 0d608h
	ld a,01bh
	call 0d603h
	jr c,l04b8h
	ld a,040h
	call 0d603h
	jr c,l04b8h
	ld a,01bh
	call 0d603h
	jr c,l04b8h
	ld a,06ch
	call 0d603h
	jr c,l04b8h
	ld a,008h
	call 0d603h
l04b8h:
	ret	
	nop	
	rst 20h	
	ld (bc),a	
	inc c	
	ex af,af'	
	ex af,af'	
	and b	
	ld hl,0efceh
	ld (0002bh),hl
	ld hl,0ddc0h
	ld de,0ec20h
	ld bc,00080h
	ldir
	ld hl,0de20h
	ld de,0efa0h
	ld bc,0003fh
	ldir
	ld hl,0efceh
	ld (0002bh),hl
	call 0d9e8h
	jp 0da4fh
	ld de,0dda7h
l04ebh:
	ld a,(hl)	
	ld (0001fh),a
	ld (hl),05fh
	ld (00000h),hl
	nop	
	rst 20h	
	ld bc,l03feh
	jp z,0d62eh
	cp 00dh
	jr z,l0545h
	cp 008h
	jr z,l052eh
	cp 009h
	jr z,l0529h
	cp 030h
	jr c,l0540h
	cp 03ah
	jr c,l051ah
	cp 041h
	jr c,l0540h
	res 5,a
	cp 047h
	jr nc,l0540h
l051ah:
	ld (hl),a	
	ld (de),a	
	push hl	
	ld hl,0ddach
	sbc hl,de
	pop hl	
	jr z,l0540h
	inc hl	
	inc de	
	jr l04ebh
l0529h:
	ld a,(0001fh)
	jr l051ah
l052eh:
	ld a,(0001fh)
	ld (hl),a	
	ld a,(hl)	
	push hl	
	ld hl,0dda7h
	sbc hl,de
	pop hl	
	jr z,l0540h
	dec hl	
	dec de	
	jr l04ebh
l0540h:
	call 0dd90h
	jr l04ebh
l0545h:
	ld a,000h
	ld (de),a	
	ld de,0dda7h
	nop	
	rst 20h	
	inc bc	
	ret	
	ld (0ddbah),hl
	push hl	
	ld hl,0ddb5h
	ld (0002bh),hl
	ld hl,(0ddbah)
	nop	
	rst 20h	
	rlca	
	ld hl,0ddb5h
	ld de,0ec65h
	ld bc,00004h
	ldir
	pop hl	
	ld hl,(0ddbah)
	ld de,000c0h
	add hl,de	
	ld (0ddbch),hl
	ld hl,0ec7bh
	ld (0002bh),hl
	ld hl,(0ddbch)
	dec hl	
	nop	
	rst 20h	
	rlca	
	ld bc,0eca0h
	ld (0001bh),bc
	ld bc,0efc0h
	ld (0001dh),bc
	nop	
	rst 20h	
	dec bc	
	nop	
	rst 20h	
	ld (bc),a	
	adc a,h	
	ld hl,0de20h
	ld de,0efa0h
	ld bc,00020h
	ldir
	ld de,(0ddbah)
l05a6h:
	ld b,008h
l05a8h:
	ld a,(de)	
	nop	
	rst 20h	
	ld b,000h
	rst 20h	
	ld c,013h
	djnz l05a8h
	ld b,008h
l05b4h:
	dec de	
	djnz l05b4h
	ld b,008h
l05b9h:
	ld a,(de)	
	cp 020h
	jr c,l05c4h
	cp 07fh
	jr nc,l05c4h
	jr l05c7h
l05c4h:
	ld a,02eh
	nop	
l05c7h:
	rst 20h	
	nop	
	inc de	
	djnz l05b9h
	ld hl,(0ddbch)
	and a	
	sbc hl,de
	jr nz,l05a6h
	push de	
	ld hl,0de20h
	ld de,0efa0h
	ld bc,00001h
	ldir
	ld hl,0efffh
	ld (0002bh),hl
	ld hl,0de5fh
	ld de,0efc0h
	ld bc,0003fh
	ldir
	ld bc,0ec00h
	ld (0001bh),bc
	ld bc,0f000h
	ld (0001dh),bc
	nop	
	rst 20h	
	dec bc	
	ld hl,0efceh
	ld (0002bh),hl
	nop	
l0609h:
	rst 20h	
	ld bc,0fed1h
	dec c	
	jr z,l0638h
	cp 003h
	jp z,0d62eh
	cp 008h
	jr z,l0629h
	cp 009h
	jr z,l0634h
	res 5,a
	cp 045h
	jr z,l063bh
	push de	
	call 0dd90h
	jr l0609h
l0629h:
	ex de,hl	
	ld bc,000c0h
	sbc hl,bc
	sbc hl,bc
	jp 0da4fh
l0634h:
	ex de,hl	
	jp 0da4fh
l0638h:
	jp 0d9bah
l063bh:
	ld hl,0de9fh
	ld de,0efc0h
	ld bc,0003fh
	ldir
	ld hl,0dedeh
	ld de,0ec34h
	ld bc,0000ch
	ldir
	ld hl,0ec65h
	ld de,0ec70h
	ld bc,00004h
	ldir
	ld de,00101h
	ld (0ddbeh),de
	ld de,00000h
	ld hl,0eca0h
	ld (0002bh),hl
	ld a,(hl)	
	cp 020h
	jr nz,l0674h
	inc hl	
	ld a,(hl)	
	inc e	
l0674h:
	push hl	
	push af	
	ld hl,0ddb0h
	ld (0002bh),hl
	ld hl,(0ddbah)
	add hl,de	
	nop	
	rst 20h	
	rlca	
	ld hl,0ddb0h
	push de	
	ld de,0ec70h
	ld bc,00004h
	ldir
	pop de	
	pop af	
	pop hl	
	ld (0001fh),a
	ld (hl),05fh
	ld (0002bh),hl
	nop	
l069bh:
	rst 20h	
	ld bc,02efeh
	jp z,0dcedh
	cp 003h
	jp z,0dd77h
	cp 00dh
	jp z,0dd53h
	cp 008h
	jp z,0dc70h
	cp 009h
	jp z,0dc38h
	cp 00bh
	jp z,0dc3fh
	cp 00ah
	jp z,0dc07h
	cp 030h
	jr c,l0702h
	cp 03ah
	jr c,l06d2h
	cp 041h
	jr c,l0702h
	res 5,a
	cp 047h
	jr nc,l0702h
l06d2h:
	ld (hl),a	
	inc hl	
	call 0dcb2h
l06d7h:
	push af	
	ld a,(0ddbeh)
	inc a	
	ld (0ddbeh),a
	cp 011h
	jr c,l06f5h
	ld a,001h
	ld b,009h
l06e7h:
	inc hl	
	djnz l06e7h
	inc e	
	ld (0ddbeh),a
	ld a,(0ddbfh)
	inc a	
	ld (0ddbfh),a
l06f5h:
	ld a,e	
	cp 0c0h
	jr nz,l06feh
	pop af	
	jp 0db5ch
l06feh:
	pop af	
	jp 0db6ch
l0702h:
	call 0dd90h
	jr l069bh
	ld a,(0001fh)
	ld (hl),a	
	push af	
	ld a,(0ddbfh)
	inc a	
	ld (0ddbfh),a
	cp 019h
	jr c,l072ah
	dec a	
	ld (0ddbfh),a
	push hl	
	call 0dd90h
	pop hl	
	ld b,020h
l0722h:
	dec hl	
	djnz l0722h
	ld b,008h
l0727h:
	dec e	
	djnz l0727h
l072ah:
	ld b,020h
l072ch:
	inc hl	
	djnz l072ch
	ld b,008h
l0731h:
	inc e	
	djnz l0731h
	pop af	
	jp 0db6ch
	ld a,(0001fh)
	ld (hl),a	
	inc hl	
	jr l06d7h
	ld a,(0001fh)
	ld (hl),a	
	push af	
	ld a,(0ddbfh)
	dec a	
	ld (0ddbfh),a
	cp 000h
	jr nz,l0762h
	inc a	
	ld (0ddbfh),a
	push hl	
	call 0dd90h
	pop hl	
	ld b,020h
l075ah:
	inc hl	
	djnz l075ah
	ld b,008h
l075fh:
	inc e	
	djnz l075fh
l0762h:
	ld b,020h
l0764h:
	dec hl	
	djnz l0764h
	ld b,008h
l0769h:
	dec e	
	djnz l0769h
	pop af	
	jp 0db6ch
	ld a,(0001fh)
	ld (hl),a	
	dec hl	
	push af	
	ld a,(0ddbeh)
	dec a	
	ld (0ddbeh),a
	cp 000h
	jr nz,l0793h
	ld a,010h
	ld b,009h
l0785h:
	dec hl	
	djnz l0785h
	dec e	
	ld (0ddbeh),a
	ld a,(0ddbfh)
	dec a	
	ld (0ddbfh),a
l0793h:
	ld a,e	
	cp 0ffh
	jr nz,l07a7h
	ld hl,0ef97h
	ld a,018h
	ld (0ddbfh),a
	ld a,010h
	ld (0ddbeh),a
	ld e,0c0h
l07a7h:
	pop af	
	ld a,(hl)	
	cp 020h
	jr nz,l07afh
	dec hl	
	dec e	
l07afh:
	jp 0db6ch
	push de	
	push af	
	push hl	
	ld hl,0deeah
	ld a,(0ddbeh)
	ld de,00000h
	ld e,a	
	add hl,de	
	ld a,(hl)	
	ld de,00000h
	ld e,a	
	pop hl	
	push hl	
	add hl,de	
	push hl	
	pop ix
	pop de	
	push de	
	dec de	
	ld a,(0ddbeh)
	bit 0,a
	jr nz,l07d7h
	dec de	
	nop	
l07d7h:
	rst 20h	
	inc bc	
	ld a,l	
	cp 020h
	jr c,l07e4h
	cp 07fh
	jr nc,l07e4h
	jr l07e6h
l07e4h:
	ld a,02eh
l07e6h:
	ld (ix+000h),a
	pop hl	
	pop af	
	pop de	
	ret	
	push af	
	ld a,(0ddbeh)
	bit 0,a
	jr z,l0847h
	ld a,(0001fh)
	ld (0ddafh),a
	pop af	
	ld (hl),a	
	inc hl	
	ld a,(hl)	
	ld (0001fh),a
	ld (hl),05fh
	ld (0002bh),hl
	nop	
l0808h:
	rst 20h	
	ld bc,l03feh
	jr z,l083bh
	cp 020h
	jr c,l084eh
	cp 07fh
	jr nc,l084eh
	push hl	
	ld hl,0ddadh
	ld (0002bh),hl
	nop	
	rst 20h	
	ld b,0e1h
	dec hl	
	ld a,(0ddadh)
	ld (hl),a	
	inc hl	
	ld a,(0ddaeh)
	ld (hl),a	
	call 0dcb2h
l082eh:
	inc hl	
	push af	
	ld a,(0ddbeh)
	inc a	
	ld (0ddbeh),a
	pop af	
	jp 0dbd7h
l083bh:
	dec hl	
	ld a,(0ddafh)
	ld (hl),a	
	inc hl	
	ld a,(0001fh)
	ld (hl),a	
	jr l082eh
l0847h:
	pop af	
	call 0dd90h
	jp 0db9bh
l084eh:
	call 0dd90h
	jr l0808h
	ld a,(0001fh)
	ld (hl),a	
	ld de,0eca0h
	ld ix,(0ddbah)
	ld b,018h
l0860h:
	push bc	
	ld b,008h
	nop	
l0864h:
	rst 20h	
	inc bc	
	ld a,l	
	ld (ix+000h),a
	inc ix
	inc de	
	djnz l0864h
	ld b,008h
l0871h:
	inc de	
	djnz l0871h
	pop bc	
	djnz l0860h
	ld hl,0ddd4h
	ld de,0ec34h
	ld bc,0000ch
	ldir
	ld hl,0ddcfh
	ld de,0ec70h
	ld bc,00005h
	ldir
	jp 0da52h
	ex af,af'	
	ld b,010h
l0893h:
	push bc	
	ld c,015h
	xor a	
l0897h:
	ld b,018h
l0899h:
	out (002h),a
	djnz l0899h
	xor 080h
	dec c	
	jr nz,l0897h
	pop bc	
	djnz l0893h
	ex af,af'	
	ret	
	jr nz,l08c9h
	jr nz,l08cbh
	jr nz,l08cdh
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	ld c,b	
	ld h,l	
	ld a,b	
	dec l	
	ld b,c	
	ld d,e	
	ld b,e	
	ld c,c	
	ld c,c	
l08c9h:
	dec l	
	ld b,h	
l08cbh:
	ld (hl),l	
	ld l,l	
l08cdh:
	ld (hl),b	
	jr nz,l08f0h
	jr nz,l08f2h
	jr nz,l08f4h
	ld b,c	
	ld l,(hl)	
	ld a,d	
	ld h,l	
	ld l,c	
	ld h,a	
	ld h,l	
	ld l,l	
	ld l,a	
	ld h,h	
	ld (hl),l	
	ld (hl),e	
	jr nz,l0902h
	jr nz,l0904h
	jr nz,$+34
	jr nz,$+34
	jr nz,$+34
	jr nz,l090ch
	jr nz,l090eh
	jr nz,$+34
l08f0h:
	jr nz,l0912h
l08f2h:
	jr nz,l0914h
l08f4h:
	jr nz,l0916h
	jr nz,l0918h
	jr nz,l091ah
	jr nz,$+34
	jr nz,$+34
	jr nz,$+34
	ld b,c	
	ld b,c	
l0902h:
	ld h,h	
	ld (hl),d	
l0904h:
	ld a,(02020h)
	jr nz,l0929h
	jr nz,$+69
	ld (hl),l	
l090ch:
	ld b,c	
	ld h,h	
l090eh:
	ld (hl),d	
	ld a,(02020h)
l0912h:
	jr nz,l0934h
l0914h:
	jr nz,l0936h
l0916h:
	ld b,l	
	ld b,c	
l0918h:
	ld h,h	
	ld (hl),d	
l091ah:
	ld a,(02020h)
	jr nz,l093fh
	jr nz,$+47
	dec l	
	dec l	
	dec l	
	dec l	
	dec l	
	dec l	
	dec l	
	dec l	
l0929h:
	dec l	
	dec l	
	dec l	
	dec l	
	dec l	
	dec l	
	dec l	
	dec l	
	dec l	
	dec l	
	dec l	
l0934h:
	dec l	
	dec l	
l0936h:
	dec l	
	dec l	
	dec l	
	dec l	
	dec l	
	dec l	
	dec l	
	dec l	
	dec l	
l093fh:
	dec l	
	ld b,c	
	ld b,c	
	ld h,h	
	ld (hl),d	
	jr nz,l09abh
	ld l,c	
	ld l,(hl)	
	ld h,a	
	ld h,l	
	ld h,d	
	ld h,l	
	ld l,(hl)	
	jr nz,l096fh
	jr nz,l0971h
	jr nz,l0973h
	jr nz,l0975h
	jr nz,l0977h
	jr nz,l099eh
	ld l,(hl)	
	ld h,h	
	ld h,l	
	jr nz,l09bch
	ld b,e	
	ld h,d	
	ld l,h	
	ld h,c	
	ld h,l	
	ld (hl),h	
	ld (hl),h	
	ld h,l	
	ld (hl),d	
	ld l,(hl)	
	jr nz,l09e0h
	ld l,a	
	ld (hl),d	
	ld (hl),a	
	ld l,03ah
l096fh:
	jr nz,l099eh
l0971h:
	ld a,020h
l0973h:
	jr nz,l09e7h
l0975h:
	ld (hl),l	
	ld h,l	
l0977h:
	ld h,e	
	ld l,e	
	ld (hl),a	
	ld l,03ah
	jr nz,l09bah
	dec l	
	ld b,l	
	ld h,h	
	ld l,c	
	ld (hl),h	
	ld l,03ah
	ld b,l	
	jr nz,l09a8h
	ld l,(hl)	
	ld h,l	
	ld (hl),l	
	ld h,l	
	jr nz,l09cfh
	ld b,c	
	ld h,h	
	ld (hl),d	
	ld a,(05243h)
	jr nz,l09b6h
	jr nz,$+71
	ld l,(hl)	
	ld h,h	
	ld h,l	
	ld a,(0435eh)
l099eh:
	jr nz,l09e5h
	ld l,c	
	ld l,(hl)	
	ld h,a	
	ld a,(04320h)
	ld (hl),l	
	ld (hl),d	
l09a8h:
	ld (hl),e	
	ld l,02dh
l09abh:
	ld d,h	
	inc l	
	jr nz,l09dfh
	dec l	
	add hl,sp	
	inc l	
	ld b,c	
	dec l	
	ld b,(hl)	
	inc l	
l09b6h:
	jr nz,l09e6h
	jr z,l09fbh
l09bah:
	ld d,e	
	ld b,e	
l09bch:
	ld c,c	
	ld c,c	
	add hl,hl	
	ld a,d	
	ld (hl),l	
	ld (hl),d	
	ld (hl),l	
	ld h,l	
	ld h,e	
	ld l,e	
	ld (hl),e	
	ld h,e	
	ld l,b	
	ld (hl),d	
	ld h,l	
	ld l,c	
	ld h,d	
	ld h,l	
	ld l,(hl)	
l09cfh:
	ld a,(05243h)
	jr nz,l09f4h
	ld b,c	
	ld h,d	
	ld h,d	
	ld (hl),d	
	ld (hl),l	
	ld h,e	
	ld l,b	
	ld a,(0435eh)
	ld b,l	
l09dfh:
	ld h,h	
l09e0h:
	ld l,c	
	ld (hl),h	
	ld l,c	
	ld h,l	
	ld (hl),d	
l09e5h:
	ld l,l	
l09e6h:
	ld l,a	
l09e7h:
	ld h,h	
	ld (hl),l	
	ld (hl),e	
	nop	
	rla	
	ld d,015h
	inc d	
	inc de	
	ld (de),a	
	ld de,00f10h
l09f4h:
	ld c,00dh
	inc c	
	dec bc	
	ld a,(bc)	
	add hl,bc	
	ex af,af'	
l09fbh:
	dec l	
	ld a,073h
	ld h,l	
	ld (hl),d	
	halt	
	ld l,c	
	ld h,e	
	ld h,l	
	dec l	
	ld (hl),b	
	ld (hl),d	
	ld l,a	
	ld h,a	
	ld (hl),d	
	ld h,c	
	ld l,l	
	jr nz,l0a74h
	ld (hl),l	
	ld h,l	
	ld (hl),d	
	jr nz,l0a6dh
	ld sp,03130h
	inc sp	
	ld h,h	
	ld l,c	
	ld (hl),e	
	ld (hl),b	
	ld l,h	
	ld h,c	
	ld a,c	
	ld (hl),b	
	ld (hl),d	
	ld l,c	
	ld l,(hl)	
	ld (hl),h	
	ld h,d	
	ld a,c	
	ld h,l	
	ld b,c	
	ld (hl),l	
	ld (hl),e	
	ld (hl),a	
	ld h,c	
	ld l,b	
	ld l,h	
	jr nz,$+111
	ld l,c	
	ld (hl),h	
	jr nz,l0a97h
	ld h,l	
	ld l,(hl)	
	jr nz,l0a7ah
	ld (hl),l	
	ld (hl),d	
	ld (hl),e	
	ld l,a	
	ld (hl),d	
	ld (hl),h	
	ld h,c	
	ld (hl),e	
	ld (hl),h	
	ld h,l	
	ld l,(hl)	
	jr nz,l0a64h
	jr nz,l0a66h
	ld l,b	
	ld l,a	
	ld h,e	
	ld l,b	
	jr nz,l0aaeh
	ld a,d	
	ld (hl),a	
	ld l,072h
	ld (hl),l	
	ld l,(hl)	
	ld (hl),h	
	ld h,l	
	ld (hl),d	
	jr nz,l0acch
	ld l,(hl)	
	ld h,h	
	jr nz,l0a9eh
	ld d,d	
	jr nz,l0a86h
	ld b,l	
	ld c,(hl)	
	ld d,h	
	add hl,hl	
	jr nz,l0a84h
l0a64h:
	jr nz,l0aaah
l0a66h:
	ld (hl),d	
	ld (hl),l	
	ld h,e	
	ld l,e	
	ld l,l	
	ld l,a	
	ld h,h	
l0a6dh:
	ld (hl),l	
	ld (hl),e	
	ld d,e	
	ld (hl),h	
	ld h,c	
	ld (hl),d	
	ld (hl),h	
l0a74h:
	jr nz,l0abah
	ld (hl),d	
	ld (hl),l	
	ld h,e	
	ld l,e	
l0a7ah:
	jr nz,l0aa4h
	ld e,c	
	cpl	
	ld c,(hl)	
	add hl,hl	
	jr nz,l0ac1h
	ld h,(hl)	
	ld l,c	
l0a84h:
	ld l,h	
	ld h,l	
l0a86h:
	ld l,(hl)	
	ld h,c	
	ld l,l	
	ld h,l	
	ld a,(02020h)
	jr nz,$+34
	jr nz,l0ab1h
	jr nz,l0ab3h
	jr nz,l0ab5h
	jr nz,$+34
l0a97h:
	jr nz,$+34
	jr nz,$+34
	jr nz,$+105
	ld l,a	
l0a9eh:
	jr nz,$+91
	cpl	
	ld c,(hl)	
	jr nz,$+65
l0aa4h:
	ld (hl),b	
	ld (hl),d	
	ld l,c	
	ld l,(hl)	
	ld (hl),h	
	ld h,l	
l0aaah:
	ld (hl),d	
	jr nz,$+107
	ld (hl),e	
l0aaeh:
	jr nz,$+121
	ld l,a	
l0ab1h:
	ld (hl),d	
	ld l,e	
l0ab3h:
	ld l,c	
	ld l,(hl)	
l0ab5h:
	ld h,a	
	jr nz,l0ad8h
	jr nz,l0adah
l0abah:
	jr nz,l0adch
	jr nz,l0adeh
	push af	
	push hl	
	push bc	
l0ac1h:
	ld l,a	
	ld a,0cfh
	out (035h),a
	ld a,0feh
	out (035h),a
l0acah:
	rst 20h	
	inc b	
l0acch:
	cp 003h
	jr z,l0af3h
	in a,(034h)
	and 008h
	jr nz,l0acah
	ld b,00ah
l0ad8h:
	ld h,0ffh
l0adah:
	sla l
l0adch:
	rl h
l0adeh:
	di	
l0adfh:
	ld a,l	
	out (034h),a
	srl h
	rr l
	ld c,00ah
l0ae8h:
	dec c	
	jr nz,l0ae8h
	djnz l0adfh
	ei	
	and a	
	pop bc	
	pop hl	
	pop af	
	ret	
l0af3h:
	pop bc	
	pop hl	
	pop af	
	scf	
	ret	
	ld e,06bh
	nop	
	nop	
	nop	
	nop	
l0afeh:
	nop	
	nop	
