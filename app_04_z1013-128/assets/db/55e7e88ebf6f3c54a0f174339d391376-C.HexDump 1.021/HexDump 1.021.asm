; z80dasm 1.1.4
; command line: z80dasm -b block.hex -S sym.hex -vvv -g 0xd600 -l -o HexDump 1.021.asm HexDump 1.021.hex

	org	0d600h
EADR_PLUS_1:	equ 0xdff9

AADR:
SADR:

; BLOCK 'ENTRY' (start 0xd600 end 0xd603)
ENTRY_start:
	jp lxxxxh
ENTRY_end:
	and a	
	jp lxxxxh
	ret	
sub_xxxxh:
	jp 0ffebh
	ret	
	jr z,lxxxxh
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
lxxxxh:
	rst 20h	
	ld (bc),a	
	inc c	
	ex af,af'	
	ex af,af'	
	and b	
	ld hl,lxxxxh
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
lxxxxh:
	ld (de),a	
	inc de	
	djnz lxxxxh
	ld hl,lxxxxh
	ld de,0ed8dh
	ld bc,00007h
	ldir
	ld hl,lxxxxh
	ld de,0edcdh
	ld bc,00005h
	ldir
	ld hl,lxxxxh
	ld de,0ee0dh
	ld bc,00003h
	ldir
	ld de,0ef62h
	ld a,02ah
	ld b,01ch
lxxxxh:
	ld (de),a	
	inc de	
	djnz lxxxxh
	ld hl,lxxxxh
	ld de,0efa2h
	ld bc,0003ch
	ldir
lxxxxh:
	ld hl,lxxxxh
	ld de,0ed8ah
	ld bc,00002h
	ldir
	ld a,001h
	ld (lxxxxh),a
	nop	
lxxxxh:
	rst 20h	
	ld bc,00afeh
	jr z,lxxxxh
	cp 00bh
	jr z,lxxxxh
	cp 00dh
	jp z,lxxxxh
	call sub_xxxxh
	jr lxxxxh
lxxxxh:
	ld a,(lxxxxh)
	ld hl,0ed8ah
	ld de,00040h
	push hl	
	push de	
	cp 001h
	jr nz,lxxxxh
	inc a	
	ld (lxxxxh),a
	ld de,0ed8ah
	call sub_xxxxh
	jr lxxxxh
lxxxxh:
	cp 002h
	jr nz,lxxxxh
	inc a	
	ld (lxxxxh),a
	ld de,0edcah
	call sub_xxxxh
	pop de	
	pop hl	
	add hl,de	
	push hl	
	push de	
	jr lxxxxh
lxxxxh:
	ld de,0ee0ah
	call sub_xxxxh
	pop de	
	pop hl	
	jr lxxxxh
lxxxxh:
	pop de	
	pop hl	
	add hl,de	
	ex de,hl	
	ld hl,lxxxxh
	ld bc,00002h
	ldir
	jr lxxxxh
sub_xxxxh:
	ld hl,lxxxxh
	ld bc,00002h
	ldir
	ret	
lxxxxh:
	ld a,(lxxxxh)
	ld hl,0ee0ah
	ld de,00040h
	push hl	
	push de	
	cp 003h
	jr nz,lxxxxh
	dec a	
	ld (lxxxxh),a
	ld de,0ee0ah
	call sub_xxxxh
	jr lxxxxh
lxxxxh:
	cp 002h
	jr nz,lxxxxh
	dec a	
	ld (lxxxxh),a
	ld de,0edcah
	call sub_xxxxh
	pop de	
	pop hl	
	sbc hl,de
	push hl	
	push de	
	jr lxxxxh
lxxxxh:
	ld a,003h
	ld (lxxxxh),a
	ld de,0ed8ah
	call sub_xxxxh
	pop de	
	pop hl	
	jr lxxxxh
lxxxxh:
	pop de	
	pop hl	
	sbc hl,de
lxxxxh:
	ex de,hl	
	ld hl,lxxxxh
	ld bc,00002h
	ldir
	jp lxxxxh
