        .module hist 
        .include 'ctc.inc'
        .include 'pio.inc'
        .include 'caos.inc'

        .globl iv_save
        .globl iv_restore

data_array      .equ 0x200
data_array_ends .equ 0x7000

; **********************************
; *                                *
; * HIST                           * 
; *                                *
; **********************************   
        .db     0x7f,0x7f
        .ascii  'HIST'
        .db     0x01

        OSTRLN 'histogramm'
isr_hist_entry::
        ld      hl,#data_array
        ld      de,#data_array+1
        ld      bc,#data_array_ends-data_array
        xor     a
        dec     a        
        ld      (hl),a
        ldir

        ld      hl,#hist_data
        ld      de,#hist_data+1
        ld      bc,#hist_data_ends-hist_data-1
        xor     a
        ld      (hl),a
        ldir


        ld      de,#isr_hist
        call    iv_save

        ld      hl,#data_array
        ld      d,#(CTC_CMD | CTC_INT_DISABLE | CTC_RESET | CTC_SET_COUNTER) 

	    ld      a,#(PIO_CMD_INTERRUPT_SET | PIO_INT_ENABLE )
	    out     (PIO_A_CONTROL),a
sample_loop::
        xor     a                ; [121]+ 4
        in      a,(#PIO_A_DATA)  ; [125]+11
        out     (#PIO_A_DATA),a  ; [136]+11
        ei
sample_loop_2:
        jr      nc,sample_loop_2 ; [ 78]+ 7 CF! [147] 2nd round
        
        ld      (hl),e           ; [ 85]+ 7
        inc     hl               ; [ 92]+ 6
        ld      a,h              ; [ 98]+ 4
        cp      #data_array_ends/256    ; [102]+ 7
        jr      nz,sample_loop   ; [109]+12

        call    iv_restore

        OSTRLN 'ok'

isr_sample::
        ld      hl,#data_array
        ld      bc,#data_array_ends-data_array
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
        
        ld      b,#0x18
        ld      c,#0
isr_hist_next_line::
hist_next_line:
        ld      a,c
        call    get_stat
        call    hist_print_sample;         
        SPACE
        SPACE
        ld      a,c
        add     #0x18
        call    get_stat
        call    hist_print_sample;         
        SPACE
        SPACE
        ld      a,c
        add     #2*0x18
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
        
isr_hist::
        in      a,(PORT_CTC+1)              ; [0] copy exact timing from load isr
        ld      e,a
        cp      #0x00                       ; just a dummy operation to meet the clock cycle count from load isr
        ld      a,a                         ; another dummy
        ld      a,d                         ; [26] - same count as load isr
	    out     (PORT_CTC+1),a              ; [30]+11
        xor     a                           ; [41]+ 4
	    out     (PORT_CTC+1),a              ; [45]+11
        scf                                 ; [56]+ 4
        ;ei                                  ; [60]+ 4
        reti                                ; [64]+14
                                            ; [78]

        .area _DATA
hist_data:
        .ds 256*2
hist_data_ends:


