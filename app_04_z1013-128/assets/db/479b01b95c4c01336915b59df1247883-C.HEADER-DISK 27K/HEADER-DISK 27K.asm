; z80dasm 1.1.4
; command line: z80dasm -b block.hex -S sym.hex -vvv -g 0xe000 -l -o HEADER-DISK 27K.asm HEADER-DISK 27K.hex

	org	0e000h

AADR:
SADR:

; BLOCK 'ENTRY' (start 0xe000 end 0xe003)
ENTRY_start:
	jp le435h
ENTRY_end:
	jp le15bh
	jp le0c5h
	jp le070h
le00ch:
	call sub_e1d0h
	call c,sub_e41eh
	ret c	
	ld a,001h
le015h:
	call sub_e046h
	call sub_e1dch
	jr c,le023h
	ld a,(le48fh)
	inc a	
	jr le015h
le023h:
	ld de,le490h+2
	ld a,020h
	ld b,016h
le02ah:
	ld (de),a	
	inc de	
	djnz le02ah
	ld hl,le485h
	ld bc,00005h
	ldir
	call sub_e3c5h
	ld a,00dh
	ld (de),a	
	xor a	
	inc de	
	ld (de),a	
	ld de,le490h+2
	call sub_e31eh
	ret	
sub_e046h:
	ld (le48fh),a
	ld de,le490h+2
	call sub_e375h
	ld a,020h
	ld (de),a	
	inc de	
	call sub_e326h
	ld a,020h
	ld (de),a	
	inc de	
	ld hl,(000e0h)
	call sub_e352h
	call sub_e3a4h
	ld a,00dh
	ld (de),a	
	inc de	
	xor a	
	ld (de),a	
	ld de,le490h+2
	call sub_e31eh
	ret	
le070h:
	call sub_e2adh
	ret c	
	ld b,a	
	push bc	
	call sub_e0d4h
	pop bc	
	jp c,le404h
	ld a,b	
	push af	
	ld hl,(0001bh)
	xor a	
	or h	
	ld (le490h),a
	jr z,le09eh
	inc a	
	ld (le490h),a
	ld bc,(000e0h)
	ld (000e0h),hl
	sbc hl,bc
	ld bc,(000e2h)
	add hl,bc	
	ld (000e2h),hl
le09eh:
	pop af	
	call sub_e2ffh
	ld de,le490h+2
	call sub_e31eh
	call sub_e1b2h
	ld hl,le47fh
	ld de,000e6h
	ld bc,00006h
	ldir
	ld a,(000ech)
	cp 043h
	ret nz	
	ld a,(le490h)
	or a	
	ret nz	
	ld hl,(000e4h)
	jp (hl)	
le0c5h:
	defb 0fdh,026h,000h	;illegal sequence
	cp 03ah
	call nz,0ffbeh
	call sub_e0e8h
	call c,sub_e3f3h
	ret	
sub_e0d4h:
	ld e,a	
	call sub_e1d0h
	ld a,e	
	ret c	
	cp 001h
	ret z	
	dec a	
	ld b,a	
le0dfh:
	push bc	
	call sub_e1dch
	pop bc	
	ret c	
	djnz le0dfh
	ret	
sub_e0e8h:
	ld de,(000e0h)
	ld hl,(000e2h)
	inc hl	
	or a	
	sbc hl,de
	ex de,hl	
	call sub_e28bh
	ret c	
	ld hl,000e0h
	ld b,020h
	ld a,001h
	call sub_e209h
	ld a,d	
	or d	
	jr z,le113h
	ld hl,(000e0h)
le109h:
	ld b,000h
	ld a,001h
	call sub_e209h
	dec d	
	jr nz,le109h
le113h:
	xor a	
	or e	
	jr z,le11dh
	ld b,e	
	ld a,001h
	call sub_e209h
le11dh:
	call sub_e27ah
	xor a	
	ld (le48ch),a
	call sub_e129h
	or a	
	ret	
sub_e129h:
	push bc	
	call sub_e14dh
	ld a,(0e48ah)
	out (c),a
	ld hl,(le48ch)
	out (c),l
	out (c),h
	pop bc	
	ret	