lxxxxh:
	ld a,(lxxxxh)
	cp 001h
	jp z,lxxxxh
	cp 002h
	jr z,lxxxxh
	cp 003h
	jr lxxxxh
	call sub_xxxxh
	jp lxxxxh
lxxxxh:
	ld a,00ch
	nop	
	rst 20h	
	nop	
	jp 00038h
lxxxxh:
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
	ld hl,lxxxxh
	ld de,0ec20h
	ld bc,0000eh
	ldir
	ld hl,lxxxxh
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
	ld hl,lxxxxh
	ld de,0efb5h
	ld bc,0000ah
	ldir
	ld hl,0efaeh
	ld (0002bh),hl
	call sub_xxxxh
	ld (0001bh),hl
	ld hl,lxxxxh
	ld de,0efc0h
	ld bc,00004h
	ldir
	ld hl,lxxxxh
	ld de,0efc4h
	ld bc,00009h
	ldir
	ld hl,0efceh
	ld (0002bh),hl
	call sub_xxxxh
	ld (lxxxxh),hl
	ld hl,0ed2fh
	ld (0002bh),hl
	ld de,(lxxxxh)
	ld hl,(0001bh)
	ld (lxxxxh),hl
	ex de,hl	
	scf	
	sbc hl,de
	jp c,lxxxxh
	ld de,00011h
	ld hl,(lxxxxh)
	add hl,de	
	ld (lxxxxh),hl
	ld hl,lxxxxh
	ld de,0ed20h
	ld bc,0000ah
	ldir
	nop	
lxxxxh:
	rst 20h	
	ld bc,0e700h
	nop	
	cp 003h
	jp z,lxxxxh
	cp 00dh
	jr z,lxxxxh
	jr lxxxxh
lxxxxh:
	ld hl,0ed2fh
	ld de,0df8ch
	ld bc,00010h
	ldir
	ld hl,0ed93h
	ld (0002bh),hl
	ld hl,lxxxxh
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
	jp nz,lxxxxh
	push de	
	push hl	
	push bc	
	ld hl,lxxxxh
	ld de,0efe0h
	ld bc,00012h
	ldir
	pop bc	
	pop hl	
	pop de	
	ld de,(lxxxxh)
	ld a,00ch
	nop	
	rst 20h	
	nop	
	call sub_xxxxh
	jp c,lxxxxh
	ld a,01eh
	call sub_xxxxh
	jp c,00084h
	nop	
	rst 20h	
	nop	
	ld b,01ah
	ld hl,lxxxxh
lxxxxh:
	ld a,(hl)	
	call ENTRY_end
	jr c,lxxxxh
	nop	
	rst 20h	
	nop	
	inc hl	
	djnz lxxxxh
	ld a,01eh
	call sub_xxxxh
	jr c,lxxxxh
	nop	
	rst 20h	
	nop	
	ld hl,(lxxxxh)
lxxxxh:
	ld a,01eh
	call sub_xxxxh
	jr c,lxxxxh
	nop	
	rst 20h	
	nop	
	call sub_xxxxh
	jr c,lxxxxh
	ld b,010h
lxxxxh:
	ld a,020h
	nop	
	rst 20h	
	nop	
	call ENTRY_end
	jr c,lxxxxh
	ld a,(hl)	
	call sub_xxxxh
	jr c,lxxxxh
	inc hl	
	djnz lxxxxh
	ld b,010h
lxxxxh:
	dec hl	
	djnz lxxxxh
	ld b,010h
	ld a,020h
	call ENTRY_end
	jr c,lxxxxh
	nop	
	rst 20h	
	nop	
lxxxxh:
	ld a,(hl)	
	cp 020h
	jr c,lxxxxh
	cp 07fh
	jr nc,lxxxxh
	jr lxxxxh
lxxxxh:
	and a	
	ld a,02eh
lxxxxh:
	call ENTRY_end
	jr c,lxxxxh
	nop	
	rst 20h	
	nop	
	inc hl	
	djnz lxxxxh
	push de	
	ex de,hl	
	scf	
	sbc hl,de
	ex de,hl	
	pop de	
	jr nc,lxxxxh
	call sub_xxxxh
	jp lxxxxh
