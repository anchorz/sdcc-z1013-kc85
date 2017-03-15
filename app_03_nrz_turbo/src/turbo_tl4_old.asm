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
    CTC_DI            .equ 0x00
    CTC_CMD_SET_COUNTER .equ 0x07

	PV1				 .equ 0xf003
	UP_HLHX			 .equ 0x1a ; HL 
	UP_HLDE			 .equ 0x1b ; HLDE 
	UP_AHEX			 .equ 0x1c ; A 
	UP_OSTR			 .equ 0x23 ; print string
	UP_OCHR			 .equ 0x24
	UP_SPACE         .equ 0x2b ; ' '
	UP_CRLF			 .equ 0x2c ; new line 0x0d 0x0a

;#define FREQ_EINS_BIT  2400
    BIT_1    = 0xE8
    BIT_SYNC = 0xC0


.macro  HLHX
        call PV1
        .db UP_HLHX
.endm

.macro  HLDE
        call PV1
        .db UP_HLDE
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
        .ascii arg
        .db 0x0d,0x0a,0x00
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

.macro  SLL_L
        .db 0xcb,0x35
.endm


;#                push    x+3(%2)

	.area _CODE
    .area _CODE_ENDS
	.area _DATA

;.globl isr_sample_block

	.area _CODE
; **********************************3DA0
; *                                *
; * .KCC HEADER                    *
; *                                *
; **********************************
	.ascii 'TLOAD4  COM'
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
ENTRY:  jp      start

        ;
        ; PROLOG
        ;       
        .db     0x7f,0x7f
        .ascii  'TL'
        .db     0x01
start:
        xor a,a
        ld  de,#0x201
        ld  hl,#0x200
        ld  bc,#0x3000-0x200
        ld  (hl),a
        ldir
    
        ;
	    ; backup and interrupt vectors
        ;
        di
	    ld      hl,(IV_PIOA)
	    ld      (save_iva),hl
        ld      hl,#isr_phase_changed_quick
	    ld      (IV_PIOA),hl
        ei

        ld      hl,#data_buffer
        call    load_block
end:
        ;
	    ; restore the interrupt vectors
        ;    
        di
	    ld      a,#(PIO_INTERRUPT_SET_DI |PIO_INTERRUPT_SET )
	    out     (PIO_A_CONTROL),a
	    ld      hl,(save_iva)
	    ld      (IV_PIOA),hl
	    ei
        ret

load_block:
        call    log_data
        ret

log_data:
        ld     hl,#0x0001
        ld     de,#0x0001
        ld     bc,#0x0000

        xor     a,a ; reset CF        
        ld      a,#(PIO_INTERRUPT_SET_EI |PIO_INTERRUPT_SET )
	    out     (PIO_A_CONTROL),a
        in      a,(#PIO_A_DATA)
        out     (#PIO_A_DATA),a  ; enable next interrupt 

        ld      hl,#0x0000
        scf
wait_for_first_int:
        jr      c, wait_for_first_int
isr_wait::
        
        ld      hl,#0x0016
        ld      de,#0x0001
        or      l ; reset ZF
next_int:
        ei
        rr      d
        rr      e
        ;dec     l
        ;ret     z        
        xor     a,a
        in      a,(#PIO_A_DATA)
        out     (#PIO_A_DATA),a  ; enable next interrupt 
        ld      bc,#0x0001
        jr      c,next_int
        ld      bc,#0x0002
        jr      c,next_int
        ld      bc,#0x0003
        jr      c,next_int
        ld      bc,#0x0004
        jr      c,next_int
        ld      bc,#0x0005
        jr      c,next_int
        ld      bc,#0x0006
        jr      c,next_int
        ld      bc,#0x0007
        jr      c,next_int
        ld      bc,#0x0008
        jr      c,next_int
        di
        ld      bc,#0x0009      
        jr      c,next_int
        xor     a,a
        ld      bc,#0x000a
        ei
        jr      nc,next_int
        ld      bc,#0x000a
        jr      nc,next_int
        ld      bc,#0x000b
        jr      nc,next_int
        ld      bc,#0x000c
        jr      nc,next_int
        ld      bc,#0x000d
        jr      nc,next_int
        ld      bc,#0x000e
        jr      nc,next_int
        ld      bc,#0x000f
        jr      nc,next_int
        ld      bc,#0x0010
        jr      next_int
        ret

isr_phase_changed_quick::
        ccf
        reti



    .area _CODE_ENDS
end_of_binary:

	    .area _DATA
save_iva:
        .ds 2
data_buffer:
        .ds 32

