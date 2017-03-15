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
    .area _CODE_ENDS
	.area _DATA

;.globl isr_sample_block

	.area _CODE
; **********************************3DA0
; *                                *
; * .KCC HEADER                    *
; *                                *
; **********************************
	.ascii 'XM2        '
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

        OSTRLN 'start5'
        ;
	    ; backup the interrupt vectors
        ;
        di
	    ld      hl,(IV_PIOA)
	    ld      (save_iva),hl
        ; 
        ; set new interrupt vectors
        ;
        ld      hl,#isr_phase_changed
	    ld      (IV_PIOA),hl
        ei

        ld      hl,#file_name
        ld      3(ix),#1
        call    load_block
        jp      c,error_msg
        call    print_header

isr_check_block2::
        ld      hl,(#file_end)
        ld      bc,#0x7f
        add     hl,bc
        xor     a,a
        ld      de,(#file_start)
        sbc     hl,de
        add     hl,hl
        ; bit shift HL>>7 into DE, assume A=0!
        rla
        ld      e,h
        ld      d,a

        ld      3(ix),#2
        ld      hl,(#file_start)
next:
        push    de
        call    load_block
        jp      c,error_msg

        call    print_current_block

        inc     3(ix)
        pop     de 
        dec     de
        ld      a,d
        or      a
        jr      nz,next
        ld      a,e
        or      a
        jr      z,end  
        cp      #1
        jr      nz,next
        ld      3(ix),#0xff
        jr      next            

isr_check_block::
        ld      a,2(ix)
        cp      #0xff
        jr      nz,next       

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


        ld      a,(#file_argc)
        cp      a,#0x03
        jr      nz,no_autostart    
        ld      hl,(#file_autostart)
        jp      (hl)               
no_autostart:

        OSTRLN 'exit'
        ret

error_msg:
        ld      bc,#-0x80
        add     hl,bc
        HLDE
        ;
	    ; restore the interrupt vectors
        ;    
        di
	    ld      a,#(PIO_INTERRUPT_SET_DI |PIO_INTERRUPT_SET )
	    out     (PIO_A_CONTROL),a
	    ld      hl,(save_iva)
	    ld      (IV_PIOA),hl
	    ei

        OSTRLN 'error_crc'
        ret


load_block:
	    ld      a,#(PIO_INTERRUPT_SET_EI |PIO_INTERRUPT_SET )
	    out     (PIO_A_CONTROL),a
        ; wait sync
        ld      bc,#0x0000
        ld      de,#0x0000
isr_dbg_loop::
loop_bit:
        in      a,(#PIO_A_DATA)
        out     (#PIO_A_DATA),a
        inc     de
        jr      nc,loop_bit
        

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
isr_dbg_block::
        ld      2(ix),b
        ld      a,b
        cp      3(ix)
        jr      nz,wrong_block_nr

        ld      a,#0x80

isr_read_next::
read_next:
        ex      af,af
        call    read_byte
        ld      (hl),b
        ld      a,b
        add     c
        ld      c,a
        inc     hl
        ex      af,af
        dec     a
        jr      nz,read_next
        call    read_byte
	    ld      a,#(PIO_INTERRUPT_SET_DI |PIO_INTERRUPT_SET )
	    out     (PIO_A_CONTROL),a
        ld      a,c
        cp      b
        ret     z
        scf
        ret

wrong_block_nr:
        ex      af,af
	    ld      a,#(PIO_INTERRUPT_SET_DI |PIO_INTERRUPT_SET )
	    out     (PIO_A_CONTROL),a
        ex      af,af
        AHEX
        ld      a,#'*'
        OCHR
        jp      load_block


read_byte::
        ld      b,#1
loop_byte:
        in      a,(#PIO_A_DATA)
        out     (#PIO_A_DATA),a
        LD      A,e
        or      a
        jr      z,loop_byte
        ld      e,#0
        cp      #BIT_1
        jr      c,shift_bit_0
        SLL_B
        jr      nc,loop_byte
        ret
shift_bit_0:
        sla     b
        jr      nc,loop_byte
        ret

print_current_block:
        ld      a,#0x0d
        OCHR
        ld      a,3(ix)
        AHEX
        ld      a,#">"
        OCHR
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
    ld      a,2(ix)
    AHEX
    ld      a,#'>'
    OCHR
    ret

isr_phase_changed::
        scf
        ei
        reti

    .area _CODE_ENDS
end_of_binary:

	.area _DATA

save_iva::
        .ds 2
file_name::
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


