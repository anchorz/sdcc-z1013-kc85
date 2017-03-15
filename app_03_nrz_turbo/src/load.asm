        .module load
        .include 'ctc.inc'
        .include 'pio.inc'
        .include 'caos.inc'
        
        .globl iv_save
        .globl block

        .area _CODE
        .db     0x7f,0x7f
        .ascii  'TLOAD'
        .db     0x01
isr_L::
        ld      de,#isr_load
        call    iv_save
    
	    ld      a,#(PIO_CMD_INTERRUPT_SET | PIO_INT_ENABLE )
	    out     (PIO_A_CONTROL),a
        ld      a,#CTC_CMD|CTC_RESET|CTC_INT_DISABLE
        out     (PORT_CTC+1),a


        ld      hl,#block
        ld      bc,#0x8008
        ld      d,#(CTC_CMD | CTC_INT_DISABLE | CTC_RESET | CTC_SET_COUNTER) 
        xor     a
sample_loop:
        in      a,(#PIO_A_DATA)
        out     (#PIO_A_DATA),a
        jr      nc,sample_loop

   	    ld      a,#(PIO_CMD_INTERRUPT_SET | PIO_INT_DISABLE )
	    out     (PIO_A_CONTROL),a
        ld      a,#CTC_CMD|CTC_RESET|CTC_INT_DISABLE
        out     (PORT_CTC+1),a

        ret

BIT_0   .equ 0xF0

isr_load::
        in      a,(PORT_CTC+1)
        cp      #BIT_0
        rl      c
	    ld      a,d
	    out     (PORT_CTC+1),a
        xor     a
	    out     (PORT_CTC+1),a
        dec     c
        jr      nz,end_of_interrupt
        
        ld      (hl),c
        inc     hl
        ex      af,af
        add     c
        ex      af,af
        djnz    end_of_interrupt       ; 92
        scf                            ;        100 Z
end_of_interrupt:                      ; 105 NZ 104 
        ei                             ; 109    108
        reti                           ; 123    122  
