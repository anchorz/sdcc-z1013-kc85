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
	UP_HLHX			 .equ 0x1a ; HL 
	UP_AHEX			 .equ 0x1c ; A 
	UP_OSTR			 .equ 0x23 ; print string
	UP_OCHR			 .equ 0x24
	UP_SPACE         .equ 0x2b ; ' '
	UP_CRLF			 .equ 0x2c ; new line 0x0d 0x0a

; #define FREQ_EINS_BIT  1000
    BIT_1    = 0xce-0x08 
    BIT_01   = 0x98-0x08
    BIT_001  = 0xB3-8
    BIT_0001 = 0x98-8

; #define FREQ_EINS_BIT  2000
;    BIT_1    = 0xE9-8
;    BIT_01   = 0xCE-8
;    BIT_001  = 0xB3-8
;    BIT_0001 = 0x98-8

; #define FREQ_EINS_BIT  4800
;    BIT_1    = 0xF6
;    BIT_01   = 0xEB
;    BIT_001  = 0xE0
;    BIT_0001 = 0xD8

.macro  HLHX
        call PV1
        .db UP_HLHX
.endm

.macro  AHEX
        call PV1
        .db UP_AHEX
.endm

.macro  OSTR    arg
        call PV1
        .db UP_OSTR
        .asciz arg
.endm

.macro  OSTRLN    arg
        call PV1
        .db UP_OSTR
        .asciz arg
        call PV1
        .db UP_CRLF
.endm

.macro  SPACE
        call PV1
        .db UP_SPACE
.endm

.macro  OCHR
       call PV1
        .db UP_OCHR
.endm

.macro  CRLF
       call PV1
        .db UP_CRLF
.endm

.macro  SLL_B
        .db 0xcb,0x30
.endm


;#                push    x+3(%2)

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
    jp  start
	.dw #0x7F7F	
	.ascii 'XM'
	.db 01
