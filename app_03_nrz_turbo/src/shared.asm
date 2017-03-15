        .module shared  
        .include 'ctc.inc'
        .include 'pio.inc'
        .include 'caos.inc'

        BLOCKLEN = 0x80

        .area _CODE
; 
; PROC: iv_save
;
; in:       DE new vector
; modified: HL
;
iv_save::
        di
        ; disable interrupt PIOA
	    ld      a,#(PIO_CMD_INTERRUPT_SET | PIO_INT_DISABLE )
	    out     (PIO_A_CONTROL),a
        ; stop CTC1
        ld      a,#CTC_CMD|CTC_RESET|CTC_INT_DISABLE
        out     (PORT_CTC+1),a
        ; set new interrupt vector  
        ld      hl,(IV_PIOA)
        ld      (save_ctc1),hl
        ex      de,hl
        ld      (IV_PIOA),hl
        ei
        ret

; 
; PROC: iv_restore
;
; modified: HL
;
iv_restore::
        di
        ; disable interrupt PIOA
	    ld      a,#(PIO_CMD_INTERRUPT_SET | PIO_INT_DISABLE )
	    out     (PIO_A_CONTROL),a
        ; stop CTC1
        ld      a,#CTC_CMD|CTC_RESET|CTC_INT_DISABLE
        out     (PORT_CTC+1),a
        ; set new interrupt vector  
        ld      hl,(save_ctc1)
        ld      (IV_PIOA),hl
        ei
        ret

        .area _DATA
save_ctc1:
        .ds 2
block::
        .ds BLOCKLEN

