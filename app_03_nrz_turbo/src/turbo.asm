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

    BIT_1    = 0xEE
    BIT_SYNC = 0xE1

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
	.ascii 'TLOAD4     '
	.ds 5
	.db 2
	.dw ENTRY
	.dw end_of_binary+1
	.dw ENTRY
    .ds 128-23
; **********************************
; *                                *
; * ENTRY                          * 
; *                                *
; **********************************
ENTRY:  ;jp      sample_data
        jp      start
        
        .db     0x7f,0x7f
        .ascii  'HIST'
        .db     0x01
        jp      sample_data
;
; PROLOG
;       
        .db     0x7f,0x7f
        .ascii  'TL'
        .db     0x01
        jp      start


start:

        ld      hl,#0x200
        ld      de,#0x201
        ld      bc,#0x7000-0x200
        xor     a
        ld      a,#0x00
        ld      (hl),a
        ldir

        ;
	    ; backup and interrupt vectors
        ;
        di
        ld      a,#(PIO_INTERRUPT_SET_DI |PIO_INTERRUPT_SET )
	    out     (PIO_A_CONTROL),a
        ld      a,#0x07
        out     (PORT_CTC+2),a
        ld      a,#0xff              
	    out     (PORT_CTC+2),a
	    ld      hl,(IV_PIOA)
	    ld      (save_iva),hl
        ld      hl,#isr_phase_changed
	    ld      (IV_PIOA),hl

        ld      hl,#file_name
        ld      3(ix),#1
        push    de ; for nothing
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
        ret

error_msg:
isr_check_crc::

        ;
	    ; restore the interrupt vectors
        ;    
        di
	    ld      a,#(PIO_INTERRUPT_SET_DI |PIO_INTERRUPT_SET )
	    out     (PIO_A_CONTROL),a
	    ld      hl,(save_iva)
	    ld      (IV_PIOA),hl
	    ei
        OSTRLN 'CRC'
        ld      bc,#-0x80
        add     hl,bc
        HLHX

        pop     de ; clean up
        ret


load_block:

        ld      de,#isr_wait_sync
	    ld      (IV_PIOA),de
	    ld      a,#(PIO_INTERRUPT_SET_EI |PIO_INTERRUPT_SET )
	    out     (PIO_A_CONTROL),a
        ; wait sync
        ld      bc,#0xff00
        ld      de,#0x07ff
