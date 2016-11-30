    .module TSAVE4
    .include 'caos.inc'

    PIO_INTERRUPT_SET_EI .equ 0x80
    PIO_INTERRUPT_SET_DI .equ 0x00
    PIO_INTERRUPT_SET    .equ 0x03

    CTC_PRESCALE_256    .equ 0x20
    CTC_PRESCALE_16     .equ 0x00
    CTC_EI              .equ 0x80
    CTC_DI              .equ 0x00
    CTC_CMD_SET_COUNTER .equ 0x07

.macro WRITE_C ?b
        ld      e,#0x08 ; 8 bits per byte
        or      e
b:
        jr      nz,b
.endm


BLOCKLEN                .equ 128
.macro  VERSION_STR
        .ascii '4.01'
.endm

.if ne(BLOCKLEN-0x80)
    .if ne(BLOCKLEN-0x20)
        .error works only for sizes of 0x80 and 0x20
    .endif
.endif

CASS_SYSTEM_Z9001       .equ 1
CASS_SYSTEM_KC85        .equ 3

RUNNING_SYSTEM          .equ CASS_SYSTEM_KC85

.if eq(BLOCKLEN-0x80)
OF_CASS_NAME            .equ  0 ; 8 Zeichen
OF_CASS_TYP             .equ  8 ; 3 Zeichen
SIZE_CASS_NAME          .equ 11
OF_CASS_RESERVED        .equ 11 ; 5 Bytes
OF_CASS_ARGN            .equ 16 ; 1 Byte
OF_CASS_AADR            .equ 17 ; 2 Bytes
OF_CASS_EADR            .equ 19 ; 2 Bytes
OF_CASS_SADR            .equ 21 ; 2 Bytes
OF_CASS_SYSTEM          .equ 23 ; 1 Byte

TESTCODE = 0 ; disable test code - no default settings of arguments
;TESTCODE = 1 ; enables test code
;OF_CASS_NAME      =  16 ; 8 Zeichen
;SIZE_CASS_NAME    = 16 

.endif

.if eq(BLOCKLEN-0x20) 
OF_CASS_AADR            .equ  0 ; 2 Bytes
OF_CASS_EADR            .equ  2 ; 2 Bytes
OF_CASS_SADR            .equ  4 ; 2 Bytes
OF_CASS_SYSTEM          .equ  6 ; 1 Byte
OF_CASS_NAME            .equ 16 ; 16 Zeichen
SIZE_CASS_NAME          .equ 16
.endif

        .area _CODE
        .area _CODE_ENDS
        .area _DATA

        .area _CODE
; **********************************
; *                                *
; * .KCC HEADER                    *
; *                                *
; **********************************
        .ascii 'TSAVE4     '
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
ENTRY:  jp      start ; start the test code

        .db     0x7f,0x7f
        .ascii  'TSAVE'
        .db     0x01
        cp      #0x02
        jp      nc,has_two_arguments
start:
        call    PV1
        .db     UP_OSTR
        .ascii  'TSAVE4 V'
        VERSION_STR
        .ascii ' Hobi'
        .db 0x27 ; '
        .ascii 's Schnellkopierer'
        .db 0x0d,0x0a
        .ascii 'Aufruf: AADR EADR (SADR)'
        .db 0x0d,0x0a
        .ascii ' AADR - Anfangsadresse'
        .db 0x0d,0x0a
        .ascii ' EADR - Endadresse (letztes Byte!)'
        .db 0x0d,0x0a
        .ascii ' SADR - (optional) Startadresse'
        .db 0x0d,0x0a, 0x00
        ret