lxxxxh:
	call sub_xxxxh
lxxxxh:
	jp lxxxxh
sub_xxxxh:
	push af	
	ld a,h	
	and a	
	call sub_xxxxh
	jr c,lxxxxh
	ld a,l	
	and a	
	call sub_xxxxh
	pop af	
	ret	
sub_xxxxh:
	push af	
	rra	
	rra	
	rra	
	rra	
	call sub_xxxxh
	jr c,lxxxxh
	pop af	
sub_xxxxh:
	push af	
	and 00fh
	add a,030h
	cp 03ah
	jr c,lxxxxh
	add a,007h
lxxxxh:
	and a	
	call ENTRY_end
	jr c,lxxxxh
	nop	
	rst 20h	
	nop	
	pop af	
	and a	
	ret	
lxxxxh:
	pop af	
	scf	
	ret	
sub_xxxxh:
	cp 01eh
	jr nz,lxxxxh
	ld a,00ah
	call ENTRY_end
	jr c,lxxxxh
	ld a,00dh
lxxxxh:
	call ENTRY_end
	jr c,lxxxxh
	ex af,af'	
	ld a,(00035h)
	add a,001h
	cp 03eh
	jr z,lxxxxh
	and a	
	ld (00035h),a
	ex af,af'	
	ret	
lxxxxh:
	scf	
	ret	
lxxxxh:
	and a	
	call sub_xxxxh
	jr c,lxxxxh
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
	jr z,lxxxxh
	and a	
	ex af,af'	
	ret	
lxxxxh:
	ex af,af'	
	scf	
	ret	
sub_xxxxh:
	call sub_xxxxh
	ld a,01bh
	call ENTRY_end
	jr c,lxxxxh
	ld a,040h
	call ENTRY_end
	jr c,lxxxxh
	ld a,01bh
	call ENTRY_end
	jr c,lxxxxh
	ld a,06ch
	call ENTRY_end
	jr c,lxxxxh
	ld a,008h
	call ENTRY_end
lxxxxh:
	ret	
	nop	
lxxxxh:
	rst 20h	
	ld (bc),a	
	inc c	
	ex af,af'	
	ex af,af'	
	and b	
	ld hl,0efceh
	ld (0002bh),hl
	ld hl,lxxxxh
	ld de,0ec20h
	ld bc,00080h
	ldir
	ld hl,0de20h
	ld de,0efa0h
	ld bc,0003fh
	ldir
	ld hl,0efceh
	ld (0002bh),hl
	call sub_xxxxh
	jp lxxxxh
sub_xxxxh:
	ld de,lxxxxh
lxxxxh:
	ld a,(hl)	
	ld (0001fh),a
	ld (hl),05fh
	ld (00000h),hl
	nop	
	rst 20h	
	ld bc,003feh
	jp z,lxxxxh
	cp 00dh
	jr z,lxxxxh
	cp 008h
	jr z,lxxxxh
	cp 009h
	jr z,lxxxxh
	cp 030h
	jr c,lxxxxh
	cp 03ah
	jr c,lxxxxh
	cp 041h
	jr c,lxxxxh
	res 5,a
	cp 047h
	jr nc,lxxxxh
lxxxxh:
	ld (hl),a	
	ld (de),a	
	push hl	
	ld hl,0ddach
	sbc hl,de
	pop hl	
	jr z,lxxxxh
	inc hl	
	inc de	
	jr lxxxxh
lxxxxh:
	ld a,(0001fh)
	jr lxxxxh
lxxxxh:
	ld a,(0001fh)
	ld (hl),a	
	ld a,(hl)	
	push hl	
	ld hl,lxxxxh
	sbc hl,de
	pop hl	
	jr z,lxxxxh
	dec hl	
	dec de	
	jr lxxxxh
lxxxxh:
	call sub_xxxxh
	jr lxxxxh
lxxxxh:
	ld a,000h
	ld (de),a	
	ld de,lxxxxh
	nop	
	rst 20h	
	inc bc	
	ret	
lxxxxh:
	ld (lxxxxh),hl
