    .module nrz_turbo

	IV_PIOA .equ 0x1e4
	IV_PIOB .equ 0x1e6
	IV_CTC2 .equ 0x1ec

    PORT_CTC	.equ 0x8c

	PIO_INTERRUPT_SET_EI .equ 0x80
	PIO_INTERRUPT_SET_DI .equ 0x00
	PIO_INTERRUPT_SET 	 .equ 0x03

	PIO_BASE			 .equ 0x88
	PIO_A_DATA			 .equ (PIO_BASE+0)
	PIO_B_DATA		 	 .equ (PIO_BASE+1)
	PIO_A_CONTROL		 .equ (PIO_BASE+2)
	PIO_B_CONTROL 		 .equ (PIO_BASE+3)

	;CLK_KC854 	.equ 1,773 447 6
    ;CLK KC854       1,773 447 5 WIKI
    ;CLK_KC852       1,750 000  
	 
	CLK_2540HZ		 .equ 43
	CLK_SAMPLE		 .equ CLK_2540HZ
	EINS_BIT_LEN     .equ 0x06

	CTC_PRESCALE_256 .equ 0x20
	CTC_PRESCALE_16  .equ 0x00
    CTC_EI           .equ 0x80
    CTC_DI           .equ 0x00

	PV1				 .equ 0xf003
	UP_OCHR			 .equ 0x24

	.area _CODE

; **********************************
; *                                *
; * .KCC HEADER                    *
; *                                *
; **********************************
	.ascii 'XM         '
	.ds 5
	.db 3
	.dw ENTRY
	.dw end_of_binary+1
	.dw ENTRY
	.ds 128-23
; **********************************
; *                                *
; * ENTRY                          *
; *                                *
; **********************************
ENTRY:
	.dw #0x7F7F	
	.ascii 'XM'
	.db 01


	; backup the interrupt vector
	ld hl,(IV_PIOA)
	ld (save_iva),hl
	ld hl,(IV_PIOB)
	ld (save_ivb),hl
	ld hl,(IV_CTC2)
	ld (save_ivt),hl

	ld hl,#isr_pio	
	ld (IV_PIOA),hl
	;ld hl,#isr	
	;ld (IV_PIOB),hl
	ld hl,#isr_timer
	ld (IV_CTC2),hl
    
	ld a,#0x7 | CTC_EI | CTC_PRESCALE_16
	out (PORT_CTC+2),a
	ld a,#CLK_SAMPLE
	out (PORT_CTC+2),a


	ld a,#(PIO_INTERRUPT_SET_EI |PIO_INTERRUPT_SET )
	out (PIO_A_CONTROL),a

	xor a
	ld  b,a
	ld  c,a
	ld  d,a
	ld  e,a
isr_start::
loopc:
	halt
	or a
	jr nz,loopc
	rr b
	rr c
	jr loopc

quit_loop:
	ld hl,(save_iva)
	ld (IV_PIOA),hl
	ld hl,(save_ivb)
	ld (IV_PIOB),hl
	ld hl,(save_ivt)
	ld (IV_CTC2),hl
	ret

isr_pio::
	cp a,#EINS_BIT_LEN
    jr nc, is_eins
    bit 7,e
	jr z,ignore_null
	res 7,e
	xor a
	rr b
    rr c
	ei
	reti

ignore_null:
	set 7,e
	xor a
	ei
	reti

is_eins:
	scf
	rr b
    rr c
	xor a
	ei
	reti

isr_timer::
	inc a
	ei
	reti

end_of_binary:

	.area _DATA
save_iva: 
	.ds 2
save_ivb: 
	.ds 2
save_ivt: 
	.ds 2