has_two_arguments:
;
; backup and interrupt vectors
;
        push    af
        push    bc
        push    de
        push    hl

        di
        ; stop counting
        ld      a,#0x03
        out     (PORT_CTC+1),a
        ld      hl,(IV_CTC1)
	    ld      (save_ctc1),hl
	    ld      hl,#isr_ctc
	    ld      (IV_CTC1),hl
        ei

        ;ld      l,CASS_L(ix)
        ;ld      h,CASS_H(ix)
        ld      hl,#block
        push    hl
        ld      e,l
        ld      d,h
        inc     de
        ld      bc,#BLOCKLEN-1
        ld      (hl),#0x00
        ldir 
        ;
        ;  test code
        ;
        ;ld      bc,#-BLOCKLEN+1+OF_CASS_NAME
        ;add     hl,bc
        ;ld      e,l
        ;ld      d,h
        ;inc     de
        ;ld      bc,#SIZE_CASS_NAME-1;
        ;ld      (hl),#0x20
        ;ldir
        ;ld      bc,#-SIZE_CASS_NAME-OF_CASS_NAME+1
        ;add     hl,bc
        pop     iy

; ******************** TEST *****************
.if ne(TESTCODE)

.if eq(RUNNING_SYSTEM-CASS_SYSTEM_KC85)
        ld      OF_CASS_ARGN(iy),#0x03
.endif
        ld      OF_CASS_AADR(iy),#0x00
        ld      OF_CASS_AADR+1(iy),#0xE0
        ld      OF_CASS_EADR(iy),#0xFF
        ld      OF_CASS_EADR+1(iy),#0xFF
        ld      OF_CASS_SADR(iy),#0x00
        ld      OF_CASS_SADR+1(iy),#0xF0
        ld      OF_CASS_SYSTEM(iy),#RUNNING_SYSTEM
               
.if ne(OF_CASS_NAME-0)
        ld      BC,#OF_CASS_NAME
        add     hl,bc
.endif

        ld      de,#dummy_name
        ex      de,hl

.if lt(SIZE_CASS_NAME-(dummy_name_ends-dummy_name))
        .error file name exceeds buffer size
.endif
        ld      bc,#dummy_name_ends-dummy_name
        ldir
; ******************** TEST *****************
.else
        OSTR 'Name:'
        call PV1
        .db UP_INLIN
isr_start::
        push    iy
        pop     hl
        ld      bc,#OF_CASS_NAME
        add     hl,bc
        ex      de,hl
        ld      bc,#0x05 ; len of 'Name:'
        add     hl,bc
        ld      bc,#SIZE_CASS_NAME
        ldir
        pop     hl
        ld      OF_CASS_AADR(iy),l
        ld      OF_CASS_AADR+1(iy),h
        pop     de
        ld      OF_CASS_EADR(iy),e
        ld      OF_CASS_EADR+1(iy),d
        pop     bc
        pop     af
        ld      OF_CASS_ARGN(iy),#0x02
        cp      #0x03
        jr      c,skip_autostart
        inc     OF_CASS_ARGN(iy)
        ld      OF_CASS_SADR(iy),c
        ld      OF_CASS_SADR+1(iy),b
skip_autostart:
        ld      OF_CASS_SYSTEM(iy),#RUNNING_SYSTEM
.endif ; TESTCODE
        xor     a
        ld      l,OF_CASS_EADR(IY)
        ld      h,OF_CASS_EADR+1(IY)
        ld      c,OF_CASS_AADR(IY)
        ld      b,OF_CASS_AADR+1(IY)
        sbc     hl,bc

.if eq(BLOCKLEN-32)
        ; bitshift >>5 BLOCKLEN
        ADD HL, HL
        RLA
        ADD HL, HL
        RLA
        ADD HL, HL
        RLA
        LD c, H
        LD b, A
.endif
.if eq(BLOCKLEN-0x80)
        ; bitshift >>7 BLOCKLEN
        ADD HL, HL
        RLA
        LD C, H
        LD B, A
.endif 
        ; if diff==0 at least 1 block (one byte to transfer), 
        ; same as 128 that means 129 bytes to transfer
        inc     bc
        push    bc   ; length in blocks
        push    iy
        pop     hl

        call    sync
        call    write_block

        ld      l,OF_CASS_AADR(IY)
        ld      h,OF_CASS_AADR+1(IY)