lxxxxh:
	push hl	
	ld hl,lxxxxh
	ld (0002bh),hl
	ld hl,(lxxxxh)
	nop	
	rst 20h	
	rlca	
	ld hl,lxxxxh
	ld de,0ec65h
	ld bc,00004h
	ldir
	pop hl	
	ld hl,(lxxxxh)
	ld de,000c0h
	add hl,de	
	ld (lxxxxh),hl
	ld hl,0ec7bh
	ld (0002bh),hl
	ld hl,(lxxxxh)
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
	ld de,(lxxxxh)
lxxxxh:
	ld b,008h
lxxxxh:
	ld a,(de)	
	nop	
	rst 20h	
	ld b,000h
	rst 20h	
	ld c,013h
	djnz lxxxxh
	ld b,008h
lxxxxh:
	dec de	
	djnz lxxxxh
	ld b,008h
lxxxxh:
	ld a,(de)	
	cp 020h
	jr c,lxxxxh
	cp 07fh
	jr nc,lxxxxh
	jr lxxxxh
lxxxxh:
	ld a,02eh
	nop	
lxxxxh:
	rst 20h	
	nop	
	inc de	
	djnz lxxxxh
	ld hl,(lxxxxh)
	and a	
	sbc hl,de
	jr nz,lxxxxh
	push de	
	ld hl,0de20h
	ld de,0efa0h
	ld bc,00001h
	ldir
	ld hl,0efffh
	ld (0002bh),hl
	ld hl,lxxxxh
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
lxxxxh:
	rst 20h	
	ld bc,0fed1h
	dec c	
	jr z,lxxxxh
	cp 003h
	jp z,lxxxxh
	cp 008h
	jr z,lxxxxh
	cp 009h
	jr z,lxxxxh
	res 5,a
	cp 045h
	jr z,lxxxxh
	push de	
	call sub_xxxxh
	jr lxxxxh
lxxxxh:
	ex de,hl	
	ld bc,000c0h
	sbc hl,bc
	sbc hl,bc
	jp lxxxxh
lxxxxh:
	ex de,hl	
	jp lxxxxh
lxxxxh:
	jp lxxxxh
lxxxxh:
	ld hl,lxxxxh+1
	ld de,0efc0h
	ld bc,0003fh
	ldir
	ld hl,lxxxxh
	ld de,0ec34h
	ld bc,0000ch
	ldir
	ld hl,0ec65h
	ld de,0ec70h
	ld bc,00004h
	ldir
lxxxxh:
	ld de,00101h
	ld (lxxxxh),de
	ld de,00000h
	ld hl,0eca0h
	ld (0002bh),hl
lxxxxh:
	ld a,(hl)	
	cp 020h
	jr nz,lxxxxh
	inc hl	
	ld a,(hl)	
	inc e	
lxxxxh:
	push hl	
	push af	
	ld hl,lxxxxh
	ld (0002bh),hl
	ld hl,(lxxxxh)
	add hl,de	
	nop	
	rst 20h	
	rlca	
	ld hl,lxxxxh
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
lxxxxh:
	rst 20h	
	ld bc,02efeh
	jp z,lxxxxh
	cp 003h
	jp z,lxxxxh
	cp 00dh
	jp z,lxxxxh
	cp 008h
	jp z,lxxxxh
	cp 009h
	jp z,lxxxxh
	cp 00bh
	jp z,lxxxxh
	cp 00ah
	jp z,lxxxxh
	cp 030h
	jr c,lxxxxh
	cp 03ah
	jr c,lxxxxh
	cp 041h
	jr c,lxxxxh
	res 5,a
	cp 047h
	jr nc,lxxxxh
lxxxxh:
	ld (hl),a	
	inc hl	
	call sub_xxxxh
lxxxxh:
	push af	
	ld a,(lxxxxh)
	inc a	
	ld (lxxxxh),a
	cp 011h
	jr c,lxxxxh
	ld a,001h
	ld b,009h
lxxxxh:
	inc hl	
	djnz lxxxxh
	inc e	
	ld (lxxxxh),a
	ld a,(lxxxxh)
	inc a	
	ld (lxxxxh),a