loop_bit:
        xor     a                ; 116 
        in      a,(#PIO_A_DATA)  ; 120
        out     (#PIO_A_DATA),a  ; 131
        ei                       ; 142
loop_bit_2:                       
        jr      nc,loop_bit_2     ; 74 after INT | max. 146 one round
        jr      z,loop_bit        ; 89 -> DEC B

        ld      a,b               ; 96

        dec     a                 ; 100
        jr      nz,loop_bit       ; 104 -> XOR A(112)
                    
        call    read_byte         ; 111
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
        ld      a,c
        cp      b
        ld      a,#(PIO_INTERRUPT_SET_DI |PIO_INTERRUPT_SET )
	    out     (PIO_A_CONTROL),a
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


isr_dbg_int:: 
read_byte::
        xor     a                   ; 135
        in      a,(#PIO_A_DATA)     ; 139
        out     (#PIO_A_DATA),a     ; 150
        ei                          ; 161
loop_byte_07:
        jr      nc,loop_byte_07      ; 165
        xor     a                   ; 135
        in      a,(#PIO_A_DATA)     ; 139
        out     (#PIO_A_DATA),a     ; 150
        ei                          ; 161
loop_byte_06:
        jr      nc,loop_byte_06      ; 165
        xor     a                   ; 135
        in      a,(#PIO_A_DATA)     ; 139
        out     (#PIO_A_DATA),a     ; 150
        ei                          ; 161
loop_byte_05:
        jr      nc,loop_byte_05      ; 165
        xor     a                   ; 135
        in      a,(#PIO_A_DATA)     ; 139
        out     (#PIO_A_DATA),a     ; 150
        ei                          ; 161
loop_byte_04:
        jr      nc,loop_byte_04      ; 165
        xor     a                   ; 135
        in      a,(#PIO_A_DATA)     ; 139
        out     (#PIO_A_DATA),a     ; 150
        ei                          ; 161
loop_byte_03:
        jr      nc,loop_byte_03      ; 165
        xor     a                   ; 135
        in      a,(#PIO_A_DATA)     ; 139
        out     (#PIO_A_DATA),a     ; 150
        ei                          ; 161
loop_byte_02:
        jr      nc,loop_byte_02      ; 165
        xor     a                   ; 135
        in      a,(#PIO_A_DATA)     ; 139
        out     (#PIO_A_DATA),a     ; 150
        ei                          ; 161
loop_byte_01:
        jr      nc,loop_byte_01      ; 165

        xor     a                   ; 135
        in      a,(#PIO_A_DATA)     ; 139
        out     (#PIO_A_DATA),a     ; 150
        ei                          ; 161
loop_byte_00:
        jr      nc,loop_byte_00      ; 165
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
;
; set CF to confirm INT
; set ZF if SYNC Bit detected

isr_wait_sync::          
 	    in      a,(PORT_CTC+2)              ;   0 
        cp      #BIT_1 
	    rl      b                           ;  18  - 00 oder 01
        jr      z, is ok_ret 
        cp      #BIT_SYNC
        jr      c, no sync                  ; 

        dec     b
                
ld      (IV_PIOA),hl


        cp      #BIT_1                      ;  11
        rl      b                           ;  18  
        ld      a,d                         ;  26
	    out     (PORT_CTC+2),a              ;  30
        ld      a,e                         ;  41
	    out     (PORT_CTC+2),a              ;  45
is_sync:

        scf                                 ;  56
        reti                                ;  60
   
isr_phase_changed::          
 	    in      a,(PORT_CTC+2)              ;   0 
        cp      #BIT_1                      ;  11
        rl      b                           ;  18  
        ld      a,d                         ;  26
	    out     (PORT_CTC+2),a              ;  30
        ld      a,e                         ;  41
	    out     (PORT_CTC+2),a              ;  45
        scf                                 ;  56
        reti                                ;  60
                                             
;
;
;
sample_data:
    
        OSTRLN 'histogramm'
        ld      hl,#0x200
        ld      de,#0x201
        ld      bc,#0x7000-0x200
        xor     a
        ld      a,#0x00
        ld      (hl),a
        ldir

        di
	    ld      hl,(IV_PIOA)
	    ld      (save_iva),hl
        ld      hl,#isr_sample_changed
	    ld      (IV_PIOA),hl
	    ld      a,#(PIO_INTERRUPT_SET_EI |PIO_INTERRUPT_SET )
	    out     (PIO_A_CONTROL),a
        ld      hl,#0x200
        ld      b,#CTC_CMD_SET_COUNTER
        ld      c,#0xff
sample_loop::
        xor     a               ; 102
        in      a,(#PIO_A_DATA) ; 106
        out     (#PIO_A_DATA),a ; 117
        ei                      ; 128
sample_loop_2:
        jr      nc,sample_loop_2  ; 132
        
isr_sample_loop::
        ld      (hl),e      ; 66
        inc     hl          ; 73
        ld      a,h         ; 79
        cp      #0x70       ; 83
        jr      nz,sample_loop ; 90

        di
	    ld      a,#(PIO_INTERRUPT_SET_DI |PIO_INTERRUPT_SET )
	    out     (PIO_A_CONTROL),a
	    ld      hl,(save_iva)
	    ld      (IV_PIOA),hl
	    ei

        ;ld      a,#0x0c
        ;OCHR

        ld      hl,#hist_data
        ld      de,#hist_data+1
        ld      bc,#512
        xor     a
        ld      a,#0x00
        ld      (hl),a
        ldir
        
isr_sample::
        ld      hl,#0x200
        ld      bc,#0x7000-0x200
        ld      de,#hist_data
next_sample:
        ld      a,(hl)
        neg
        push    hl
        ld      h,#0
        ld      l,a
        add     hl,hl
        add     hl,de
        inc     (hl)
        jr      nc,no_overflow
        inc     hl
        inc     (hl)       
no_overflow:
        pop     hl
        inc     hl
        dec     bc  
        ld      a,b
        or      c
        jr      nz,next_sample

        di


        ld      b,#0x10
        ld      c,#0
isr_hist_next_line::
hist_next_line:
        ld      a,c
        call    get_stat
        call    hist_print_sample;         
        SPACE
        SPACE
        ld      a,c
        add     #16
        call    get_stat
        call    hist_print_sample;         
        SPACE
        SPACE
        ld      a,c
        add     #32
        call    get_stat
        call    hist_print_sample;         
        CRLF
        inc     c
        djnz    hist_next_line

        ret

;
;  in A
;  out HL
get_stat:
        push    hl
        ld      h,#0
        ld      l,a
        add     hl,hl
        ld      de,#hist_data
        add     hl,de
        ld      e,(hl)
        inc     hl
        ld      d,(hl)
        pop     hl
        ld      l,e
        ld      h,d
        ret
;
;
;
hist_print_sample:
        push    af
        neg
        AHEX
        SPACE
        HLHX
        pop     af
        ret
        

isr_sample_changed::
 	    in      a,(PORT_CTC+2)              ;  0 
        ld      e,a                         ;  11
        ld      a,b                         ;  15
	    out     (PORT_CTC+2),a              ;  19
        ld      a,c
	    out     (PORT_CTC+2),a              ;  30
        scf                                 ;  41
        reti                                ;  45
                                            ;  59


    .area _CODE_ENDS
end_of_binary:

	.area _DATA

isr_hist_data::
hist_data:
        .ds 256*2
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