sub_e13bh:
	push bc	
	call sub_e14dh
	in a,(c)
	ld (0e48ah),a
	in l,(c)
	in h,(c)
	ld (le48ch),hl
	pop bc	
	ret	
sub_e14dh:
	call sub_e273h
	xor a	
	out (c),a
	inc c	
	out (c),a
	ld a,(le490h+1)
	ld c,a	
	ret	
le15bh:
	rst 20h	
	ld (bc),a	
	jr nz,$+102
	ld h,l	
	ld l,h	
	ld h,l	
	ld (hl),h	
	ld h,l	
	jr nz,le1c7h
	ld l,h	
	ld l,h	
	ccf	
	jr nz,le193h
	ld e,c	
	cpl	
	ld c,(hl)	
	add hl,hl	
	and b	
	rst 20h	
	ld bc,03ef5h
	dec c	
	rst 20h	
	nop	
	pop af	
	cp 059h
	ret nz	
	call sub_e273h
	ld h,c	
	ld a,(le490h+1)
	ld e,a	
	xor a	
	ld d,a	
le185h:
	out (c),d
	inc c	
	ld l,c	
	xor a	
	out (c),a
	ld c,e	
	ld b,000h
	ld a,0e5h
le191h:
	out (c),a
le193h:
	djnz le191h
	inc d	
	ld c,h	
	jr nz,le185h
	inc e	
	ld a,(le490h+1)
	add a,004h
	cp e	
	jr nc,le185h
	ld hl,00100h
	ld (le48ch),hl
	ld a,(le490h+1)
	ld (0e48ah),a
	call sub_e129h
	ret	
sub_e1b2h:
	ld de,(000e0h)
	ld hl,(000e2h)
	inc hl	
	or a	
	sbc hl,de
	ex de,hl	
le1beh:
	ld b,000h
	xor a	
	call sub_e209h
	dec d	
	jr nz,le1beh
le1c7h:
	ld a,e	
	or a	
	ret z	
	ld b,e	
	xor a	
	call sub_e209h
	ret	
sub_e1d0h:
	ld a,(le490h+1)
	ld (0e48ah),a
	ld hl,00000h
	ld (le48ch),hl
sub_e1dch:
	call sub_e27ah
	ret c	
	call sub_e273h
	ld a,(le48ch+1)
	out (c),a
	inc c	
	ld a,00dh
	out (c),a
	ld b,003h
	ld a,(0e48ah)
	ld c,a	
le1f3h:
	in a,(c)
	cp 0d3h
	jr nz,sub_e1dch
	djnz le1f3h
	xor a	
	ld (le48ch),a
	ld hl,000e0h
	ld b,020h
	xor a	
	call sub_e209h
	ret	
sub_e209h:
	ld (le48ch+2),a
	push de	
	ld a,(le48ch)
	neg
	jr z,le21dh
	ld e,a	
	xor a	
	or b	
	jr z,le222h
	ld a,e	
	cp b	
	jr c,le222h
le21dh:
	call sub_e22ch
	pop de	
	ret	
le222h:
	ld a,b	
	sub e	
	ld d,a	
	ld b,e	
	call sub_e22ch
	ld b,d	
	jr le21dh
sub_e22ch:
	push bc	
	call sub_e265h
	ld a,(0e48ah)
	ld c,a	
	ld a,(le48ch+2)
	or a	
	jr nz,le23eh
	inir
	jr le240h
le23eh:
	otir
le240h:
	pop af	
	push af	
	push hl	
	ld hl,(le48ch)
	or a	
	jr nz,le251h
	inc h	
	ld (le48ch),hl
	jr z,le258h
	jr le262h
le251h:
	ld c,a	
	add hl,bc	
	ld (le48ch),hl
	jr nc,le262h
le258h:
	ld hl,0e48ah
	inc (hl)	
	ld a,(le490h+1)
	add a,004h
	cp (hl)	
le262h:
	pop hl	
	pop bc	
	ret	
sub_e265h:
	push hl	
	ld hl,(le48ch)
	call sub_e273h
	out (c),h
	inc c	
	out (c),l
	pop hl	
	ret	