lxxxxh:
	ld a,e	
	cp 0c0h
	jr nz,lxxxxh
	pop af	
	jp lxxxxh
lxxxxh:
	pop af	
	jp lxxxxh
lxxxxh:
	call sub_xxxxh
	jr lxxxxh
lxxxxh:
	ld a,(0001fh)
	ld (hl),a	
	push af	
	ld a,(lxxxxh)
	inc a	
	ld (lxxxxh),a
	cp 019h
	jr c,lxxxxh
	dec a	
	ld (lxxxxh),a
	push hl	
	call sub_xxxxh
	pop hl	
	ld b,020h
lxxxxh:
	dec hl	
	djnz lxxxxh
	ld b,008h
lxxxxh:
	dec e	
	djnz lxxxxh
lxxxxh:
	ld b,020h
lxxxxh:
	inc hl	
	djnz lxxxxh
	ld b,008h
lxxxxh:
	inc e	
	djnz lxxxxh
	pop af	
	jp lxxxxh
lxxxxh:
	ld a,(0001fh)
	ld (hl),a	
	inc hl	
	jr lxxxxh
lxxxxh:
	ld a,(0001fh)
	ld (hl),a	
	push af	
	ld a,(lxxxxh)
	dec a	
	ld (lxxxxh),a
	cp 000h
	jr nz,lxxxxh
	inc a	
	ld (lxxxxh),a
	push hl	
	call sub_xxxxh
	pop hl	
	ld b,020h
lxxxxh:
	inc hl	
	djnz lxxxxh
	ld b,008h
lxxxxh:
	inc e	
	djnz lxxxxh
lxxxxh:
	ld b,020h
lxxxxh:
	dec hl	
	djnz lxxxxh
	ld b,008h
lxxxxh:
	dec e	
	djnz lxxxxh
	pop af	
	jp lxxxxh
lxxxxh:
	ld a,(0001fh)
	ld (hl),a	
	dec hl	
	push af	
	ld a,(lxxxxh)
	dec a	
	ld (lxxxxh),a
	cp 000h
	jr nz,lxxxxh
	ld a,010h
	ld b,009h
lxxxxh:
	dec hl	
	djnz lxxxxh
	dec e	
	ld (lxxxxh),a
	ld a,(lxxxxh)
	dec a	
	ld (lxxxxh),a
lxxxxh:
	ld a,e	
	cp 0ffh
	jr nz,lxxxxh
	ld hl,0ef97h
	ld a,018h
	ld (lxxxxh),a
	ld a,010h
	ld (lxxxxh),a
	ld e,0c0h
lxxxxh:
	pop af	
	ld a,(hl)	
	cp 020h
	jr nz,lxxxxh
	dec hl	
	dec e	
lxxxxh:
	jp lxxxxh
sub_xxxxh:
	push de	
	push af	
	push hl	
	ld hl,lxxxxh
	ld a,(lxxxxh)
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
	ld a,(lxxxxh)
	bit 0,a
	jr nz,lxxxxh
	dec de	
	nop	
lxxxxh:
	rst 20h	
	inc bc	
	ld a,l	
	cp 020h
	jr c,lxxxxh
	cp 07fh
	jr nc,lxxxxh
	jr lxxxxh
lxxxxh:
	ld a,02eh
lxxxxh:
	ld (ix+000h),a
	pop hl	
	pop af	
	pop de	
	ret	
lxxxxh:
	push af	
	ld a,(lxxxxh)
	bit 0,a
	jr z,lxxxxh
	ld a,(0001fh)
	ld (lxxxxh),a
	pop af	
	ld (hl),a	
	inc hl	
	ld a,(hl)	
	ld (0001fh),a
	ld (hl),05fh
	ld (0002bh),hl
	nop	
lxxxxh:
	rst 20h	
	ld bc,003feh
	jr z,lxxxxh
	cp 020h
	jr c,lxxxxh
	cp 07fh
	jr nc,lxxxxh
	push hl	
	ld hl,lxxxxh
	ld (0002bh),hl
	nop	
	rst 20h	
	ld b,0e1h
	dec hl	
	ld a,(lxxxxh)
	ld (hl),a	
	inc hl	
	ld a,(lxxxxh)
	ld (hl),a	
	call sub_xxxxh