next_block:
        call    write_block
        pop     bc
        dec     bc
        push    bc
        ld      a,b
        or      c
        jr      nz,next_block
;
;  restore vectors
;
        di
        ld      a,#0x03
        out     (PORT_CTC+1),a
        pop     bc ; cleanup
        ld      hl,(save_ctc1)
        ld      (IV_CTC1),hl
        ei
        ret

;
; PROC:  sync
;

PRE_CYCLES_COUNT = 0x40

sync:
        ld      d,#0x87
        ld      a,#0x87
        out     (PORT_CTC+1),a
        ld      a,#0xf0
        out     (PORT_CTC+1),a
        ld      b,#PRE_CYCLES_COUNT
        ld      c,#0xff ; 1-bits are longer, that gives us more time 
                        ; to fetch a new value into C before the new interrupt arrives
wait_sync:
        WRITE_C
        djnz    wait_sync
        ld      a,#0x03
        out     (PORT_CTC+1),a
        ; now we have to hurry to get the next byte before the timer hit ZERO again
        ; the last timer from 1-bit is still running
        ret

;
; PROC write_block
;      assumption there is a running CTC, but the interrupts does not arrive within 600 clock cycles 
;
write_block:
        push    hl
        ld      b,#BLOCKLEN/4
        xor     a,a
fix_crc:
        add     (hl)
        inc     hl
        add     (hl)
        inc     hl
        add     (hl)
        inc     hl
        add     (hl)
        inc     hl
        djnz    fix_crc
        pop     hl        ; from PUSH HL to POP HL => 547 clock cycles BLOCKLEN==0x20 
        ld      c,a
isr_block::
        ld      a,#0x87   ; actually this is kind of useless code, only needed if there is no CRC calculation 
                          ; the time for CRC calculation is that long, we dont need to set the sync bit anymore
        out     (PORT_CTC+1),a
        ld      a,#0x3*BIT_0  ; BLOCKLEN==0x80 2200 cycles, but at least 3 times the normal width
        out     (PORT_CTC+1),a

        WRITE_C

        ld      b,#BLOCKLEN
next_byte:
        ld      c,(hl)          ; 42 2.4. 7.16 [91]
        inc     hl              ; 49 1.4. 0.16 [98]
        ;ld      e,#0x08        ; 55 1.4.10.16 [104] here we can allow the interrupt again -which is by some strange coincidence still
                                ;                within the 4x16 timer boundary
        ;or      e              ;              [111]
        WRITE_C                 ; 22 3.4.11.16 [71][115]
        djnz    next_byte       ; 29 3.4. 4.16 [78]

        ; wait for the last more bit, where we will stop
        ld      c,#0xff
        ld      e,#0x01
        or      e
finalize_block:
        jr      nz,finalize_block
        ld      a,#0x03
        out     (PORT_CTC+1),a
        ret

BIT_0    .equ 0x4

isr_ctc::
        ld      a,d                 ; [ 0]
        out     (PORT_CTC+1),a      ; [ 4]
        rlc     c                   ; [15]
        ld      a,#BIT_0           ;
        jr      nc,isr_bit         ; originally we "copy" the CF into BIT 3  
        add     a                  ; 
        ;ld      a,#BIT_0/4          ; [23] we can do similar with 4 clock cycles less
        ;rla                         ; [30]
        ;rla                         ; [34]
isr_bit:
        out     (PORT_CTC+1),a      ; [38]
        dec     e                   ; 0 since timer started / [49] cycles from start
        ei                          ; 4  4.4.13.16 [53]
        reti                        ; 8  4.4. 9.16 [57]
                                    ; 22 3.4.11.16 [71]

; ******************** TEST *****************
.if ne(TESTCODE)

dummy_name:
        .ascii 'CAOS.E  BIN'
       ;.ascii '0123456.COM'
dummy_name_ends:
.endif
; ******************** TEST *****************

        .area _CODE_ENDS
end_of_binary:

        .area _DATA
save_ctc1::
        .ds 2
block::
        .ds BLOCKLEN
isr_endofdata::