sub_e273h:
	ld a,(le490h+1)
	add a,006h
	ld c,a	
	ret	
sub_e27ah:
	ld hl,le48ch+1
	or a	
	inc (hl)	
	ret nz	
	ld hl,0e48ah
	inc (hl)	
	ld a,(le490h+1)
	add a,004h
	cp (hl)	
	ret	
sub_e28bh:
	call sub_e13bh
	push hl	
	ld hl,0e48ah
	ld a,(le490h+1)
	add a,002h
	cp (hl)	
	pop hl	
	ret nc	
	ccf	
	push de	
	ld de,00000h
	ex de,hl	
	sbc hl,de
	or a	
	ld de,00020h
	sbc hl,de
	pop de	
	ret c	
	sbc hl,de
	ret	
sub_e2adh:
	push hl	
	push de	
	push bc	
	rst 20h	
	ld (bc),a	
	dec c	
	ld c,(hl)	
	ld (hl),d	
	cp d	
	ld hl,(0002bh)
	ld (00016h),hl
le2bch:
	rst 20h	
	ld bc,003feh
	scf	
	jr z,le2dfh
	rst 20h	
	nop	
	cp 00dh
	jr nz,le2bch
	ld hl,00000h
	ld de,(00016h)
	call sub_e2e3h
	jr z,le2dfh
	rst 20h	
	ld (bc),a	
	inc a	
	ld (03535h),a
	ld hl,018a0h
	pop de	
le2dfh:
	pop bc	
	pop de	
	pop hl	
	ret	
sub_e2e3h:
	ld a,(de)	
	inc de	
	cp 020h
	jr z,le2fbh
	cp 02ch
	jr z,le2fbh
	sub 030h
	ld b,h	
	ld c,l	
	add hl,hl	
	add hl,hl	
	add hl,bc	
	add hl,hl	
	ld b,000h
	ld c,a	
	add hl,bc	
	jr sub_e2e3h
le2fbh:
	ld a,h	
	or a	
	ld a,l	
	ret	
sub_e2ffh:
	ld de,le490h+2
	call sub_e375h
	call sub_e338h
	ld a,00dh
	ld (de),a	
	inc de	
	ld b,004h
	ld a,020h
le310h:
	ld (de),a	
	inc de	
	djnz le310h
	call sub_e326h
	ld a,00dh
	ld (de),a	
	xor a	
	inc de	
	ld (de),a	
	ret	
sub_e31eh:
	ld a,(de)	
	inc de	
	or a	
	ret z	
	rst 20h	
	nop	
	jr sub_e31eh
sub_e326h:
	ld a,(000ech)
	ld (de),a	
	inc de	
	ld a,020h
	ld (de),a	
	inc de	
	ld hl,000f0h
	ld bc,00010h
	ldir
	ret	
sub_e338h:
	ld b,003h
	ld ix,000e0h
le33eh:
	ld a,020h
	ld (de),a	
	inc de	
	ld l,(ix+000h)
	inc ix
	ld h,(ix+000h)
	inc ix
	call sub_e352h
	djnz le33eh
	ret	
sub_e352h:
	push af	
	ld a,h	
	call sub_e35dh
	ld a,l	
	call sub_e35dh
	pop af	
	ret	
sub_e35dh:
	push af	
	rra	
	rra	
	rra	
	rra	
	call sub_e366h
	pop af	
sub_e366h:
	push af	
	and 00fh
	add a,030h
	cp 03ah
	jr c,le371h
	add a,007h
le371h:
	ld (de),a	
	inc de	
	pop af	
	ret	
sub_e375h:
	push af	
	push hl	
	push bc	
	cp 064h
	jr nc,le380h
	ld b,020h
	jr le38eh
le380h:
	cp 0c8h
	jr nc,le38ah
	ld b,031h
	sub 064h
	jr le38eh
le38ah:
	ld b,032h
	sub 0c8h
le38eh:
	ld c,a	
	ld a,b	
	ld (de),a	
	inc de	
	ld b,c	
	xor a	
	or b	
	jr z,le39dh
	xor a	
le398h:
	add a,001h
	daa	
	djnz le398h
le39dh:
	call sub_e35dh
	pop bc	
	pop hl	
	pop af	
	ret	