lxxxxh:
	inc hl	
	push af	
	ld a,(lxxxxh)
	inc a	
	ld (lxxxxh),a
	pop af	
	jp lxxxxh
lxxxxh:
	dec hl	
	ld a,(lxxxxh)
	ld (hl),a	
	inc hl	
	ld a,(0001fh)
	ld (hl),a	
	jr lxxxxh
lxxxxh:
	pop af	
	call sub_xxxxh
	jp lxxxxh
lxxxxh:
	call sub_xxxxh
	jr lxxxxh
lxxxxh:
	ld a,(0001fh)
	ld (hl),a	
	ld de,0eca0h
	ld ix,(lxxxxh)
	ld b,018h
lxxxxh:
	push bc	
	ld b,008h
	nop	
lxxxxh:
	rst 20h	
	inc bc	
	ld a,l	
	ld (ix+000h),a
	inc ix
	inc de	
	djnz lxxxxh
	ld b,008h
lxxxxh:
	inc de	
	djnz lxxxxh
	pop bc	
	djnz lxxxxh
lxxxxh:
	ld hl,lxxxxh
	ld de,0ec34h
	ld bc,0000ch
	ldir
	ld hl,lxxxxh+1
	ld de,0ec70h
	ld bc,00005h
	ldir
	jp lxxxxh
sub_xxxxh:
	ex af,af'	
	ld b,010h
lxxxxh:
	push bc	
	ld c,015h
	xor a	
lxxxxh:
	ld b,018h
lxxxxh:
	out (002h),a
	djnz lxxxxh
	xor 080h
	dec c	
	jr nz,lxxxxh
	pop bc	
	djnz lxxxxh
	ex af,af'	
	ret	
lxxxxh:
	jr nz,lxxxxh
lxxxxh:
	jr nz,lxxxxh
	jr nz,lxxxxh
lxxxxh:
	nop	
lxxxxh:
	nop	
lxxxxh:
	nop	
lxxxxh:
	nop	
	nop	
	nop	
	nop	
	nop	
lxxxxh:
	nop	
	nop	
	nop	
	nop	
	nop	
lxxxxh:
	nop	
	nop	
lxxxxh:
	nop	
	nop	
lxxxxh:
	nop	
lxxxxh:
	nop	
lxxxxh:
	ld c,b	
	ld h,l	
	ld a,b	
	dec l	
	ld b,c	
	ld d,e	
	ld b,e	
	ld c,c	
	ld c,c	
lxxxxh:
	dec l	
	ld b,h	
lxxxxh:
	ld (hl),l	
	ld l,l	
lxxxxh:
	ld (hl),b	
lxxxxh:
	jr nz,lxxxxh
	jr nz,lxxxxh
	jr nz,lxxxxh
lxxxxh:
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
	jr nz,lxxxxh
	jr nz,lxxxxh
	jr nz,$+34
	jr nz,$+34
	jr nz,$+34
	jr nz,lxxxxh
	jr nz,lxxxxh
	jr nz,$+34
lxxxxh:
	jr nz,lxxxxh
lxxxxh:
	jr nz,lxxxxh
lxxxxh:
	jr nz,lxxxxh
	jr nz,lxxxxh
	jr nz,lxxxxh
	jr nz,$+34
	jr nz,$+34
	jr nz,$+34
	ld b,c	
	ld b,c	
lxxxxh:
	ld h,h	
	ld (hl),d	
lxxxxh:
	ld a,(02020h)
	jr nz,lxxxxh
	jr nz,$+69
	ld (hl),l	
lxxxxh:
	ld b,c	
	ld h,h	
lxxxxh:
	ld (hl),d	
	ld a,(02020h)
lxxxxh:
	jr nz,lxxxxh
lxxxxh:
	jr nz,lxxxxh
lxxxxh:
	ld b,l	
	ld b,c	
lxxxxh:
	ld h,h	
	ld (hl),d	
