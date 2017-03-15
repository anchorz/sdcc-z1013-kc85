    .module nrz_sample

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

; #define FREQ_EINS_BIT  1000
;    BIT_1    = 0xce-0x08 
;    BIT_01   = 0x98-0x08
;    BIT_001  = 0xB3-8
;    BIT_0001 = 0x98-8

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

;#define FREQ_EINS_BIT  2400
    BIT_1    = 0xE1
    BIT_SYNC = 0xDA

;#define FREQ_EINS_BIT  3200
;    BIT_1    = 0xEC
;    BIT_SYNC = 0xDA


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
        .area _CODE

        .db 0x7f,0x7f
        .ascii 'SAM'
        .db 0x01

        .globl save_iva
        .globl isr_phase_changed
        .globl read_byte

isr_sample_block::

        ld  a,#0x02
        ld  3(ix),a
        ;
	    ; backup the interrupt vectors
        ;
        di
	    ld      hl,(IV_PIOA)
	    ld      (save_iva),hl
        ; 
        ; set new interrupt vectors
        ;
        ld      hl,#isr_phase_sample
	    ld      (IV_PIOA),hl
        ei


	    ld      hl,#0x200
        ld      a,#(PIO_INTERRUPT_SET_EI |PIO_INTERRUPT_SET )
	    out     (PIO_A_CONTROL),a
.ifeq (1)
loop_bit:
        in      a,(#PIO_A_DATA)
        out     (#PIO_A_DATA),a
        LD      A,e
        or      a
        jr      z,loop_bit
        ld      e,#0
        cp      #BIT_SYNC
        jr      c,is_sync_bit
        cp      #BIT_1
        jr      c,is_bit_0
        SLL_B
        jr      loop_bit
is_bit_0:
        sla     b
        jr      loop_bit
is_sync_bit:
        ld      a,b
        cp      #0xff
        jr      nz,loop_bit
        call    read_byte
isr_sam_block::
        ld      2(ix),b
        ld      a,b
        cp      3(ix)
        jr      nz,loop_bit
.endif
loop_real:
        in      a,(#PIO_A_DATA)
        out     (#PIO_A_DATA),a
        LD      A,e
        or      a
        jr      z,loop_real
        ld      (hl),e
        ld      e,#0
        inc     hl
        ld      a,h    
        cp      #0x10
        jr      z,exit_loop
        jr      nz,loop_real
exit_loop:

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

isr_phase_sample::
        push    af
 	    in      a,(PORT_CTC+2)  
        ld      d,e
        ld      e,a        
        ld      a,#CTC_CMD_SET_COUNTER
	    out     (PORT_CTC+2),a
	    ld      a,#0xff
	    out     (PORT_CTC+2),a
        pop     af
        ei
        reti