sub_e3a4h:
	push de	
	ld de,(000e0h)
	ld hl,(000e2h)
	xor a	
	sbc hl,de
	srl h
	rr l
	srl h
	rr l
	or l	
	jr z,le3bbh
	inc h	
le3bbh:
	ld a,h	
	pop de	
le3bdh:
	call sub_e375h
	ld a,04bh
	ld (de),a	
	inc de	
	ret	
sub_e3c5h:
	push de	
	call sub_e13bh
	ld a,(le490h+1)
	ld b,a	
	ld a,(0e48ah)
	sub b	
	ld b,a	
	ld a,003h
	sub b	
	sla a
	sla a
	sla a
	sla a
	sla a
	sla a
	ld bc,(le48ch)
	ld hl,00000h
	or a	
	sbc hl,bc
	srl h
	srl h
	add a,h	
	pop de	
	jr le3bdh
sub_e3f3h:
	push af	
	rst 20h	
	ld (bc),a	
	jr nz,$+102
	ld l,c	
	ld (hl),e	
	ld l,e	
	jr nz,le463h
	ld (hl),l	
	ld l,h	
	ld l,h	
	ld hl,0188dh
	daa	
le404h:
	push af	
	rst 20h	
	ld (bc),a	
	jr nz,le46fh
	ld l,c	
	ld l,h	
	ld h,l	
	jr nz,$+102
	ld l,a	
	ld h,l	
	ld (hl),e	
	jr nz,le481h
	ld l,a	
	ld (hl),h	
	jr nz,le47ch
	ld a,b	
	ld l,c	
	ld (hl),e	
	ld (hl),h	
	adc a,l	
	jr le42bh
sub_e41eh:
	push af	
	rst 20h	
	ld (bc),a	
	jr nz,$+112
	ld l,a	
	jr nz,le48ch
	ld l,c	
	ld l,h	
	ld h,l	
	ld (hl),e	
	adc a,l	
le42bh:
	push bc	
	ld bc,03939h
	call 0ffdch
	pop bc	
	pop af	
	ret	
le435h:
	ld hl,000b0h
	ld bc,00024h
	ld a,(le473h)
	cpir
	jr nz,le452h
	dec hl	
	ld de,le473h
	ld b,00ch
le448h:
	ld a,(de)	
	cp (hl)	
	inc hl	
	inc de	
	jr nz,le452h
	djnz le448h
	jr le468h
le452h:
	ld hl,000d3h
	ld de,000dfh
	ld bc,00024h
	lddr
	ld hl,le473h
	ld de,000b0h
le463h:
	ld bc,0000ch
	ldir
le468h:
	ld hl,(00039h)
	ld bc,00007h
	add hl,bc	
le46fh:
	push hl	
	jp le00ch
le473h:
	ld d,a	
	ld b,0e0h
	ld d,d	
	add hl,bc	
	ret po	
	ld c,e	
	inc bc	
	ret po	
le47ch:
	ld b,(hl)	
	inc c	
	ret po	
le47fh:
	ld b,d	
	ld (hl),d	
le481h:
	ld l,a	
	ld (hl),e	
	ld l,c	
	ld h,a	
le485h:
	ld h,(hl)	
	ld (hl),d	
	ld h,l	
	ld h,l	
	ld a,(0009bh)
le48ch:
	defb 0ddh,0ddh,001h	;illegal sequence
le48fh:
	dec de	
le490h:
	call 02098h
	jr nz,$+34
	jr nz,$+34
	jr nz,$+34
	jr nz,$+34
	jr nz,EADR_PLUS_1
	jr nz,le4bfh
	jr nz,$+34
	jr nz,$+34
	jr nz,$+34
	jr nz,$+34
	jr nz,$+104
	ld (hl),d	
	ld h,l	
	ld h,l	
	ld a,(03020h)
	add hl,sp	
	ld c,e	
	dec c	
	nop	
	ld b,h	
	jr nz,$+51
	ld l,035h
	jr nz,$+81
	jr nz,$+15
	nop	
EADR_PLUS_1:
	rst 38h	
	nop	
le4bfh:
	nop	