lxxxxh:
	ld a,(02020h)
	jr nz,lxxxxh
	jr nz,$+47
	dec l	
	dec l	
	dec l	
	dec l	
	dec l	
	dec l	
	dec l	
	dec l	
lxxxxh:
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
lxxxxh:
	dec l	
	dec l	
lxxxxh:
	dec l	
	dec l	
	dec l	
	dec l	
	dec l	
	dec l	
	dec l	
	dec l	
	dec l	
lxxxxh:
	dec l	
	ld b,c	
	ld b,c	
	ld h,h	
	ld (hl),d	
lxxxxh:
	jr nz,lxxxxh
	ld l,c	
	ld l,(hl)	
	ld h,a	
	ld h,l	
	ld h,d	
	ld h,l	
	ld l,(hl)	
	jr nz,lxxxxh
	jr nz,lxxxxh
	jr nz,lxxxxh
	jr nz,lxxxxh
	jr nz,lxxxxh
	jr nz,lxxxxh
	ld l,(hl)	
	ld h,h	
	ld h,l	
	jr nz,lxxxxh
	ld b,e	
lxxxxh:
	ld h,d	
	ld l,h	
	ld h,c	
	ld h,l	
	ld (hl),h	
	ld (hl),h	
	ld h,l	
	ld (hl),d	
	ld l,(hl)	
	jr nz,lxxxxh
	ld l,a	
	ld (hl),d	
	ld (hl),a	
	ld l,03ah
lxxxxh:
	jr nz,lxxxxh
lxxxxh:
	ld a,020h
lxxxxh:
	jr nz,lxxxxh
lxxxxh:
	ld (hl),l	
	ld h,l	
lxxxxh:
	ld h,e	
	ld l,e	
	ld (hl),a	
	ld l,03ah
	jr nz,lxxxxh
	dec l	
	ld b,l	
	ld h,h	
	ld l,c	
	ld (hl),h	
	ld l,03ah
	ld b,l	
	jr nz,lxxxxh
	ld l,(hl)	
	ld h,l	
	ld (hl),l	
	ld h,l	
	jr nz,lxxxxh
	ld b,c	
	ld h,h	
	ld (hl),d	
	ld a,(05243h)
	jr nz,lxxxxh
	jr nz,$+71
	ld l,(hl)	
	ld h,h	
	ld h,l	
	ld a,(0435eh)
lxxxxh:
	jr nz,lxxxxh
	ld l,c	
	ld l,(hl)	
	ld h,a	
	ld a,(04320h)
	ld (hl),l	
	ld (hl),d	
lxxxxh:
	ld (hl),e	
	ld l,02dh
lxxxxh:
	ld d,h	
	inc l	
	jr nz,lxxxxh
	dec l	
	add hl,sp	
	inc l	
	ld b,c	
	dec l	
	ld b,(hl)	
	inc l	
lxxxxh:
	jr nz,lxxxxh
	jr z,lxxxxh
lxxxxh:
	ld d,e	
	ld b,e	
lxxxxh:
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
lxxxxh:
	ld a,(05243h)
	jr nz,lxxxxh
lxxxxh:
	ld b,c	
	ld h,d	
	ld h,d	
	ld (hl),d	
	ld (hl),l	
	ld h,e	
	ld l,b	
	ld a,(0435eh)
lxxxxh:
	ld b,l	
lxxxxh:
	ld h,h	
lxxxxh:
	ld l,c	
	ld (hl),h	
	ld l,c	
	ld h,l	
	ld (hl),d	
lxxxxh:
	ld l,l	
lxxxxh:
	ld l,a	
lxxxxh:
	ld h,h	
	ld (hl),l	
	ld (hl),e	
lxxxxh:
	nop	
	rla	
	ld d,015h
	inc d	
	inc de	
	ld (de),a	
	ld de,00f10h
lxxxxh:
	ld c,00dh
	inc c	
	dec bc	
	ld a,(bc)	
	add hl,bc	
	ex af,af'	
lxxxxh:
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
	jr nz,lxxxxh
	ld (hl),l	
	ld h,l	
	ld (hl),d	
	jr nz,lxxxxh
	ld sp,03130h
	inc sp	