start:

    OSTRLN 'start'
    ;
	; backup the interrupt vectors
    ;
    di
	ld  hl,(IV_PIOA)
	ld  (save_iva),hl
	ld  hl,(IV_PIOB)
	ld  (save_ivb),hl
    ;
    ; set new interrupt vectors
    ;
    	ld hl,#isr_keyb	
	    ld (IV_PIOB),hl
	    ld a,#(PIO_INTERRUPT_SET_EI |PIO_INTERRUPT_SET )
	    out (PIO_B_CONTROL),a

        ld      de,#buffer
        call    block_load
        call    print_header
        ld      hl,(#file_end)
        ld      bc,#0x80-1  ; BLOCK_LEN
        add     hl,bc
        xor     a,a
        ld      de,(#file_start)
        sbc     hl,de

        add     hl,hl
        ld      l,h
        ld      h,#0
        rl      h
next_block:
        push    hl        
        call    block_load
isr_dbg_block::
        dec     de
        dec     de
        ld      a,#0x0d 
        OCHR
        ld      a,(de)
        AHEX
        ld      a,#'>'
        OCHR
        pop     hl
        dec     hl
        ld      a,l
        or      h
        jr      nz,next_block  

kbd_hit_quit:
    ;
	; restore the interrupt vectors
    ;
    
    di
	ld hl,(save_iva)
	ld (IV_PIOA),hl
	ld hl,(save_ivb)
	ld (IV_PIOB),hl
    ei
    OSTRLN 'exit'
    call PV1
    .db 0x12
;
; BLOCK LOAD
;
block_load:
	    ld      hl,#isr_wait_sync	
	    ld      (IV_PIOA),hl
	    ld      a,#(PIO_INTERRUPT_SET_EI |PIO_INTERRUPT_SET )
	    out     (PIO_A_CONTROL),a
	    ld      a,#0x07
	    out     (PORT_CTC+2),a
	    ld      a,#0x00
	    out     (PORT_CTC+2),a
        ei
loop:
        halt
        jr      loop
isr_end_block:
        ret

;
; PRINT HEADER
;
print_header:
    ld      b,#8+3
    ld      hl,#file_name
ph_name:
    ld      a,(hl)
    OCHR
    inc     hl
    djnz    ph_name
    SPACE
    ld      hl,(#file_start)
    HLHX
    ld      hl,(#file_end)
    dec     hl
    HLHX
    ld      a,(#file_argc)
    cp      #0x03
    jr      nz,no_third_argument
    ld      hl,(#file_autostart)    
    HLHX
no_third_argument:
    CRLF
isr_dbg4::
    ld      a,(#file_block)
    AHEX
    ld      a,#'>'
    OCHR
    ret

isr_keyb::
    ld  hl,#kbd_hit_quit ; jump out
    ex (sp),hl
	ei
	reti

;
; ISR SYNC
;
isr_wait_sync::
    in  a,(PORT_CTC+2)
    ex  af,af
	ld a,#0x07
	out (PORT_CTC+2),a
	ld a,#0x00
	out (PORT_CTC+2),a
    ex  af,af
    ld  hl,#0x8000
    dec (hl)
isr_dbg3::
    cp  #BIT_1
    jr  c,bit_zero
    SLL_B        
bit_zero:
    cp  #BIT_001  ; ~0x2c timeout >"001"
    jr  nc,no_sync
sync_frame: 
    ld  a,b
    cp  #0xff
    jr  nz,no_sync
    ; 0001 = invalid bit frame  
    ld bc,#0x180+1+1 ; start of byte + 0x80 bytes + 1 byte block + 1 byte checksum
	ld hl,#isr_phase	
	ld (IV_PIOA),hl
no_sync:
	ei
	reti

;
;  isr read byte
;
isr_phase::
    in  a,(PORT_CTC+2)
    ex  af,af
	ld a,#0x07
	out (PORT_CTC+2),a
	ld a,#0x00
	out (PORT_CTC+2),a
    ex  af,af
isr_dbg1::
    cp  #BIT_1
    jr  c,bit_01

    ; set bit 1
    ld  h,#1 ; just in case there is a byte write - here is the new start value
    .db 0xcb,0x30 ; SLL B <- 1
    jr  c,byte_write
    jr  dont_write

bit_01:
    cp  #BIT_01
    jr  c,bit_001

    ld  h,#3 ; just in case there is a byte write - here is the new start value
    sla b
    jr  c,byte_write
    ld  h,#1 ; just in case there is a byte write - here is the new start value
    .db 0xcb,0x30 ; 01: SLL B <- 01
    jr  c,byte_write
    jr  dont_write

bit_001:
    ld  h,#2 ; just in case there is a byte write - here is the new start value
    sla b
    jr  c,byte_write
    ld  h,#1 ; just in case there is a byte write - here is the new start value    
    sla b
    jr  c,byte_write
    jr  dont_write
byte_write:

isr_dbg2::
    ld  a,b
    ld  (de),a
    ld  b,h
    inc de
    dec c    
    jr  nz,dont_write
    ld a,#(PIO_INTERRUPT_SET | PIO_INTERRUPT_SET_DI)
	out (PIO_A_CONTROL),a
    ld  hl,#isr_end_block
    ex (sp),hl
dont_write:
	ei
	reti

end_of_binary:

	.area _DATA
save_return_from_sync:
    .ds 2 
save_return_read:
    .ds 2 
save_iva: 
	.ds 2
save_ivb: 
	.ds 2
status:
    .ds 1
buffer:
file_name:
    .ds 8    ; 120
file_type:
    .ds 3    ; 117
file_internal:
    .ds 5    ; 112
file_argc: 
    .ds 1    ; 111
file_start: 
    .ds 2    ; 109
file_end: 
    .ds 2    ; 107
file_autostart: 
    .ds 2    ; 105
    .ds 105
file_block:
    .ds 1
file_crc:
    .ds 1