lxxxxh:
	ld h,h	
	ld l,c	
	ld (hl),e	
	ld (hl),b	
	ld l,h	
	ld h,c	
	ld a,c	
lxxxxh:
	ld (hl),b	
	ld (hl),d	
	ld l,c	
	ld l,(hl)	
	ld (hl),h	
lxxxxh:
	ld h,d	
	ld a,c	
	ld h,l	
lxxxxh:
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
	jr nz,lxxxxh
	ld h,l	
	ld l,(hl)	
	jr nz,lxxxxh
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
	jr nz,lxxxxh
	jr nz,lxxxxh
	ld l,b	
	ld l,a	
	ld h,e	
	ld l,b	
	jr nz,lxxxxh
	ld a,d	
	ld (hl),a	
	ld l,072h
	ld (hl),l	
	ld l,(hl)	
	ld (hl),h	
	ld h,l	
	ld (hl),d	
	jr nz,lxxxxh
	ld l,(hl)	
	ld h,h	
	jr nz,lxxxxh
	ld d,d	
	jr nz,lxxxxh
	ld b,l	
	ld c,(hl)	
	ld d,h	
	add hl,hl	
lxxxxh:
	jr nz,lxxxxh
lxxxxh:
	jr nz,lxxxxh
lxxxxh:
	ld (hl),d	
	ld (hl),l	
	ld h,e	
	ld l,e	
	ld l,l	
	ld l,a	
	ld h,h	
lxxxxh:
	ld (hl),l	
	ld (hl),e	
lxxxxh:
	ld d,e	
	ld (hl),h	
	ld h,c	
	ld (hl),d	
	ld (hl),h	
lxxxxh:
	jr nz,lxxxxh
	ld (hl),d	
	ld (hl),l	
	ld h,e	
	ld l,e	
lxxxxh:
	jr nz,lxxxxh
	ld e,c	
	cpl	
	ld c,(hl)	
	add hl,hl	
	jr nz,lxxxxh
lxxxxh:
	ld h,(hl)	
	ld l,c	
lxxxxh:
	ld l,h	
	ld h,l	
lxxxxh:
	ld l,(hl)	
	ld h,c	
	ld l,l	
	ld h,l	
	ld a,(02020h)
	jr nz,$+34
	jr nz,lxxxxh
	jr nz,lxxxxh
	jr nz,lxxxxh
	jr nz,$+34
lxxxxh:
	jr nz,$+34
	jr nz,$+34
	jr nz,$+105
	ld l,a	
lxxxxh:
	jr nz,EADR_PLUS_1
	cpl	
	ld c,(hl)	
	jr nz,$+65
lxxxxh:
	ld (hl),b	
	ld (hl),d	
	ld l,c	
	ld l,(hl)	
	ld (hl),h	
	ld h,l	
lxxxxh:
	ld (hl),d	
	jr nz,$+107
	ld (hl),e	
lxxxxh:
	jr nz,$+121
	ld l,a	
lxxxxh:
	ld (hl),d	
	ld l,e	
lxxxxh:
	ld l,c	
	ld l,(hl)	
lxxxxh:
	ld h,a	
	jr nz,lxxxxh
	jr nz,lxxxxh
lxxxxh:
	jr nz,lxxxxh
	jr nz,lxxxxh
lxxxxh:
	push af	
	push hl	
	push bc	
lxxxxh:
	ld l,a	
	ld a,0cfh
	out (035h),a
	ld a,0feh
	out (035h),a
lxxxxh:
	rst 20h	
	inc b	
lxxxxh:
	cp 003h
	jr z,lxxxxh
	in a,(034h)
	and 008h
	jr nz,lxxxxh
	ld b,00ah
lxxxxh:
	ld h,0ffh
lxxxxh:
	sla l
lxxxxh:
	rl h
lxxxxh:
	di	
lxxxxh:
	ld a,l	
	out (034h),a
	srl h
	rr l
	ld c,00ah
lxxxxh:
	dec c	
	jr nz,lxxxxh
	djnz lxxxxh
	ei	
	and a	
	pop bc	
	pop hl	
	pop af	
	ret	
lxxxxh:
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
	nop	
	nop	
