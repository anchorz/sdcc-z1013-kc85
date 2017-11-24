; This is the commented BASIC listing of the 
; TDL 12K Extended "Zapple" BASIC, 
; by Roger Amidon and Neil Colvin, May 1977
;
; This was produced by IDA disassembler
; and further modified for readability (macros and long symbols)
; note this is, although it looks like, not correct Z80 assembler
; to be directly fed into an assembler program - mainly because
; many symbols are too long for Z80 assemblers
; use this as reference only, rather use the HEX dump
; to produce a binary.
;
; The HEX dump has been compared with this commented file;
; while commenting, several OCR errors were corrected.
;
; The hex dump was produced from the book
; Rolf-Dieter Klein, Basic-Interpreter, Franzis Verlag Mnchen, 1982;
; in German language, ISBN 3-7723-6941-3
; The book author himself mentions in the book that he published
; the hex dump because "Der Interpreter wurde urspruenglich von
; TDL (Technical Design Labs) entwickelt und ist sehr leistungsfaehig.
; Da die Firma nicht mehr existiert, soll durch den Abdruck des Listings
; dem Leser die Moeglichkeit gegeben werden, Zugang zu diesem Basic zu
; erhalten." (Seite 103) (Translation: the interpreter was developed
; originally by TDL (Technical Design Labs) and is very powerful.
; Because the company is no longer in existance, the reader is given
; the chance, by printing this listing to get access to this Basic).
;
; The work of reverse engineering and commenting was done by Holger Veit,
; 2012 - this whole work is published unter Creative Commons License
; CC-BY-SA http://creativecommons.org/licenses/by-sa/3.0/

;--------------------------------------------------------------------

;****************************************************************
; some macro definitions for readability
CPHL_DE         macro
                ld    a, h
                sub   d
                jr    nz, @@1
                ld    a, l
                sub   e
@@1:
                endm

LDBC_M          macro
                ld    c, (hl)
                inc   hl
                ld    b, (hl)
                endm

LDDE_M          macro
                ld    e, (hl)
                inc   hl
                ld    d, (hl)
                endm

LDHL_M          macro @tmp
                ld    @tmp, (hl)
                inc   hl
                ld    h, (hl)
                ld    l, @tmp
                endm
				
LDM_BC          macro
                ld    (hl), c
                inc   hl
                ld    (hl), b
                endm

LDM_DE          macro
                ld    (hl), e
                inc   hl
                ld    (hl), d
                endm

LDHL_BC         macro
                ld    h, b
                ld    l, c
                endm

LDHL_DE         macro
                ld    h, d
                ld    l, e
                endm

LDBC_HL         macro
                ld    b, h
                ld    c, l
                endm

LDDE_HL         macro
                ld    d, h
                ld    e, l
                endm

POP_FPREG       macro
                pop   bc
                pop   ix
                pop   de
                endm

PUSH_FPREG      macro
                push  bc
                push  ix
                push  de
                endm
				
FPREG_CONST     macro @1, @2, @3
                ld    bc, @1
                ld    ix, @2
                ld    de, @2
                endm

EXPECT          macro @token
                ld    a, @token
                call  expect_char
				endm

TEST_FFFF       macro
                ld    a, h
                and   l
                inc   a                ; is valid (!= ffff)
				endm

TEST_0          macro
                ld    a, h
                or    l
                endm
				
                
; **************************************************************
CHAR_CTRLC     equ   3
CHAR_TAB       equ   9
CHAR_LF        equ   0Ah
CHAR_CR        equ   0Dh
CHAR_CTRLO     equ   0Fh
CHAR_CTRLQ     equ   11h
CHAR_CTRLR     equ   12h
CHAR_CTRLS     equ   13h
CHAR_CTRLT     equ   14h
CHAR_CTRLU     equ   15h
CHAR_CTRLX     equ   18h
CHAR_CTRLZ     equ   1Ah
CHAR_ESC       equ   1Bh
CHAR_RUBOUT    equ   7Fh
CHAR_EXCL      equ   '!'
CHAR_BSLASH    equ   '\'
CHAR_SPACE     equ   ' '
CHAR_COMMA     equ   ','
CHAR_LPAREN    equ   '('
CHAR_RPAREN    equ   ')'
CHAR_QUOTE     equ   22h
CHAR_TIC       equ   27h
CHAR_SEMI      equ   ';'
CHAR_COLON     equ   ':'
CHAR_ZERO      equ   '0'
CHAR_NINE      equ   '9'
CHAR_PERCENT   equ   '%'
CHAR_AMP       equ   '&'
CHAR_PERIOD    equ   '.'
CHAR_A         equ   'A'
CHAR_E         equ   'E'
CHAR_Z         equ   'Z'
CHAR_PLUS      equ   '+'
CHAR_MINUS     equ   '-'
CHAR_HASH      equ   '#'
CHAR_DOLLAR    equ   '$'
CHAR_STAR      equ   '*'
CHAR_POWER     equ   '^'
CHAR_QUEST     equ   '?'

TOKEN_END       equ   80h
TOKEN_FOR       equ   81h
TOKEN_DATA      equ   83h
TOKEN_INPUT     equ   84h
TOKEN_GOTO      equ   88h
TOKEN_FNEND     equ   89h
TOKEN_IF        equ   8Ah
TOKEN_RESTORE   equ   8Bh
TOKEN_GOSUB     equ   8Ch
TOKEN_REM       equ   8Eh
TOKEN_QUEST     equ   97h
TOKEN_EXCL      equ   9Ch
TOKEN_USING     equ   9Dh
TOKEN_TAB       equ   9Eh
TOKEN_TO        equ   9Fh
TOKEN_FN        equ   0A0h
TOKEN_SPC       equ   0A1h
TOKEN_THEN      equ   0A2h
TOKEN_NOT       equ   0A3h
TOKEN_STEP      equ   0A4h
TOKEN_PLUS      equ   0A5h
TOKEN_MINUS     equ   0A6h
TOKEN_GREATER   equ   0ACh
TOKEN_EQUAL     equ   0ADh
TOKEN_LESS      equ   0AEh
TOKEN_SGN       equ   0AFh
TOKEN_CHRS      equ   0C3h
TOKEN_MIDS      equ   0C6h
TOKEN_LPOS      equ   0C7h
TOKEN_INSTR     equ   0C8h
TOKEN_ELSE      equ   0C9h
TOKEN_REM       equ   0D5h

MASK_7BIT       equ   07Fh
NULL            equ   0                ; 0 as string terminator

; precedence of operations
PREC_OR         equ   46h
PREC_AND        equ   50h
PREC_NOT        equ   5ah
PREC_STRCMP     equ   64h
PREC_RELOP      equ   78h
PREC_ADDSUB     equ   79h
PREC_MULDIV     equ   7Ch
PREC_MINUS      equ   7Dh
PREC_POWER      equ   7Fh


; **************************************************************

; this structure is typically pointed to by IY
; IY is not used otherwise
ioparams        struc
curpos:         db ?                   ; current position
linelength:     db ?                   ; length of output line
last_field:     db ?
padcount:       db ?                   ; # of padding characters
padchar:        db ?                   ; char used for padding after CRLF
                                       ; (typically NUL)
ioparams        ends

; this is the structure of a string descriptor
string_desc     struc
len:            db ?
unused:         db ?
addr:           dw ?
string_desc     ends

; BASIC interpreter variables
                org 0
resetvector:    ds 1                   ; contains a C3h (JP)
reset_addr:     ds 2                   ; point to BASIC warmstart

                org 100h
iosuppress:     ds 1                   ; flag to suppress I/O
dim_flag:       ds 1                   ; used in array declaration
expr_type:      ds 1                   ; type of current expression
                                       ; =0 numeric
                                       ; =1 string
byte_103:       ds 1                   ; used in tokenizing line
memory_top:     ds 2                   ; highest memory address
stringstkptr:   ds 2                   ; ptr to stringstk
stringstk:      ds 60                  ; stack for storing nested string expressions

; String accu, temporary scratchpad for string expression processing
; must be directly after stringstk
straccu:        ds 1                   ; length of string
                ds 1                   ; unused
                ds 2                   ; address of string
string_top:     ds 2                   ; point to end of string area
arrayvalptr:    ds 2                   ; used in calaculating array values
currentlineno:  ds 2                   ; stores current lineno in BASIC execution
subscript_flag: ds 1                   ; subscript flag, used in variable decl. and eval.
                                       ; = 1 (exec_kill)
                                       ; = 0
                                       ; = CHAR_RPAREN
input_read_flag: ds 1                  ; used in INPUT processing
curlineptr:     ds 2                   ; ptr to current line in BASIC execution
lineptrsave:    ds 2                   ; temporary
lineno:         ds 2                   ; temporary
contlineno:     ds 2                   ; lineno for CONT
contlineptr:    ds 2                   ; temporary
string_base:    ds 2                   ; stack grows below this space
                                       ; string data extends from here to memory_top
start_memory:   ds 2                   ; start of BASIC program
prog_end:       ds 2                   ; end of BASIC program, scalar variables start here
end_of_vars:    ds 2                   ; end of scalar variable table, arrays start here
end_arrays:     ds 2                   ; end of array table, start of free space

; memory layout
; start_memory -> BASIC lines
; prog_end     -> start of variable table
; end_of_vars  -> start of array table
; end_arrays   -> end of array table
; ----- free space, will grow downward
;
; temporary expression stack
; string_base  -> start of string space
; string_top   -> end of string space, growing downwards
; memory_top   -> highest memory
;
; format of BASIC line
; xxxx -> link to next line (0000 if end of program)
; nnnn -> lineno (1...65520)
; tokenized basic line
; 00 -> end of line
; link points to here

data_ptr:       ds 2                   ; ptr to next DATA item to be READ

; FP ACCU #1, stores value in packed format
; i.e. mant6-2 (1 only exists in register calculations)
; contain mantissa with    sign bit in mant6, normalized
; with supression of leading 1
; exp =    0 -> accu is 0
; exp =    0x81 ->    number is 0..1
fpaccu_mant32:  ds 2
fpaccu_mant54:  ds 2
fpaccu_mant6:   ds 1
fpaccu_exp:     ds 1
fpaccu_mantsign: ds 1                  ; FPaccu sign

; buf for conversion and formatting of numbers into decimal representation
numberbuf0:     ds 1                   ; unused, but HL is usually initialized when
                                       ; pointing to number buf
numberbuf:      ds 19
                ds 6                   ; used as token buf

rnd_mant23:     ds 2                   ; random init value
rnd_mant45:     ds 2
rndmant6_exp:   ds 2

outputvector:   ds 1                   ; output vector, points to console or printer
                                       ; filled with JP instruction
output_addr:    ds 2                   ; address of current output routine

; parameter table for CONSOLE (pointed to by IY)
conparam:       ds 1                   ; curpos
                ds 1                   ; linelength
                ds 1                   ; last_field
                ds 1                   ; padcount
                ds 1                   ; padchar

; parameter table for PRINTER output (pointed to by IY)
prtparam:       ds 1                   ; curpos
                ds 1                   ; linelength
                ds 1                   ; last_field
                ds 1                   ; padcount
                ds 1                   ; padchar
curlineno:      ds 2                   ; temporary
auto_increment: ds 2                   ; lineno for autoincrement

renum_size:     ds 1                   ; RENUMBER parameters
renum_incr:     ds 2
renum_new:      ds 2

trace_mode:     ds 1                   ; bit 7=1: LTRACE ON
                                       ; bit 6=1: TRACE ON
                            
coldvector:     ds 1                   ; filled with JP instruction
cold_addr:      ds 2                   ; address of coldstart

inputbuf_cnt:   ds 1                   ; cntr for line inputbuf

pos_period:     ds 2                   ; used in number conversion

fmt_flags:      ds 1                   ; flag for formatting number output
                                       ; bit0 = add for digits for exponent (E+XX)
                                       ; bit1 = unused?
                                       ; bit2 = print SPACE for positive sign
                                       ; bit3 = add leading '+' sign
                                       ; bit4 = add leading '$'
                                       ; bit5 = replace empty positions with '*'
                                       ; bit6 = add commas each 3 digits
                                       ; bit7 = percent format
prompt_flag:    ds 1                   ; =0 : direct mode
                                       ; =1 : prompt auto lineno
renum_start:    ds 2                   ; used in RENUMBER
div_ovf:        ds 1                   ; flag division overflow
precision:      ds 1                   ; number PRECISION
byte_1B0:       ds 1                   ; filled with comma
inputbuf:       ds 14Fh                ; inputbuf for enter, edit, and convert input

; ------------------------------------------------------------------------------

; program code starts here
;
; Jump table, modify these to point to own routines

                org 300h
COLDSTART:      jp    coldstart
WARMSTART:      jp    recovered_msg
math_usr:       jp    illfunc_error

; wait for console character available, return in A
CONSOLEIN:      jp    0F003h

; read a character from paper tape reader, return in A, return C=1 if EOF
READERIN:       jp    0F006h

; write a character in C to CONSOLE, no wait
CONSOLEOUT:     jp    0F009h

; write a character in C to paper tape punch, no wait
PUNCHOUT:       jp    0F00Ch

; write a character in C to printer, no wait
LISTOUT:        jp    0F00Fh

; check if a character is present from CONSOLE, A=0: no, A=FF: yes
; char can be obtained with CONSOLEIN then
CONSOLESTAT:    jp    0F012h

; get IObyte of (Zapple) monitor in A
IOCHECK:        jp    0F015h

; set IObyte of (Zapple) monitor in C
IOSET:          jp    0F018h

; get memory size in BA (B=high, A=low)
MEMSIZE:        jp    0F01Bh

; return to monitor
TRAP:           jp    0F01Eh

; helper functions for USR() programmer
                jp    fpaccu_to_16
                jp    AB_to_fpaccu

; BASIC function dispatch table
func_tbl:       dw    math_sgn
                dw    math_int
                dw    math_abs
                dw    math_usr         ; call USR vector
                dw    math_fre
                dw    math_inp
                dw    math_pos
                dw    math_sqr
                dw    math_rnd
                dw    math_log
                dw    math_exp
                dw    math_cos
                dw    math_sin
                dw    math_tan
                dw    math_atn
                dw    math_peek
                dw    math_len
                dw    math_strs
                dw    math_val
                dw    math_asc
                dw    math_chrs
                dw    math_lefts
                dw    math_rights
                dw    math_mids
                dw    math_lpos
                dw    math_instr
                
; operand dispatch table (first byte of each entry is precedence)
oper_tbl:       db    PREC_ADDSUB 
                dw    pop_fpreg_and_add
                db    PREC_ADDSUB
                dw    pop_fpreg_and_sub
                db    PREC_MULDIV
                dw    pop_fpreg_and_mult
                db    PREC_MULDIV
                dw    pop_fpreg_and_div
                db    PREC_POWER
                dw    pop_fpreg_and_power
                db    PREC_AND
                dw    pop_fpreg_and_booland
                db    PREC_OR
                dw    pop_fpreg_and_boolor

; basic cmd dispatch table                
token2_dispatch:
                dw    exec_end
                dw    exec_for
                dw    exec_next
                dw    exec_data
                dw    exec_input
                dw    exec_dim
                dw    exec_read
                dw    exec_let
                dw    exec_goto
                dw    exec_fnend
                dw    exec_if
                dw    exec_restore
                dw    exec_gosub
                dw    exec_return
                dw    advance_to_eoln  ; REM statement
                dw    exec_stop
                dw    exec_out
                dw    exec_on
                dw    exec_null
                dw    exec_wait
                dw    exec_def
                dw    exec_poke
                dw    exec_print
                dw    exec_print
                dw    exec_input
                dw    exec_clear
                dw    exec_fnend       ; fnreturn
                dw    exec_save
                dw    advance_to_eoln  ; ! statement

; special BASIC token dispatch table
token1_dispatch:
                dw    advance_to_eoln ; ELSE
                dw    exec_lprint
                dw    exec_trace
                dw    exec_ltrace
                dw    exec_randomize
                dw exec_switch
                dw exec_lwidth
                dw exec_lnull
                dw exec_width
                dw exec_lvar
                dw exec_llvar
                dw exec_print
                dw syntax_error        ; tic alternative REM, not processed here
                dw exec_precision
                dw exec_call
                dw exec_kill
                dw exec_exchange
                dw exec_lineinput
                dw exec_loadgo
                dw exec_run
                dw exec_load
                dw exec_new
                dw exec_auto
                dw exec_copy
                dw exec_aloadc
                dw exec_amergec
                dw exec_aload
                dw exec_amerge
                dw exec_asave
                dw exec_list
                dw exec_llist
                dw exec_renumber
                dw exec_delete
                dw exec_edit
                dw exec_cont
                
; discard the last pending FOR loops
; DE = FFxx -> discard all open levels,
;         point to first non-FOR loop level
; DE = 00 -> point to last open level
; DE = var ptr -> discard all open levels
;         and point to correct level
;
; Note: the stack is used for storing various structures,
; such as FOR loop, GOSUB, and expressions
; each structure has a marker at the end which
; is usually the originating token.
; the marker is two levels above (stack mark and process
; routine of BASIC command)
discard_open_forloops:
                ld    hl, 4            ; skip over 2 levels of calls
                add   hl, sp
                ld    bc, 11h
loop3FD:        ld    a, (hl)          ;<+ get stack marker
                inc   hl               ; | advance
                cp    TOKEN_FOR        ; | is it FOR token?
                ret   nz               ; | no, return
                                       ; |
; discard pending for loops              |
                ld    a, (hl)          ; | get next byte of FOR structure
                inc   hl               ; | advance
                push  hl               ; | save it
                ld    h, (hl)          ; | get next byte of FOR structure
                ld    l, a             ; | pack pair into HL
                ld    a, d             ; | get variable to match
                or    e                ; |
                ex    de, hl           ; | save variable name
                jr    z, loc_413       ; | variable zero? NEXT without variable name
                                       ; | matches unconditionally
                ex    de, hl           ; | restore variable
                CPHL_DE                ; | compare with FOR variable name
loc_413:        pop   hl               ; | reload ptr into FOR structure
                inc   hl               ; | point to payload after variable name
                ret   z                ; | return if correct level found
                add   hl, bc           ; | skip over payload
                jr    loop3FD          ;-+ loop

; HL = new end address
; BC = old end address
; DE = start address
make_space:     call  check_memfree    ; validate enough space available
                push  bc
                ex    (sp), hl         ; swap oldend and newend
                pop   bc               ; BC is newend
loc_41F:        or    a                ; clear CY
                push  hl               ; save oldend
                sbc   hl, de           ; calculate bytes to move
                push  bc
                ex    (sp), hl         ; swap newend and bytes to move
                pop   bc               ; BC is move count, HL is newend
                ex    de, hl           ; DE is newend, HL is start
                ex    (sp), hl         ; stack is start, HL is oldend
                inc   bc               ; one more byte to move
                lddr                   ; move data
                inc   hl               ; HL points to end of freed space
                inc   de               ; DE points to start of space
                ld    b, d             ; move DE -> BC
                ld    c, e
                pop   de               ; DE is start of free space
                ret

; verify that 2*C bytes are still free in memory
verify_space:   push  hl               ; save HL
                ld    hl, (end_arrays) ; get start of free space
                ld    b, 0             ; make C 16bit
                add   hl, bc           ; add to free space
                add   hl, bc           ; add to free space
                call  check_memfree    ; check if not overlapping with string space
                pop   hl
                ret

check_memfree:  push  de               ; save DE
                ex    de, hl           ; save HL
                ld    hl, -40          ; subtract 40 from stack
                add   hl, sp
                CPHL_DE                ; subtract memory base
                ex    de, hl
                pop   de
                ret   nc               ; enough space free
out_of_memory_error:
                ld    e, 7
                jr    print_error

; expect the char in A in the inputbuf, otherwise error
expect_char:    cp    (hl)
                jp    z, nextchar
                jr    syntax_error

invalid_input:  ld    a, (input_read_flag) ; get input/read flag
                or    a
                jr    nz, loc_467      ; in READ?
                pop   bc               ; no, drop curlineptr
                ld    hl, a_invalid_input ; message "*invalid input"
                call  print_string     ; error
                jp    loc_5F4          ; restore curlineptr and exit
loc_467:        ld    hl, (currentlineno) ; copy lineno into error lineno
                ld    (lineno), hl     ; otherwise (in READ), 
                                       ; notify a syntax error in data line

; error print routines
syntax_error:
                ld    e, 2
                db    1                ; LD BC, xxxx to skip over next code
div_by_zero_error:
                ld    e, 11
                db    1                ; LD BC, xxxx to skip over next code
recovered_msg:  ld    e, 22
                db    1                ; LD BC, xxxx to skip over next code
redim_array_error:
                ld    e, 10
                db    1                ; LD BC, xxxx to skip over next code
usercall_error: ld    e, 18
                db    1                ; LD BC, xxxx to skip over next code
next_wo_for_error:
                ld    e, 1

; print an error message in E
print_error:    call  reset_stack_warm ; correct stack ptr
                call  enable_output    ; enable output again, if it was suppressed
                call  print_crlf       ; do a CRLF
                ld    hl, e_next_wo_for ; load start of error table
loop48A:        dec   e                ;<--+ decrement error number
                jr    z, loc_494       ;   | if zero, found
loop48D:        bit   7, (hl)          ;<+ | test high bit
                inc   hl               ; | | advance ptr
                jr    z, loop48D       ;-+ | loop to end of string
                jr    loop48A          ;---+ loop until error string found
loc_494:        call  print_string     ; emit the message string
                ld    hl, (lineno)     ; get lineno
                TEST_FFFF              ;  check if != ffff
                call  nz, print_at_lineno ; is valid, print " @ line "
                                       ; if line is printed: A    != 0

; enters here to print ready prompt
; according to flag in A (print if A=0)
print_prompt:
                call  enable_output    ; enable output if it was suppressed
                ld    (prompt_flag), a ; A is 0, clear prompt flag
                call  print_ready_prompt ; print "READY"
loop4A9:        ld    hl, 0FFFFh       ;<+ reset lineno
                ld    (lineno), hl     ; | 
                ld    a, (prompt_flag) ; | prompting?
                or    a                ; | 
                jr    z, loc_4DA       ; | no, go to direct mode
                ld    hl, (curlineno)  ; | get current lineno
                jp    m, sub_1DD5      ; | prompt flag=FF?, yes coming from aload/amerge
                ld    de, (auto_increment) ; in auto mode, get increment
                add   hl, de           ; | make new lineno
                jp    c, subscript_range_error ; too large, error
                                       ; |
; do auto mode                           | 
auto:           ld    (curlineno), hl  ; | store as new lineno
                push  hl               ; | save it
                call  print_HL         ; | print lineno
                call  print_space      ; | print a space
                call  get_inputline    ; | process a whole input line
                call  nextchar         ; | get next char
                pop   de               ; | restore auto lineno
                or    a                ; | line was empty?
                jr    z, print_prompt  ; | yes, continue with next line
                scf                    ; | set flag C=1: digit seen
                jr    loc_4E4          ; | process line, assuming a lineno
                                       ; | has been already found
loc_4DA:        call  get_inputline    ; | get a line
                call  nextchar         ; | read char
                inc   a                ; | set flags
                dec   a                ; |
                jr    z, loop4A9       ;-+ empty line, loop
loc_4E4:        push  af               ; save char and C flag (C=1: digit seen)
                cp    CHAR_CTRLC       ; is it CTRL-C?
                jp    z, has_break     ; yes, skip
                exx                    ; save all regs
                ld    hl, prompt_flag  ; check prompt flag
                inc   (hl)
                dec   (hl)
                exx                    ; restore all regs
loc_4F1:                               ; is in direct mode? try finding a lineno
                call  z, parse_lineno  ; DE contains lineno or 0
                                       ; otherwise: DE contains the AUTO lineno
                cp    CHAR_SPACE       ; is char space?
                jr    nz, loc_4F9      ; no, regular char
                inc   hl               ; advance to next (a space after a lineno)
loc_4F9:        push  de               ; save potential lineno
                call  tokenize_line    ; compress line by tokenizing it
                ld    b, a             ; B = 0 (A returned with 0)
                pop   de               ; restore lineno
                pop   af               ; restore char read
                jp    nc, execute_command ; was not a number?

; a line starting with a statement number was entered
                push  de               ; save potential lineno
                push  bc               ; length of line in C, B is 0
loop505:        inc   hl               ;<+ get first char of line
                ld    a, (hl)          ; | 
                or    a                ; | is zero?
                jr    z, loc_516       ; | flush buf to memory
                cp    CHAR_SPACE       ; | is space?
                jr    z, loop505       ;>+ yes ignore and loop
                cp    CHAR_TAB         ; | is tab?
                jr    z, loop505       ;>+ yes ignore and loop
                cp    CHAR_LF          ; | is LF?
                jr    z, loop505       ;-+ yes ignore and loop
loc_516:        push  af               ; save char seen for future
                call  find_line        ; find the line in program memory
                push  bc               ; save previous link
                jr    nc, loc_531      ; must be inserted before
; must replace line
                ex    de, hl           ; save nextlink in DE
                ld    hl, (prog_end)   ; get end of program
loop521:        ld    a, (de)          ;<+ get data from nextlink
                ld    (bc), a          ; | copy into previous
                inc   bc               ; | advance
                inc   de               ; | 
                CPHL_DE                ; | end of program reached?
                jr    nz, loop521      ;-+ no loop (delete the matching line)
                ld    (prog_end), bc   ; save new end of program
loc_531:        pop   de               ; restore previous link in DE
                pop   af               ; restore char
                jr    z, rebuild_nextchain ; was zero? yes, we just had to 
				                       ; delete the line
                ld    bc, (prog_end)   ; get end of program
                pop   hl               ; get line length to insert
                add   hl, bc           ; add to end of program
                push  hl               ; save new end
                call  make_space       ; shift program up to make a space for line
                pop   hl               ; save new end of program
                ld    (prog_end), hl
                ex    de, hl           ; get link to new line in HL
                ld    (hl), h          ; ensure that line link is not zero
                inc   hl               ; advance to lineno position
                inc   hl
                pop   de               ; restore lineno
                LDM_DE                 ; save it into new line
                inc   hl
                ld    de, inputbuf     ; get inputbuf
loop54F:        ld    a, (de)          ;<+ move line into program space
                ld    (hl), a          ; | 
                inc   hl               ; | 
                inc   de               ; | 
                or    a                ; | until line terminator seen
                jr    nz, loop54F      ;-+
rebuild_nextchain:                     
                call  init_from_start  ; clear variables
                inc   hl               ; HL points to start of program now
                ex    de, hl           ; into DE
                ld    hl, loop4A9      ; set new return address
                push  hl
rebuild_nextchain1:                    ;<--+
                LDHL_DE                ;   | DE is ptr to nextlink, copy into HL
                ld    a, (hl)          ;   | get current nextlink
                inc   hl               ;   | 
                or    (hl)             ;   | 
                ret   z                ;   | return if zero -> finished with
				                       ;   | adjustment of program
                inc   hl               ;   | advance beyond lineno
                inc   hl               ;   | 
                inc   hl               ;   | 
                xor   a                ;   | clear A
loop569:        cp    (hl)             ;<+ | find the line terminator
                inc   hl               ; | | advance
                jr    nz, loop569      ;-+ | loop until found
                ex    de, hl           ;   | HL = previous nextlink, DE = start of next line
                LDM_DE                 ;   | save line position into previous nextlink
                jr    rebuild_nextchain1 ;-+ loop until end of program

; get a range of linenos
; find the first line, set HL, BC as in find_line
; end of range is on stack when returning
get_lineno_range:
                ld    de, 0            ; preload starting lineno
                push  de
                jr    z, loc_585       ; no more arguments, set 0-65535
                pop   de               ; discard start value
                call  read_lineno      ; read a lineno in DE
                push  de               ; save it for later
                jr    z, loc_58E       ; end of command, only delete a single line
                EXPECT TOKEN_MINUS     ; otherweise expect token '-'
loc_585:        ld    de, 0FFFFh       ; preload 65535 as end of range
                call  nz, read_lineno  ; if not end of line yet, get the end of range
                jp    nz, syntax_error ; error, if more characters follow
loc_58E:        ex    de, hl           ; HL is end of range
                pop   de               ; DE is start lineno range
                ex    (sp), hl         ; insert it on stack
                push  hl               ; push old return address

; DE is lineno to search
; return address of nextlink of HL
; return nextlink of previous line in BC
; Z=1 if line matched or nextlink=0
; C=0 if line has to be    inserted here
find_line:      ld    hl, (start_memory) ; load start of program
find_line_from_current: 
                LDBC_HL                ; ptr to nextlink: copy into BC
                ld    a, (hl)          ; check link
                inc   hl
                or    (hl)             ; was it 0000?
                dec   hl               ; HL points to nextlink 0000 (end of program)
                ret   z                ; yes, exit
                inc   hl               ; skip over nextlink
                inc   hl
                LDHL_M A               ; read lineno into HL
                sbc   hl, de           ; compare with lineno to be entered in DE
                LDHL_BC                ; restore nextlink
                LDHL_M A               ; read nextlink into HL
                ccf
                ret   z                ; matched line exactly
                                       ; return nextlink of this line
                ccf
                ret   nc               ; must insert before this line
                exx                    ; fragment of exec_copy:
                                       ; increment cntr of lines to copy
                add   hl, de
                exx
                jr    find_line_from_current ; loop through program
; process NEW command
exec_new:       ret   nz               ; return if arguments follow

new_memory:     ld    hl, (start_memory) ; get lowest memory
                xor   a                ; clear A
                ld    (trace_mode), a  ; clear flag
                ld    (hl), a          ; clear first memory cells
                inc   hl
                ld    (hl), a
                inc   hl
                ld    (prog_end), hl   ; save endofbasic

; initialize program ptrs, clear variables
init_from_start:
                ld    hl, (start_memory)
                dec   hl               ; point to start of memory - 1

; initialize from current position
init_from_current:
                ld    (curlineptr), hl ; save it
                ld    hl, (memory_top) ; copy top ptr
                ld    (string_top), hl
                call  reset_dataptr    ; set program ptr
                ld    hl, (prog_end)   ; end of program text
                ld    (end_of_vars), hl ; start of vars
                ld    (end_arrays), hl ; end of variables

reset_stack_warm:
                pop   bc               ; get return address
                ld    sp, (string_base) ; reset stack
                ld    hl, stringstk    ; HL is  ptr to exprstack
                ld    (stringstkptr), hl ; save ptr
                xor   a                ; clear A
                ld    h, a
                ld    l, a
                ld    (contlineptr), hl ; clear CONT ptr
                ld    (subscript_flag), a ; clear subscript flag
                ld    (inputbuf_cnt), a ; clear cntr of input chars
                push  hl               ; push zero into stacktop
                                       ;  = fallback to reset vector = WARMSTART
                push  bc               ; push return address
loc_5F4:        ld    hl, (curlineptr) ; load ptr to current line
                ret

; clear IOSUPPRESS flag, enabling output again
enable_output:
                xor   a
                ld    (iosuppress), a  ; clear IOSUPPRESS flag

; select console for output
select_console:
                ld    iy, CONSOLEOUT   ; get address of CONSOLEOUT routine
                ld    (output_addr), iy ; put into output vector
                ld    iy, conparam     ; load console parameter set
                ret

tokenize_line:  xor   a                ; clear A
                ld    (byte_103), a
                ld    c, 5             ; load cntr
                ld    de, inputbuf     ; inputbuf, used to compact the inputbuf
                                       ; by replacing keywords with tokens
loop612:        ld    a, (hl)          ; get char
                ld    b, a             ; into B (remember start of string)
                or    a                ; end of buf?
                jp    z, loc_6AD       ; yes exit
                cp    CHAR_EXCL
                jr    c, loc_66B       ; less than "!" ?, skip
                cp    CHAR_QUOTE       ; is it " ?
                jr    z, loc_69B       ; yes, skip
                ld    a, (byte_103)    ; get flag
                or    a                ; is set?
                ld    b, a             ; save in B
                ld    a, (hl)          ; get char
                jr    nz, loc_66B      ; flag is set, accumulate mode
                cp    CHAR_ZERO        ; is char >= '0'?
                jr    c, loc_630       ; no, continue
                cp    CHAR_NINE+1      ; is it <= '9'?
                jr    c, loc_66B       ; yes, accumulate
loc_630:        push  de               ; save DE
                ld    de, token_tbl    ; start of token table
                push  hl               ; ptr to potential keyword
                jr    loop639          ; process token table
loop637:        inc   hl               ;<--+ next char in keyword
                inc   de               ;   | next char in token tbl
loop639:        ld    a, (de)          ;<----+ get char from token table
                or    a                ;   | | end of table?
                jr    z, loc_662       ;   | | yes, exit
                cp    CHAR_SPACE       ;   | | is it a space?
                jr    nz, loc_64A      ;   | | no, skip
                inc   de               ;   | | skip space
loop642:        ld    a, (hl)          ;<+ | | char from input line
                cp    CHAR_SPACE       ; | | | is it a space?
                jr    nz, loc_64A      ; | | | no skip
                inc   hl               ; | | | ignore space
                jr    loop642          ;-+ | | and get next char
loc_64A:        ex    de, hl           ;   | | token table in HL, buf in DE
                ld    a, (de)          ;   | | get buf char
                cp    60h              ;   | | alphabetic?
                jr    c, loc_652       ;   | | no, skip
                and   5Fh              ;   | | make upper case
loc_652:        xor   (hl)             ;   | | compare with token table
                and   MASK_7BIT        ;   | | mask 7 bits only
                ex    de, hl           ;   | | buf in HL, token table in DE
                jr    nz, loc_6A1      ;   | | did not match
                ld    a, (de)          ;   | | get char from token table
                rla                    ;   | |  
                jr    nc, loop637      ;---+ | not yet end of token? loop
                pop   af               ;     | we have a match, discard HL
                ld    a, b             ;     | get token count
                or    80h              ;     | mark as token
                jr    loc_66A          ;     | token  value in A
loc_662:        pop   hl               ;     | end of table reached, restore ptr to keyword
                ld    a, (hl)          ;     | get char
                cp    60h              ;     | > 0x60
                jr    c, loc_66A       ;     | no skip
                and   5Fh              ;     | make upper case
loc_66A:        pop   de               ;     | restore bufptr
loc_66B:        ex    de, hl           ;     | get target buf
                cp    TOKEN_ELSE       ;     | is it token ELSE?
                ld    (hl), CHAR_COLON ;     | put colon in buf
                jr    nz, loc_674      ;     | no, skip
                inc   c                ;     | yes, advance
                inc   hl               ;     | 
loc_674:        ex    de, hl           ;     | restore target buf in DE
                inc   hl               ;     | advance to next char
                ld    (de), a          ;     | accumulate char in buf
                inc   de               ;     | to next position
                inc   c                ;     | 
                sub   CHAR_COLON       ;     | is char ':'?
                jr    z, loc_687       ;     | yes, delimiter
                cp    CHAR_TIC-CHAR_COLON ;  | is it "tic"? (D5)
                ld    b, CHAR_COLON    ;     | put colon in buf
                jr    z, loc_694       ;     | yes, was D5
                cp    CHAR_DATA-CHAR_COLON ; | is token 83 (DATA)?
                jr    nz, loc_68A      ;     | no skip
loc_687:        ld    (byte_103), a    ;     | save flag
loc_68A:        sub   TOKEN_REM-CHAR_COLON ; | is token 8E (REM)?
                jr    z, loc_693       ;     | yes skip
                sub   TOKEN_EXCL-TOKEN_REM ; | is token ! (REM)?
                jp    nz, loop612      ;     | no, loop
loc_693:                               ;     | store zero in B
                ld    b, a             ;     | disable tokenizer until end of line
loc_694:        ld    a, (hl)          ;     | get char
                or    a                ;     | is 0?
                jr    z, loc_6AD       ;     | yes, done
                cp    b                ;     | same as start char?
                jr    z, loc_66B       ;     | yes, done
loc_69B:        inc   hl               ;     | advance to next char
                ld    (de), a          ;     | put char in buf
                inc   c                ;     | increment cntr
                inc   de               ;     | increment targetbufptr
                jr    loc_694          ;     | disable tokenizer until next " is seen, or 0
loc_6A1:        pop   hl               ;     | restore ptr to potential keyword
                push  hl               ;     | save it again
                inc   b                ;     | increment token cntr
                ex    de, hl           ;     | keyword in DE, tokentable in HL
loop6A5:        bit   7, (hl)          ;<+   | test bit of token tbl entry
                inc   hl               ; |   | advance
                jr    z, loop6A5       ;-+   | loop as long as end of token not reached
                ex    de, hl           ;     | keyword in HL, tokentbl in DE
                jr    loop639          ;-----+ loop
loc_6AD:        ld    hl, inputbuf-1   ; point to start of inputbuf -1
                ld    (de), a          ; save three 0 bytes at the end of buf
                inc   de               ; 1st byte = end of line
                                       ; 2nd,3rd = link to next line
                                       ; is 0000 because this is a single
                                       ; line in inputbuf
                ld    (de), a
                inc   de
                ld    (de), a
                ret

ctrl_7f:        ld    a, b             ; get current char count of input line
                dec   a                ; decrement
                or    (iy+ioparams.curpos) ; get current position
                jr    z, get_inputline ; at beginning of line? yes, restart get_inputline
                call  print_backslash  ; no, print a backslash
loop6C0:        djnz  loc_6CA          ;<+ skip if count not zero
                call  print_backslash  ; | two backslahes
                call  print_backslash  ; |
                jr    loc_704          ; | restart get_inputline in new line
loc_6CA:        dec   hl               ; | decrement line ptr
                ld    a, (hl)          ; | get last char
                call  print_char       ; | print it
                call  read_conchar     ; | get a character
                cp    CHAR_RUBOUT      ; | is RUBOUT?
                jr    z, loop6C0       ;-+ yes, loop
                push  af               ; save char entered
                call  print_backslash  ; final backslash
                pop   af               ; restore
                jr    loc_713          ; back with entering data in buf

; print ?? to get more input
; read a new inputbuf, return start of buf in HL
get_moreinput:
                ld    a, CHAR_QUEST
                call  write_char
; prompt ?, get an inputbuf, Z=1 if CTRL-C entered,
; HL points to inputbuf-1
get_input:      ld    a, CHAR_QUEST    ; print a question mark
                call  write_char
                call  print_space      ; print a space
                call  get_inputline    ; get a buf
                inc   hl               ; point to inputbuf
                ld    a, (hl)          ; get char in buf
                dec   hl               ; point to inputbuf-1
                cp    3                ; check for CTRL-C
                ret                    ; exit

con_emit_ctrl_char:
                call  select_console   ; select console for I/O
emit_ctrl_char:
                push  af               ; save char for output
                ld    a, '^'           ; prefix ^ for CTRL char
                call  write_char       ; output it
                pop   af               ; restore char
                or    40h              ; convert to A-Z
                jr    write_char       ; emit it

ctrlu:          call  emit_ctrl_char   ; emit CTRL-U
loc_704:        call  prompt_edit_lineno ; emit the lineno,if any

; read input line in inputbuf
; return inputbuf-1, B = # characters entered,
; buf terminated with 0
get_inputline:
                ld    hl, inputbuf     ; get bufptr
                ld    b, 1             ; initialize count
                ld    a, b
                ld    (inputbuf_cnt), a
loop710:        call  read_conchar     ;<+ read a character
loc_713:        cp    7                ; | is it BEL?
                jr    z, loc_753       ; | yes, skip
                cp    CHAR_CR          ; | is it CR?
                jp    z, loc_CE9       ; | yes, do CRLF and exit
                cp    3                ; | is it CTRL-C?
                jp    z, loc_CE1       ; | yes, store CTRL-C and exit
                cp    CHAR_CTRLU       ; | is CTRL-U?
                jr    z, ctrlu         ; | yes, discard line
                cp    CHAR_RUBOUT      ; | is it RUBOUT?
                jr    z, ctrl_7f       ; | yes, skip
                cp    CHAR_CTRLR       ; | is CTRL-R?
                jr    nz, loc_741      ; | no, skip
                call  emit_ctrl_char   ; | emit CTRL-R
                call  prompt_edit_lineno ; do CRLF and edit prompt, if any
                ld    hl, inputbuf     ; | get current inputbuf
                ld    c, b             ; | copy current line count in C
loop737:        dec   c                ;<--+ pre decrement char cntr
                jr    z, loop710       ;-+ | no more chars? continue with input
                ld    a, (hl)          ;   | get char from buf
                inc   hl               ;   | advance ptr
                call  print_char       ;   | print it
                jr    loop737          ;---+ loop
loc_741:        cp    CHAR_TAB         ; is TAB?
                jr    z, loc_753       ; yes, accept as normal char
                cp    CHAR_LF          ; is LF?
                jr    nz, loc_74F      ; no, skip
                dec   b                ; decrement cntr
                jr    z, get_inputline ; if at beginning, restart get_inputline
                inc   b                ; restore buf cnt
                jr    loc_753          ; accept as normal character
loc_74F:        cp    CHAR_SPACE       ; is another control character?
                jr    c, loop710       ; yes, ignore
loc_753:        ld    c, a             ; save entered char
                ld    a, b             ; get current buf count
                cp    253              ; still space in buf?
                ld    a, 7             ; preload BEL
                jr    nc, loc_75F      ; no space, ring bell
                ld    a, c             ; restore entered char
                ld    (hl), a          ; store it in buf
                inc   hl               ; advance bufptr
                inc   b                ; advance buf ocunt
loc_75F:        call  print_char       ; emit character
                jr    loop710          ; loop

;print a SPACE on current output device
print_space:
                ld    a, CHAR_SPACE

; print char in A on the current output device,
; interpret LF (emit CR+LF+NUL...)
print_char:     cp    CHAR_LF          ; is LF?
                jr    nz, write_char   ; no, emit char
                call  print_crlf       ; do a CRLF
                ld    a, CHAR_LF       ; reload char (LF)
                ret                    ; exit

print_backslash:
                ld    a, CHAR_BSLASH   ; print a backslash (for DEL)

; print out a char in A at the current output device
write_char:     push  bc               ; print_char
                ld    c, a             ; save char
                ld    a, (iosuppress)  ; get IO suppress flag
                or    a
                jr    nz, loc_7B9      ; is set, exit
                ld    a, c             ; get char
                cp    CHAR_TAB         ; is a TAB?
                jr    nz, loc_7A6      ; no, skip
                ld    a, (iy+ioparams.linelength) ; get line length
                and   0F8h ; '?'       ; adjust to multiple of 8
                dec   a                ; -1
                cp    (iy+ioparams)    ; compare to current pos
                jr    c, loc_7A1       ; would TAB skip to next line?, then do CRLF
                ld    a, (iy+ioparams) ; no get current pos
loc_78D:        and   7                ; get # of chars printed in current tab column
                cpl                    ; calculate number of chars still to print
                add   a, 9
                ld    b, a             ; into cntr
                ld    c, CHAR_SPACE    ; load SPACE
loop795:        call  outputvector     ;<----+ emit it
                inc   (iy+ioparams.curpos) ; | advance next position
                djnz  loop795          ;-----+ loop
loc_79D:        ld    c, CHAR_TAB      ; restore char
                jr    loc_7B9          ; exit
loc_7A1:        call  print_crlf       ; advance to next line
                jr    loc_79D          
loc_7A6:        cp    CHAR_SPACE       ; is it a CTRL?
                jr    c, loc_7B6       ; no, skip
                ld    a, (iy+ioparams.curpos) ; get current pos
                cp    (iy+ioparams.linelength) ; compare with line length
                call  z, print_crlf    ; if end of line reached, do CRLF
                inc   (iy+ioparams.curpos) ; advance position
loc_7B6:        call  outputvector ; emit it
loc_7B9:        ld    a, c             ; restore registers, return char in A
                pop   bc
                or    a
                ret

; print a string pointed to by HL, delimited by character with high byte set
print_string:   ld    a, (hl)          ; get character
                res   7, a             ; reset bit 7
                call  print_char       ; emit
                bit   7, (hl)          ; test bit 7
                ret   nz               ; exit if set
                inc   hl               ; advance to next char
                jr    print_string     ; loop

; read a char from console, return in A
read_conchar:   call  CONSOLEIN        ; read a character
                and   MASK_7BIT        ; mask out parity bit
                cp    CHAR_CTRLX       ; is it CTRL-X?
                jr    z, loc_7E1       ; yes, skip
                cp    CHAR_CTRLO       ; is it CTRL-O?
                ret   nz               ; no, return with character read
                call  con_emit_ctrl_char ; print char as ^O
                ld    a, (iosuppress)  ; complement IOSUPPRESS flag
                cpl
                ld    (iosuppress), a
                xor   a                ; return A =0
                ret
loc_7E1:        call  con_emit_ctrl_char
                call  print_crlf       ; print a CRLF
                call  TRAP             ; return to monitor
                xor   a                ; hopefully return here back to BASIC
                ret                    ; with A = 0

exec_llist:     call  select_printer   ; select printer for output
exec_list:      pop   bc               ; drop return address
                call  get_lineno_range ; get a lineno range
                                       ; HL, BC point to first line
                                       ; stack contains end of range
                push  bc               ; save nextlink of first line
list1:          call  print_crlf       ; new line
                pop   hl               ; get nextlink of line in HL
                pop   de               ; DE is lastlineno to list
                LDBC_M                 ; get nextlink into BC
                inc   hl
                ld    a, b             ; is it zero, ie end of program?
                add   a, c
                jr    z, loc_834       ; yes, done, return to interpreter
                call  check_break      ; check for break, exit if CTRL-C
                push  bc               ; save nextlink
                LDBC_M                 ; get current lineno in BC
                inc   hl
                push  bc               ; save it
                ex    (sp), hl         ; stack is ptr to line
                                       ; HL is current lineno
                ex    de, hl           ; swap with lastlineno
                CPHL_DE                ; compare this lineno with lastlineno
                pop   bc               ; restore ptr to line
                jr    c, sub_833       ; end reached, clean up and return to interpreter
                ex    (sp), hl         ; stack is lastlineneo
                                       ; HL is nextlink
                push  hl               ; save
                push  bc               ; save ptr to line
                ex    de, hl           ; HL becomes current lineno
                call  print_HL         ; print it
                pop   hl               ; restore ptr to line
                call  print_space      ; print a space
                call  detokenize       ; detokenize line
                ld    hl, inputbuf     ; load inputbuf
                ld    bc, list1        ; recurse LIST/LLIST
                push  bc               ; on return

sub_82A:        dec   hl               ; point to position before buf
                ld    b, NULL          ; set terminator character
                call  copy_0string     ; copy 0-terminated string to expression stack
                jp    straccu_print    ; print the string

sub_833:        pop   bc
loc_834:        jp    print_prompt

; HL points to program line
; expand tokens  to keywords and copy expanded line into inputbuf
detokenize:     ld    bc, inputbuf-1   ; ptr to inputbuf - 1
                db    3Eh              ; LD A, xx to skip next instruction
                                       ; masks POP HL. LD A is uncritical because
                                       ; A will be overwritten
loop83B:        pop   hl               ; restore ptr to program line again
loop83C:        ld    a, (hl)          ; get char from program line
                inc   bc               ; advance inputbuf
                or    a                ; set flags
                inc   hl               ; advance program line
                ld    (bc), a          ; store char in inputbuf
                ret   z                ; exit if terminating 0 byte
                jp    p, loop83C       ; if character not a token, loop
                cp    TOKEN_ELSE       ; is it an ELSE?
                jr    nz, loc_84A      ; no skip
                dec   bc               ; decrement ptr
                                       ; tokenizer has inserted a ':' before ELSE to
                                       ; improve parsing -> discard this
loc_84A:        sub   80h              ; convert to 0...N
                push  hl               ; save ptr to program line
                ld    hl, token_tbl    ; get token table
                jr    z, kwd_found     ; if zero, found correct keyword
loop852:        bit   7, (hl)          ;<+ test high bit of keyword
                inc   hl               ; | advance token ptr
                jr    z, loop852       ;>+ not at end of keyword, loop
                dec   a                ; | decrement token to find
                jr    nz, loop852      ;-+ correct keyword not yet reached
kwd_found:      ld    a, (hl)          ; get char from keyword
                cp    CHAR_SPACE       ; ignore space, as in GO SUB and GO TO
                jr    z, loc_867
                or    a                ; set sign of character
                res   7, a             ; make positive
                ld    (bc), a          ; put into inputbuf
                jp    m, loop83B       ; was end of keyword? yes, continue
                inc   bc               ; advance inputbufptr
loc_867:        inc   hl               ; advance to next char, skip space
                jr    kwd_found        ; loop

; process FOR/TO/STEP
exec_for:       ld    a, CHAR_RPAREN
                ld    (subscript_flag), a ; this won't match a '(' in find_var,
                                       ; so effectively prevents array variables
                                       ; as FOR variables -> will result in a syntax
                                       ; error when attempting so
                call  exec_let         ; initialize loop variable
                                       ; DE = target address
                                       ; note: this is ensured to be a scalar variable
                ex    (sp), hl         ; HL = return address
                                       ; stack    = curlineptr
                call  discard_open_forloops
                pop   de               ; DE = curlineptr after loop init
                jr    nz, loc_87B      ; some levels discarded?
                add   hl, bc           ; BC = 17 (sizeof FOR structure)
                ld    sp, hl           ; store as new stack position
loc_87B:        ex    de, hl           ; HL = curlineptr after loop init
                ld    c, 0Ah           ; verify we have enough space
                call  verify_space
                push  hl               ; save curlineptr
                call  exec_data        ; advance to end of line or next statement
                ex    (sp), hl         ; HL = curlineptr after loop init
                                       ; stack = curlineptr of loop body
                push  hl               ; push it on stack
                ld    hl, (lineno)     ; FORSTRUCT: replace with current lineno
                ex    (sp), hl         ; curlineptr points to TO

loc_88B:        EXPECT TOKEN_TO        ; expect a TO
                call  assert_numeric   ; require loop variable numeric
                call  expression       ; get TO expression
                push  hl               ; save curlineptr
                call  fpaccu_to_fpreg  ; convert end value into FPREG
                pop   hl               ; restore curlineptr
                PUSH_FPREG             ; FORSTRUCT: push 6 bytes end value
                ld    bc, 8100h        ; load constant 1.0 into FPreg
                ld    ix, 0
                ld    d, c
                ld    e, c
                ld    a, (hl)          ; get next char
                cp    TOKEN_STEP       ; is it STEP token?
                ld    a, 1             ; sign flag: positive
                jr    nz, loc_8BD      ; no, skip
                call  nextchar         ; get STEP expression
                call  expression
                push  hl               ; save curlineptr
                call  fpaccu_to_fpreg  ; put into FPreg
                call  fpaccu_sgn       ; get sign flag 1=positive, ff=negative
                pop   hl               ; restore curlineptr
loc_8BD:        PUSH_FPREG             ; FORSTRUCT: push 6 bytes of STEPsize
                push  af               ; FORSTRUCT: push upward or downward flag
                inc   sp               ; discard flag byte
                push  hl
                ld    hl, (curlineptr) ; FORSTRUCT: push address of target variable
                ex    (sp), hl
loc_8C8:        ld    b, TOKEN_FOR     ; push FOR marker
                push  bc
                inc   sp               ; single byte only
                                       ; no subroutines to discard, so
                                       ; not returning with RET
; enters here after having processed a complete command, i.e. accept either
; EOLN or command separator ':' test for break here
command_done:   call  CONSOLESTAT      ; get console status
                inc   a                ; has a char?
                call  z, con_get_char  ; yes, get the char
                                       ; will accept CTRL-C, XON, XOFF,
                                       ; other chars get lost
                ld    (curlineptr), hl ; save current line ptr
                ld    a, (hl)          ; get current char in process
                cp    CHAR_COLON       ; is it a colon?
                jr    z, execute_command ; yes, process it
                or    a                ; is end of line?
                jp    nz, syntax_error ; no, error
                inc   hl               ; was end of line, advance
                ld    a, (hl)          ; get link to next line H
                inc   hl               ; advance
                or    (hl)             ; get link to next line L
                inc   hl               ; advance
                jp    z, end_program   ; lineno is zero?, end of program
                LDDE_M                 ; get lineno in DE
                ld    (lineno), de     ; store it a new current lineno
                ld    a, (trace_mode)  ; is trace mode on?
                or    a
                jr    z, execute_command ; no, execute the command
loc_8F4:        push  af               ; save trace flag
                call  m, select_printer ; if bit7=1, select printer for output
                push  de               ; save regs
                push  hl
                ld    a, '<'           ; print a '<'
                call  write_char
                ex    de, hl           ; get lineno in HL
                call  print_HL         ; print it out
                ld    a, '>'           ; print '>'
                call  write_char
                pop   hl               ; restore regs
                pop   de
                pop   af               ; restore trace flag
                add   a, a             ; shift left
                jr    nc, execute_command ; was LTRACE? no, execute the command
                call  select_console   ; select console output again
                add   a, a             ; was ALSO bit 6 set?
                jr    c, loc_8F4       ; yes also trace on console
execute_command:            
                call  nextchar         ; get next char/token
                ld    de, command_done ; push return address to call
                                       ; when command is finished
                push  de
loc_91B:        ret   z                ; line was empty, then loop to command_done
execute_token:  sub   80h              ; has a token or a single ASCII
                jp    c, do_assignment ; is not a token, skip
                cp    TOKEN_MIDS-80h   ; is token MID$?
                jp    z, do_lh_mids    ; yes process left-hand-side MID$
                cp    TOKEN_USING-80h  ; is token TAB( ?
                jr    c, loc_939       ; less than this, skip
                sub   TOKEN_ELSE-80h   ; token 9D to C6 are functions that 
                                       ; can't be used in direct mode
                jp    c, syntax_error  ; invalid instruction
                cp    TOKEN_DELETE-TOKEN_ELSE ; token larger than E9 are syntax errors
                jp    nc, syntax_error
                ld    de, token1_dispatch ; obviously a valid token, load jump table
                jr    loc_93C
loc_939:        ld    de, token2_dispatch ; load jump table
loc_93C:        rlca                   ; token * 2 (word index)
                ld    c, a             ; put as index into BC
                ld    b, 0             ; make 16 bit
                ex    de, hl           ; save curlineptr
                                       ; load token_dispatch table into HL
                add   hl, bc           ; point to command entry
                LDBC_N                 ; get command address into BC
                push  bc               ; push it on stack, will be called on
                                       ; return of nextchar
                ex    de, hl           ; restore curlineptr

; get next char    from inputbuf, set CY if digit seen
nextchar:       inc   hl               ; point to next char in buf
skipspace:      ld    a, (hl)          ; get char from    buf
                cp    TOKEN_REM        ; is it "tic" (REM, token D5)?
                jr    nz, loc_955      ; no, skip
loc_94D:        inc   hl               ; next char
                ld    a, (hl)          ; get next char
                cp    CHAR_COLON       ; is it ':'?
                ret   z                ; yes, exit
                or    a
                jr    nz, loc_94D
loc_955:        cp    CHAR_NINE+1      ; is it > '9'? 
                ret   nc               ; yes, exit
                cp    CHAR_SPACE       ; is it space?
                jr    z, nextchar      ; skip space
                cp    CHAR_TAB         ; is it TAB?
                jr    z, nextchar      ; yes skip white space
                cp    CHAR_LF          ; is it LF?
                jr    z, nextchar      ; yes, skip whitespace
                cp    CHAR_ZERO        ; compare with '0'
                ccf                    ; complement CY
                inc   a                ; set flags
                dec   a
                ret                    ; exit

; process RESTORE
exec_restore:   jr    z, reset_dataptr ; no arg, reset DATA ptr to start of program
                call  read_lineno      ; get a lineno
                push  hl               ; save curlineptr
                call  find_line        ; find line
                pop   de               ; restore curlineptr into DE
                jp    nc, undef_stmt_error ; error if line does not exist
                LDHL_BC                ; copy ptr to LINE into HL
                jr    set_dataptr      ; set the data ptr
                                       ; will restore the curlineptr again into HL

; set the ptr to next DATA
reset_dataptr:  ex    de, hl           ; save HL
                ld    hl, (start_memory) ; get memory start
set_dataptr:    dec   hl
set_dataptr1:   ld    (data_ptr), hl   ; save next position to interpret
                ex    de, hl           ; restore HL
                ret

; read a lineno into DE (may be missing -> DE=0)
read_lineno:    dec   hl               ; point to begin of expression
read_lineno_here:            
                call  nextchar         ; get next char
                call  parse_lineno     ; read a lineno into DE
                jr    skipspace        ; skip spaces

input_ctrlc:    pop   bc               ; drop address of variable
input_ctrlc1:   pop   bc               ; drop curlineptr
has_break:      or    a                ; enters here with ctrl-C seen
                jr    break_entry      ; jump into END for break processing

check_break:    call  CONSOLESTAT      ; get console status
                inc   a                ; if A=FF, character present
                ret   nz               ; no char present: exit

con_get_char:   call  read_conchar     ; read a character
                cp    CHAR_CTRLT       ; is it CTRL-T?
                jr    nz, loc_9AB      ; no, skip
                push  hl               ; save HL
                ld    hl, (lineno)     ; get lineno
				TEST_FFFF              ; is valid (!= ffff)
                call  nz, trace_lineno ; yes, emit it
                pop   hl               ; restore
                ret
loc_9AB:        cp    CHAR_CTRLS       ; is it CTRL-S (XOFF)?
                jr    nz, loc_9BA      ; no skip
loop9AF:        call  read_conchar     ;<+ read a char
                cp    CHAR_CTRLC       ; | is it CTRL-C (break)?
                jr    z, loc_9BA       ; | yes exit
                cp    CHAR_CTRLQ       ; | is it CTRL-Q (XON)?
                jr    nz, loop9AF      ;-+ no loop, until XON or break
loc_9BA:        cp    CHAR_CTRLC       ; if not break, return
                ret   nz
                call  con_emit_ctrl_char ; emit ^C
                                       ; and skip to exec_end
                db    3Eh              ; LD A, xxxx to skip next instructions
exec_stop:      ret   nz               ;* more instructions follow?, exit
                db    0F6h             ;* OR xxxx to skip next instruction
                                       ; ensures that A is non zero
exec_end:                              ; ignore unless at end of line
                ret   nz               ; note: when entered through END, A=0
                                       ; when entered through STOP, A = 0xC0
                ld    (curlineptr), hl ; save last position for CONT
break_entry:    pop   bc               ; discard return address
                                       ; will leave interpreter loop on return
end_program:    push  af               ; save token (C0 if stop)
                ld    hl, (lineno)     ; get lineno
                TEST_FFFF              ; is FFFF?
                jr    z, loc_9DA       ; yes, not in program mode
                ld    (contlineno), hl ; save last lineno for continue
                ld    hl, (curlineptr)
                ld    (contlineptr), hl ; save lineptr for continue
loc_9DA:        call  enable_output    ; reenable console out if suppressed
                pop   af               ; restore STOP/END flag
                ld    hl, a_break      ; load break message
                jp    nz, loc_494      ; was a break/STOP, do print BREAK @ LINE ...
                jp    print_prompt     ; display READY prompt and return to interpreter

; process CONT
exec_cont:      ld    e, 11h           ; preload error message "CAN'T CONTINUE"
                ld    hl, (contlineptr) ; get ptr to continue line
                TEST_0
                jr    z, loc_A46       ; is zero: error
                ex    de, hl           ; save continue    line
                ld    hl, (contlineno) ; set current lineno
                ld    (lineno), hl
                ex    de, hl           ; restore line ptr
                ret                    ; return to interpreter, will continue processing

; process LNULL, NULL commands
exec_lnull:     call  temporary_select_printer
exec_null:      call  expression_u8_ae ; get 8 bit expression
                cp    50               ; more than 50?
                jr    nc, illfunc_error ; yes, error
                ld    (iy+ioparams.padcount), a ; store in pad count
                ld    a, CHAR_COMMA    ; get a comma
                cp    (hl)             ; does a comma follow in buf?
                ret   nz               ; no, return
                call  nextchar         ; get next char
                call  expression_u8_ae ; and get the pad character
                ld    (iy+ioparams.padchar), a ; put into PAD field
                ret

; return CY clear, if character is alphabetic
check_alpha:    ld    a, (hl)          ; get char
                cp    CHAR_A           ; is < 'A'?
                ret   c                ; yes return CY set
                cp    CHAR_Z+1         ; is less than '['?
                ccf                    ; complement CY
                ret                    ; return CY clear, if alphabetic

sub_A1C:        call  assert_numeric
                jr    fpaccu_to_16

; read next char andparse following expression
getnext_expression_U16:
                call  nextchar

; has first char of expression in A, parse 16 bit expression
expression_u16: call  expression

; convert fpaccu to a 16 bit number in DE
fpaccu_to_u16:  call  fpaccu_sgn       ; get sign
                jp    m, illfunc_error ; error, if negative

; convert fpaccu to u16
fpaccu_to_16:   ld    a, (fpaccu_exp)  ; load exponent
                cp    91h              ; less than 65536?
                jp    c, fpreg_fix     ; yes, convert
                FPREG_CONST 9180h, 0, 8000h ; constant 65536
                call  fpaccu_compare   ; compare it
loc_A42:        ld    d, c
                ret   z                ; less than this?, okay return
illfunc_error:  ld    e, 5             ; load illegal function error
loc_A46:        jp    print_error

; parse a lineno and return it in DE
parse_lineno:   dec    hl              ; adjust bufptr to point 
                                       ; to previous char
                ld    de, 0            ; set cntr = 0
loopA4D:        inc   hl               ; point to next char
                ld    a, (hl)          ; get char from buf
                or    a                ; empty line?
                ret   z                ; yes exit
                cp    CHAR_ZERO        ; less than '0'?
                ccf
                ret   nc               ; yes exit
                cp    CHAR_NINE+1      ; greater than '9'?
                ret   nc               ; yes exit
                push  hl               ; save bufptr
                ld    hl, 6552         ; maximum lineno 65529 before
                                       ; calculating * 10 + digit
                add   a, a             ; multiply digit with 2
                sbc   hl, de           ; subtract DE from constant
                jp    c, syntax_error  ; lineno too large
                LDHL_DE                ; DE -> HL
                add   hl, de           ; * 2
                add   hl, hl           ; * 4
                add   hl, de           ; * 5
                add   hl, hl           ; * 10
                sub   CHAR_ZERO        ; convert ASCII to digit
                ld    e, a             ; add digit
                ld    d, 0
                add   hl, de
                ex    de, hl           ; into number
                pop   hl               ; restore buf
                jr    loopA4D          ; loop

; process CLEAR
exec_clear:     jr    z, loc_A9A       ; no argument, go directly to clear
                call  expression_u16   ; get argument
                call  skipspace        ; advance beyond expression
                ret   nz               ; return if more arguments
                push  hl               ; save bufptr
                ld    hl, (memory_top) ; get memory top
                sbc   hl, de           ; subtract space for strings
                ex    de, hl           ; DE is start of reserved space
                jp    c, syntax_error  ; more space requested than available memory?
                ld    hl, (prog_end)   ; get ptr to end of program
                ld    bc, 40           ; reserve space for stack
                add   hl, bc
                CPHL_DE                ; subtract string base?
                                       ; do program and string area overlap?
                jp    nc, out_of_memory_error ; yes error
                ex    de, hl           ; HL is start of reserved space
                ld    (string_base), hl ; store it
                pop   hl
loc_A9A:        jp    init_from_current ; interpreter loop

exec_run:       jp    z, init_from_start ; initialize ptrs, clear variables
                call  init_from_current ; init again
                ; will push WARMSTART return twice on stack
                ; this is possibly to mark stack that no GOSUB is pending
                ld    bc, command_done ; get command_done entry point
                jr    pre_goto         ; push entry anddo a GOTO

; process a GOSUB
; this pushes the following structure on the stack
; TOS -> 0x8C inputbufcnt
;     current lineno
;     current line ptr
exec_gosub:     ld    c, 3
                call  verify_space     ; assert 3 words are free
                pop   bc               ; pop return address
                push  hl               ; GOSUB push curlineptr
                ld    de, (lineno)
                push  de               ; GOSUB push current lineno
                ld    a, d             ; is lineno ffff?
                or    e
                inc   a
                ld    a, (inputbuf_cnt) ; get inputbuf count
                ld    d, a             ; save it
                jr    nz, loc_AC1      ; was not in direct mode, skip
                xor    a               ; gosub called from direct mode
                                       ; clear inputbuf cntr
                ld    (inputbuf_cnt), a
loc_AC1:        ld    e, TOKEN_GOSUB   ; gosub marker
                push  de               ; GOSUB push gosubmarker
pre_goto:       push  bc               ; push return address

exec_goto:      call  parse_lineno     ; get a lineno in DE
                call  advance_to_eoln  ; advance to end of line
                push  hl               ; save ptr to next line
                                       ; (points to line terminator)
                ld    hl, (lineno)     ; get current lineno
                CPHL_DE                ; compare this lineno and target lineno
                pop   hl               ; restore line ptr
                inc   hl               ; advance to nextlink
                call  c, find_line_from_current ; must move forward, jump into
                                       ; find_line at current position
loc_ADA:        call  nc, find_line    ; anyway, find the line
                LDHL_BC                ; become new position
                dec   hl
                ret   c                ; if line was found, exit
undef_stmt_error:
                ld    e, 8
loc_AE3:        jp    print_error

exec_return:    ret   nz               ; more cmds follow?, exit
                ld    d, 0FFh          ; do not match any variable
                call  discard_open_forloops ; clean stack from pending open FOR loop
                ld    d, (hl)          ; get inputbuf cntr
                inc   hl               ; advance
                ld    sp, hl           ; remove token word
                cp    TOKEN_GOSUB      ; check whether it is a GOSUB token
                ld    e, 3             ; error "RETURN W/O GOSUB"
                jr    nz, loc_AE3      ; not a GOSUB token: error
                pop   hl               ; restore lineno
                ld    (lineno), hl     ; set Z=1 if lineno is FFFF
                TEST_FFFF 
                ld    hl, inputbuf_cnt ; get current inputbuf cntr
                ld    a, (hl)          ; load it
                ld    (hl), d          ; store the old cntr from GOSUB
                jr    nz, loc_B07      ; skip if called in program context
                or    a                ; inputbuf was overwritten sinc e?
                jp    nz, ill_direct_error ; yes, error
loc_B07:        ld    hl, command_done
                ex    (sp), hl         ; return through command_done

; process DATA
; which is effectively the same as a REM to the program
; exception: will not advance to end of line but to next colon only
; this routine is also called from elsewhere, e.g. IF to advance to the ELSE
exec_data:      db    1                ; LD BC, 0E3Ah to skip next instruction
                                       ; skips the LD C,0 instruction,
                                       ; with NOP remaining
                                       ; loads C with 3A (colon), i.e. stop when
                                       ; EOLN or next colon found
                db    3Ah              ; ** LDA xxxx to skip next instruction
advance_to_eoln:            
                ld    c, NULL          ; ** skipped
                ld    b, NULL
loopB11:        ld    a, c             ;<--+ swap C and B
                ld    c, b             ;   |
                ld    b, a             ;   |
loopB14:        ld    a, (hl)          ;<+ | get next char
                or    a                ; | | end of line?
                ret   z                ; | | yes exit
                cp    b                ; | | is it same as B?
                ret   z                ; | | yes exit
                inc   hl               ; | | advance
                cp    CHAR_QUOTE       ; | | is it a begin of string
                jr    z, loopB11       ;---+ 1st time: B becomes ", C becomes 0
                                       ; | 2nd time: B becomes 0, C becomes "
                                       ; | i.e. wait until end of string or EOLN
                sub   TOKEN_IF         ; | subtract 8A (token IF)
                jr    nz, loopB14      ;-+ no loop
                ; we found an IF here: this routine is also called
                ; by exec_if to find the position of an ELSE, but we have
                ; a nesting of IFs here
                cp    b                ; C=1 if pending ", C=0 if not in string
                adc   a, d             ; increment level of nesting
                ld    d, a             ; into D
                jr    loopB14          ; loop

exec_let:       cp    TOKEN_MIDS       ; is MID$ token?
                jr    z, do_lh_mids    ; yes, LET MID$(xx,y,z) = expression

;entry here for assigment without LET
do_assignment:  call  find_var         ; get address of variable value into DE
                EXPECT TOKEN_EQUAL     ; expect a '=' token
                push  de               ; HL = curlineptr
                                       ; DE save var address
                ld    a, (expr_type)   ; save required    expression type
                push  af
                call  expression1      ; evaluate an expression inro fpaccu
                pop   af
                ex    (sp), hl         ; HL = address of variable
                                       ; stack = curlineptr
                ld    (curlineptr), hl ; save address in curlineptr
                rra                    ; expressiontype expected into CY
                call  verify_exprtype
                jr    nz, store_string ; must store a string
                push  hl               ; target address
                call  fpaccu_to_mem    ; store result
                pop   de               ; DE = target address
                pop   hl               ; restore curlineptr
                ret

store_string:   push  hl               ; save target address
                ld    hl, (fpaccu_mant32) ; get address of string descriptor
                push  hl               ; save it
                inc   hl               ; advance to string length
                inc   hl
                LDDE_M                 ; get string address into DE
                ld    hl, inputbuf+255 ; load end of input line buf
                CPHL_DE                ; check whether string in inputbuf
                jr    nc, loc_B7A      ; is below, skip
                ld    hl, (string_base) ; get base of string
                CPHL_DE                ; is below string base?
                pop   de               ; restore string descriptor in DE
                jr    nc, loc_B82      ; is below string base, skip
                ld    hl, (prog_end)   ; check for constant in program
                CPHL_DE
                jr    nc, loc_B82      ; is in program, skip
                db 3Eh                 ; LD A, xx to skip next instruction
loc_B7A:
                pop   de               ; restore string descriptor
                call  peekpop_str_stringstk ; get off string stack
                ex    de, hl
                call  string_dup       ; make a copy 
loc_B82:
                call  peekpop_str_stringstk ; get off string stack
                pop   hl               ; restore target address
                call  move_to_var      ; move to variable
                pop   hl               ; restore curlineptr 
                ret

; lefthand-side MID$
do_lh_mids:     call  nextchar         ; get next char
                EXPECT CHAR_LPAREN     ; expect left paren
                call  find_var         ; get variable into DE
                call  assert_string    ; verify it is a string
                EXPECT CHAR_COMMA      ; expect a start value for string
                push  de               ; save variable ptr
                call  expression_u8_ae ; get an 8 bit expression
                or    a                ; is zero?
                jp    z, illfunc_error ; yes, error
                push  af               ; save start pos
                ld    e, 0FFh          ; preload maximum position
                ld    a, (hl)          ; get char
                cp    CHAR_RPAREN      ; is it right paren?
                jr    z, loc_BB6       ; yes, skip
                EXPECT CHAR_COMMA      ; expect a comma
                call  expression_u8_ae ; get length expression
loc_BB6:        EXPECT CHAR_RPAREN     ; expect a right paren now
                EXPECT TOKEN_EQUAL     ; expect assignment now
                pop   af               ; restore start position
                ex    (sp), hl         ; get variable ptr in HL
                dec   a                ; adjust start position to 0-based
                cp    (hl)             ; compare with string length in var
                ld    b, 0
                jr    nc, loc_BD0
                ld    c, a             ; start position in C
                ld    a, (hl)          ; get string length in A
                sub   c
                cp    e
                ld    b, a
                jr    c, loc_BD0
                ld    b, e
loc_BD0:        push  bc
                inc   hl
                inc   hl
                LDHL_M B     
                ld    b, 0
                add   hl, bc
                pop   bc
                ex    (sp), hl
                push  bc
                call  string_expression1
                pop   bc
                pop   de
                push  hl
                ld    hl, (fpaccu_mant32)
                ld    a, b
                sub   (hl)
                push  af
                ld    a, b
                jr    c, loc_BED
                ld    a, (hl)
loc_BED:        inc   hl
                inc   hl
                LDBC_M       
                call  copy_string
                pop   af
                jr    c, loc_C01
                jr    z, loc_C01
                ex    de, hl
loopBFB:        ld    (hl), CHAR_SPACE ;<+
                inc   hl               ; |
                dec   a                ; |
                jr    nz, loopBFB      ;-+
loc_C01:        call  fpaccu_getstr
                pop   hl
                ret

; process ON GOTO/GOSUB
exec_on:
                call  expression_u8_ae ; get selector expression
                ld    a, (hl)          ; get next char
                ld    b, a             ; put into b
                cp    TOKEN_GOSUB      ; is it gosub?
                jr    z, process_on    ; ok
                EXPECT TOKEN_GOTO      ; must be goto
                dec   hl               ; point before goto/gosubtoken
process_on:     ld    c, e             ; get expression result into C
loopC16:        dec   c                ;<+ decrement
                ld    a, b             ; | get current token
                jp    z, execute_token ; | correct lineno found,
                                       ; | continue instruction processing
                                       ; | note: the token is either GOTO or GOSUB
                                       ; | in A, ready to parsed, the curlineptr
                                       ; | points directly to the position of
                                       ; | the matching lineno
                call  read_lineno_here ; | parse a line number
                cp    CHAR_COMMA       ; | does a comma follow?
                ret   nz               ; | no, exit
                jr    loopC16          ;-+ loop

; process IF/THEN/ELSE
exec_if:        call  expression1      ; get expression into fpaccu
                ld    a, (hl)          ; get token
                cp    CHAR_COMMA       ; is it comma? ???
                call  z, nextchar      ; yes ignore
                cp    TOKEN_GOTO       ; GOTO token?
                jr    z, loc_C36       ; yes, IF x THEN nnn case
                EXPECT TOKEN_THEN      ; expect a THEN
                dec   hl               ; point to token before
loc_C36:        push  hl               ; save it
                call  fpaccu_sgn       ; get sign of expression
                pop   hl               ; restore curlineptr
                jr    z, loc_C46       ; was condition false?
loopC3D:        call  nextchar         ;<+ get the current token again
                jp    c, exec_goto     ; | if number follows, do a GOTO
                jp    loc_91B          ; | otherwise do the instructions after THEN
loc_C46:        ld    d, 1             ; | load flag for skipping next instructions
loc_C48:        call  exec_data        ; | advance to next colon, using the
                                       ; | DATA skip routine
                or    a                ; | is end of line?
                ret   z                ; | yes done
                call  nextchar         ; | no get next char
                cp    TOKEN_ELSE       ; | is it ELSE?
                jr    nz, loc_C48      ; | no, loop
                dec   d                ; | decrement nesting level
                jr    nz, loc_C48      ; | not zero, find matching ELSE
                jr    loopC3D          ;-+ okay, found the right ELSE, 
                                       ; do GOTO or instruction

exec_lprint:    call  temporary_select_printer
exec_print:     jp    z, print_crlf    ; end of statement, i.e. empty PRINT?
				                       ; just do a CRLF and exit
                cp    TOKEN_USING      ; token USING?
                jp    z, printusing
                cp    TOKEN_TAB        ; token TAB( ?
                jr    z, printtab      ; advance to given position
                cp    TOKEN_SPC        ; token SPC( ?
                jr    z, printspc      ; sprint a given number of spaces
                push  hl               ; save curlinepos
                cp    CHAR_COMMA       ; check for COMMA
                jr    z, printcomma    ; advance to next field
                cp    CHAR_SEMI        ; check for semicolon
                jr    z, printsemi     ; advance to next argument
                pop   bc               ; discard curlinepos from stack
                call  expression1      ; evaluate next field expression
                push  hl               ; save curlinepos
                ld    a, (expr_type)   ; get expression type
                or    a
                jr    nz, loc_C9A      ; not zero, is a string
                call  format_number    ; is a number, do raw formatting
                call  straccu_copy     ; copy string pointed to by HL into straccu
                ld    hl, (fpaccu_mant32) ; point to string length
                ld    a, (iy+ioparams.curpos) ; get current cursor position
                add   a, (hl)          ; addstring length
                cp    (iy+ioparams.linelength) ; is string longer than rest of line?
                call  nc, print_crlf   ; yes, do a CRLF first
                call  straccu_print    ; print out string
                call  print_space      ; print a SPACE
                xor    a               ; skip next instruction  (Z=1)
loc_C9A:        call  nz, straccu_print ; print string
                pop   hl               ; restore curlinepos
                call  skipspace        ; advance to next non-whitespace
                jr    exec_print       ; loop in PRINT until end of line
printcomma:     ld    a, (iy+ioparams.curpos) ; get current print position
                cp    (iy+ioparams.last_field) ; is beyond last field position?
                call  nc, print_crlf   ; yes new line
                jr    nc, printsemi    ; continue printing argument
loopCAE:        sub   14               ;<+ current pos modulo field width (14)
                jr    nc, loopCAE      ;-+ modulo by subtracting
                cpl                    ; complement (became negative)
                                       ; -> number of spaces to print to advance
                jr    loc_CCD          ; print as much spaces to advance to next field
printspc:       scf                    ; set CY flag for SPC(
                                       ; comparison for TAB cleared CY
printtab:       push  af               ; save flag
                call  next_fpaccu_u8   ; get 8 bit expression
                EXPECT CHAR_RPAREN     ; expect a closing ')'
                dec   hl               ; curlineptr to point back to ')'
                pop   af               ; restore flag
                push  hl               ; save curlineptr
                ld    a, 0FFh          ; load maximum possible line position
                jr    c, loc_CCA       ; was SPC( ? skip
                ld    a, (iy+ioparams.curpos) ; get current cursor position
                cpl                    ; complement for subtraction
loc_CCA:        add   a, e             ; add argument
                jr    nc, printsemi    ; position already reached? yes exit
loc_CCD:        inc   a                ; adjust
                ld    b, a             ; store as cntr in B
loopCCF:        call  print_space      ;<+ print space to advance print position
                djnz    loopCCF        ;-+ loop until done
printsemi:      pop   hl               ; restore curlineptr
                call  nextchar         ; get next char/token
                ret   z                ; end of statement? yes exit
                jr    exec_print       ; otherwise loop in PRINT

print_ready_prompt:
                ld    hl, a_ready
                jp    coldvector

loc_CE1:        ld    hl, inputbuf     ; get start of buf
                ld    (hl), a          ; store control char at beginning
                inc   hl               ; advance
                call  emit_ctrl_char   ; emit control character
loc_CE9:        ld    (hl), NULL       ; store NULL as end of buf
                ld    hl, inputbuf-1   ; load inputbuf - 1

; print a CRLF including delaying padding bytes
print_crlf:     ld    a, CHAR_CR       ; load CR
                ld    (iy+ioparams.curpos), a  ; set char position to anything
                call  write_char       ; emit byte
                ld    a, CHAR_LF       ; load LF
                call  write_char       ; emit

print_nul_delay:
                ld    a, (iy+ioparams.padcount) ; get NUL byte cntr
                inc   a                ; +1
loopCFF:        dec   a                ;<-------+ predecrement
                ld    (iy+ioparams.curpos), a ; |  clear charpos (A is 0 on exit)
                ret   z                ;        | exit if finished
                push  af               ;        | save cntr
                ld    a, (iy+ioparams.padchar) ;| get NUL byte
                call  write_char       ;        | emit
                pop   af               ;        | restore cntr
                jr    loopCFF          ;--------+ loop

prompt_edit_lineno:
                call  print_crlf       ; do a CRLF
                ld    a, (prompt_flag) ; print PROMPT?
                or    a
                ret   z                ; no, exit
                push  hl               ; save registers
                push  bc
                ld    hl, (curlineno)  ; get the current EDIT lineno
                call  print_HL         ; emit it
                call  print_space      ; emit a space
                pop   bc               ; exit
                pop   hl
                ret

; process AUTO
exec_auto:      pop   de               ; discard resturn address
                ld    de, 10           ; load default start value
                push  de               ; push it for later
                call  c, read_lineno   ; get a lineno into DE
                ex    de, hl           ; save curlineptr into DE
                                       ; number read into DL
                ex    (sp), hl         ; set new start value, HL=10
                ex    de, hl           ; HL = curlineptr
                                       ; DE = 10 (increment unless second arg follows)
                cp    CHAR_COMMA       ; another arg follows?
                jr    nz, loc_D39      ; no, skip, assume increment=10 (DE)
                call  nextchar         ; advance
                call  c, read_lineno   ; read stepping value into DE
loc_D39:        or    a                ; now EOLN?
                jp    nz, syntax_error ; no, error
                ld    (auto_increment), de ; save as auto increment
                ld    a, d             ; if zero, error
                or    e
                jp    z, syntax_error
                ld    a, 1             ; set AUTO mode
                ld    (prompt_flag), a
                pop   hl               ; restore step width
                jp    auto

exec_lineinput: EXPECT TOKEN_INPUT     ; expect following input token
                db    0F6h             ; OR xxxx to skip next instruction
                                       ; also ensure A != 0 for string input

exec_input:     xor    a               ;** set flag=numeric
                push  af
                ld    a, (hl)          ; get current char
                cp    CHAR_QUOTE       ; is it a string?, e.g. INPUT "Enter data";A,B
                ld    a, 0             ; enable I/O
                ld    (iosuppress), a
                jr    nz, loc_D6E      ; no, skip
                call  copy_strconst    ; get the string to output
                EXPECT CHAR_SEMI       ; expect a semicolon
                push  hl               ; save curlineptr
                call  straccu_print    ; print the string message
                pop   hl               ; restore curlineptr
loc_D6E:        ex    (sp), hl         ; insert curlineptr on stack
                                       ; top of stack is cntr
                push  hl
                call  assert_run_program ; trigger ILLEGAL DIRECT error, 
                                       ; unless in program
                call  get_input        ; print a ? and request an inputbuf
                jp    z, input_ctrlc   ; CTRL-C? yes exit
                pop   af               ; restore type flag
                jr    z, read_input    ; if coming from INPUT, use READ
                                       ; routine to request input
loopD7C:        ex    (sp), hl         ;<+ no, this comes from LINEINPUT
				                       ; | HL is curlineptr
                call  find_var         ; | get a variable
                call  assert_string    ; | verify it is a string variable
                ex    (sp), hl         ; | put curlineptr on stack again
                push  de               ; | save variable address
                ld    b, 0             ; | string terminator (0), i.e. until 
                                       ; | end of buf
                call  copy_0string     ; | copy a string
                ex    de, hl           ; | save ptr to inputbuf
                ld    hl, loc_D93      ; | push handler
                ex    (sp), hl         ; | HL is curlineptr
                push  de               ; | save inputbufptr
                jp    store_string     ; | 
loc_D93:        pop   hl               ; | restore curlineptr
                call  skipspace        ; | advance
                ret   z                ; | end of line? exit
                EXPECT CHAR_COMMA      ; | require a comma
                push  hl               ; | save curlineptr
                call  get_moreinput    ; | print ?? andget an inputbuf
                jp    z, input_ctrlc1  ; | exit if CTRL-C
                jr    loopD7C          ;-+ loop

exec_read:      push  hl               ; save curlineptr
                ld    hl, (data_ptr)   ; get ptr to current data item to read
                db    0F6h             ; OR xxxx to skip next instruction
read_input:     xor   a                ; ** skipped, enters here from exec_input
                ld    (input_read_flag), a ; flag: != 0 if coming from READ,
                                       ; = 0 if coming from INPUT
                ex    (sp), hl         ; stack is data_ptr
                                       ; HL is    curlineptr
                jr    loc_DB7          ; skip
loc_DB2:        EXPECT CHAR_COMMA      ; expect a comma
loc_DB7:        call  find_var         ; get variable name, payload address in DE
                ex    (sp), hl         ; stack is curlineptr
                                       ; HL is data_ptr
                push  de               ; save address of variable
                ld    a, (hl)          ; get char from data_ptr
                cp    CHAR_COMMA       ; is it comma?
                jr    z, get_next_dataitem ; yes, advance
                ld    a, (input_read_flag) ; get input/read flag
                or    a
                jr    nz, find_next_DATA ; comes from READ, skip
                call  get_moreinput    ; INPUT: not enough data, query    more
                jp    z, input_ctrlc   ; if CTRL-C, leave
get_next_dataitem:            
                ld    a, (expr_type)   ; get required expression
                add   a, a             ; make 0 or 2
                jr    z, get_numeric_data ; is numeric, skip
                call  nextchar         ; advance in DATA/INPUT    buf
                ld    d, a             ; save as delimiters
                ld    b, a
                cp    CHAR_QUOTE       ; is it a dbl quote?
                jr    z, loc_DE1       ; yes, skip
                ld    d, CHAR_COLON    ; no, set line delimiter (:) and comma delimiter
                ld    b, CHAR_COMMA
                dec   hl               ; point to start of string
loc_DE1:        call  copy_string1     ; copy a string into straccu
                ex    de, hl           ; save ptr to data/input
                ld    hl, data_handler ; insert DATA/INPUT handler return
                ex    (sp), hl         ; stack is handler
                                       ; HL is address of variable
                push  de               ; save data/input ptr
                jp    store_string     ; copy string to payload address in HL
                                       ; and continue at data_handler
get_numeric_data:            
                call  nextchar         ; get next char
                call  parse_number_fpaccu ; get a number into fpaccu
                ex    (sp), hl         ; stack is data ptr
                                       ; HL is address of variable
                call  fpaccu_to_mem    ; save number read
                pop   hl               ; restore data ptr
data_handler:                          ; advance to next input data
                call  skipspace
                jr    z, loc_E02       ; end of input, skip
                cp    CHAR_COMMA       ; comma follows?
                jp    nz, invalid_input ; no, notify invalid input (INPUT)
                                       ; or syntax error (READ)
loc_E02:        ex    (sp), hl         ; stack is data_ptr
				                       ; HL is curlineptr
                call  skipspace        ; advance to next READ/INPUT variable
                jr    nz, loc_DB2      ; if not end of line, loop
                pop   de               ; restore data ptr
                ld    a, (input_read_flag) ; get mode flag
                or    a
                ex    de, hl           ; HL is input line ptr
                                       ; DE is curlineptr
                jp    nz, set_dataptr1 ; is data, save new data_ptr andexit
                add   a, (hl)          ; A is 0, add char from input line to set flags
                ld    hl, a_extralost  ; load EXTRA LOST message
                push  de               ; save curlineptr
                call  nz, print_string ; if more chars in input line,
                                       ; print *EXTRA_LOST*
                pop   hl               ; restore curlineptr
                ret                    ; done

; HL is data_ptr, find the next DATA statement
find_next_DATA:
                call  exec_data        ; end of DATA line, advance to next DATA
                or    a                ; end of line?
                jr    nz, loc_E31      ; no, advance
                inc   hl               ; at end of line, go to next char
                ld    a, (hl)          ; is the link 0?
                inc   hl
                or    (hl)
                ld    e, 4             ; load OUT OF DATA error code
                jr    z, loc_E92       ; link, is 0, error
                inc   hl               ; advance and get current lineno
                LDDE_M       
                ld    (currentlineno), de ; save it
loc_E31:        call  nextchar         ; get next char
                cp    TOKEN_DATA       ; is it a DATA token?
                jr    nz, find_next_DATA ; no, advance until found
                jp    get_next_dataitem ; yes, found one, continue READ

; process NEXT
exec_next:      ld    de, 0            ; preload zero variable name
sub_E3E:        call  nz, find_var     ; if not EOLN, find the named variable
                ld    (curlineptr), hl ; save curlineptr
                call  discard_open_forloops ; discard loops
                jp    nz, next_wo_for_error ; didn't find a FORSTRUCT? error
                ld    sp, hl           ; correct stack level
                push  de               ; push address of var
                ld    a, (hl)          ; load UP/DOWN marker
                inc   hl               ; advance, point to step value now
                push  af               ; save up/down
                push  de               ; push address of var
                call  mem_to_fpaccu    ; load step value in fpaccu, add6 to HL
                ex    (sp), hl         ; HL = address of var
                                       ; STACK = address of end value
                push  hl               ; push var
                call  load_and_add_fpaccu ; add step to variable
                pop   hl               ; restore address of var
                call  fpaccu_to_mem    ; move result back into for variable
                pop   hl               ; load variable in fpreg
                call  load_fpreg
                push  hl               ; save address of end value
                call  fpaccu_compare
                pop   hl               ; restore ptr to end value
                pop   bc               ; restore UP/DOWN flag in B
                sub   b
                call  restore_de_bc    ; DE = lineno, BC = curlineptr
                jr    z, loc_E75       ; loop ended, continue
                ex    de, hl           ; save new line number
                ld    (lineno), hl
                LDHL_BC                ; load curlineptr
                jp    loc_8C8          ; put up FOR marker again, set SP and
                                       ; continue processing
loc_E75:        ld    sp, hl           ; adjust stack (discard this loop)
                ld    hl, (curlineptr) ; restore curlineptr
                ld    a, (hl)          ; get char
                cp    CHAR_COMMA       ; a NEXT X,Y ?
                jp    nz, command_done ; no, continue processing
                call  nextchar         ; get next char
                call  sub_E3E          ; recurse into NEXT processing

; evaluate an expression, result in fpaccu
expression:     call  expression1

assert_numeric: db    0F6h             ; OR xx to skip next instruction
                                       ; clears CY
assert_string:  scf                    ;** set CY for string type

; CY = 0 for numeric, 1 for string type required
verify_exprtype:
                ld    a, (expr_type)   ; get expression type of last expression
                adc   a, a             ; add CY
                or    a                ; test result
                ret   pe               ; okay?
type_mismatch_error:                   ; no, types don't match
                ld    e, 13
loc_E92:        jp    print_error

string_expression1:
                call  expression1
                jr    assert_string

; evaluate expression
expression1:    dec   hl               ; point to char before expression
                ld    d, 0             ; precedence
; highly recursive expression handler
expresssion2:   push  de               ; save precedence
                ld    c, 1
                call  verify_space     ; verify still 2 bytes free
                call  expr             ; calculate an expression
                ld    (lineptrsave), hl
loc_EA9:        ld    hl, (lineptrsave)
loc_EAC:        pop   bc               ; restore precedence
                ld    a, b             ; into A
                cp    PREC_RELOP
                call  nc, assert_numeric ; result must be numeric
                ld    a, (hl)          ; get current char in line
                ld    d, 0             ; initialize relation flag
loopEB6:                               ;<+ subtract token '>'
                sub   TOKEN_GREATER    ; | '<' is 0
                                       ; | '=' is 1
                                       ; | '>' is 2
                jr    c, loc_ECF       ; | is it lower?
                cp    3                ; | is it above token '<'?
                jr    nc, loc_ECF      ; | no not comparison
                cp    1                ; | is it '='? set CY if less
                rla                    ; | and shift
                                       ; | '<' is 001
                                       ; | '=' is 010
                                       ; | '>' is 100
                xor    d               ; | xor with previous comparison value
                                       ; | <> or >< is 101
                                       ; | <= or =< is 011
                                       ; | >= or => is 110
                cp    d                ; | compare with previous
                ld    d, a             ; | and store as new compare value
                jp    c, syntax_error  ; | did the value decrease, e.g. by
                                       ; | invalid '=' '='?
                                       ; | yes, error
                ld    (arrayvalptr), hl ;| save curlineptr
                call  nextchar         ; | get next char
                jr    loopEB6          ;-+ loop comparison operator
; has expression and a relational operator in D
loc_ECF:        ld    a, d             ; get compare operator
                or    a                ; was zero, not a relational operator
                jp    nz, expr_compare
                ld    a, (hl)          ; store end of relational operator
                ld    (arrayvalptr), hl
                sub   TOKEN_PLUS       ; subtract '+' token
                ret   c                ; exit if less than '+'
                cp    7                ; check if '+', '-', '*', '/', '^', 'AND', 'OR'
                ret   nc               ; no, above or equal, exit
                ld    e, a             ; store dyadic operator in E
                                       ; '+' is 0
                                       ; '-' is 1
                                       ; '*' is 2
                                       ; '/' is 3
                                       ; '^' is 4
                                       ; AND is 5
                                       ; OR  is 6
                ld    a, (expr_type)   ; get expression type
                dec   a                ; FF=numeric, 0=string
                or    e                ; becomes 0 for string addition, FF otherwise
                ld    a, e             ; get operator
                jp    z, string_add    ; handle string addition
                rlca
                add   a, e             ; multiply with 3
                ld    e, a             ; into E
                                       ; note: D=0 because it was no relational operator
                ld    hl, oper_tbl     ; load operator table
                add   hl, de           ; add index
                ld    a, b             ; get current precedence
                ld    d, (hl)          ; get precedence of new operator
                cp    d                ; compare curprec - newprec
                ret   nc               ; above or equal, exit
                inc   hl               ; advance to next char
                call  assert_numeric   ; require current subexpression is numeric
loc_EF7:        push  bc               ; save precedence
                ld    bc, loc_EA9      ; push expression loop
                push  bc               ; as return
                ld    bc, fpaccu_mant32 ; push current accu on stack
                push  bc
                ld    bc, fpaccu_mant54
                push  bc
                ld    bc, fpaccu_mant6
                push  bc
                LDBC_M                 ; get operator handler
                push  bc               ; push it, to be called at the end of expression
                ld    hl, (arrayvalptr) ; restore ptr to start
                                       ; of second operandexpression
                jr    expresssion2

; process single expression
; including functions
;
; precedence:
; 0x46:    OR
; 0x50:    AND
; 0x5a:    NOT
; 0x78:    relational ops
; 0x79:    dyadic '+', '-'
; 0x7c:    '*', '/'
; 0x7d:    monadic    '-'
; 0x7f:    '^'
expr:           xor    a               ; set expression type = numeric
                ld    (expr_type), a
                call  nextchar         ; get char
                jp    c, expr_numeric  ; is numeric?, yes skip
                call  check_alpha
                jr    nc, expr_alpha   ; yes is letter
                cp    TOKEN_PLUS       ; is token '+' ?
                jr    z, expr          ; yes, ignore it
                cp    CHAR_PERIOD      ; is a minus?
                jp    z, expr_numeric
                cp    TOKEN_MINUS      ; is token '-'?
                jr    z, expr_minus
                cp    CHAR_QUOTE       ; is string delimiter?
                jp    z, copy_strconst
                cp    TOKEN_NOT        ; is token NOT
                jp    z, expr_not
                cp    TOKEN_FN         ; is token FN?
                jp    z, expr_fn
                cp    CHAR_AMP         ; is & ?
                jp    z, expr_hex
                sub   TOKEN_SGN        ; subtract token SGN
                jr    nc, expr_function ; is above or equal, i.e. a function
expr_paren:
                EXPECT CHAR_LPAREN     ; expect an opening parenthesis
                call  expression1      ; evaluate expression
                EXPECT CHAR_RPAREN     ; expect closing parenthesis
                ret                    ; exit, result is in fpaccu

expr_minus:
                ld    d, PREC_MINUS    ; set precedence
                call  expresssion2     ; recurse evaluator
                ld    hl, (lineptrsave)
                push  hl
                call  fpaccu_changesign
loc_F62:        call  assert_numeric   ; verify numeric result
                pop   hl
                ret

expr_alpha:     call  find_var         ; locate variable, return address
                                       ; of value/descriptor
loc_F6A:        push  hl               ; save curlineptr
                ex    de, hl           ; get payload address in DE
                ld    (fpaccu_mant32), hl ; store string descriptor in accu
                ld    a, (expr_type)   ; get type of variable
                or    a
                call  z, mem_to_fpaccu ; if numeric, copy value into FPaccu
                pop   hl               ; restore curlineptr
                ret

expr_function:  ld    b, 0             ; high value
                rlca                   ; multiply function token (minus TOKEN_SGN) with 2
                ld    c, a             ; make 16 bit
                push  bc               ; save offset to func table
                call  nextchar         ; get next char
                ld    a, c
                cp    2*(TOKEN_CHRS-TOKEN_SGN) ; less than CHR$()?
                jr    c, loc_FAB       ; yes, handle single parenthesis
                cp    2*(TOKEN_LPOS-TOKEN_SGN) ; is LPOS?
                jr    z, loc_FAB       ; yes, handle single parenthesis
                cp    2*(TOKEN_INSTR-TOKEN_SGN) ; is INSTR?
                jr    z, loc_FA8       ; yes, skip
                jp    nc, illfunc_error ; above or equal? not a function token
                                       ; here we have string functions
                                       ; with more than one argument
                EXPECT CHAR_LPAREN    ; expect opening parenthesis
                call  string_expression1 ; get a string expression
                EXPECT CHAR_COMMA      ; expect a second argument
                ex    de, hl           ; save curlineptr in DE
                ld    hl, (fpaccu_mant32) ; get string descriptor in fpaccu
                ex    (sp), hl         ; insert on stack
                push  hl
                ex    de, hl           ; restore curlineptr
                call  expression_u8_ae ; get an 8 bit expression in E
                ex    de, hl           ; into HL
loc_FA8:        ex    (sp), hl         ; stack is 2nd arg of function
				                       ; HL is offset to function table
                jr    loc_FB3
loc_FAB:        call  expr_paren       ; get single argument expression into fpaccu
                ex    (sp), hl         ; stack is curlineptr
                                       ; HL is offset to function table
                ld    de, loc_F62      ; insert checker that result is numeric
                push  de
loc_FB3:        ld    bc, func_tbl     ; get function offset
                add   hl, bc           ; add to function table
                LDHL_M C               ; get function handler address into HL
                jp    (hl)             ; jump to it

pop_fpreg_and_boolor:
                db    0F6h             ; OR xxxx to skip next instruction
                                       ; ensure A is not zero
pop_fpreg_and_booland:
                xor    a               ;** skipped, clears A
                push  af               ; Z = 1 for AND, 0 for OR
                call  sub_A1C          ; get value from fpaccu
                pop   af               ; restore AF
                ex    de, hl           ; get 1st result in HL
                pop   bc               ; restore operandon stack in BC, IX, DE
                pop   ix
                ex    (sp), hl         ; put 1st result on stack
                ex    de, hl           ; restore rest of fpreg
                call  store_fpaccu     ; save in FPaccu
                push  af               ; save A
                call  fpaccu_to_16     ; get value from fpaccu into DE
                pop   af               ; restore A
                pop   bc               ; restore 1st result
                ld    a, c             ; get first result low
                ld    hl, AC_to_fpaccu ; load routine of result copy routine
                jr    nz, boolor       ; was not zero, to OR operation
                and   e                ; and of low part
                ld    c, a             ; into C
                ld    a, b             ; and of high part
                and   d
                jp    (hl)             ; copy result (AC_to_fpaccu)
boolor:         or    e                ; or of low part
                ld    c, a             ; save
                ld    a, b             ; get high part
                or    d                ; or of high part
                jp    (hl)             ; copy result (AC_to_fpaccu)

; has compare operator in D:
; 001 <
; 010 =
; 011 <=
; 100 >
; 101 <>
; 110 >=
expr_compare:   ld    hl, compare_tbl  ; load handler
                ld    a, (expr_type)   ; get type of expression
                rra                    ; set CY for string
                ld    a, d             ; get condition
                rla                    ; shift in CY
                ld    e, a             ; save in E
                ld    d, PREC_STRCMP   ; set precedence
                ld    a, b
                cp    d                ; compare with current precedence
                ret   nc               ; don't handle yet
                jp    loc_EF7          ; push on stack and get second operand

compare_tbl:    dw    compare_handler  ; routine to handle comparison

compare_handler:            
                ld    a, c             ; get operation
                or    a                ; ensure CY = 0
                rra                    ; discard lowest bit, i.e. convert back
                                       ; to operation code
                POP_FPREG              ; pop 1st operand off stack
                push  af
                call  verify_exprtype  ; check that types match
                ld    hl, exit_compare ; push routine to call on exit
                push  hl
                jp    z, fpaccu_compare ; do comparison of numerics
                                       ; will go to exit_compare on ret
                xor    a               ; string comparison
                ld    (expr_type), a   ; set expression result type numeric
                push  de               ; descriptor of second operand
                call  fpaccu_getstr    ; get 2nd string descr in HL
                pop   de               ; restore 2nd descriptor
                LDBC_M                 ; get string length into BC
                inc   hl
                push  bc               ; save
                LDBC_M                 ; get string address into BC
                push  bc               ; save
                call  peek_str_stringstk ; discard 1st string
                call  restore_de_bc    ; restore 1st string descr in
                                       ; E=length / BC = string addr
                pop   hl               ; pop string address
                ex    (sp), hl         ; stack is string addr
                                       ; HL is string length
                ld    d, l             ; get length into D
                pop   hl               ; HL is string addr
loop1024:       ld    a, e             ;<+ both strings are empty? yes return Z=1
                or    d                ; | 
                ret   z                ; | yes exit with A=0
                ld    a, d             ; | subtract 1 from length of 1st string
                sub   1                ; | 
                ret   c                ; | cntr negative?
                xor    a               ; | clear A
                cp    e                ; | is other length also 0?
                inc   a                ; | set A = 1
                ret   nc               ; | exit if 1st is longer
                dec   d                ; | decrement string lengths
                dec   e                ; |
                ld    a, (bc)          ; | compare strings
                cp    (hl)             ; |
                inc   hl               ; | advance to next string positions
                inc   bc               ; |
                jr    z, loop1024      ;-+ still same? yes loop
                ccf                    ; complement CY
                jp    loc_22CA         ; set A = FF or 1, depending on CY result
exit_compare:   inc   a                ; adjust result to 0, 1, 2
                adc   a, a             ; to 0, 2, 4
                pop   bc               ; restore compare operation
                and   b                ; mask result (will produce 1 <, 2 =, 4    >
                add   a, 0FFh          ; adjust to 0, 1, 3
                sbc   a, a             ; subtract CY -> -1,    0, 2
                jp    s8_to_fp         ; convert into numeric result

expr_not:       ld    d, PREC_NOT      ; set precedence
                call  expresssion2     ; get expression
                call  assert_numeric   ; require it to be numeric
                call  fpaccu_to_16     ; convert to 16 bit
                ld    a, e             ; complement
                cpl                    ; E is low value
                ld    c, a
                ld    a, d
                cpl                    ; A is high value
                call  AC_to_fpaccu     ; convert to numeric
                pop   bc               ; discard caller
                jp    loc_EA9          ; jump back into expression

dim_loop:       call  skipspace        ; skip white space
                ret   z                ; end of line, exit
                EXPECT CHAR_COMMA      ; expect a comma

exec_dim:       ld    bc, dim_loop     ; stay in DIM
                push  bc
                db    0F6h             ; OR 0AFh instruction, sets dim_flag
                                       ; for DIM to non-zero

; find anddefine variable pointed to by HL
; return payload address in DE
find_var:       xor    a               ; clear dim_flag (non-zero if declaring arrays)
                ld    (dim_flag), a    ; set by exec_dim
                ld    b, (hl)          ; get 1st char of variable
loc_106F:       call  check_alpha      ; error, if not alpha
                jp    c, syntax_error
                xor   a                ; preload 2nd letter
                ld    c, a             ; clear expression type
                ld    (expr_type), a
                call  nextchar         ; get a char
                jr    c, loc_1084      ; numeric, skip
                call  check_alpha      ; second letter alpha?
                jr    c, loc_108F      ; no, skip
loc_1084:       ld    c, a             ; store second letter
loop1085:                              ;<+ ignore following variable characters
                call  nextchar         ; | only two are significant
                jr    c, loop1085      ;>+ numeric, ignore
                call  check_alpha      ; | alpha, ignore
                jr    nc, loop1085     ;-+
loc_108F:                
                sub   CHAR_DOLLAR      ; is it a string variable?
                jr    nz, loc_109C     ; no, numeric
                inc   a                ; set expression type = string (1)
                ld    (expr_type), a
                set    7, c            ; set bit 7 to mark string variable
                call  nextchar         ; get next character

; subscript flag is 0 in normal    processing
; ie will here go to var_subscript to evaluate an
; array or FN expression
; flag is 1 for processing exec_kill
; flag is CHAR_RPAREN to locate and create variable/FN
; return ptr to payload in DE
loc_109C:                ; get subscript    flag
                ld    a, (subscript_flag)
                dec   a
                jp    z, kill_matrix   ; subscript flag is 1 (exec_kill), set number of indices = 0
                add   a, (hl)          ; addnext char
                                       ; if it was '(', result will be 0x27
                sub   CHAR_LPAREN-1    ; subtract 0x27
                jr    z, var_subscript ; we found a subscript and are in an expression
                                       ; evaluate the whole item
                xor    a               ; not in var evaluation or func definition
                                       ; clear subscript flag
                ld    (subscript_flag), a
                push  hl               ; save curlineptr
                ld    hl, (end_of_vars)
                ex    de, hl           ; DE = end of vars
                ld    hl, (prog_end)   ; HL = prog_end
find_var1:      CPHL_DE                ; compare with end
                jr    z, var_not_found ; end of variables found?
                ld    a, c             ; compare variable name with name in var table
                sub   (hl)
                inc   hl
                jr    nz, loc_10C3
                ld    a, b
                sub   (hl)
loc_10C3:       inc   hl
                jr    z, var_found     ; found variable, return address of payload in DE
                inc   hl               ; advance to next variable
                                       ; (skip over the floating point/string value)
                inc   hl
                inc   hl
                inc   hl
                inc   hl
                inc   hl
                jr    find_var1        ; loop
var_not_found:  pop   hl               ; restore curlineptr
                ex    (sp), hl         ; stack: curlineptr
                                       ; HL: return address
                push  de               ; save DE
                ld    de, loc_F6A      ; came from expression handler?
                CPHL_DE   
                pop   de               ; restore DE
                jr    z, fpaccu_clear  ; yes, called out of expression handler
                                       ; clear fpaccu
                ex    (sp), hl         ; restore return address, HL = curlineptr
                push  hl               ; save curlineptr
                push  bc               ; save variable name
                ld    bc, 8            ; require space for 8 bytes
                ld    hl, (end_arrays) ; get start of arrays
                push  hl               ; save it
                add   hl, bc           ; calculate new end address
                pop   bc               ; old end address
                push  hl               ; new end address
                                       ; DE is start address
                call  make_space       ; copy area 8 bytes up
                pop   hl
                ld    (end_arrays), hl ; save new end address
                LDHL_BC                ; get end of free space
                ld    (end_of_vars), hl ; new end of variables
loop10F6:       dec   hl               ;<+ clear free space
                ld    (hl), NULL       ; |
                CPHL_DE                ; |
                jr    nz, loop10F6     ;-+ loop
                pop   de               ; get variable name
                LDM_DE                 ; save it in variable
                inc   hl
var_found:      ex    de, hl           ; address of payload of variable in DE
                pop   hl               ; curlineptr in HL
                ret                    ; exit

fpaccu_clear:   ld    (fpaccu_exp), a  ; A is 0
                ld    hl, 2FFh         ; should be irrelevant, as exp=0
                ld    (fpaccu_mant32), hl ; mark newly initialized variable
                pop   hl
                ret

; called to evaluate a var expression for an
; already declared array
var_subscript:  push  hl               ; save curlineptr
                ld    hl, (dim_flag)   ; load dim_flag and expression type
                ex    (sp), hl         ; save it, restore curlineptr
                ld    d, a             ; clear D, A was 0
loop111A:       push  de               ;<+ save registers
                push  bc               ; | 
                call  getnext_expression_U16 ; get index in DE
                pop   bc               ; | restore reg
                pop   af               ; | restore cntr of indices
                ex    de, hl           ; | index in HL
                ex    (sp), hl         ; | push on stack
                push  hl               ; | 
                ex    de, hl           ; | get current line ptr again
                inc   a                ; | increment # of indices
                ld    d, a             ; | into D
                ld    a, (hl)          ; | get next char
                cp    CHAR_COMMA       ; | is it comma?
                jr    z, loop111A      ;-+ yes, loop
                EXPECT CHAR_RPAREN     ; must be end of subscript
                ld    (lineptrsave), hl ; save line ptr
                pop   hl               ; restore expression/var types
                ld    (dim_flag), hl
                ld    e, 0             ; D is # indices, E = 0
                push  de               ; save
                db    11h              ; LD DE, xxxx to skip next 2 instructions
kill_matrix:    push  hl               ;** save curlineptr
                push  af               ;** number of indices
                                       ; is 0 if coming from exec_kill
; var_subscript skips here
                ld    hl, (end_of_vars) ; HL = end_of_vars = start_arrays
                db    3Eh              ; LD A, xx to skip next instruction
loop1142:       add   hl, de           ;**
                ld    de, (end_arrays) ;<+ is end_of_arrays reached?
                CPHL_DE                ; | 
                jr    z, array_declare ; | end of table, not found, go declare it
                ld    a, (hl)          ; | compare with name
                cp    c                ; | 
                inc   hl               ; | 
                jr    nz, loc_1156     ; | 
                ld    a, (hl)          ; | 
                cp    b                ; | 
loc_1156:       inc   hl               ; | 
                LDDE_M                 ; | DE = size of array in bytes
                inc   hl               ; |
                jr    nz, loop1142     ;-+ array not found, loop
                                       ; the array is found
                ld    a, (dim_flag)    ; was it from DIM?
                or    a
                jp    nz, redim_array_error ; yes, and it already exists
                                       ; otherwise error!
                pop   af               ; restore number of indices
                jp    z, kill_array    ; zero, ie comes from exec_kill
                sub   (hl)             ; subtract from #indices of declared array
                jr    z, find_arrayvar ; both match

subscript_range_error:            
                ld    e, 9             ; no, error 
                jp    print_error
array_declare:  ld    de, 6            ; sizeof element
                pop   af               ; restore #indices
                jp    z, loc_1F19      ; zero?
                LDM_BC                 ; store variable name
                inc   hl
                ld    c, a             ; reserve space for index words
                call  verify_space
                inc   hl               ; advance 2 bytes (for total size)
                inc   hl
                ld    (arrayvalptr), hl ; save index table ptr
                ld    (hl), c          ; save #index bytes
                inc   hl
                ld    a, (dim_flag)    ; get dimension flag
                rla                    ; put flag in CY
                ld    a, c             ; load index count
loop118B:       ld    bc, 0Bh          ;<+ load default value for index
                jr    nc, loc_1192     ; | not DIM, skip
                pop   bc               ; | get index
                inc   bc               ; | +1 (zero based)
loc_1192:       LDM_BC                 ; | store index
                inc   hl               ; | 
                push  af               ; | save count
                push  hl               ; | save ptr to index tbl
                call  umultiply16      ; | calculate total size
                ex    de, hl           ; | result in DE
                pop   hl               ; | restore ptr
                pop   af               ; | restore #indices
                dec   a                ; | decrement
                jr    nz, loop118B     ;-+ loop over all indices
                push  af               ; A = 0, save
                ld    b, d             ; get total size in BC
                ld    c, e
                ex    de, hl           ; HL = end of index table
                add   hl, de           ; add total size
                jr    c, subscript_range_error ; overflow? error
                call  check_memfree    ; enough space free?
                ld    (end_arrays), hl ; store new end of array
loop11AE:       dec   hl               ;<+ clear array
                ld    (hl), NULL       ; |
                CPHL_DE                ; |
                jr    nz, loop11AE     ;-+ loop
                inc   bc               ; total size +1
                ld    d, a             ; D = 0, because A is 0
                ld    hl, (arrayvalptr) ; get ptr to array index table
                ld    e, (hl)
                ex    de, hl           ; HL = # indices
                add   hl, hl           ;  HL * 2
                add   hl, bc           ; add size of payload
                ex    de, hl           ; into DE
                dec   hl               ; point to total size field
                dec   hl
                LDM_DE                 ; store array length
                inc   hl
                pop   af               ; restore CY = dimflag
                jr    c, loc_11F2      ; restore curlineptr and exit
find_arrayvar:  ld    b, a             ; clear BC
                ld    c, a
                ld    a, (hl)          ; load #indices of declared array
                inc   hl               ; advance to index list
                db    16h              ; LD D, xx to skip next instruction
                                       ; is uncritical because D is loaded 3 instrs
                                       ; later again
loop11D1:       pop   hl               ;<+ ** pop requested index
                LDDE_M                 ; | load requested subscript in DE
                inc   hl               ; | 
                ex    (sp), hl         ; | get next index dimension
                push  af               ; | save #indices
                CPHL_DE                ; | reqd index to large?
                jr    nc, subscript_range_error ; yes, error
                push  hl               ; | save dimension
                call  umultiply16      ; | HL = DE * BC
                pop   de               ; | restore dimension
                add   hl, de           ; | add dimension size
                pop   af               ; | restore #indices
                dec   a                ; | decrement
                LDBC_HL                ; | move to new position
                jr    nz, loop11D1     ;-+ loop over all indices
                add   hl, hl           ; HL * 2
                add   hl, bc           ; HL + BC
                add   hl, hl           ; HL * 2
                                       ; -> multiply with 6 (element size)
                pop   bc               ; add base
                add   hl, bc
                ex    de, hl           ; address of variable in DE
loc_11F2:       ld    hl, (lineptrsave) ; restore curlineptr
                ret

math_fre:       ld    hl, (end_arrays) ; get end of array space
                ex    de, hl           ; into DE
                ld    hl, 0            ; get SP
                add   hl, sp
                ld    a, (expr_type)   ; check expression type of FRE
                or    a
                jr    z, loc_1211      ; is numeric? skip
                call  fpaccu_getstr    ; put string on expr stack
                                       ; to allow it to be disposed directly
                call  gc               ; do garbage collection
                ld    hl, (string_base) ; get current base of strings
                ex    de, hl           ; into DE
loc_120E:       ld    hl, (string_top) ; get end of strings
loc_1211:       xor    a               ; set expression type to numeric
                ld    (expr_type), a
                sbc   hl, de           ; subtract start of range from end of range
                                       ; => used space by strings

hl_to_fpaccu:   ex    de, hl           ; copy number in DE

; convert unsigned 16 bit DE number into FPACCU
uDE_to_fpaccu:  xor    a               ; sign is 0
                ld    b, 98h           ; preload exponent with 0x98
                jr    loc_1227         ; go convert 16 bit

; convert C into FP, A is sign
AC_to_fpaccu:   ld    b, c

; convert B into FP, A is sign
AB_to_fpaccu:   ld    d, b
                ld    e, 0
                ld    hl, expr_type
                ld    (hl), e          ; clear cell
                ld    b, 90h           ; exponent = 0x90 (16 bit)
loc_1227:       jp    s24_to_fp

; process LPOS()
math_lpos:      ld    a, (prtparam.curpos) ; get printer position
                jr    uA_to_fpaccu

; process POS()
math_pos:       ld    a, (conparam.curpos) ; load current cursor position

; convert unsigned 8 bit in A into FP
uA_to_fpaccu:   ld    b, a             ; put into B
                xor    a               ; clear sign
                jr    AB_to_fpaccu     ; convert into FP

exec_def:       call  locate_fn_info   ; define or read a variable for FN
                                       ; ptr to payload in DE
                call  assert_run_program ; only allowed in program
                ex    de, hl           ; payload to function in HL
                LDM_DE                 ; save current line ptr in function
                ex    de, hl           ; DE = payload, FL = curlineptr
                dec   hl               ; point to previous char
loop1242:       call  nextchar         ;<+ get next char
                jr    z, fn_program    ; | EOLN or end of statement?
                                       ; | yes function subprogram
                cp    TOKEN_EQUAL      ; | token '=' ?
                jr    nz, loop1242     ;-+ no possibly argument list, skip over it
loop124B:       jp    exec_data        ;<+ one-line function, ignore until EOLN or ':'
fn_program:     or    a                ; | is a real EOLN?
                jr    nz, loc_1260     ; | no, something follows
                inc   hl               ; | multiline FN definition at the end of program?
                ld    a, (hl)          ; | 
                inc   hl               ; | 
                or    (hl)             ; | 
                jp    z, syntax_error  ; | yes, not terminated with FNEND
                inc   hl               ; | get new lineno
                LDDE_M                 ; | 
                ld    (lineno), de     ; | and store it
loop1260:       call  nextchar         ;<--+ get next char (argument list or function body)
                jr    z, fn_program    ; | | EOLN or end statement, go loop
                cp    TOKEN_FNEND      ; | | an FNEND found?
                jr    z, loop124B      ;-+ | yes, advance until end 
                                       ;   | of statement (return expression)
                jp    loop1260         ;---+ no, skip over it

expr_fn:        call  locate_fn_info
                ld    a, (expr_type)
                or    a
                push  af
                ld    (lineptrsave), hl
                ex    de, hl
                LDHL_M A     
                or    h
                jp    z, usercall_error
                ld    a, (hl)
                cp    CHAR_SPACE
                jr    nz, loc_12F6
                call  nextchar
                ld    (arrayvalptr), hl
                jr    loc_1292
loop128D:       EXPECT CHAR_COMMA      ;<+
loc_1292:       ld    c, 5             ; |
                call  verify_space     ; |
                ld    a, CHAR_RPAREN   ; |
                ld    (subscript_flag), a
                call  find_var         ; |
                ex    de, hl           ; |
                ld    a, (expr_type)   ; |
                or    a                ; |
                scf                    ; |
                jr    nz, loc_12B7     ; |
                LDBC_M                 ; |
                push  bc               ; |
                inc   hl               ; |
                LDBC_M                 ; |
                push  bc               ; |
                inc   hl               ; |
                LDBC_M                 ; |
                push  bc               ; |
                jr    loc_12BF         ; |
loc_12B7:       push  af               ; |
                push  de               ; |
                ex    de, hl           ; |
                call  de_push_stringstk ;|
                pop   de               ; |
                pop   af               ; |
loc_12BF:       push  hl               ; |
                push  af               ; |
                ex    de, hl           ; |
                ld    a, (hl)          ; |
                cp    CHAR_RPAREN      ; | 
                jr    nz, loop128D     ;-+
                ld    hl, (lineptrsave)
                EXPECT CHAR_LPAREN
                push  hl
                ld    hl, (arrayvalptr)
loop12D3:       call  find_var         ;<+
                ex    (sp), hl         ; |
                call  sub_833          ; |
                ld    a, (hl)          ; |
                cp    CHAR_RPAREN      ; |
                jr    z, loc_12EC      ; |
                EXPECT CHAR_COMMA      ; |
                ex    (sp), hl         ; |
                EXPECT CHAR_COMMA      ; |
                jr    loop12D3         ;-+
loc_12EC:       call  nextchar
                ex    (sp), hl
                EXPECT CHAR_RPAREN
                db    3Eh              ; LD A, xx to skip next instruction
                                       ; LD A is uncritical because	skipspace_buf
                                       ; will destroy A
loc_12F6:       push  de               ;* skipped
                call  skipspace
                jr    z, loc_130C
                EXPECT TOKEN_EQUAL
                call  expression1
                call  skipspace
                jp    nz, syntax_error
                jr    loc_1346
loc_130C:       ld    c, 2
                call  verify_space
                ld    de, (lineno)
                push  de
                ld    d, TOKEN_FN
                push  de
                inc   sp
                jp    command_done

exec_fnend:     jr    nz, has_fnreturn ; return expression follows?
                call  fpaccu_zero      ; no, return value is zero
                ld    (straccu.len), a ; set to 0
                cpl
                ld    (expr_type), a   ; set to FF
                jr    loc_1334         ; continue
has_fnreturn:   call  expression1      ; parse result expression
                call  skipspace        ; advance
                jp    nz, syntax_error ; is not EOLN? error
loc_1334:       ld    d, 0FFh          ; destroy any FOR loops that were in function
                call  discard_open_forloops
                ld    sp, hl           ; store new stack top
                cp    TOKEN_FN         ; is a FN structure on stack?
fnreturn_error: ld    e, 23            ; no, FNRETURN W/O FUNCTION error
                jp    nz, print_error
                pop   de               ; restore old lineno
                ld    (lineno), de

loc_1346:       ld    a, (expr_type)
                inc   a
                jr    z, loc_134F
                dec   a
                jr    nz, loc_137D
loop134F:       pop   de               ;<---+
loop1350:       pop   af               ;<-+ |
                jr    nc, loc_1366     ;  | |
                jr    nz, loc_138C     ;  | |
                pop   hl               ;  | |
                pop   bc               ;  | |
                ld    (hl), b          ;  | |
                dec   hl               ;  | |
                ld    (hl), c          ;  | |
                dec   hl               ;  | |
                pop   bc               ;  | |
                ld    (hl), b          ;  | |
                dec   hl               ;  | |
                ld    (hl), c          ;  | |
                dec   hl               ;  | |
                pop   bc               ;  | |
                ld    (hl), b          ;  | |
                dec   hl               ;  | |
                ld    (hl), c          ;  | |
                jr    loop1350         ;--+ |
loc_1366:       push  af               ;  | |    
                push  de               ;  | |    
                ld    hl, expr_type    ;  | |    
                bit    7, (hl)         ;  | |    
                jr    z, loc_1370      ;  | |    
                ld    (hl), a          ;  | |    
loc_1370:       or    a                ;  | |    
                ld    de, straccu      ;  | |    
                call  nz, de_push_stringstk
                pop   hl               ;  | |    
                pop   af               ;  | |    
                rra                    ;  | |    
                jp    verify_exprtype  ;  | |    
loc_137D:       ld    de, fpaccu_mant32 ; | |    
                call  peekpop_str_exprstk ; |    
                ld    hl, straccu      ;  | |    
                call  move_to_var      ;  | |    
                jr    loop134F         ;--|-+
loc_138C:       call  peekpop_str_stringstk
                ld    a, (hl)          ;  |
                ld    (stringstkptr), hl ;|
                pop   hl               ;  |
                ld    (hl), a          ;  |
                inc   hl               ;  |
                inc   hl               ;  |
                LDM_BC                 ;  |
                jr    loop1350         ;--+

; check if function is called while program is running
assert_run_program:
                push  hl               ; save curlineptr
                ld    hl, (lineno)     ; get lineno
                inc   hl
                TEST_0
                pop   hl
                ret   nz               ; if not zero, return
ill_direct_error:                      
                ld    e, 12            ; illegal direct error
                jp    print_error

locate_fn_info: EXPECT TOKEN_FN        ; expect FN
                or    80h              ; set bit7 of first character of func name
                ld    b, a             ; store in B
                ld    a, CHAR_RPAREN   ; set subscript flag
                ld    (subscript_flag), a
                jp    loc_106F         ; jump into find_var

math_strs:
                call  assert_numeric   ; require argument to be numeric
                call  format_number    ; format it into scratchpad
                call  straccu_copy     ; copy it into straccu
                call  fpaccu_getstr    ; get it
                ld    bc, loc_15C2     ; push result on exprstack later
                push  bc

; reserve space for string (descr at HL) and copy it to this area
string_dup:     ld    a, (hl)          ; get length of string
                inc   hl               ; point to address of string
                inc   hl
                push  hl
                call  reserve_strspace ; reserve space on stack
                pop   hl
                LDBC_M                 ; get string address into BC
                call  straccu_store    ; store string descr in straccu
                push  hl               ; save descriptor
                call  copy_string      ; copy string to reserved space
                pop   de
                ret

; reserve space for A bytes and store descriptor in straccu
straccu_reserve_strspace:
                call  reserve_strspace ; reserve space for A bytes

; store A=len, DE=addr into string accu
straccu_store:  ld    hl, straccu      ; point to current string descriptor
                push  hl               ; save it
                ld    (hl), a          ; save string length
                inc   hl               ; skip a cell
                inc   hl
                LDM_DE                 ; save current address of string
                pop   hl
                ret

straccu_copy:   dec   hl               ; position to double quote character

; enters here with double quote 8") seen
; copy a string constant into straccu, and push on stringstk
; set expr_type to string
copy_strconst:  ld    b, CHAR_QUOTE    ; load constant string terminator

; entered here with terminator 0 as well
copy_0string:   ld    d, b             ; store terminator
copy_string1:   push  hl               ; save ptr to string
                ld    c, 0FFh          ; set char cntr to -1
loop13F4:       inc   hl               ;<+ advance to next string char
                ld    a, (hl)          ; | get string char
                inc   c                ; | increment length
                or    a                ; | is it zero?
                jr    z, string_end    ; | yes, done
                cp    d                ; | is it terminator in D?
                jr    z, string_end    ; | yes, done
                cp    b                ; | is it terminator in B?
                jr    nz, loop13F4     ;-+ no, loop
string_end:     cp    CHAR_QUOTE       ; if terminator was ", advance
                call  z, nextchar
                ex    (sp), hl         ; stack is current position
                                       ; HL is start of string
                inc   hl               ; skip over the starting "
                ex    de, hl           ; put into DE
                ld    a, c             ; get length in A
                call  straccu_store    ; store in string accu

straccu_push_exprstack:                ; get string accu
                ld    de, straccu
                db    3Eh              ; LD A, xx to skip instruction
                                       ; is uncritical, because A is loaded later again
de_push_stringstk:
                push  de
                ld    hl, (stringstkptr) ; HL points to exprstack
                ld    (fpaccu_mant32), hl ; store exprstackptr in fpaccu
                ld    a, 1
                ld    (expr_type), a   ; set expression type to string
                call  move_to_var      ; put into exypression stack
                                       ; HL points to next position
                                       ; DE = stringaccu+6
                CPHL_DE                ; check if exprstack full
                                       ; assume DE was stringaccu
                                       ; on 11th call level, this will
                                       ; copy stringaccu -> stringaccu
                                       ; and will result in overflow
                ld    (stringstkptr), hl ; store new exprstack ptr
                pop   hl               ; restore stringaccu
                ld    a, (hl)          ; get length of string
                ret   nz               ; return if no stack overflow
                ld    e, 16            ; error code "too complex"

print_error1:   jp    print_error      ; exit error

loc_1430:       inc   hl
straccu_copy_print:
                call  straccu_copy

; print string pointed to by fpaccu
straccu_print:  call  fpaccu_getstr    ; get the string pointed to by fpaccu
                call  restore_de_bc    ; restore string descriptor into DE andBC
                                       ; E is length, BC is address
                inc   e                ; preincrement for loop
loop143B:       dec   e                ;<+ decrement length
                ret   z                ; | return if zero
                ld    a, (bc)          ; | get char of string
                call  print_char       ; | print it
                cp    CHAR_CR          ; | was it a CR?
                call  z, print_nul_delay ; yes, print padding characters
                inc   bc               ; | advance to next position
                jr    loop143B         ;-+ loop

; reserve space on string scratchpad
; A=requested size
; DE = start of string space
; HL = string_base
reserve_strspace:
                or    a                ; set flags of requested length
                db    0Eh              ; LD C, xx to skip next instruction
                                       ; is uncritical because C is loaded later again

; will arrive here twice, first coming from reserve_strspace
; and second, if string scratchpad space overflows
reserve_strspace1:            
                pop   af               ; ** skipped
                push  af               ; save A
                ld    hl, (string_base) ; get stringbase into DE
                ex    de, hl
                ld    hl, (string_top) ; get start of strings
                ld    c, a             ; get requested length
                xor    a               ; extend to 16 bit in BC, clear CY
                ld    b, a
                sbc   hl, bc           ; subtract from string start
                CPHL_DE                ; compare with base of strings
                jr    c, loc_1468      ; overflow?, error
                ld    (string_top), hl ; store as new string start
                inc   hl               ; point to string
                ex    de, hl           ; into DE
                pop   af               ; restore requested length
                ret

; on first call, Z is never 1
; on second call, Z is forced to be 1
; to fall thru to no-memory error
loc_1468:       pop   af               ; drop length
                ld    e, 14            ; error "no string space"
                jr    z, print_error1  ; if Z flag == 1, error
                                       ; note comment above
                cp    a                ; enforce Z=1
                push  af               ; save requested size andZ=1
                ld    bc, reserve_strspace1 ; schedule reserve_space again
                push  bc

; try garbage collection
;
; GC algorithm:
; set string_top = memory_top
; while not at string_base do
;   for each string in system
;     find xstring with highest address
;     copy xstring below string_top
;     set string_top = start of xstring
;     correct string descriptor of xstring
;   end for
; end while
;
gc:             ld    hl, (memory_top) ; get highest memory address
gc_outer_while: ld    (string_top), hl ; set as new start of string area
; run the following entirely in the alternative register set
                xor   a                ; clear A' and F' (CY=0)
                ex    af, af'
                ld    de, (string_base) ; DE = loop variable for traversing
                                        ; strings to find the currently upmost one
                                        ; initialized with lowest string in system,
                                        ; so any string above it this will override it
                exx                     ; swap to alternative set
                ld    hl, stringstk     ; HL' = exprstack

; garbage collection of string expression stack
;
; loop to handle scalar vars and expr stack
gc_inner_scalar:            
                ld    de, (stringstkptr) ; DE' = current exprstackptr
                CPHL_DE                ; compare
                ld    bc, gc_inner_scalar ; BC' is addr to return to outer loop
                jr    nz, gc_inner_find_xstring ; stack is not empty,
                                       ; do garbage collection

; garbage collection for string variable list
                ld    hl, (prog_end)   ; get end_of_prog (start_of_vars table)
loop1495:       ld    de, (end_of_vars) ;<+ get end_of_vars ptr
                CPHL_DE                ;  | compare
                jr    z, loc_14AB      ;  | end of vars reached? yes, to array processing
                bit    7, (hl)         ;  | test bit 7 of 1st char of variable name
                                       ;  | is set for string variable
                inc   hl               ;  | point to payload (string descriptor)
                inc   hl               ;  |
                call  gc_inner_find_xstring1 ; check if this is highest (no outer loop)
                jr    loop1495         ;--+ loop until all variables have been traversed

; garbage collection for string arrays
loop14AA:       pop   bc               ;<+ drop saved ptr to array declaration
loc_14AB:       ex    de, hl           ; | HL' is current string descriptor
                ld    hl, (end_arrays) ; | compare with end of end of array ptr
                sbc   hl, de           ; |
                ex    de, hl           ; | HL' is again current string descriptor
                jr    z, loc_14F8      ; | is it at the end of array space? yes, skip
                call  restore_de_bc    ; | DE' is variable name
                                       ; | BC' is total size
                bit    7, e            ; | check variable name bit7=1: string var
                push  hl               ; | save ptr to array declaration
                add   hl, bc           ; | advance to next array element
                jr    z, loop14AA      ;-+ is it not a string array? loop
                ex    (sp), hl         ; stack is ptr to next array element
                                       ; HL' is ptr to declaration
                ld    c, (hl)          ; load # of array indices
                ld    b, 0             ; make 16 bit
                add   hl, bc           ; skip over space for indices
                add   hl, bc
                inc   hl               ; +1 for #indices
                                       ; HL' points to list of array elements
                                       ; note: even for a multidimensional array,
                                       ; these are sequential, and the actual element
                                       ; subscripts are irrelevant

; loop to handle string arrays
gc_inner_array: pop   de               ; DE' is ptr to next array element
                CPHL_DE                ; compare ptr to curr. element with end of array
                jr    z, loc_14AB      ; end reached? loop
                push  de               ; restore end of element list of array
                ld    bc, gc_inner_array ; setup outer loop to find highest string

; find xstring (string with highest address below string_top)
; IX is ptr to descriptor for this
gc_inner_find_xstring:            
                push  bc               ; push address for loop

; HL points to current string descriptor
gc_inner_find_xstring1:            
                ld    a, (hl)          ; A' = length of string
                inc   hl
                inc   hl
                LDDE_M                 ; DE' is addr of potential xstring
                inc   hl               ; advance to next entry
                inc   hl
                inc   hl
                ret   z                ; Z was 1? yes return to inner loop
                                       ; note: on call of gc_inner_find_xstring, Z=0
                                       ; when entering through gc_inner_find_xstring1,
                                       ; Z depends on whether entered
                                       ; with a string var name (bit7=1)
                or    a                ; is string length = 0?
                ret   z                ; yes, return to inner loop
                push  de               ; transfer string address into std reg set
                exx                    ; back to std register set
                pop   bc               ; restore string address
                ld    hl, (string_top) ; get current top of string set
                sbc   hl, bc           ; subtract string address
                exx                    ; alternate register set
                ret   c                ; is above string_top, already GC'd
                exx                    ; back to standard set
                LDHL_DE                ; DE is currently highest string
                sbc   hl, bc           ; subtract curr_high_string - stringaddr
                exx                    ; alternate set
                ret   nc               ; is below curr_high_string
                                       ; don't handle now, and return
                exx                    ; standard set
                ld    d, b             ; DE = new curr_high_string
                ld    e, c
                exx                    ; alternate set
                ex    af, af'          ; restore string length requested
                                       ; and set CY=1 in std set: found a descriptor
                push  hl               ; put descr of curr_high_string into IX
                pop   ix
                ret                    ; return to inner loop

; we have found the string descriptor of xstring in IX
loc_14F8:       ex    af, af'          ; check std set CY flag: IX contains a descriptor
                ret   nc               ; no, we haven't found one,
                                       ; -> terminate garbage collection.
                exx                    ; switch back to std set
                ld    hl, (string_top) ; get start of string space
                ex    de, hl           ; into DE
                ld    c, a             ; get string length of xstring
                ld    b, 0             ; make 16 bit in BC
                add   hl, bc
                dec   hl               ; move string below string_top area
                lddr
                LDHL_DE                ; HL is new string_top
                inc   de               ; DE is new start of string
                ld    (ix-3), d        ; adjust ptr to string in descriptor
                ld    (ix-4), e        ; IX points to end of 6 byte string descriptor
                jp    gc_outer_while   ; loop again with next string

string_add:     push  bc
                push  hl
                ld    hl, (fpaccu_mant32)
                ex    (sp), hl
                call  expr
                ex    (sp), hl
                call  assert_string
                ld    a, (hl)
                push  hl
                ld    hl, (fpaccu_mant32)
                push  hl
                add   a, (hl)
                ld    e, 0Fh        ; error    code
                jp    c, print_error    ; "string to long error"
                call  straccu_reserve_strspace
                pop   de
                call  peek_str_stringstk
                ex    (sp), hl
                call  pop_str_stringstk
                push  hl
                ld    hl, (straccu.addr)
                ex    de, hl
                call  sub_1549
                call  sub_1549
                ld    hl, loc_EAC
                ex    (sp), hl
                push  hl
                jp    straccu_push_exprstack

sub_1549:       pop   hl
                ex    (sp), hl
                LDBC_M       
                inc   hl
                LDHL_M A    
loc_1553:       ld    a, b
                or    c
                ret   z
                ldir
                ret

; copy a string in BC of length A to DE
copy_string:    LDHL_BC                ; get source length into HL
                ld    c, a             ; get length into BC
                ld    b, 0
                jr    loc_1553         ; move string to DE space

; get string, descriptor in fpaccu, HL points to descriptor
string_expression:
                call  assert_string    ; verify that fpaccu contains a string result

; get string from stringstk, pointed to by fpaccu
fpaccu_getstr:  ld    hl, (fpaccu_mant32) ; point to string on exprstack

; popstring descr from exprstack, and discard it from string space, if easily
; possible
pop_str_stringstk:
                ex    de, hl           ; move to DE, i.e. pop
; discard string from exprstack, and also discard it from string space, if at
; the beginning of area
peek_str_stringstk:
                call  peekpop_str_stringstk ; popstring descr from stringstk
                ex    de, hl           ; DE is current stkptr
                                       ; HL is previous stkptr
                ret   nz               ; exit if not popped
                push  de               ; save stkptr
                ld    d, b             ; DE is address of string
                ld    e, c
                dec   de               ; decrement stringptr
                ld    c, (hl)          ; get string length into C
                ld    hl, (string_top) ; get top of strings ptr
                CPHL_DE                ; is at string space?
                jr    nz, loc_1581     ; no, some other string, restore stringstkptr
                ld    b, a             ; clear B (A is zero)
                add   hl, bc           ; yes, discard string from string space
                ld    (string_top), hl
loc_1581:       pop   hl
                ret

; peek or pop a value from expr stack
; if DE == (stringstk-6) pop, else peek
peekpop_str_stringstk:
                ld    hl, (stringstkptr) ; point to exprstack
                dec   hl               ; skip 2 unused bytes in exprstack
                dec   hl
                dec   hl
                ld    b, (hl)          ; get string address into BC
                dec   hl
                ld    c, (hl)
                dec   hl               ; skip unused byte
                dec   hl               ; skip string length
                CPHL_DE                ; compare ptr with DE value
                                       ; something strange happened, don't pop
                ret   nz               ; but exit with NZ
                ld    (stringstkptr), hl ; store ptr
                ret

math_len:       ld    bc, uA_to_fpaccu ; push function convert A to fpaccu
                push  bc

; parse a string argument
; HL = fpaccu
; A = string length
fpaccu_get_string:
                call  string_expression ; get a string expression
                xor   a                ; clear D
                ld    d, a
                ld    (expr_type), a   ; set resulting exprtype to numeric
                ld    a, (hl)          ; get string length
                or    a                ; set flags
                ret

math_asc:       call  fpaccu_get_string ; get string
                jr    z, error_illfunc ; is length zero? error
                inc   hl               ; advance to string address
                inc   hl
                LDDE_M                 ; get address into DE
                ld    a, (de)          ; get first char
                jp    uA_to_fpaccu     ; convert to FPaccu

math_chrs:      ld    a, 1             ; set request size
                call  straccu_reserve_strspace ; reserve space for 1 byte of string
                call  fpaccu_u8        ; Get a single byte
                ld    hl, (straccu.addr) ; load address of reserved string
                ld    (hl), e          ; store char into string space
loc_15C2:       pop   bc               ; drop caller
                jp    straccu_push_exprstack ; push result on exprstack

math_lefts:     call  get_numarg_stack ; get the numeric argument in B
                xor   a                ; starting position is 0
loc_15CA:       ex    (sp), hl         ; HL is string descriptor
                ld    c, a             ; copy starting position
                db    3Eh              ; LD A, xx to skip next instruction
loc_15CD:       push  hl               ; ** skipped, save descriptor
loc_15CE:       push  hl               ; save string descriptor
                ld    a, (hl)          ; get length of string
                cp    b                ; compare with LEFT$ arg
                jr    c, loc_15D5      ; is less?, yes skip
                ld    a, b             ; B = minimum length
                db    11h              ; LD DE, xxxx to skip next instruction
                                       ; is uncritical because next call will destroy DE
loc_15D5:       ld    c, 0             ; ** skipped
                push  bc               ; save B, C
                call  reserve_strspace ; reserve space for result string
                pop   bc
                pop   hl               ; reload descriptor
                push  hl
                inc   hl               ; point to string addr
                inc   hl
                LDHL_M B               ; get string address into HL
                ld    b, 0             ; make C 16 bit
                add   hl, bc           ; add starting position
                LDBC_HL                ; into BC
                call  straccu_store    ; setup target string descriptor (A, DE)
                call  copy_string      ; copy string
                pop   de               ; restore original string descr
                call  peek_str_stringstk ; discard original string, if possible
                jp    straccu_push_exprstack ; put result on expr stack

math_rights:    call  get_numarg_stack ; get numeric argument
                pop   de               ; reload original string descriptor
                push  de
                ld    a, (de)          ; get string length
                sub   b                ; subtract right position to be copied
                jr    loc_15CA         ; use LEFT$ code to copy substring

math_mids:      ex    de, hl           ; HL is string descriptor
                ld    a, (hl)          ; get string length
                pop   de               ; restore first argument
                ld    b, e             ; into B
                inc   b                ; set flags
                dec   b
error_illfunc:  jp    z, illfunc_error ; 1st arg is zero?, error
                push  bc               ; save starting position
                ld    e, 0FFh          ; preload maximum length
                cp    CHAR_RPAREN      ; no third argument?
                jr    z, loc_1617      ; no, don't have it, skip
                EXPECT CHAR_COMMA      ; expect a comma
                call  expression_u8_ae ; get an 8 bit expression in E
loc_1617:       EXPECT CHAR_RPAREN     ; now really expect closing parenthesis
                pop   af               ; restore starting position in A
                ex    (sp), hl         ; stack is curlineptr
                                       ; HL is string descriptor
                dec   a                ; adjust starting pos to 0-justified
                cp    (hl)             ; compare with string pos
                ld    b, 0
                jr    nc, loc_15CE
                ld    c, a             ; starting pos, save in C
                ld    a, (hl)          ; get length again
                sub   c                ; subtract start
                cp    e                ; compare with length to copy
                ld    b, a
                jr    c, loc_15CE
                ld    b, e             ; calculate minimum value
                jr    loc_15CE         ; and use LEFT$ to copy B chars from position C

math_instr:     pop   hl               ; restore curlineptr
                EXPECT CHAR_LPAREN     ; require '('
                call  string_expression1 ; get first argument
                ld    de, (fpaccu_mant32)
                push  de               ; save ptr to string
                EXPECT CHAR_COMMA      ; require comma
                call  string_expression1 ; get second argument
                ld    de, (fpaccu_mant32) ; save ptr to second string
                push  de
                ld    bc, 0FFh         ; preload start B=0, length C=FF
                ld    a, (hl)          ; get next char
                cp    CHAR_COMMA       ; does a start position follow?
                jr    nz, loc_1666     ; no, search from beginning to end
                push  bc               ; save BC
                call  next_fpaccu_u8   ; get a starting position
                pop   bc               ; restore BC
                dec   e                ; adjust start position 0-based
                ld    b, e             ; put into B (starting position)
                inc   e                ; check if it was 255
                jr    z, error_illfunc ; yes error
                ld    a, (hl)          ; get next char
                cp    CHAR_COMMA       ; is it a comma?
                jr    nz, loc_1666     ; no, search from given start position to end
                push  bc               ; save BC
                call  next_fpaccu_u8   ; get length argument
                pop   bc               ; restore start/length
                ld    c, e             ; put length argument
loc_1666:       EXPECT CHAR_RPAREN     ; require closing paren
                ex    (sp), hl         ; stack is curlineptr
                                       ; DE is second string
                push  bc               ; save start/length
                call  pop_str_stringstk ; discard second string
                pop   bc               ; restore start/length
                ex    de, hl           ; DE is second string
                pop   hl               ; restore curlineptr
                ex    (sp), hl         ; stack is curlineptr
                                       ; HL is first string
                push  de               ; save second string
                push  bc               ; save start/length
                call  pop_str_stringstk ; discard first string
                pop   bc               ; restore start/length
                pop   de               ; restore second string
                ld    a, b             ; get start position
                sub   (hl)             ; get length of first string
                jp    nc, loc_16D1     ; check beyond end of string? exit - no match
                neg                    ; length - start
                cp    c                ; compare with length to search
                jr    nc, loc_1686
                ld    c, a             ; set minimum of both
loc_1686:       inc   hl               ; advance to string address
                inc   hl
                LDHL_M A               ; into HL
                push  hl               ; save 1st address
                push  bc               ; save start/length
                ld    c, b             ; start as 16 bit
                ld    b, 0
                add   hl, bc           ; build string start poisiton
                pop   bc               ; restore start/lengh
                ex    de, hl           ; DE is first string address
                                       ; HL is second string descriptor
                ld    a, c             ; get search length
                sub   (hl)             ; subtract length of 2nd string
                jr    c, loc_16D0      ; is less, cannot match in this range, exit
                inc   a                ; add 1 to compare length
                ld    c, a             ; length to check in C
                ld    b, (hl)          ; get length of 2nd string in B
                inc   hl               ; advance to string address
                inc   hl
                LDHL_M A               ; get string address in HL
                ex    de, hl           ; DE is addr of 2nd string
                                       ; HL is addr of 1st string
                ld    a, b             ; get length of 2nd string
                or    a
                jr    z, loc_16C3      ; is zero?, skip
loc_16A6:       push  bc               ; save B = 2nd length, C = compare width
                ld    b, 0             ; make 16 bit comparison length
                ld    a, (de)          ; get first char to search
                cpir                   ; find position of first char of
                                       ; 2nd string in 1st string
                ld    a, c             ; save position
                pop   bc               ; restore length, compare width
                jr    nz, loc_16D0     ; not found
                ld    c, a             ; set new compare length
                push  bc               ; save regs
                push  de
                push  hl
                jr    loc_16BC         ; found first char in 1st string, skip
loop16B6:       inc   de               ;<+ advance ptr to char in 2nd string
                ld    a, (de)          ; | get char
                cp    (hl)             ; | does it match 1st string?
                jr    nz, loc_16BE     ; | no, leave loop
                inc   hl               ; | yes, advance to next position in 1st string
loc_16BC:       djnz  loop16B6         ;-+ end of 2nd string reached? no loop
loc_16BE:       pop   hl               ; restore regs
                pop   de
                pop   bc
                jr    nz, loc_16CC     ; no match, skip
loc_16C3:       pop   de               ; drop 2nd string descr
                sbc   hl, de           ; subtract string positions
                ld    a, l             ; get difference into A -> returned position
loc_16C7:       call  uA_to_fpaccu     ; convert position to FP
                pop   hl               ; restore curlineptr
                ret                    ; done
loc_16CC:       ld    a, c             ; at end of range to search?
                or    a
                jr    nz, loc_16A6     ; no, try again
loc_16D0:       pop   de               ; drop saved 2nd string descr
loc_16D1:       xor    a               ; return position 0 (not found)
                jr    loc_16C7         ; return result

; process INP(port)
math_inp:       call  fpaccu_u8        ; get port number in A
                ld    c, a             ; move into C
                in    a, (c)           ; read from port into A
                jp    uA_to_fpaccu     ; convert to fpaccu

; process OUT command
exec_out:       call  expression_2u8   ; get port in C, data in A
                out    (c), a          ; do out port
                ret

; process WAIT command
exec_wait:      call  expression_2u8   ; get port in C, mask in A
                ld    b, a             ; save mask in B
                push  bc               ; save mask
                ld    e, 0             ; exor argument
                call  skipspace        ; advance
                jr    z, loc_16F7      ; end of line?, no exor
                EXPECT CHAR_COMMA      ; expect a comma
                call  expression_u8_ae ; get exxor expression in E
loc_16F7:       pop   bc               ; restore mask
loop16F8:       in    a, (c)           ;<+ read port
                xor   e                ; | exor with arg
                and   b                ; | mask out bits
                jr    z, loop16F8      ;-+ wait as long port remains zero
                                       ; DANGEROUS: if port bit never changes,
                                       ; program will hang forever, need RESET
                ret

; get numeric second arg off stack, which was
; pushed there by function evaluator
get_numarg_stack:
                ex    de, hl           ; HL = curlineptr
                EXPECT CHAR_RPAREN     ; expect closing paren
                pop   bc               ; restore caller
                pop   de               ; restore 2nd arg of LEFT$/RIGHT$ off stack
                push  bc               ; push caller
                ld    b, e             ; get argument in B
                ret

; get 2 u8 expressions, return first in C, second in E
expression_2u8: call  expression_u8_ae ; get an 8 bit expression
                push  de               ; save it
                EXPECT CHAR_COMMA      ; expect a comma
                call  expression_u8_ae ; get an 8 bit expression in A and E
                pop   bc               ; return 1st arg in C
                ret                    ; return 2nd in A and E

; get next char and parse a 8 bit expression
next_fpaccu_u8: call  nextchar

; evaluate an unsigned 8 bit expression, return in A or E
expression_u8_ae:
                call  expression
fpaccu_u8:      call  fpaccu_to_u16
                ld    a, d             ; larger than 8 bit?
                or    a
                jp    nz, illfunc_error ; yes, error
                call  skipspace        ; advance to non-whitespace
                ld    a, e             ; get result in A and E
                ret

math_val:       call  fpaccu_get_string ; evaluate string expression
                                       ; set exprtype to numeric
                jp    z, fpaccu_zero   ; length of string zero?
                                       ; yes, return 0
                ld    e, a             ; store string length
                                       ; note: D is 0
                inc   hl
                inc   hl
                LDHL_M A               ; get string address into HL
                push  hl               ; save start of string
                add   hl, de           ; get end of string
                ld    b, (hl)          ; save original value
                ld    (hl), d          ; make 0-terminated
                ex    (sp), hl         ; save end of string, HL is start of string
                push  bc               ; save BC
                ld    a, (hl)          ; load first char of number
                call  parse_number_fpaccu ; convert string to number
                pop   bc               ; restore BC
                pop   hl               ; restore end of string
                ld    (hl), b          ; restore original value
                ret                    ; done

; process SWITCH command
exec_switch:    jr    c, loc_1751      ; has an argument?
                call  IOCHECK          ; get IO byte of Zapple monitor
                xor   3                ; invert (why that?)
loc_174D:       ld    c, a             ; put into C
                jp    IOSET            ; set it
loc_1751:       call  expression_u8_ae ; get an 8 bit expression
                cp    4                ; is it >= 4?
                jp    nc, syntax_error ; yes, error
                ld    b, a             ; save it
                call  IOCHECK          ; get IO byte from Zapple monitor
                and   0FCh             ; mask out lowest bits
                or    b                ; put in new console switch
                jr    loc_174D         ; set IO byte

; process LWIDTH, WIDTH commands
exec_lwidth:    call  temporary_select_printer
exec_width:     call  expression_u8_ae ; get an 8 bit expression
                cp    14               ; less or equal 14?
                jp    c, illfunc_error ; invalid
                ld    (iy+ioparams.linelength), a ; store as line width
                ld    c, a             ; get width again
loop1771:       sub   14               ;<+ subtract 14
                jr    nc, loop1771     ;-+ loop until negative
                add   a, 28            ; make a number between 14 and 27
                neg                    ; invert
                add   a, c             ; length of last printout field
                ld    (iy+ioparams.last_field), a
                ret

sub_177E:       call  check_alpha      ; check for alpha character
                jp    c, syntax_error  ; no, return error
                ld    c, a             ; save program name to load
loop1785:       ld    b, 3             ;<+ cntr for chars
loop1787:       call  READERIN         ;<--+ get a char from reader
                jr    c, loc_17A7      ; | | error, exit
                inc   a                ; | | expect at least 3 * FF chars
                jr    nz, loop1785     ;-+ |
                djnz  loop1787         ;---+ wait for three FF
loop1791:       call  READERIN         ;<+ get a char from reader
                jr    c, loc_17A7      ; | error, exit
                inc   a                ; | expect a FF
                jr    z, loop1791      ;-+ loop as long as FF
                dec   a                ; regenerate char
                cp    c                ; compare with file name
                jr    z, loc_17A2      ; yes, correct program found
                call  read_reader_zero ; wait for 00 or EOF
                jr    loop1787         ; redo load
loc_17A2:       ld    c, 7             ; load BEL char
                jp    CONSOLEOUT       ; emit it to console
loc_17A7:       ld    e, 19            ; error code "file not found"
                jr    loc_17BC         ; print error

read_reader_zero:
                ld    b, 3
loop17AD:       call  read_reader      ;<---+ get char
                or    a                ;    | wait for three 00
                jr    nz, read_reader_zero ;|
                djnz  loop17AD         ;----+
                ret                    ; got them

read_reader:    call  READERIN         ; get a char from reader
                ret   nc               ; return if char found
loc_17BA:       ld    e, 20            ; error code "illegal EOF error"
loc_17BC:       jp    print_error
loc_17BF:       inc   d
                call  nz, new_memory
                jr    loc_17BA

; process binary SAVE
exec_save:      call  check_alpha      ; get program name character
                jp    c, syntax_error  ; not found, error
                ld    c, a             ; save in C
                call  nextchar         ; get next char
                jp    nz, syntax_error ; error if not end of line
                push  hl               ; save buf address
                push  bc               ; save program name
loop17D4:       ld    bc, 8FFh         ;<+ load char FF and cntr 8
                call  PUNCHOUT         ; | punch tape
                djnz  loop17D4         ;-+ loop to emit 8 * FF
                pop   bc               ; restore program name
                call  PUNCHOUT         ; write program name
                ld    hl, (prog_end)   ; load end of program
                ex    de, hl           ; into DE
                ld    hl, (start_memory) ; load start of program
loop17E7:       ld    c, (hl)          ;<+ get byte to write
                inc   hl               ; | advance ptr
                call  PUNCHOUT         ; | punch it
                CPHL_DE                ; | compare with end
                jr    nz, loop17E7     ;-+ loop until at end
                ld    bc, 8FFh         ; load byte FF and cntr 8
loop17F7:       call  PUNCHOUT         ;<+ punch trailer
                djnz  loop17F7         ;-+ loop to emit 8 * FF
                pop   hl               ; restore bufptr
                ret                    ; exit

; process LOAD, LOAD?
exec_load:      cp    TOKEN_QUEST      ; "LOAD?"
                ld    d, 0FFh          ; set flag verify
                jr    z, loc_180F      ; yes, skip verify
                ld    (fpaccu_mant32), a ; save argument of LOAD
loc_1807:       call  new_memory       ; clear memory
                ld    d, 0             ; set flag load
                ld    hl, (data_ptr+1) ; ***** this is possibly a bug, it should
                                       ; have been data_ptr+0
loc_180F:       call  nextchar         ; reload char
                call  sub_177E         ; read program name
                ld    hl, (start_memory) ; get start of memory
loop1818:       ld    b, 3             ;<--+
loop181A:       call  READERIN         ;<+ | get a char
                jr    c, loc_17BF      ; | | EOF?
                ld    e, a             ; | | put into E
                sub   (hl)             ; | | compare with memory
                and   d                ; | | and with LOAD=0, VERIFY=FF
                jr    nz, loc_183C     ; | | if not zero, does not match
                ld    (hl), e          ; | | store data
                call  check_memfree    ; | | check whether there is still space
                ld    a, (hl)          ; | | get current character
                or    a                ; | | set flags
                inc   hl               ; | | next cell
                jr    nz, loop1818     ;---+ loop until three consecutive zeros
                djnz  loop181A         ;-+
                ld    (prog_end), hl   ; save end address
                ld    a, (prompt_flag) ; print prompt if flag is zero
                or    a
                call  z, print_ready_prompt
                jp    rebuild_nextchain ; go execute
loc_183C:       ld    e, 21            ; error code "files different"
                jp    print_error

; process ASAVE command
exec_asave:     ret   nz               ; exit if argument follows
                pop   hl               ; discard return address
                ld    bc, 8FFh         ; B=8, C=FF
loop1846:       call  PUNCHOUT         ;<+ write FF to punch device
                djnz    loop1846       ;-+ loop 8 times
                ld    hl, (start_memory) ; get start of program
loop184E:       ld    a, (hl)          ;<+ get next link
                inc   hl               ; |
                or    (hl)             ; |
                inc   hl               ; |
                jr    z, loc_1885      ; | is it zero? end of program
                LDDE_M                 ; | get lineno into DE
                inc   hl               ; |
                push  hl               ; | save position in line
                call  uDE_to_fpaccu    ; | put into FPaccu
                call  format_number    ; | format as number
                inc   hl               ; | advance to number (no sign)
                call  punch_asciz      ; | write number
                pop   hl               ; | restore line ptr
                ld    a, (hl)          ; | get character
                cp    9                ; | is TAB?
                jr    z, loc_186E      ; | yes, ignore
                ld    c, CHAR_SPACE    ; | punch a space
                call  PUNCHOUT         ; |
loc_186E:       call  detokenize       ; | convert line decoded into inputbuf
                push  hl               ; | save current position
                ld    hl, inputbuf     ; | get inputbuf
                call  punch_asciz      ; | dump it
                pop   hl               ; | restore line position
                ld    c, CHAR_CR       ; | punch a CRLF
                call  PUNCHOUT         ; |
                ld    c, CHAR_LF       ; |
                call  PUNCHOUT         ; |
                jr    loop184E         ;-+ loop
loc_1885:       ld    c, CHAR_CTRLZ    ; punch a CTRL-Z
                call  PUNCHOUT
                ld    bc, 8FFh         ; B=8 C=FF
loop188D:       call  PUNCHOUT         ;<+ send a FF to punch
                djnz  loop188D         ;-+ 8 times
                jp    print_prompt     ; return to interpreter loop

; send a 0-terminated string in    HL to PUNCH device
punch_asciz:    ld    a, (hl)          ;<+ get character
                or    a                ; | is 0?
                ret   z                ; | yes exit
                ld    c, a             ; | put int C
                call  PUNCHOUT         ; | and punch
                inc   hl               ; | advance to next position
                jr    punch_asciz      ;-+ loop

temporary_select_printer:
                ex    de, hl           ; save HL
                ld    hl, select_console
                ex    (sp), hl         ; insert into stack
                push  hl
                ex    de, hl           ; restore HL

select_printer: ld    iy, LISTOUT
                ld    (output_addr), iy
                ld    iy, prtparam
                ret

exec_renumber:  ex    af, af'          ; save flags (following arguments?)
                ex    de, hl           ; save curlineptr
                ld    hl, (lineno)     ; get lineno
                TEST_FFFF              ; is it FFFF?
                jp    nz, illfunc_error ; no, error, not in  direct mode
                ld    hl, (start_memory) ; start of program
                ld    a, (hl)          ; get nextlink
                inc   hl
                or    (hl)
                ex    de, hl           ; restore curlineptr
                jp    z, advance_to_eoln ; no program? ignore the whole junk
                ld    de, 10           ; preload starting line
                push  de
                ex    af, af'          ; restore flags
                call  c, read_lineno   ; number follows?, yes get a lineno
                                       ; otherwise reuse the preloaded number
                ld    (renum_new), de  ; save it
                pop   de               ; drop preload
                cp    CHAR_COMMA       ; comma follows?
                jr    nz, loc_18DF     ; no, skip
                call  nextchar         ; get next char
                call  c, read_lineno   ; and read increment
loc_18DF:       ld    (renum_incr), de ; save increment (if not given, DE was 10)
                push  hl               ; save curlineptr
                ld    hl, (start_memory) ; get program start
                inc   hl               ; skip over nextlink
                inc   hl
                LDDE_M                 ; get first line
                pop   hl
                cp    CHAR_COMMA       ; another comma follows?
                jr    nz, loc_18FF     ; no, skip
                call  nextchar         ; get the lineno to start
                call  c, read_lineno
                ld    hl, (renum_new)  ; new lineno to set
                sbc   hl, de           ; subtract the line where to start
                jp    c, syntax_error  ; error if start > new
loc_18FF:       ld    (renum_start), de ; save line to start
                or    a                ; more arguments follow?
                jp    nz, syntax_error ; yes, error
                call  find_line        ; find starting line
                jp    nc, undef_stmt_error ; not found, error
                LDHL_BC                ; ptr to start of line into HL
                exx                    ; alt set
                ld    de, 1            ; initialize cntr of lines
                                       ; DE' is increment
                ld    hl, 0            ; HL' is initial count
                exx
                ld    de, 0FFFFh       ; search for highest line
                call  find_line_from_current ; and count number of lines to renumber
                exx                    ; from now on, ignore reg set, only HL = count of
                                       ; lines is interesting
                dec   hl               ; one less
                ex    de, hl           ; put nmber of lines in DE
                ld    bc, (renum_incr) ; get increment
                ld    a, b             ; increment is zero?
                or    c
                jp    z, syntax_error  ; yes error
                call  umultiply16      ; HL is increment * number of lines
                ld    de, (renum_new)  ; get start of renumbering
                add   hl, de           ; add, to find the highest number to expect
                jp    c, subscript_range_error ; overflow? error
                ld    hl, (start_memory) ; start of program
renum_doline:   inc   hl               ; skip over nextlink
                inc   hl
                LDBC_M                 ; get current lineno in BC
                ex    de, hl           ; save curlineptr
                ld    hl, (renum_start) ; check if renumbering starts?
                sbc   hl, bc           ; is above the lower margin?
                jr    c, loc_194A      ; yes, skip
                jr    z, loc_1954      ; is exactly the starting position
                LDHL_BC                ; no, put lineno in HL
                jr    loc_1957         ; skip
loc_194A:       ld    bc, (renum_incr) ; get increment
                ld    hl, (curlineno)  ; get current line cntr
                add   hl, bc           ; and add, to get the new lineno to set
                jr    loc_1957
loc_1954:       ld    hl, (renum_new)  ; set base of new line
loc_1957:       ld    (curlineno), hl  ; store as the current line handled
                ex    de, hl           ; reload curlineptr
renum_search:   call  nextchar         ;<+ advance to next char in line
renum_search1:  or    a                ; | end of line?
                jp    z, renum_eoln    ; | yes, skip
                cp    TOKEN_GOTO       ; | is GOTO?
                jr    z, renum_target  ; | yes, handle jump target
                cp    TOKEN_GOSUB      ; | is GOSUB?
                jr    z, renum_target  ; | yes, handle
                cp    TOKEN_THEN       ; | is THEN?
                jr    z, renum_target  ; | yes, handle
                cp    TOKEN_ELSE       ; | is ELSE?
                jr    z, renum_target  ; | yes handle
                cp    TOKEN_USING      ; | is USING?
                jr    z, renum_target  ; | yes handle
                cp    TOKEN_RESTORE    ; | is RESTORE?
                jr    nz, renum_search ;-+ no, continue searching
renum_target:   call  nextchar         ; found token with a lineno following?
                jr    nc, renum_search1 ; no, none following, continue searching
                ld    (auto_increment), hl ; save curlineptr
                dec   hl               ; to first char of line
                ld    de, 0            ; initialize number store
                ld    c, 0             ; number of chars in number
loop1988:       call  nextchar         ;<--+ get char
                jr    nc, loc_19B8     ;   | no digit
                push  hl               ;   | save curlineptr
                or    a                ;   | clear CY
                ld    hl, 6552         ;   | maximum lineno before adding last digit
                sbc   hl, de           ;   | would result in too large number?
                jr    nc, loc_19A7     ;   | no, skip
loc_1996:       ld    hl, e_subscr_range ; | print error message
                call  print_string     ;   |
                call  trace_curlineno  ;   | print lineno currently handled
                pop   hl               ;   | restore curlineno
loop19A0:       call  nextchar         ;<+ | advance to next
                jr    c, loop19A0      ;-+ | still a number? advance
                jr    renum_search1    ;   | continue
loc_19A7:       LDHL_DE                ;   | save current number value in HL
                add   hl, hl           ;   | multiply with 10
                add   hl, hl           ;   |
                add   hl, de           ;   |
                add   hl, hl           ;   |
                sub   CHAR_ZERO        ;   | subtract '0' from digit
                ld    e, a             ;   | make 16 bit
                ld    d, 0             ;   |
                add   hl, de           ;   | add to number store
                ex    de, hl           ;   | put number back into DE
                pop   hl               ;   | restore curlineptr
                inc   c                ;   | increment digit count
                jr    loop1988         ;---+ loop
loc_19B8:       ld    a, c             ; save the length of number
                ld    (renum_size), a
                push  hl               ; save curlineptr
                ld    hl, (renum_start) ; get starting position to renumber
                ex    de, hl           ; DE is starting line to renumber
                                       ; HL is lineno found in text
                push  hl               ; save found number
                sbc   hl, de           ; subtract
                jr    c, loc_19F0      ; is below the range to renumber
                call  find_line        ; find the line where to start renumbering
                LDHL_BC                ; ptr to nextlink in HL
                pop   de               ; restore GOTO etc. target
                exx
                ld    hl, (renum_new)  ; initialize cntr for renumbered lines
                                       ; HL' is starting count
                                       ; DE' is increment
                ld    de, (renum_incr)
                exx
                call  find_line_from_current ; find the target
                jr    c, loc_19ED      ; got it
                ld    hl, e_undef_stmt ; otherwise, notify undefined statement error
                push  de               ; save target
                call  print_string
                pop   hl
                call  print_HL         ; print target
                call  trace_curlineno  ; print lineno where found
                pop   hl               ; restore curlineptr
                ld    a, (hl)          ; load current char
                jp    renum_search1    ; continue searching
loc_19ED:       exx                    ; get the calculated new target lineno
                                       ; out of alt set
                push  hl
                exx
loc_19F0:       pop   de               ; into DE
                pop   hl               ; restore old target number
                xor    a               ; positive sign
                ld    b, 98h           ; convert into a FP number
                call  s24_to_fp
                call  format_number    ; format it
                ld    b, 0             ; initialize digit cntr
                inc   hl               ; point to next char in number buf
                push  hl               ; save start of number buf
loop19FF:       ld    a, (hl)          ;<+ get char
                or    a                ; | 
                jr    z, loc_1A07      ; | end of number? yes exit loop
                inc   b                ; | incr digit count
                inc   hl               ; | advance
                jr    loop19FF         ;-+ loop
loc_1A07:       ld    a, (renum_size)  ; get size of old target
                sub   b                ; compare with size of new target
                jr    z, loc_1A49      ; same? great, skip
                jr    c, loc_1A2B      ; new target is larger
                ld    c, a             ; new target is smaller
                ld    b, 0             ; make 16 bit
                ld    hl, (auto_increment) ; get position of old target
                LDDE_HL                ; into DE
                add   hl, bc           ; addsize of new target
                push  hl               ; save end position
                ld    hl, (prog_end)   ; end of program
                sbc   hl, de           ; subtract old target pos
                sbc   hl, bc           ; subtract size of new target
                LDBC_HL                ; count of bytes to move
                pop   hl               ; restore end position
                ldir                   ; move data
                ld    (prog_end), de   ; adjust new end of program
                jr    loc_1A49         ; now has correct space for new target
loc_1A2B:       neg                    ; difference was negative, negate
                ld    c, a             ; make 16 bit, number of bytes to expand
                ld    b, 0
                ld    hl, (prog_end)   ; get end of program
                LDDE_HL                ; into DE
                add   hl, bc           ; calculate new end
                call  check_memfree    ; validate enough free space
                ld    (prog_end), hl   ; store as new end
                ex    de, hl           ; put into DE
                push  hl               ; save old end of program
                ld    bc, (auto_increment) ; get position of old target
                sbc   hl, bc           ; subtract -> number of bytes to move
                LDBC_HL                ; into BC
                pop   hl
                lddr                   ; move bytes to open gap
; now gap is exactly as large to fit the new target number
loc_1A49:       pop   de               ; start of number buf
                ld    hl, (auto_increment) ; position of old target
loop1A4D:       ld    a, (de)          ;<+ get digit from number buf
                or    a                ; | 
                jr    z, loc_1A56      ; | at end? yes leave loop
                ld    (hl), a          ; | put into gap
                inc   hl               ; | advance ptrs
                inc   de               ; |
                jr    loop1A4D         ;-+ loop
loc_1A56:       push  hl               ; save next position
                ld    hl, (start_memory) ; get start of program into DE
                ex    de, hl
                call  rebuild_nextchain1 ; fix next chain
                pop   hl               ; restore curlineptr
                ld    a, (hl)          ; get next char
                cp    CHAR_COMMA       ; is it a comma? ON GOTO case
                jp    z, renum_target  ; yes, stay in loop to fix a potential target
                jp    renum_search1    ; continue line processing
renum_eoln:     inc   hl               ; at end of line, skip over 0 byte
                or    (hl)             ; check  nextlink (A is 0)
                inc   hl
                or    (hl)
                dec   hl
                jp    nz, renum_doline ; not at end of program yet, continue
                ld    de, (renum_start) ; find start line to renumber
                call  find_line
                LDHL_BC                ; put ptr to nextlink in HL
                ld    bc, (renum_incr) ; get increment
                ld    de, (renum_new)  ; get new value
                inc   hl               ; skip over nextlink
loop1A82:       inc   hl               ;<--+
                LDM_DE                 ;   | put new lineno into line
loop1A86:       inc   hl               ;<+ | advance
                ld    a, (hl)          ; | | advance to end of line
                or    a                ; | | 
                jr    nz, loop1A86     ;-+ | 
                ex    de, hl           ;   | save curlineptr
                add   hl, bc           ;   | increment the new lineno
                ex    de, hl           ;   | restore curlineptr
                inc   hl               ;   | check if end of program
                or    (hl)             ;   | 
                inc   hl               ;   | 
                or    (hl)             ;   | 
                jr    nz, loop1A82     ;---+ no, loop, setting next lineno
                call  init_from_current ; clear all variables
                jp    print_prompt     ; return to interpreter loop

trace_curlineno:
                ld    hl, (curlineno)
trace_lineno:   call  print_at_lineno
                jp    print_crlf

; process DELETE
exec_delete:    call  get_lineno_range ; obtain lineno range
                                       ; HL is address of nextlink
                                       ; BC is address of previous nextlink
                pop   de               ; restore ending lineno
                push  bc               ; save starting position
                call  find_line        ; find the ending line from current position
                jp    nc, illfunc_error ; not matched, error
                LDDE_HL                ; DE = start of lines to delete
                ex    (sp), hl         ; insert it in stack
                push  hl
                CPHL_DE                ; subtract address range
                jp    nc, illfunc_error ; negative? yes error
                call  print_ready_prompt ; print READY
                pop   bc               ; restore starting position
                ld    hl, rebuild_nextchain ; return via rebuild_nextchain
                ex    (sp), hl
                ex    de, hl           ; DE = end to delete
                ld    hl, (prog_end)   ; HL = prog_end
                                       ; BC = start to delete
loop1AC7:       ld    a, (de)          ;<+ get byte from range end
                ld    (bc), a          ; | move to range start
                inc   bc               ; | advance ptrs
                inc   de               ; | 
                CPHL_DE                ; | loop until end of program
                jr    nz, loop1AC7     ;-+
                ld    (prog_end), bc   ; save new end of program
                ret

exec_ltrace:    ld    a, 7Fh           ; load flag for LTRACE
                db    1                ; LD BC, xxxx to skip next instruction

; process TRACE/LTRACE
exec_trace:     ld    a, 0BFh          ;** load flag for TRACE
                push  af               ; save LTRACE/TRACE flag
                call  expression1      ; evaluate an expression
                call  skipspace        ; continue
                jr    nz, loc_1AFA     ; if not EOLN, error
                call  fpaccu_sgn       ; get value (0,1)
                dec   a                ; convert to 0/FF
                cpl
                ld    b, a             ; save
                pop   af               ; restore flag
                ld    c, a             ; save
                cpl                    ; complement: LTRACE = 0x80, TRACE = 0x40
                and   b                ; mask bit
                ld    b, a             ; result into B
                ld    a, (trace_mode)  ; get trace mode
                and   c                ; mask out relevant bit
                or    b                ; inject trace flag
                ld    (trace_mode), a  ; save it
                ret
loc_1AFA:       pop   af
                jp    syntax_error

exec_edit:      call  read_lineno      ; read the line number
                ret   nz               ; exit if more arguments follow
                pop   hl               ; drop return address
loc_1B03:       call  find_line        ; find the line to be edited
                jp    nc, illfunc_error ; not found, error
                LDHL_BC                ; put start of line into HL
                inc   hl               ; skip over next link
                inc   hl
                LDBC_M                 ; get lineno into BC
                inc   hl
                push  bc               ; save lineno
                call  detokenize       ; move line into inputbuf
loc_1B15:       pop   hl               ; restore lineno
                push  hl               ; save again
                call  print_HL         ; print lineno
                call  print_space      ; print blank
                ld    hl, inputbuf     ; ptr to inputbuf
                push  hl
                ld    e, 0FFh          ; E = -1
loop1B23:       inc   e                ;<+ increment
                ld    a, (hl)          ; | get char
                and   MASK_7BIT        ; | discard parity bit
                ld    (hl), a          ; | 
                inc   hl               ; | advance
                jr    nz, loop1B23     ;-+ loop until end of buf
                                       ; E is length of line
                pop   hl               ; restore start of buf
                ld    d, a             ; clear D (A is 0)
edit_loop:      ld    b, 0             ; clear count
loop1B2F:       call  read_conchar     ;<+ get char from console
                cp    ':'              ; | between 0-9?
                jr    nc, loc_1B46     ; | 
                cp    CHAR_ZERO        ; | 
                jr    c, loc_1B46      ; | no, skip
                sub   CHAR_ZERO        ; | make digit
                ld    c, a             ; | into C
                ld    a, b             ; | get count
                rlca                   ; | multiply with 10
                rlca                   ; | 
                add   a, b             ; | 
                rlca                   ; | 
                add   a, c             ; | add digit
                ld    b, a             ; | new count
                jr    loop1B2F         ;-+ loop
loc_1B46:       push  hl               ; save bufptr
                ld    hl, edit_loop
                ex    (sp), hl         ; put edit_loop on stack
                                       ; HL is bufptr
                dec   b                ; check if count is 0
                inc   b
                jr    nz, loc_1B50
                inc   b                ; yes, set to 1
loc_1B50:       exx                    ; alt register set
loop1B51:       ld    hl, edit_tbl     ;<--+ HL' is edit_tbl
loop1B54:       cp    (hl)             ;<+ | compare entered character with table entry
                inc   hl               ; | | advance
                LDBC_M                 ; | | get handler address into BC'
                inc   hl               ; | | 
                push  bc               ; | | save on stack
                exx                    ; | | std set
                ret   z                ; | | if command found, return to handler routine
                exx                    ; | | to alt set
                pop   bc               ; | | drop handler address
                inc   (hl)             ; | | check for terminating 0 byte
                dec   (hl)             ; | | 
                jr    nz, loop1B54     ;-+ | no loop
                cp    60h              ;   | is it a lower case letter?
                jr    c, loc_1B6B      ;   | no, ring bell for error
                and   5Fh              ;   | make it upper case
                jr    loop1B51         ;---+ and try again
loc_1B6B:       exx                    ; return to std set
                ld    a, 7             ; ring BEL
                jp    write_char       ; and return to edit_loop
edit_tbl:       db    CHAR_SPACE
                dw    edit_right
                db    'Q'
                dw    break_entry
                db    'L'
                dw    edit_list
                db    'F'
                dw    edit_find
                db    'I'
                dw    edit_insert
                db    'D'
                dw    edit_delete
                db    CHAR_CR
                dw    edit_end
                db    'R'
                dw    edit_replace
                db    'E'
                dw    edit_save
                db    'X'
                dw    edit_append
                db    'K'
                dw    edit_kill
                db    'H'
                dw    edit_deleoln
                db    CHAR_RUBOUT
                dw    edit_left
                db    'A'
                dw    edit_reload
                db    0

edit_reload:    pop   bc               ; drop argument
                pop   de               ; restore current line to edit
                call  print_crlf       ; print CRLF
                jp    loc_1B03         ; find and reload line in DE

edit_right:     ld    a, (hl)          ;<+ get current char
                or    a                ; | at end of line?
                ret   z                ; | yes, exit to edit_loop
                inc   d                ; | increment pos
                call  print_char       ; | print character
                inc   hl               ; | advance ptr
                djnz    edit_right     ;-+ loop N times
                ret                    ; exit to edit_loop

edit_kill:      push  hl               ; save position
                ld    hl, print_backslash1 ; print a backslash
                ex    (sp), hl         ; put on stack, HL is position
                scf                    ; set CY
edit_find:      push  af               ; save flags
                call  read_conchar     ; get character
                ld    c, a             ; save in C
                pop   af               ; restore flags
                dec   (hl)             ; at end of line?
                inc   (hl)
                ret   z                ; yes, exit to print_backslash1
                push  af               ; save flags
                call  c, print_backslash1 ; if in kill mode, print char X as "\X"
                ld    a, (hl)
loop1BC3:       call  print_char       ;<+
                pop   af               ; | restore flags
                push  af               ; | save again
                jr    nc, loc_1BCF     ; | if not in kill mode, skip
                call  del_char_from_buf ;| delete char from buf
                djnz  loc_1BD1         ; | loop for count
loc_1BCF:       inc   hl               ; | advance to next position
                inc   d                ; | advance char cntr
loc_1BD1:       ld    a, (hl)          ; | get character
                or    a                ; | 
                jr    z, loc_1BDA      ; | end of line? yes skip
                cp    c                ; | is it the char to find
                jr    nz, loop1BC3     ;>+ no loop
                djnz  loop1BC3         ;-+ loop N times
loc_1BDA:       pop   af               ; drop flags
                ret                    ; return to edit_loop

edit_list:      call  sub_82A          ; print buf
                call  print_crlf       ; do CRLF
                pop   bc               ; cleanup stack
                jp    loc_1B15         ; loop to EDIT print line

edit_delete:    ld    a, (hl)          ; get char
                or    a                ; is it end of line?
                ret   z                ; yes, exit to edit_loop
                ld    a, CHAR_BSLASH   ; print a backslash
                call  write_char       ;<+
loop1BEE:       ld    a, (hl)          ; | print char
                or    a                ; | 
                jr    z, print_backslash1 ; unless it is end of line
                call  print_char       ; | 
                call  del_char_from_buf ;| delete char from buf
                djnz    loop1BEE       ;-+ loop N times

print_backslash1:
                ld    a, CHAR_BSLASH
                jp    write_char

edit_replace:   ld    a, (hl)          ;<+ get char
                or    a                ; | 
                ret   z                ; | if end of line, exit to edit_loop
                call  read_conchar     ; | get character
                call  print_char       ; | print it
                ld    (hl), a          ; | put into buf
                inc   hl               ; | advance bufptr
                inc   d                ; | advance buf count
                djnz    edit_replace   ;-+ loop N times
                ret

edit_deleoln:   ld    (hl), 0          ; set end of buf here
                ld    e, d             ; store buf count
edit_append:    ld    b, 0FFh          ; go as much right as possible
                call  edit_right
edit_insert:    call  read_conchar     ;<+ get char from console
                cp    CHAR_CR          ; | is it CR?
                jr    z, edit_end      ; | yes, done
                cp    CHAR_ESC         ; | is it ESCAPE?
                ret   z                ; | yes, leave edit mode
                cp    CHAR_RUBOUT      ; | is it RUBOUT?
                jr    nz, loc_1C33     ; | no, skip
                dec   d                ; | check position
                inc   d                ; | 
                jr    z, loc_1C3A      ; | at the start of buf
                dec   hl               ; | no, decrement bufptr
                dec   d                ; | and cntr
                ld    a, (hl)          ; | get the char
                call  print_char       ; | print it
                call  del_char_from_buf ;| and delete it from buf
                jr    edit_insert      ;-+ loop
loc_1C33:       push  af               ; save character
                ld    a, e             ; get edit count
                cp    0FFh             ; is it 255?
                jr    c, loc_1C41      ; no, not yet, go insert the char
                pop   af               ; drop character
loc_1C3A:       ld    a, 7             ; ring bell (end of buf)
                call  write_char
                jr    edit_insert      ; loop
loc_1C41:       sub   d                ; edit count - buf position
                inc   e                ; increment both
                inc   d
                push  de               ; save DE
                ex    de, hl           ; bufptr
                ld    l, a             ; make 16 bit
                ld    h, 0
                add   hl, de           ; bufptr + insertion length
                LDBC_HL                ; into BC
                inc   bc               ; add 1
                call  loc_41F          ; reserve space
                pop   de               ; restore DE
                pop   af               ; restore char inserted
                call  print_char       ; print it
                ld    (hl), a          ; put into buf
                inc   hl
                jr    edit_insert      ; loop

edit_left:      ld    a, d             ;<+ get buf pos
                or    a                ; | already at the beginning?
                ret   z                ; | yes ignore
                dec   d                ; | move pos andptr to left
                dec   hl               ; | 
                ld    a, (hl)          ; | print char
                call  print_char       ; | 
                djnz  edit_left        ;-+ loop N times
                ret

edit_end:       call  sub_82A          ; print the whole line
edit_save:      call  print_crlf       ; print a CRLF
                pop   bc               ; cleanup stack
                pop   de               ; restore lineno
                scf                    ; set CY
                push  af               ; save it
                ld    hl, inputbuf     ; load inputbuf
                jp    loc_4F9          ; enter into line insertion routine

del_char_from_buf:
                push  hl               ; save buf position
                dec   e                ; decrement count
loop1C77:       ld    a, (hl)          ;<+ get character
                or    a                ; | end of buf reached
                jr    z, loc_1C82      ; | 
                inc   hl               ; | advance to next position
                ld    a, (hl)          ; | delete char from buf
                dec   hl               ; | 
                ld    (hl), a          ; | 
                inc   hl               ; | 
                jr    loop1C77         ;-+ loop
loc_1C82:       pop   hl               ; restore position
                ret

; get a random init value from refresh register
; BAD code: this only gets 256 different random values
exec_randomize: ret   nz               ; exit if argument follows
                ex    de, hl           ; save HL
                ld    hl, rnd_mant23
                ld    a, r             ; get refresh register (256 values)
                ld    (hl), a          ; save mant2
                inc   hl
                ld    (hl), a          ; save mant3
                inc   hl
                ld    (hl), a          ; save mant4
                inc   hl
                ld    (hl), a          ; save mant5
                inc   hl
                and   7Fh              ; make positive (suppressed MSB)
                ld    (hl), a          ; save mant6
                inc   hl
                ld    (hl), 80h        ; make expenent
                ex    de, hl
                ret

; handle LVAR/LLVAR
; anachronism: does not print arrays
exec_llvar:     call  temporary_select_printer ; select printer for output
exec_lvar:      ret   nz               ; exit, if arguments follow
                push  hl               ; save curlineptr
                ld    hl, (prog_end)   ; get start of variables
loop1CA3:       call  print_crlf       ;<+ print a CRLF
                call  check_break      ; | check for break
                ld    de, (end_of_vars) ;| load end of variables
                CPHL_DE                ; | 
                jr    z, loc_1CF0      ; | is end of vars already reached? yes exit
                ld    c, (hl)          ; | get variable name in C
                inc   hl               ; | 
                ld    a, (hl)          ; | and A
                inc   hl               ; | 
                bit   7, a             ; | test bit 7
                jr    nz, loc_1CE8     ; | advance to next, is a function
                call  write_char       ; | write 1st character
                ld    a, c             ; | get second character
                and   MASK_7BIT        ; | mask high bit
                call  nz, write_char   ; | print if character is not 0
                ld    a, CHAR_DOLLAR   ; | preload $
                bit    7, c            ; | check bit 7 if 2nd char
                call  nz, write_char   ; | print $ (string) if bit 7 set
                ld    a, '='           ; | print a '='
                call  write_char       ; | 
                ld    a, c             ; | get 2nd char
                rla                    ; | put bit 7 into CY
                sbc   a, a             ; | set flag = FF if string
                ld    (fpaccu_mant32), hl ; save address of string descriptor in fpaccu
                push  hl               ; | save var ptr
                jr    nz, loc_1CE4     ; | was a string? yes, skip
                call  mem_to_fpaccu    ; | load numeric value info FPaccu
                call  format_number    ; | format as number
                call  straccu_copy     ; | copy formatted number to straccu
loc_1CE4:       call  straccu_print    ; | print the string
                pop   hl               ; | restore ptr to variable
loc_1CE8:       inc   hl               ; | advance to next position
                inc   hl               ; | 
                inc   hl               ; | 
                inc   hl               ; | 
                inc   hl               ; | 
                inc   hl               ; | 
                jp    loop1CA3         ;-+ loop
loc_1CF0:       pop   hl               ; done
                ret
				
exec_aload:     call  new_memory       ; clear memory
exec_amerge:    ld    hl, (prog_end)   ; load current end of program
                dec   hl
loop1CF9:       call  get_RDR          ;<+ get char from reader
                jr    c, loc_1D25      ; | CY set?, end of file, skip
loc_1CFE:       jr    z, loop1CF9      ;>+ zero byte, ignore
                cp    CHAR_RUBOUT      ; | is RUBOUT marker?
                jr    z, loop1CF9      ;-+ yes ignore
                inc   hl               ; advance ptr
                ld    (hl), a          ; save it
                call  check_memfree    ; validate still memory available
                ld    a, (hl)          ; load char
                sub   CHAR_CR          ; is it a CR?
                jr    nz, loc_1D21     ; no continue
                ld    (hl), a          ; save 0 byte at line end
                inc   hl               ; leave space for following nextlink andlineno
                ld    (hl), a
                inc   hl
                ld    (hl), a
                inc   hl
                ld    (hl), a
                call  get_RDR          ; get char from reader
                jr    c, loc_1D25      ; end of file? skip
                cp    CHAR_LF          ; is it a following LF?
                jr    z, loop1CF9      ; yes, ignore
                or    a                ; set flags
                jr    loc_1CFE         ; and process normally
loc_1D21:       cp    CHAR_CR          ; is it 0d+0d == 1a == CTRL-Z?
                jr    nz, loop1CF9     ; no process normally
; end of file encntred
loc_1D25:       ld    (hl), NULL       ; store terminating 0
                inc   hl
                ld    (hl), CHAR_CTRLZ ; store terminating CTRL-Z
                ld    hl, (prog_end)   ; begin at program end again
loc_1D2D:       push  hl               ; save current line ptr
                ld    a, (hl)          ; get current char
                sub   CHAR_CTRLZ       ; is it CTRL-Z?
                jr    nz, loop1D3C     ; no, skip
                ld    (prompt_flag), a ; yes, finished
                call  init_from_start  ; reinitialize
                jp    print_prompt     ; return to interpreter    loop
loop1D3C:       ld    a, (hl)          ;<+ get current char
                inc   hl               ; | advance
                or    a                ; | set flags
                jr    nz, loop1D3C     ;-+ loop until end of line
; has found a 0 byte                     
loop1D41:       ld    a, (hl)          ;<+ get current char
                inc   hl               ; |
                or    a                ; |
                jr    z, loop1D41      ;-+ loop until non-null byte
                dec   hl               ; point to next line
                ld    (curlineno), hl  ; save position in curlineno
                pop   hl               ; restore start of line
                ld    a, 0FFh          ; set prompt flag = FF
                ld    (prompt_flag), a
                call  skipspace        ; advance in buf to non-empty
                inc   a                ; check char read
                dec   a
                jp    z, loc_4A9       ; char is zero?, clear line
amerge_enter_line:            
                jr    nc, loc_1D5F     ; no lineno found from skipspace?
                push  af               ; save char
                xor    a               ; clear char
                jp    loc_4F1          ; jump into line parser to insert the
                                       ; line HL points to.
                                       ; Note: this, in theory, could overwrite
                                       ; the text that AMERGE read in, but this won't
                                       ; happen, because a tokenized line is always
                                       ; shorter than the plain text line. So it will
                                       ; enter a line and then continue with
                                       ; the next line of RDR.
loc_1D5F:       ld    e, 24            ; error code "missing statement number"
                jp    print_error

get_RDR:        call  READERIN         ; get char from reader
                ret   c                ; return if end of file
                and   MASK_7BIT        ; discard parity bit
                ret

exec_aloadc:    call  new_memory       ; clear memory
exec_amergec:   ld    hl, inputbuf-1   ; point to inputbuf
                ld    b, 0             ; init char per line cntr
loop1D73:       call  get_RDR          ;<+ get char from reader
                jr    c, loc_1DAA      ; | end of file?, exit done
                jr    z, loop1D73      ;>+ ignore zero bytes
                cp    CHAR_RUBOUT      ; | is it a RUBOUT?
                jr    z, loop1D73      ;-+ yes ignore
                cp    CHAR_CTRLZ       ; is it CTRL-Z?
                jr    z, loc_1DAA      ; yes end of file, done
                cp    CHAR_LF          ; is it an LF?
                jr    nz, loc_1D8A     ; no, skip
                inc   b                ; test char count
                dec   b                
                jr    z, loop1D73      ; was empty, ignore
loc_1D8A:       ld    c, a             ; save char
                ld    a, b             ; get char cntr
                cp    0FFh             ; is it 255?
                ld    a, c             ; restore char
                jr    z, loc_1D93      ; yes, ignore more characters
                inc   hl               ; advance bufptr
                inc   b                ; advance char cnt
loc_1D93:       ld    (hl), a          ; put char into buf
                sub   CHAR_CR          ; check if CR
                jr    nz, loop1D73     ; no loop
                ld    (hl), a          ; store 9 byte in buf
                ld    a, 0FEh          ; set prompt flag = FE
                ld    (prompt_flag), a
                ld    hl, inputbuf-1   ; point to inputbuf
                call  nextchar         ; get next char
                inc   a                ; end of line?
                dec   a
                jr    z, exec_amergec  ; yes, loop
                jr    amerge_enter_line ; jump into AMERGE to process line
loc_1DAA:       call  init_from_start  ; clear variables
                jp    print_prompt     ; and return to interpreter loop

; process LOADGO
exec_loadgo:    ld    (fpaccu_mant32), a ; save program name
                call  nextchar         ; get next char
                ld    de, 0FFFFh       ; DE = ffff
                jr    z, loc_1DC9      ; end of command, no start lineno given
                EXPECT CHAR_COMMA      ; expect a comma
                jp    nc, syntax_error
                call  read_lineno      ; get a lineno,
                                       ; not using expression here!
                                       ; only accept a numeric value.
                jp    nz, syntax_error ; invalid, error
loc_1DC9:                
                ld    (curlineno), de  ; store into next line to execute
                ld    a, 0FDh          ; set prompt flag to -3
                ld    (prompt_flag), a
                jp    loc_1807         ; load program

sub_1DD5:       inc   a                ; prompting flag in A
                jp    z, loc_1D2D      ; was it FF?, yes skip
                inc   a                ; was it FE?
                jr    z, exec_amergec  ; yes, continue with AMERGEC
                call  init_from_start  ; clear variables
                xor    a
                ld    (prompt_flag), a ; clear prompt flag
                ld    de, (curlineno)  ; is lineno FFFF?
                ld    a, d
                and   e
                inc   a
                ld    bc, command_done
                push  bc
                ret   z                ; yes, go back into command_done loop
                jp    loc_ADA

; COPY newstart,increment=startrange-endrange
exec_copy:      ret   z                ; exit if end of statement
                jp    nc, illfunc_error ; no number follows? error
                call  read_lineno      ; get lineno
                ld    (curlineno), de  ; save as newstart
                ld    de, 10           ; preload increment of 10
                cp    CHAR_COMMA       ; does a comma follow?
                jr    nz, loc_1E0A     ; no, skip
                call  nextchar         ; get an increment
                call  c, read_lineno
loc_1E0A:       ld    (auto_increment), de ; store in autoincrement
                EXPECT TOKEN_EQUAL     ; expect a '='
                call  get_lineno_range ; get a range (endrange on stack),
                                       ; BC = nextlink of startrange
                pop   de               ; DE = endrange lineno (passed through stack)
                push  bc               ; save nextlink of startrange
                LDHL_BC                ; put as startrange lineno to search for
                                       ; endrange lineno into HL
                exx                    ; alt set
                ld    de, 1            ; preload cntr for counting the lines to move
                                       ; DE' = 1 (increment)
                ld    hl, 0            ; HL' = 0 (initial value)
                exx                    ; std set
                call  find_line_from_current ; find nextlink of endrange
                                       ; and count the number of lines to move in HL'
                jp    nc, illfunc_error ; not found, error
                push  hl               ; save nextlink of endrange
                exx                    ; alt set
                ex    de, hl           ; DE' is count of lines between current position
                                       ; and line to copy
                                       ; ** from here we are no longer interested
                                       ; in data in other set, so no longer marking
                                       ; alt registers and no bothering to switch
                                       ; back set
                ld    bc, (auto_increment) ; BC = increment
                ld    a, b             ; if zero, error
                or    c
                jp    z, syntax_error
                call  umultiply16      ; HL = increment * DE
                                       ; = numbering span to expect
                ld    de, (curlineno)  ; add newstart lineno
                add   hl, de           ; to find the highest new number to expect
                jp    c, subscript_range_error ; overflow, error
                push  hl               ; save as newend lineno
                ld    de, (curlineno)  ; find nextlink of newstart
                call  find_line
                jp    c, illfunc_error ; does the newend lineno exist?
                                       ; yes error
                pop   de               ; DE = newend lineno
                push  bc               ; newstart was not there, but we have
                                       ; a nextlink position where it would go to
                LDHL_BC                ; put into HL
                ld    a, (hl)          ; get nextlink of position where to put
                                       ; newstart to
                inc   hl
                or    (hl)
                jr    z, loc_1E5D      ; if zero, skip (we are at end)
                inc   hl               ; get the lineno of this line into HL
                LDHL_M A
                sbc   hl, de           ; subtract newend lineno
                jp    c, subscript_range_error ; overlapping? error
loc_1E5D:       pop   bc               ; restore ptr of newstart
                pop   hl               ; restore ptr of endrange
                pop   de               ; restore ptr of startrange
                push  hl               ; save ptr of endrange
                sbc   hl, de           ; subtract ptr of startrange
                ex    (sp), hl         ; stack is bytes between endrange andstartrange
                                       ; HL is endrange ptr
                dec   hl               ; decrement
                sbc   hl, bc           ; layout:
                                       ; ....
                                       ; startrange---+--+
                                       ; ...          |  |stack (bytes in range)
                                       ; endrange+-------+
                                       ; ...     |    |
                                       ; ...     |DE  |HL
                                       ; newstart+----+
                                       ; ...
                                       ;
                                       ; HL = bytes from endrange to newstart
                ex    de, hl           ; DE is bytes between endrange andnewstart
                                       ; HL is startrange ptr
                jr    c, loc_1E74      ; newstart is above endrange, i.e.
                                       ; append behind range
                                       ; (as in diagram above)
                sbc   hl, bc           ; bytes from startrange to newstart
                jp    c, illfunc_error ; negative result?
                add   hl, bc           ; undo
                ex    de, hl           ; DE is startrange ptr
                pop   hl               ; restore bytes in range
                push  hl               ; save bytes in range
                add   hl, de           ; HL is startrange+bytes in range
loc_1E74:       ex    (sp), hl         ; insert on stack
                push  hl               ; HL is bytes in range
                ld    d, b             ; DE is newstart ptr
                ld    e, c
                ld    bc, (prog_end)   ; end of program ptr
                add   hl, bc           ; add bytes in range
                push  hl               ; save
                call  make_space       ; DE=start, BC=old end, HL=new end
                                       ; reserve space
                pop   hl               ; set new end of range
                ld    (prog_end), hl
                LDHL_BC                ; HL is old end of program
                pop   bc               ; BC is bytes to copy
                ex    (sp), hl         ; HL is ptr to start of range to copy
                push  de               ; DE is newstart save it
                ldir                   ; copy the lines
                pop   hl               ; restore ptr to nextlink of newstart
                ld    bc, (curlineno)  ; get the newstart lineno
loop1E91:       inc   hl               ;<--+ skip over nextlink
                inc   hl               ;   | 
                LDM_BC                 ;   | put new lineno in line
loop1E96:       inc   hl               ;<+ | advance to end of line
                ld    a, (hl)          ; | | 
                or    a                ; | | 
                jr    nz, loop1E96     ;-+ | loop
                inc   hl               ;   | skip over 0 byte, pointing to 
                                       ;   | nextlink of following line
                pop   de               ;   | restore endrange ptr
                CPHL_DE                ;   | end reached?
                jr    z, loc_1EB0      ;   | yes, we're finished, cleanup
                push  de               ;   | save endrange ptr
                ex    de, hl           ;   | save ptr to line
                ld    hl, (auto_increment) ; get increment
                add   hl, bc           ;   | add current lineno
                LDBC_HL                ;   | put into BC for next round
                ex    de, hl           ;   | restore ptr to line
                jr    loop1E91         ;---+ process next line
loc_1EB0:       call  print_ready_prompt ; print OK
                jp    rebuild_nextchain ; fixup the nextlink chain

exec_exchange:
                call  find_var         ; find first variable
                push  de               ; save addr of 1st var
                push  hl               ; save curlineptr
                ld    hl, numberbuf0   ; move first var into a temporary save
                call  move_to_var
                ld    hl, (end_of_vars) ; get variable end
                ex    (sp), hl         ; stack is end_of_vars
                    ; HL is    curlineptr
                ld    a, (expr_type)   ; save type of variable
                push  af
                EXPECT CHAR_COMMA      ; expect a comma
                call  find_var         ; get second var
                pop   bc               ; DE is addr of 2nd var
                                       ; restore type into B
                ld    a, (expr_type)   ; get type of variable
                xor    b               ; compare with type of 1st var
                rra                    ; result into CY
                jp    c, type_mismatch_error ; error if types don't match
                ex    (sp), hl         ; stack = curlineptr
                                       ; HL = end_of_vars
                ex    de, hl           ; DE = end_of_vars
                                       ; HL = address of 2nd var
                push  hl               ; save it
                ld    hl, (end_of_vars) ; compare end_of_vars with old value
                CPHL_DE                 was second variable newly declared?
                jp    nz, illfunc_error ; yes, error
                pop   de               ; DE = addr of 2nd var
                pop   hl               ; HL = curlineptr
                ex    (sp), hl         ; stack is curlineptr
                                       ; HL is addr of 1st var
                push  de               ; save 2nd var
                call  move_to_var      ; move 1st var -> 2nd var
                pop   hl               ; restore 2nd var
                ld    de, numberbuf0   ; move scratchpad to 2nd var
                call  move_to_var
                pop   hl               ; restore curlineptr
                ret

exec_kill:      ld    a, 1             ; set subscript flag to 1, i.e. 
                                       ; to search for arrays without subscript
                ld    (subscript_flag), a
                jp    find_var

kill_array:                            ; HL points to #indices in array
                push  hl               ; DE is total size of array
                add   hl, de           ; calculate end of array
                ex    de, hl           ; save it in DE
                ld    hl, (end_arrays) ; get end_array ptr
                or    a                ; set CY
                sbc   hl, de           ; calculate size of range to move
                ex    (sp), hl         ; stack = size to move
                                       ; HL = ptr to indices
                pop   bc               ; BC = move size
                ex    de, hl           ; HL = ptr to new end of arrays
                                       ; DE = ptr to start of array
                dec   de               ; adjust (total size and variable name)
                dec   de
                dec   de
                dec   de
                jr    z, loc_1F15      ; unless empty, move data
                ldir
loc_1F15:       ld    (end_arrays), de ; store new end of array
loc_1F19:       ld    (subscript_flag), a ; (A was 0) clear subscript flag
                pop   hl               ; restore curlineptr
                ld    a, (hl)          ; get next char
                cp    CHAR_COMMA       ; was comma?
                ret   nz               ; no, exit
                call  nextchar         ; yes, get next char
                jr    exec_kill        ; and continue in kill
exec_call:      ret   z                ; no arguments follow? exit
                ld    (curlineno), sp  ; save stack to curlineno
                push  hl               ; save curlineptr
                ld    de, hlrestore    ; push HL restore to return stack
                push  de
                call  expression_u16   ; get address expression
                ld    c, 0             ; count number of arguments
loop1F35:       push  de               ;<+ push call address on stack
                call  skipspace        ; | advance
                jr    z, call2         ; | end of statement? done with arguments
                EXPECT CHAR_COMMA      ; | expect a comma
                inc   c                ; | increment argument count
                push  bc               ; | save argument count
                call  expression_u16   ; | get argument
                pop   bc               ; | 
                ex    de, hl           ; | DE is curlineptr
                                       ; | HL is argument
                ex    (sp), hl         ; | stack is argument
                                       ; | HL is call address
                ex    de, hl           ; | DE is call address
                                       ; | HL is curlineptr
                jr    loop1F35         ;-+ loop over all arguments

call2:          push  de               ; push caller address
                ex    de, hl           ; DE is curlineptr
                                       ; HL is caller address
                ld    hl, (curlineno)  ; get initial stack ptr
                                       ; is location where call address
                                       ; was pushed initially
                dec   hl               ; put curlineptr in it
                ld    (hl), d
                dec   hl
                ld    (hl), e
                dec   hl               ; point to HL restore routine
                dec   hl
                ret                    ; return to call address

; calling convention:
                    ; C contains number of 16bit arguments
                    ; Stack    -> argumentN
                    ;       argumentN-1
                    ;       ...
                    ;       argument1
                    ; HL contains return address
                    ; return from caller via JP (HL)
                    ;
                    ; will jump on HLrestore which will
                    ; restore the curlineptr andthen exit
                    ; int interpreter loop
                    ;
hlrestore:      pop   hl               ; pop pending HL value (curlineptr?) from stack
                ret

; process PRECISION
exec_precision: ld    a, 0             ; get precision 0
                call  nz, expression_u8_ae ; if argument, get expression
                ret   nz               ; exit if more arguments
                cp    0Bh              ; is it exactly 11?, then set precision  0
                jr    z, exec_precision
                jp    nc, illfunc_error ; is it larger? error
                ld    (precision), a   ; save precision value
                ret

; process PEEK()
math_peek:      call  fpaccu_to_u16    ; get 16 bit argument in DE
                ld    a, (de)          ; get value from memory at DE
                jp    uA_to_fpaccu     ; put result

; process POKE command
exec_poke:      call  expression_u16   ; get a 16 bit expression in DE
                push  de               ; save address
                EXPECT CHAR_COMMA      ; expect a comma
                call  expression_u8_ae ; get 8 bit expression
                pop   de               ; restore address
                ld    (de), a          ; save data
                ret

; addconstant 0.5
add_0_5:        ld    hl, const0_5     ; constant 0.5
load_and_add_fpaccu:
                call  load_fpreg
                jr    add_fpreg_fpaccu

load_fpreg_and_subtr:
                call  load_fpreg
                jr    subtr_fpreg_fpaccu

pop_fpreg_and_sub:
                POP_FPREG

; subtract fpreg - fpaccu => fpaccu
subtr_fpreg_fpaccu:
                call  fpaccu_changesign ; change sign of fpaccu

; add fpaccu andFPreg, result in fpaccu
add_fpreg_fpaccu:
                ld    a, b             ; get fpreg exponent
                or    a
                ret   z                ; if zero, then done
                ld    a, (fpaccu_exp)  ; get fpaccu exponent
                or    a                ; is zero?
                jp    z, store_fpaccu  ; yes, just store FPreg into fpaccu
                sub   b                ; subtract fpreg exp from fpaccu exp
                jr    nc, loc_1FB2
                neg
                exx                    ; save fpreg temporarily
                                       ; FPREG in alternative regs
                push  ix               ; including ix
                call  fpaccu_to_fpreg  ; copy fpaccu to fpreg
                exx                    ; restore fpreg
                                       ; fpaccu in alternative regs
                ex    (sp), ix         ; including ix
                call  store_fpaccu     ; store in fpaccu
                exx                    ; fpaccu in these registers
                pop   ix
loc_1FB2:       cp    29h              ; do exponents differ too much?
                ret   nc               ; yes, ignore (adding a large number
                                       ; and a very small one) and exit
                push  af               ; save difference of exponent
                call  fpaccu_restoresign ; restore the sign of mantissa
                ld    h, a             ; save sign in H
                pop   af               ; restore shift count
                call  fpreg_shiftmant  ; adjust fpreg to same exponent as fpaccu
                or    h                ; was positive sign?
                ld    hl, fpaccu_mant32 ; load address of fpaccu
                jp    p, subtr_mantissa ; go subtract mantissas
                call  add_mantissas    ; add mantissas
                jr    nc, round_store_fpreg ; overflow?
                inc   hl               ; yes
                inc   (hl)             ; increment exponent
                jp    z, e_overflow    ; too bad, exponent overflow, error
                ld    l, 1
                call  mant_shiftright1 ; shift mantissa 1 bit
                                       ; (because exponent was incremented)
                jr    round_store_fpreg ; round fpreg and store in fpaccu
subtr_mantissa: xor   a                ; subtract adjusted mantissas
                sub   b
                ld    b, a
                ld    a, (hl)
                sbc   a, e
                ld    e, a
                inc   hl
                ld    a, (hl)
                sbc   a, d
                ld    d, a
                inc   hl
                ld    a, (hl)
                sbc   a, xl
                ld    xl, a
                inc   hl
                ld    a, (hl)
                sbc   a, xh
                ld    xh, a
                inc   hl
                ld    a, (hl)
                sbc   a, c
                ld    c, a
				
; normalize and round a number in FPreg, and store in fpaccu
; if CY, complement mantissa
; mant6-mant1 = C,XH,XL,D,H,L
; exponent = B

fpreg_normalize:            
                call  c, fpreg_complement ; complement FPaccu in registers
loc_1FF3:       ld    l, b             ; copy BE -> HL
                ld    h, e
                xor   a                ; clear lower mantissa
                ld    b, a
                ld    a, c             ; get highest mantissa
                or    a
loop1FF9:       jr    nz, loc_2022     ;<+ not zero, shift single
                ld    c, xh            ; | high mantissa is 0, shift mantissa a byte
                                       ; | XH -> C
                ld    a, xl            ; | XL -> XH
                ld    xh, a            ; | 
                ld    xl, d            ; | D -> XL
                xor    a               ; | 
                ld    d, h             ; | H -> D
                ld    h, l             ; | L -> H
                ld    l, a             ; | 0 -> L
                ld    a, b             ; | get exponent
                sub   8                ; | subtract 8
                cp    0D0h             ; | 
                jr    nz, loop1FF9     ;-+ not yet zero? loop

; load zero in fpaccu
fpaccu_zero:    xor   a                ; accu is zero
loc_200F:       ld    (fpaccu_exp), a
                ret

; part of normalizing FPreg:
; B = binary exponent
; C = high mantissa (6)
; IXH =    mantissa (5)
; IXL =    mantissa (4)
; D = mantissa (3)
; H = mantissa (2)
; L = lowest mantissa (1)
loop2013:       dec   b                ;<+ decrement exponent
                add   hl, hl           ; | shift HL left
                rl    d                ; | rotate into D
                ex    af, af'          ; | save flags
                add   ix, ix           ; | shift IX left
                ex    af, af'          ; | restore flags, CY from IX is in AF'
                jr    nc, loc_201F     ; | no CY from D? skip
                inc   ix               ; | move CY from D into IX
loc_201F:       ex    af, af'          ; | get CY from IX
                rl    c                ; | rotate into C
loc_2022:       jp    p, loop2013      ;-+ highest mantissa still positive?, yes skip
                ld    a, b             ; get exponent
                ld    e, h             ; save HL -> EB
                ld    b, l
                or    a                ; exponent zero?
                jr    z, round_store_fpreg ; yes, skip
                ld    hl, fpaccu_exp   ; get binary shift
                add   a, (hl)          ; addit to exponent
                ld    (hl), a          ; store it
                jr    nc, fpaccu_zero  ; underflow?, mark as zero
                ret   z                ; exit zero
round_store_fpreg:                     ; get lowest mantissa
                ld    a, b
loc_2034:       ld    hl, fpaccu_exp   ; get shift
                rlca                   ; shift bit 6 into sign
                call  m, mant_inc r    ; if negative, round FPreg up
                ld    b, (hl)          ; B = adjustment
                inc   hl               ; point to sign mantissa
                ld    a, (hl)          ; mask out sign bit
                and   80h
                xor    c               ; merge into high mantissa (suppressed MSB)
                ld    c, a
                jp    store_fpaccu     ; store it in accu1

mant_inc r:     inc   e                ; increment mantissa 2
                ret   nz               ; exit unless carry
                inc   d                ; increment mantissa 3
                ret   nz
                inc   xl               ; increment mantissa 4
                ret   nz
                inc   xh
                ret   nz               ; exit unless carry
                inc   c                ; increment mantissa 6
                ret   nz
                ld    c, 80h           ; highest mantissa became 0
                                       ; make 0x80 again
                inc   (hl)             ; needs adjustment again
                ret   nz               ; oops, this also overflowed?
e_overflow:     ld    e, 6             ; error code "arithmetic overflow"
                jp    print_error

add_mantissas:  ld    a, (hl)          ; add adjusted mantissas
                add   a, e
                ld    e, a
                inc   hl
                ld    a, (hl)
                adc   a, d
                ld    d, a
                inc   hl
                ld    a, (hl)
                adc   a, xl
                ld    xl, a
                inc   hl
                ld    a, (hl)
                adc   a, xh
                ld    xh, a
                inc   hl
                ld    a, (hl)
                adc   a, c
                ld    c, a
                ret

fpreg_complement:
                ld    hl, fpaccu_mantsign
                ld    a, (hl)          ; complement sign of mantissa
                cpl
                ld    (hl), a
                xor    a
                ld    l, a             ; clear HL
                ld    h, a
                sub   b                ; complement B
                ld    b, a
                ld    a, l             ; A = 0
                sbc   hl, de           ; complement DE
                ex    de, hl
                ld    l, a             ; L = 0
                sbc   a, xl            ; complement XL
                ld    xl, a
                ld    a, l             ; A = 0
                sbc   a, xh            ; complement XH
                ld    xh, a
                ld    a, l             ; A = 0
                sbc   a, c             ; complement C
                ld    c, a
                ret

fpreg_shiftmant:
                ld    b, 0             ; load zero
mant_shift8:    sub   8                ; subtract 8 from exponent
                jr    c, loc_20A5      ; borrow, skip
                ld    b, e             ; E -> B
                ld    e, d             ; D -> E
                ld    d, xl            ; XL -> D
                ex    af, af'
                ld    a, xh
                ld    xl, a            ; XH -> XL
                ex    af, af'
                ld    xh, c            ; C -> XH
                ld    c, 0             ; 0 -> C
                jr    mant_shift8      ; loop
loc_20A5:       add   a, 9             ; correct exponent again
                ld    l, a             ; save exp in l
mant_shift1:    xor   a                ; clear    a
                dec   l                ; decrement exp
                ret   z                ; exit if zero
				ld    a, c             ; get mant6
mant_shiftright1:            
                rra
				ld    c,a              ; shift right C
                ld    a, xh            ; shift right XH
                rra
                ld    xh, a            ; A -> XH
loc_20B3:       ld    a, xl            ; shift right XL
                rra
                ld    xl, a
                rr    d                ; shift right D
                rr    e                ; shift right E
                rr    b                ; shift right B
                jr    mant_shift1      ; loop

const1:         db    0, 0, 0, 0, 0, 81h ; 1.0
LOG_poly_tbl:   db    6
                db    23h, 85h, 0ACh, 0C3h, 11h, 7Fh ; 0.28469600
                db    53h, 0CBh, 9Eh, 0B7h, 23h, 7Fh ; 0.31976029
                db    0CCh, 0FEh, 0A6h, 0Dh, 53h, 7Fh ; 0.41221353
                db    0CBh, 5Ch, 60h, 8Bh, 13h, 80h ; 0.57634547
                db    0DDh, 0E3h, 4Eh, 38h, 76h, 80h ; 0.96179669
                db    5Ch, 29h, 3Bh, 0AAh, 38h, 82h ; 2.88539008

math_log:       call  fpaccu_sgn       ; get sign
                or    a
                jp    pe, illfunc_error ; negative? yes error
                ld    hl, fpaccu_exp
                ld    a, (hl)          ; get exponent
                FPREG_CONST 8035h, 4F3h, 33FAh ; constant 1/SQR(2)
                sub   b                ; normalize exponent
                                       ; reuse 0x80 from constant
                push  af               ; save it for later
                ld    (hl), b          ; put it into fpaccu
                PUSH_FPREG             ; save constant
                call  add_fpreg_fpaccu ; add constant
                POP_FPREG
                inc   b                ; convert constant to SQR(2)
                                       ; 2*(1/SQR(2)) == SQR(2)
                call  div_fpreg_fpaccu ; divide SQR(2) / argument
                ld    hl, const1
                call  load_fpreg_and_subtr ; subtract 1.0 - argument
                ld    hl, LOG_poly_tbl ; load coefficient table
                call  fpaccu_polyeval_sqr ; evaluate polynomial
                FPREG_CONST 8080h,0,0  ; add -0.5
                call  add_fpreg_fpaccu
                pop   af
                call  fpaccu_add_u8    ; adjust exponent
                FPREG_CONST 8031h,7217h,0F7D2 ; constant LOG(2)
                jr    multiply_fpreg_fpaccu ; multiply with it

; pop fpreg from stack and multiply with fpaccu
pop_fpreg_and_mult:
                POP_FPREG              ; pop fpreg from stack
; multiply fpreg * fpaccu => fpaccu
multiply_fpreg_fpaccu:
                call  fpaccu_sgn       ; get sign of fpaccu
                ret   z                ; is zero?, exit (result is zero)
                ld    l, 0
                call  mult_div_calcexponent ; calculate new exponent
                ld    a, c             ; get mantissa6
                push  de               ; push mant32 fpreg
                exx                    ; alternative registers
                ld    c, a             ; mant6 -> C'
                pop   de               ; mant32 -> DE'
                push  ix               ; mant54 -> HL'
                pop   hl
                exx                    ; back to std set
                ld    bc, 0            ; clear BC (mant61)
                ld    d, b             ; clear DE (mant32)
                ld    e, b
                ld    ix, 0            ; clear IX (mant54)
                ld    hl, loc_1FF3     ; call normalize on return
                push  hl
                ld    hl, loc_2168     ; call restore altregs on return
                push  hl               ; four times
                push  hl               ; will calculate partial
                                       ; multiplication for 8 bits
                push  hl
                push  hl
                ld    hl, fpaccu_mant32 ; get fpaccu
loc_2168:       ld    a, (hl)          ; get factor byte
                inc   hl               ; advance
                or    a                ; is zero?
                jr    nz, loc_217B     ; no, must do bitwise partial multiply
                ld    b, e             ; shift 8 bits
                                       ; mant2 -> mant1
                ld    e, d             ; mant3 -> mant2
                ld    d, xl            ; mant4 -> mant3
                ex    af, af'
                ld    a, xh            ; mant5 -> mant4
                ld    xl, a
                ex    af, af'
                ld    xh, c            ; mant6 -> mant5
                ld    c, a             ; 0 -> mant6
                ret
loc_217B:       push  hl               ; save ptr to fpaccu
                ex    de, hl           ; mant32 -> HL
                ld    e, 8             ; cntr for 8 bits
loop217F:       rra                    ;<+ next bit of factor
                ld    d, a             ; | save factor
                ld    a, c             ; | mant6 -> C
                jr    nc, loc_2196     ; | bit is zero, only shift
                push  hl               ; | push mant32
                exx                    ; | alternative set
                ex    (sp), hl         ; | stack is mant54', HL' is mant32
                add   hl, de           ; | DE is mant32'
                                       ; | mant32 + mant32' -> HL'
                ex    (sp), hl         ; | HL' is mant54', stack is mant32
                ex    de, hl           ; | HL' is mant32', DE' is mant54'
                push  ix               ; | push mant54
                ex    (sp), hl         ; | stack is mant32', HL' is mant54
                adc   hl, de           ; | CY + mant54' + mant54 -> HL'
                ex    (sp), hl         ; | stack is mant54, HL is mant32'
                pop   ix               ; | restore mant54
                ex    de, hl           ; | HL' is mant54', DE is mant32'
                adc   a, c             ; | CY + mant6' + mant6 -> A
                exx                    ; | std set
                pop   hl               ; | restore mant32
loc_2196:       rra                    ; | shift right mant6
                ld    c, a             ; | 
                ld    a, xh            ; | shift right mant5
                rra                    ; | 
                ld    xh, a            ; | 
                ld    a, xl            ; | shift right mant4
                rra                    ; | 
                ld    xl, a            ; | 
                rr    h                ; | shift right mant3
                rr    l                ; | shift right mant2
                rr    b                ; | shift right mant1
                dec   e                ; | decrement bit count
                ld    a, d             ; | restore factor
                jr    nz, loop217F     ;-+ not yet done? loop
                ex    de, hl           ; mant32 -> DE
loc_21AD:       pop   hl               ; restore ptr to fpaccu
                ret

; divide fpaccu by 10
fpaccu_div10:   call  push_fpaccu      ; push fpaccu
                FPREG_CONST 8420h,0,0  ; constant 10.0
                call  store_fpaccu     ; put in fpaccu

; popfpreg from stack anddivide by fpaccu
pop_fpreg_and_div:
                POP_FPREG
; divide fpreg / fpaccu => fpaccu
div_fpreg_fpaccu:
                call  fpaccu_sgn       ; check fpaccu is 0?
                jp    z, div_by_zero_error ; yes division by zero error
                ld    l, 0FFh          ; for complement of exponent
                call  mult_div_calcexponent ; calculate exponent
                push  iy               ; save IY
                inc   (hl)             ; adjust exponent (2's complement)
                inc   (hl)
                dec   hl
                push  hl               ; ptr to fpaccu mant6
                exx                    ; alt set
                pop   hl               ; get ptr
                ld    c, (hl)          ; mant6' -> C'
                dec   hl
                ld    d, (hl)          ; mant54' -> DE'
                dec   hl
                ld    e, (hl)
                dec   hl
                ld    a, (hl)          ; mant32' -> HL'
                dec   hl
                ld    l, (hl)
                ld    h, a
                ex    de, hl           ; mant54' -> HL'
                                       ; mant32' -> DE'
                exx                    ; std set
                ld    b, c             ; mant6 -> B
                ex    de, hl           ; mant32 -> HL
                push  ix               ; mant54 -> IY
                pop   iy
                xor    a               ; extent registers
                ld    c, a
                ld    d, a
                ld    e, a
                ld    ix, 0
                ld    (div_ovf), a
loop21F3:       push  hl               ;<+ push mant6...mant2
                push  iy               ; | 
                push  bc               ; | 
                push  hl               ; | push mant32
                ld    a, b             ; | mant6 -> A
                exx                    ; | alt set
                ex    (sp), hl         ; | stack is mant54', HL' is mant32
                or    a                ; | set CY
                sbc   hl, de           ; | mant32 - mant32' -> HL'
                ex    (sp), hl         ; | stack is mant32, HL' is mant54'
                ex    de, hl           ; | DE' is mant54', HL' is mant32'
                push  iy               ; | push mant54
                ex    (sp), hl         ; | stack is mant32', HL' is mant54
                sbc   hl, de           ; | mant54 - mant54' -> HL'
                ex    (sp), hl         ; | stack is mant54, HL' is mant32'
                pop   iy               ; | restore mant54
                ex    de, hl           ; | DE' is mant32', HL' is mant54'
                sbc   a, c             ; | C' is mant6
                                       ; | mant6 - mant6' -> A
                exx                    ; | std set
                pop   hl               ; | restore mant32
                ld    b, a             ; | store mant6
                ld    a, (div_ovf)     ; | get overflow?
                sbc   a, 0             ; | subtract remainying CY
                ccf                    ; | complement it
                jr    nc, loc_221E     ; | this failed, undo subtract
                ld    (div_ovf), a     ; | store overflow
                pop   af               ; | discard mant6...2
                pop   af               ; | 
                pop   af               ; | 
                scf                    ; | set CY
                jr    loc_2222         ; | skip
loc_221E:       pop   bc               ; | restore old mantissa
                pop   iy               ; | 
                pop   hl               ; | CY is 0, coming from here
loc_2222:       inc   c                ; | get sign of mant6
                dec   c                ; | 
                rra                    ; | set CY into bit7
                jp    m, loc_225E      ; | are we done?, yes, skip
                rla                    ; | shift in the CY bit
                rl    e                ; | shift mant32 left
                rl    d                ; | 
                ex    af, af'          ; | save flags
                add   ix, ix           ; | shift mant54 left
                ex    af, af'          ; | save flags
                jr    nc, loc_2235     ; | adjust for CY in
                inc   ix               ; | 
loc_2235:       ex    af, af'          ; | save flags
                rl    c                ; | shift left mant6
                add   hl, hl           ; | shift left extent HL
                ex    af, af'          ; | 
                add   iy, iy           ; | shift left extent IY
                ex    af, af'          ; | restore flags
                jr    nc, loc_2241     ; | adjust for CY
                inc   iy               ; | 
loc_2241:       ex    af, af'          ; | 
                rl    b                ; | shift left B
                ld    a, (div_ovf)     ; | shift left extent
                rla                    ; |
                ld    (div_ovf), a     ; |
                ld    a, c             ; | still bits left to shift?
                or    d                ; | 
                or    e                ; | 
                or    xh               ; | 
                or    xl               ; | 
                jr    nz, loc_21F3     ;-+ yes, loop
                push  hl               ; save HL
                ld    hl, fpaccu_exp   ; get exponent
                dec   (hl)             ; decrement (left shift == exp-1)
                pop   hl               ; restore HL
                jr    nz, loop21F3     ; not zero?
                jr    e_overflow1      ; exponent overflow
loc_225E:       pop   iy               ; restore IY
                jp    loc_2034         ; round and store result

mult_div_calcexponent:
                ld    a, b             ; get fpreg exponent
                or    a
                jr    z, loc_2287      ; is zero? yes, result is zero
                ld    a, l             ; multiply: l=0, divide: l=ff
                ld    hl, fpaccu_exp   ; get exponent
                xor    (hl)            ; do 1's complement for division
                add   a, b             ; add exponents
                ld    b, a             ; resulting exponent in fpreg
                rra                    ; test overflow (bit 6 shift into bit 7)
                xor    b               ; check overflow
                ld    a, b             ; get resulting exponent
                jp    p, loc_2286      ; if positive, skip
                add   a, 80h           ; adjust exponent again
                ld    (hl), a          ; store as new exponent in fpaccu
                jp    z, loc_21AD      ; exponent is 0, exit
                call  fpaccu_restoresign ; restore sign of mantissa
                ld    (hl), a          ; store sign
                dec   hl
                ret
loc_2280:       call  fpaccu_sgn       ; get sign of fpaccu
                cpl                    ; complement
                or    a                ; set flags (redundant, because CPL
                                       ; already sets sign)
                db    21h              ; LD HL, xxxx to skip next 2 instructions
loc_2286:       or    a                ;** set flags
loc_2287:       pop   hl               ;** discard caller
                jp    p, fpaccu_zero   ; if positive, return zero
e_overflow1:    jp    e_overflow       ; overflow error

fpaccu_mult10:  call  fpaccu_to_fpreg  ; copy fpaccu into registers
                ld     a, b            ; get exponent
                or    a
                ret   z                ; is zero? yes exit
                add   a, 2             ; multiply fpreg with 4
                jr    c, e_overflow1   ; check for overflow
                ld    b, a             ; store fpreg exponent
                call  add_fpreg_fpaccu ; add 4*X + X -> 5*X
                ld    hl, fpaccu_exp   ; get fpaccu exponent
                inc   (hl)             ; multiply with 2
                ret   nz               ; not zero? okay
                jr    e_overflow1      ; overflow error

; process SGN()
math_sgn:       call  fpaccu_sgn       ; get sign of FPACCU in    A

; convert signed byte in A into fpaccu
s8_to_fp:       ld    b, 88h           ; preload exponent with 8
                ld    de, 0            ; low mantissa = 0

; entry point used to also convert signed 16 bit
; and unsigned 16 bit numbers in A,D,E
s24_to_fp:      ld    hl, fpaccu_exp   ; address of FPaccu
                ld    c, a             ; put sign into C
                push  de               ; put upper mantissa in IX
                pop   ix
                ld    de, 0            ; lower mantissa = 0
                ld    (hl), b          ; store exponent
                ld    b, 0             ; clear B
                inc   hl
                ld    (hl), 80h
                rla
                jp    fpreg_normalize

; return SGN(fpaccu) in A (ff,0,1)
fpaccu_sgn:     ld    a, (fpaccu_exp)  ; is exponent 0?
                or    a
                ret   z                ; yes, return A = 0
                ld    a, (fpaccu_mant6) ; get highest mantissa
                db    0FEh             ; CP xx to skip following instruction
loc_22C8:       cpl                    ;** skipped
                rla                    ; sign of mantissa into CY
loc_22CA:       sbc   a, a             ; A = FF if negative
                ret   nz               ;  exit
                inc   a                ; A = 1, if positive
                ret

; process ABS()
math_abs:       call  fpaccu_sgn       ; get sign of fpaccu
                ret   p                ; is already positive? yes exit

; toggle sign in fpaccu
fpaccu_changesign:
                ld    hl, fpaccu_mant6 ; get sign bit of mantissa
                ld    a, (hl)
                xor    80h             ; complement
                ld    (hl), a
                ret

; push fpaccu on stack
push_fpaccu:    ex    de, hl           ; save old HL

; push fpaccu on stack, exchange DE,HL
push_fpaccu_ex: ld    hl, (fpaccu_mant32)
                ex    (sp), hl
                push  hl
                ld    hl, (fpaccu_mant54)
                ex    (sp), hl
                push  hl
                ld    hl, (fpaccu_mant6)
                ex    (sp), hl
                push  hl
                ex    de, hl        ; restore old HL
                ret

; copy value in memory at HL into fpaccu
mem_to_fpaccu:  ld    de, fpaccu_mant32
                ld    bc, 6
                ldir
                ret

store_fpaccu:   ld    (fpaccu_mant32), de
                ld    (fpaccu_mant54), ix
                ld    (fpaccu_mant6), bc
                ret

fpaccu_to_fpreg:
                ld    hl, fpaccu_mant32 ; get mantissa32
load_fpreg:     LDDE_M                 ; load mant32 into DE
                inc   hl
                ld    c, (hl)          ; load mant4 into IXL
                ld    xl, c
                inc   hl
                ld    c, (hl)          ; load mant5 into IXH
                ld    xh, c
                inc   hl
                LDBC_M                 ; load mant6 into C
                                       ; load exp into B
                inc   hl
                ret

; store fpaccu into memory, pointed to by HL
fpaccu_to_mem:  ld    de, fpaccu_mant32

; move 6 byte value at addr in DE to  addr in HL
move_to_var:    ld    bc, 6
                ex    de, hl
                ldir
                ex    de, hl
                ret

; restore sign of mantissa, return sign    in A
fpaccu_restoresign:
                ld    hl, fpaccu_mant6 ; get mantissa with suppressed leading 1
                ld    a, (hl)          ; A = S6543210
                rlca                   ; A = 6543210S, CY=S
                scf                    ; CY=H
                rra                    ; A = H6543210, CY=S
                ld    (hl), a          ; store correct mantissa in fpaccu_mant6
                ccf                    ; CY=-S
                rra                    ; A = -S7654321, CY=0
                inc   hl
                inc   hl               ; point to separate sign bit
                ld    (hl), a          ; save A=-S6543210
                ld    a, c             ; A=S6543210
                rlca                   ; A = 6543210S, CY=S
                scf                    ; CY=H
                rra                    ; A = H6543210, CY=S
                ld    c, a             ; store correct mant6 in C
                rra                    ; A = SH654321, CY=0
                xor   (hl)             ; A = Sxxxxxxx
                ret

; compare a number in fpaccu with B,C,IXH,IXL,D,E
; return ff,0,1  n A
fpaccu_compare: ld    a, b             ; get exponent of number in regs
                or    a
                jr    z, fpaccu_sgn    ; if zero, return zero in A
                call  fpaccu_sgn       ; set sign of fpaccu in Z
                ld    a, c             ; get high mantissa
                jr    z, loc_22C8      ; if zero, go complement
                ld    hl, fpaccu_mant6 ; get fpaccu mantissa
                xor   (hl)             ; complement with number in regs
                ld    a, c             ; get high mantissa again
                jp    m, loc_22C8      ; return result sign
                call  fp_compare1      ; compare fpaccu
                rra                    ; build correct compare sign
                xor   c
                jp    loc_22C8         ; exit compare status

fp_compare1:    inc   hl               ; point to fpexp
                ld    a, b             ; get exponent
                cp    (hl)             ; compare exponents
                ret   nz               ; exit if not same
                dec   hl               ; point to mant6
                ld    a, c             ; compare mantissa
                cp    (hl)
                ret   nz               ; exit not same
                dec   hl               ; compare mant5
                ld    a, xh
                cp    (hl)
                ret   nz               ; exit not same
                dec   hl               ; compare mant4
                ld    a, xl
                cp    (hl)
                ret   nz               ; exit not same
                dec   hl
                ld    a, d
                cp    (hl)             ; compare mant3
                ret   nz               ; exit not same
                dec   hl
                ld    a, e
                sub   (hl)             ; compare mant2
                ret   nz               ; exit not same
                pop   hl               ; leave subroutine level of fpaccu_compare
                                       ; directly
                ret                    ; return to fpaccu_compare

; load next 4 bytes at HL into DE,BC
restore_de_bc:  LDDE_M                 ; load 4 bytes into DE, BC
                inc   hl
                LDBC_M
                inc   hl
                ret

fpreg_fix:      ld    b, a             ; store A into FPreg
                ld    c, a
                ld    d, a
                ld    e, a
                ld    xh, a
                ld    xl, a
                or    a                ; was it zero?, yes, exit
                ret   z
                push  hl               ; save HL
                call  fpaccu_to_fpreg  ; load current fpaccu
                call  fpaccu_restoresign
                xor    (hl)            ; complement sign
                ld    h, a             ; save in H
                jp    p, loc_239B      ; positive? skip, else decrement for
                                       ; 2's complement
                dec   de               ; decrement mantissa
                ld    a, d             ; is borrow?
                and   e
                inc   a
                jr    nz, loc_239B     ; no skip
                dec   ix               ; decrement next part of mantissa
                ld    a, xh
                and   xl               ; more borrow?
                inc   a
                jr    nz, loc_239B
                dec   c                ; decrement highest mantissa part
loc_239B:       ld    a, 0A8h          ; exponent for overflow
                sub   b
                call  fpreg_shiftmant  ; do 8 bit shifts
                ld    a, h             ; restore mantissa sign
                rla                    ; move into CY
                call  c, mant_inc r    ; increment for 2s complement
                ld    b, 0             ; mant1
                call  c, fpreg_complement ; complement mantissa
                pop   hl               ; restore HL
                ret

; process INT()
math_int:       ld    hl, fpaccu_exp   ; load exponent
                ld    a, (hl)
                cp    0A8h             ; exponent more than 2^40?
                                       ; no fractional bits available
                ld    a, (fpaccu_mant32)
                ret   nc               ; exit
                ld    a, (hl)          ; clip fractional bits
                call  fpreg_fix
                ld    (hl), 0A8h
                ld    a, b
                push  af
                ld    a, c
                rla
                call  fpreg_normalize  ; normalize number again
                pop   af
                ret

; HL = BC * DE
umultiply16:    ld    hl, 0            ; clear HL
                ld    a, b             ; is index 0?
                or    c
                ret   z                ; return
                ld    a, 11h           ; 17 rounds
loop23CE:       dec   a                ;<+
                ret   z                ; | 
                add   hl, hl           ; | HL * 2
                jr    c, loc_23DB      ; | overflow?, error
                ex    de, hl           ; | get sizeof element
                add   hl, hl           ; | DE * 2
                ex    de, hl           ; | 
                jr    nc, loop23CE     ;>+ overflow?
                add   hl, bc           ; | add index
                jr    nc, loop23CE     ;-+
loc_23DB:       jp    subscript_range_error

; HL=buf, read a 16 bit number
; A= current char read
; returns packed number    in fpaccu
parse_number_fpaccu:
                cp    CHAR_AMP         ; potentially a hex number?
                jp    z, expr_hex
expr_numeric:   cp    CHAR_MINUS       ; negative sign?
                push  af               ; save it
                jr    z, loc_23ED      ; skip
                cp    CHAR_PLUS        ; positive sign?
                jr    z, loc_23ED      ; yes
                dec   hl               ; go back to current char, should be a digit
loc_23ED:       call  fpaccu_zero      ; A = 0
                ld    b, a             ; B = 0
                ld    d, a             ; D = 0
                ld    e, a             ; E = 0
                cpl
                ld    c, a             ; C = FF
loop23F5:       call  nextchar         ;<+ get next from buf
                jr    c, do_mantissapart ; is number? process
                cp    CHAR_PERIOD      ; | is a period?
                jr    z, do_period     ; | yes, process period
                cp    'E'              ; | is exponent?
                jr    nz, number_done  ; | no skip
                call  nextchar         ; | get next char
                dec   d                ; | D = exponent sign
                cp    TOKEN_MINUS      ; | is '-' as token?
                jr    z, do_exponent   ; | yes, advance
                cp    CHAR_MINUS       ; | is '-' as ASCII?
                jr    z, do_exponent   ; | yes advance
                inc   d                ; | positive exponent sign
                cp    CHAR_PLUS        ; | is positive?
                jr    z, do_exponent   ; | yes advance
                cp    TOKEN_PLUS       ; | '+' sign as token?
                jr    z, do_exponent   ; | yes, advance
                dec   hl               ; | no sign found, reread this char
; process exponent                       | 
do_exponent:    call  nextchar         ; | get char of exponent
                jr    c, add_expdigit  ; | is number?, process
                inc   d                ; | exponent sign: was negative?
                jr    nz, number_done  ; | no, done with number
                xor    a               ; | complement exponent
                sub   e                ; | 
                ld    e, a             ; | E = exponent
                inc   c                ; | disable processing part after decimal point
; process mantissa after decimal point   |
; now count each fractional digit (C = 0) in B
; this is the decrement    value for exponent
do_period:      inc   c                ; | was there already a decimal point?
                jr    z, loc_23F5      ;>+ no, loop to read more digits
; has complete number                  ; |
number_done:    push  hl               ; | save curlineptr
                ld    a, e             ; | get exponent
                sub   b                ; | subtract fractional digits
                jp    p, loc_2439      ; | positive? skip
                call  push_fpaccu      ; | push fpaccu
                neg                    ; | make positive
                ld    hl, const1       ; | load constant 1 into fpaccu
                call  mem_to_fpaccu    ; | 
                scf                    ; | set CY
loc_2439:       push  af               ; | save CY and exponent
loop243A:       call  mult10_and_dec   ;<|-+ multiply by 10 and decrement exponent cntr
                jr    nz, loop243A     ;---+ loop until count is zero
                pop   af               ; | restore C flag (negative)
                jr    nc, loc_2449     ; | was positive
                POP_FPREG              ; | pop FPaccu
                call  div_fpreg_fpaccu ; | divide (10*exponent) / mantissa
loc_2449:       pop   de               ; | restore registers
                pop   af               ; | restore sign of mantissa
                call  z, fpaccu_changesign ; change sign if negative
                ex    de, hl           ; | restore curlineptr
                ret                    ; | exit
; process mantissa before decimal point  | 
do_mantissapart:                       ; | 
                push  de               ; | save DE
                ld    d, a             ; | put char in D
                ld    a, b             ; | add C to B
                adc   a, c             ; | CY is set
                                       ; | will add 0 to B for each  digit
                                       ; | before decimal point, and add 1 for each
                                       ; | in fractional part
                ld    b, a             ; | 
                push  bc               ; | save registers
                push  hl               ; | 
                push  de               ; | save character in D
                call  fpaccu_mult10    ; | 
                pop   af               ; | restore character in A
                sub   CHAR_ZERO        ; | convert to digit 0-9
                call  fpaccu_add_u8    ; | add the digit
                pop   hl               ; | restore registers
                pop   bc               ; | 
                pop   de               ; | restore DE
                jr    loop23F5         ;-+ loop next digit
; process exponent digit
add_expdigit:                          ; get exponent
                ld    a, e
                add   a, a             ; multiply with 10
                add   a, a
                add   a, e
                add   a, a
                add   a, (hl)          ; addexponent digit
                sub   CHAR_ZERO        ; convert to digit
                ld    e, a             ; store exponent
                jr    do_exponent      ; loop

expr_hex:       ld    de, 0            ; initialize number buf
loop2474:       call  nextchar         ;<+ get char
                jr    z, loc_249B      ; | end of buf?, exit
                jr    c, loc_2487      ; | is a digit? yes, skip
                sub   'A'              ; | no digit andless than 'A'?
                jr    c, loc_249B      ; | yes, exit
                cp    6                ; | more than 'F'?
                jr    nc, loc_249B     ; | yes, exit
                add   a, 10            ; | adjust to hex digit 0a...0f
                jr    loc_2489         ; | input into number buf
loc_2487:       sub   CHAR_ZERO        ; | was digit, convert to 0...9
loc_2489:       ex    af, af'          ; | save digit
                ld    a, d             ; | get overflow word
                cp    16               ; | is DE already>0xfff? yes reject another digit
                jp    nc, e_overflow   ; | yes, arithmetic overflow
                ex    af, af'          ; | restore digit
                ex    de, hl           ; | save HL
                add   hl, hl           ; | shift HL 4 bit left
                add   hl, hl           ; | 
                add   hl, hl           ; | 
                add   hl, hl           ; | 
                or    l                ; | mask in digit at lowest position
                ld    l, a             ; | back into L
                ex    de, hl           ; | number back into DE
                jr    loop2474         ;-+ loop
loc_249B:       push  hl               ; save HL
                call  uDE_to_fpaccu    ; convert DE to    floating point
                pop   hl        ; restore HL
                ret

fpaccu_add_u8:  call  push_fpaccu      ; push fpaccu
                call  s8_to_fp         ; convert 8 bit into FP
pop_fpreg_and_add:
                POP_FPREG
                jp    add_fpreg_fpaccu

mult10_and_dec: ret   z

fpaccu_mult10_and_dec1:
                push  af
                call  fpaccu_mult10
                pop   af
                dec   a                ; decrement exponent count
                ret

fpaccu_div10_and_inc :
                push  de               ; save registers
                push  hl
                push  af
                call  fpaccu_div10     ; divide fpaccu by 10
                pop   af               ; restore registers
                pop   hl
                pop   de
                inc   a                ; and increment exponent cntr
                ret

; print string " @ line ", for error/stop output,
; print lineno in HL
print_at_lineno:
                push  hl               ; save HL
                ld    hl, a_at_line    ; print " @ line "
                call  print_string
                pop   hl               ; restore it

; print    u16 number in HL
print_HL:       call  hl_to_fpaccu     ; put 16 bit number in fpaccu
                ld    hl, precision    ; save precision
                ld    a, (hl)          ; adjust to maximum precision
                ld    (hl), 0
                push  af
                call  format_number    ; format number
                pop   af               ; restore precision
                ld    (precision), a
                jp    loc_1430

format_number:  xor   a                ; fmt unconditionally

; format number  with format flags in A
format_number_fmt:
                ld    (fmt_flags), a
                ld    hl, numberbuf    ; scratchpad for formatting number
                ld    (hl), CHAR_SPACE ; store a leading space
                and   8                ; check bit 3: put leading '+' sign
                jr    z, loc_24EC      ; no leading '+'
                ld    (hl), CHAR_PLUS  ; stor leading +
loc_24EC:       call  fpaccu_sgn       ; get sign of fpaccu
                jp    p, loc_24FA      ; positive?, yes, dont change sign
                                       ; note: if result is 0, Z is 1
                ld    (hl), CHAR_MINUS ; store leading '-'
                push  hl               ; save print position
                call  fpaccu_changesign ; make accu positive
                pop   hl               ; restore print position
                or    h                ; HL is 01xx, this way ensure that Z=0
loc_24FA:       inc   hl               ; next print position 
                ld    (hl), CHAR_ZERO  ; store a '0'
                ld    a, (fmt_flags)   ; get flags
                ld    d, a             ; into D
                rla                    ; check bit 7 (shifted into CY)
                                       ; note: RLC does not affect Z flag, so this
                                       ; is preserved from checking for accu==zero
                jp    c, format_percent ; do percent format? yes, skip
                jp    z, end_format    ; is accu zero? yes, finished, exit
                                       ; no is not set, continue
                push  hl               ; save print position
                call  adjust_number_1e10 ; adjust number to be in range
                                       ; 1E10-1E11 or larger
                                       ; A contains exponent of adjustment factor
                                       ; 10 ^ -A.
                ld    hl, precision    ; get precision
                inc   (hl)             ; check if zero
                dec   (hl)
                jr    z, loc_2564      ; yes, skip
; assume for example here
; Number N=12.3456789, precision=4
; number in fpaccu is now 1234567800
                ld    d, a             ; D = negative adjustment exponent (-8)
                add   a, 0Bh           ; add 11 (+3)
                jp    m, loc_2555      ; still negative? skip: number is less than 0.01
                cp    (hl)             ; compare with precision (4)
                jr    z, loc_251E      ; same? yes continue
                jr    nc, loc_2555     ; larger than precision, no rounding
                                       ; here: 3-4 -> no skip
loc_251E:       ld    b, a             ; put adjustment into B (+3)
                ld    a, (hl)          ; get precision (4)
                sub   b                ; subtract adjustment (+1)
                inc   a                ; plus 1 (+2)
                ld    c, a             ; into C (+2)
                inc   b                ; adjustment plus 1 (+4)
                ld    a, d             ; exponent into A (-8)
                ld    d, 0Bh           ; D = 11
                pop   hl               ; restore print position
                inc   hl               ; advance to next position
                call  format_numinbuf  ; format the number
                push  hl               ; save current buf position
                xor    a               ; clear A
                ld    bc, 0            ; load maximum cntr
                cpir                   ; find zero byte
                dec   hl               ; one before
                ld    bc, loc_253C     ; inject continuation routine
                push  bc
                xor    a               ; clear A, push  on stack
                push  af               ; exponent to add (0=none)
                jr    loc_2583         ; skip: put exponent if any and exit
loc_253C:                              ; return here after formatting buf
                pop   hl               ; restore the buf position
                ld    a, (hl)          ; get character from buf
                cp    CHAR_MINUS       ; is negative sign?
                ret   z                ; yes, exit
                cp    CHAR_SPACE       ; is space?
                ret   z                ; yes, exit
                cp    CHAR_ZERO        ; is zero?
                jr    z, loc_2552      ; yes, skip
                cp    CHAR_PERCENT     ; is percent?
                jr    nz, loc_2551     ; no, skip
                inc   hl               ; yes, it is
                    ; advance to next
                ld    a, (hl)          ; get next character
                cp    CHAR_MINUS       ; is negative sign?
                ret   z                ; yes, skip
loc_2551:       dec   hl               ; no replace with space
loc_2552:       ld    (hl), CHAR_SPACE
                ret                    ; exit
loc_2555:       ld    c, (hl)          ; get precision again
                dec   c                ; decrement
                jr    z, loc_255A      ; was 1?
                inc   c                ; no, add 1 more digit
loc_255A:       ld    b, 2             ; load cntr = 2
                pop   hl               ; restore print position
                inc   hl               ; advance to next position
                ld    a, d             ; load adjustment exponent
                ld    d, 0             ; cntr = 0
; A = adjustment exponent
; D = 0
                jp    loc_26D7
; precision is 0
; A is adjustment exponent (positive or negative)
loc_2564:       ld    bc, 300h         ; B = 3, C = 0
                add   a, 0Ch           ; add 12
                jp    m, loc_2574      ; still negative, i.e. less than 0.01
                cp    0Dh              ; is it even less than 0.001?
                jr    nc, loc_2574
                inc   a                ; increment
                ld    b, a             ; set exponent = 2
                ld    a, 2
loc_2574:       sub   2
                pop   hl
                push  af
                call  set_comma
                ld    (hl), CHAR_ZERO
                jr    nz, loc_2580
                inc   hl
loc_2580:       call  output_num_digits ; put digits of number into buf
loc_2583:       dec   hl               ; point to previous buf position
                ld    a, (hl)          ; load char
                cp    CHAR_ZERO        ; is zero?
                jr    z, loc_2583      ; yes, loop
                cp    CHAR_PERIOD      ; is decimal point?
                jr    z, loc_258E      ; yes, skip
                inc   hl               ; point to last non-zero fractional digit
loc_258E:       pop   af               ; restore exponent
                jr    z, end_format1   ; terminate if 0 (none)

sub_2591:       ld    (hl), CHAR_E     ; put E for exponent in buf
                inc   hl               ; next position
                ld    (hl), CHAR_PLUS  ; put positive sign
                jp    p, loc_259D      ; was exponent positive?
                ld    (hl), CHAR_MINUS ; no, put negative sign
                neg                    ; negate exponent
loc_259D:       ld    b, CHAR_ZERO-1   ; preload '0'-1
loc_259F:       inc   b                ; increment digit count
                sub   10               ; subtract 10 from exponent
                jr    nc, loc_259F     ; loop until negative
                add   a, CHAR_NINE+1   ; add10 again andconvert to digit (+'0')
                inc   hl               ; put tenth digit into buf
                ld    (hl), b
                inc   hl               ; put remainder digit into buf
                ld    (hl), a
end_format:     inc   hl               ; advance 
end_format1:    ld    (hl), 0          ; store terminating zero byte
                ex    de, hl           ; DE is end of number
                ld    hl, numberbuf    ; HL is start of number
                ret

format_percent: inc   hl               ; advance to next position
                push  bc               ; save format, buf position
                push  hl
                ld    a, d             ; load format flags
                rra                    ; bit 0 into CY (digits for exponent)
                jp    c, loc_26CE      ; must do an exponent? yes, skip
                FPREG_CONST 0B60Eh, 1BC9h, 0BF04h ; constant 1E16
                call  fpaccu_compare   ; compare value with 1E16
                jp    m, loc_25D3      ; larger?
                pop   hl               ; restore regs
                pop   bc
                call  format_number    ; just format number
                dec   hl               ; and add a percent sign afterwards
                ld    (hl), CHAR_PERCENT
                ret                    ; exit
loc_25D3:       ld    d, 11            ; length of field
                call  fpaccu_sgn       ; check number zero
                call  nz, adjust_number_1e10 ; no adjust into range 1E10-1E11
                pop   hl               ; restore regs
                pop   bc
                jp    m, format_numinbuf ; format number
                push  bc               ; save format to use
                ld    e, a             ; save precision
                ld    a, b
                sub   d                ; subtract field width
                sub   e                ; subtract precision
                call  p, add_zeros     ; addleading zeros
                call  check_1000s_marker ; calculate position of next comma if any, in C
                call  output_num_digits ; format the digits to emit
                or    e                ; more digits before decimal point?
                call  nz, pad_zeros    ; yes, pad with zeros, A=0
                add   a, e             ; put E in A, set flags
                call  nz, set_comma    ; add comma, if neeeded
                pop   de               ; restore format
                ld    a, e             ; load C (precision)
                or    a                ; is zero?
                jr    nz, loc_25FC     ; no, skip
                dec   hl               ; preceding position
loc_25FC:       dec   a
                call  p, add_zeros
loc_2600:       push  hl               ; save HL
                ld    hl, numberbuf    ; get number buf
                ld    b, (hl)          ; get first char
                ld    c, CHAR_SPACE    ; preload space
                ld    a, (fmt_flags)   ; get format flags
                ld    e, a             ; into E
                and   20h              ; test bit 6 (replace leading ' ' with '*')
                jr    z, loc_2616      ; do not replace
                ld    a, b             ; put char in A
                cp    c                ; is space?
                ld    c, CHAR_STAR     ; preload '*'
                jr    nz, loc_2616     ; was not space, skip
                ld    b, c             ; was space, replace with '*'
loop2616:       ld    (hl), c          ;<+ put space or '*' in buf
                call  nextchar         ; | get next char from buf
                jr    z, loc_262C      ; | end of buf, skip
                cp    CHAR_E           ; | is E?
                jr    z, loc_262C      ; | yes, skip
                cp    CHAR_ZERO        ; | is '0'?
                jr    z, loop2616      ;>+ yes, advance
                cp    CHAR_COMMA       ; | is comma?
                jr    z, loop2616      ;-+ yes, advance
                cp    CHAR_PERIOD      ; is decimal point?
                jr    nz, loc_262F     ; no skip
loc_262C:       dec   hl               ; preceding position
                ld    (hl), CHAR_ZERO  ; put '0' here
loc_262F:       bit    4, e            ; add leading '$'?
                jr    z, loc_2636      ; no, skip
                dec   hl               ; preceding position
                ld    (hl), CHAR_DOLLAR ; put '$' in buf
loc_2636:       bit    2, e            ; space for positive sign?
                jr    nz, loc_263C     ; yes, skip
                dec   hl               ; preceding position
                ld    (hl), b          ; put space or '*' in position
loc_263C:       pop   hl               ; restore end of bufptr
                jr    z, loc_2641      ; was not space for positive
                ld    (hl), b          ; put trailing '*' or space
                inc   hl               ; next position
loc_2641:       ld    (hl), 0          ; put zero byte delimiter
                ld    hl, numberbuf0   ; load one position before buf
loop2646:       inc   hl               ;<+ advance position
loop2647:       ld    a, (pos_period)  ;<--+ get low address val of position of period
                sub   l                ; | | subtract buf begin
                sub   d                ; | | subtract field length
                ret   z                ; | | correct size?    return
                ld    a, (hl)          ; | | load character
                cp    CHAR_SPACE       ; | | is space?
                jr    z, loop2646      ;>+ | 
                cp    CHAR_STAR        ; | | or '*'?
                jr    z, loop2646      ;>+ | yes, advance
                dec   hl               ;   | preceding position
                push  hl               ;   | digits start here, save
loop2658:       push  af               ;<+ | save current character
                call  nextchar         ; | | next char
                cp    CHAR_MINUS       ; | | is negative sign?
                jr    z, loop2658      ;>+ | save and advance
                cp    CHAR_PLUS        ; | | is positive sign?
                jr    z, loop2658      ;>+ | yes, save and advance
                cp    CHAR_DOLLAR      ; | | is '$'?
                jr    z, loop2658      ;>+ | yes save andadvance
                cp    CHAR_ZERO        ;   | is leading zero?
                jr    nz, loc_267C     ;   | no, non-zero digits start here
; discard leading zeroes to fit number into buf
                inc   hl               ;   | advance to next
                call  nextchar         ;   | get next char
                jr    nc, loc_267C     ;   | not digit, skip
                dec   hl               ;   | position to previous
                db    1                ;   | LD BC, xxxx to skip over next two instrs
loop2674:       dec   hl               ;<+ | ** position to previous
                ld    (hl), a          ; | | ** store character here
                pop   af               ; | | restore the char before leading zeros
                jr    z, loop2674      ;-+ | not at end? loop
                pop   bc               ;   | drop saved digit position
                jr    loop2647         ;---+ loop fitting number into field
loop267C:       pop   af               ;<+ drop characters until end of buf
                jr    z, loop267C      ;-+
                pop   hl               ; restore buf position
                ld    (hl), CHAR_PERCENT ; add a percent sign
                ret                    ; done

; has number in FPaccu, adjusted to range 1E10-1E11
; again in example:
; Number=12.2345678 precision 4
; fpaccu=1234567800
format_numinbuf:
                ld    e, a             ; save exponent in E (-8)
                ld    a, c             ; adjustment in A (+2)
                or    a                ; does not need correction?
                jr    z, loc_2689      ; no, skip
                dec   a                ; decrement required adjustment (+1)
loc_2689:       add   a, e             ; target exponent (-7)
                jp    m, loc_268E      ; is negative?, skip
                xor   a                ; target exponent=0
loc_268E:       push  bc               ; save BC (B=+4, C=+2)
                push  af               ; save target exponent
loop2690:       call  m, fpaccu_div10_and_inc ;<+ divide FPaccu/10 andincrement A
                jr    nz, loop2690     ;--------+ target exponent is not yet 0, loop
                                       ; fpaccu now 123.4567800
                pop   bc               ; restore exponent in B (-7)
                ld    a, e             ; get exponent (-8)
                sub   b                ; subtract (-1)
                pop   bc               ; restore BC (+4, +2)
                ld    e, a             ; save further exponent correction (-1)
                add   a, d             ; add field width (10)
                ld    a, b             ; get B again (+4)
                jp    m, loc_26AA      ; too large for field?, skip
                sub   d                ; subtract (-7)
                sub   e                ; subtract (-8)
                call  p, add_zeros     ; positive: add leading zeros
                push  bc               ; save BC (+4, +2)
                call  check_1000s_marker ; get modulo for 1000s comma
                jr    loc_26BB         ; skip
loc_26AA:       call  add_zeros        ; add leading zeros
                ld    a, c             ; save C
                call  set_period       ; store decimal point in buf
                ld    c, a             ; restore C
                xor   a                ; calculate number of trailing zeros
                sub   d
                sub   e
                call  add_zeros        ; add trailing zeros
                push  bc               ; save B, C (+4,+2)
                ld    b, a             ; clear B,C
                ld    c, a
loc_26BB:       call  output_num_digits ; (B+C digits)
                pop   bc               ; restore BC
                or    c                ; A was 0, check if C is also 0
                jr    nz, loc_26C5     ; no, still digits to add(after decimal  point)
                ld    hl, (pos_period) ; get position of period
loc_26C5:       add   a, e             ; calculate remaining field width
                dec   a                ; add trailing zeros to fill field width
                call  p, add_zeros
                ld    d, b             ; get number digits after decimal point
                jp    loc_2600         ; jump to final corrections
loc_26CE:       call  fpaccu_sgn
                scf
                call  nz, adjust_number_1e10
                pop   hl
                pop   bc
loc_26D7:       push  af               ; save adjustment
                ld    a, c             ; get precision
                add   a, a             ; * 2
                push  af               ; save
                jr    z, loc_26DE      ; was zero, skip
                dec   a                ; one less
loc_26DE:       add   a, b
                ld    c, a
                ld    a, d
                and   4
                cp    1
                sbc   a, a
                ld    d, a
                add   a, c
                ld    c, a
                sub   0Bh
                push  af
                push  bc
loop26ED:       call  m, fpaccu_div10_and_inc ;<+
                jp    m, loop26ED      ;--------+
                pop   bc
                pop   af
                push  bc
                push  af
                jp    m, loc_26FB
                xor    a
loc_26FB:       neg
                add   a, b
                inc   a
                add   a, d
                ld    b, a
                ld    c, 0
                call  output_num_digits
                pop   af
                call  p, sub_2815
                pop   bc
                pop   af
                jr    nz, loc_270F
                dec   hl
loc_270F:       pop   af
                jr    c, loc_2716
                add   a, 0Bh
                sub   b
                sub   d
loc_2716:       push  bc
                call  sub_2591
                ex    de, hl
                pop   de
                jp    loc_2600

; routine to adjust number so it is between 1E10 and1E11
; return correction exponent in A
; A is negative when number had to be multiplied, i.e. was <1E10
; e.g. number =    1.00 ->    A = -9
adjust_number_1e10:
                push  de               ; save registers
                xor    a               ; clear adjustment factor
                push  af               ; save it
                call  sub_2748
loop2725:       FPREG_CONST 0A215h, 2F8h, 0FFFDh ; constant 9 999 999 999.9
                call  fpaccu_compare   ; compare accu with constant
                jp    p, loc_2745      ; is larger, exit
                pop   af               ; restore exponent count
                call  fpaccu_mult10_and_dec1 ; multiply with 10 and decrement exponent
                push  af
                jp    loop2725         ; loop
loop273D:       pop   af               ;<---+ restore exponent count
                call  fpaccu_div10_and_inc ;| divide by 10 and adjust exponent count
                push  af               ;    | save exponent count again
                call  sub_2748         ;    | is still too large?
loc_2745:       pop   af               ;    | 
                pop   de               ;    | 
                ret                    ;    | 
sub_2748:       FPREG_CONST 0A53Ah, 43B7h, 3FFCh ; constant 99 999 999 999.5
                call  fpaccu_compare   ;    | compare accu with constant
                pop   hl               ;    | get return value
                jp    p, loop273D      ;----+ if larger, divide by 10
                jp    (hl)

; set a 1000s marker (comma), if needed
; (still digits to emit before decimal point)
; B is digits before decimal point
set_comma:      dec   b                ; decrement count of digits before period
                jr    nz, loc_2765     ; not yet zero, emit more

; put a decimal point into number buf, clear C if called from set_comma
set_period:     ld    (hl), CHAR_PERIOD ; store a period
                ld    (pos_period), hl ; save period position
                inc   hl               ; advance to next position
                ld    c, b             ; clear C, when coming from set_comma
                ret                    ; exit
loc_2765:       dec   c                ; decrement comma cntr
                ret   nz               ; not yet zero, exit
                ld    (hl), CHAR_COMMA ; put a comma marker into buf
                inc   hl
                ld    c, 3             ; reload comma cntr
                ret                    ; exit

output_num_digits:
                push  de               ; save registers
                push  bc
                push  hl
                call  add_0_5          ; add 0.5 for rounding
                inc   a                ; add 1 to FPaccu exponent
                call  fpreg_fix        ; clip fractional digits
                call  store_fpaccu     ; save result again
                pop   hl               ; restore HL, BC registers
                pop   bc
                ld    de, powers10     ; get powers of 10 table
                ld    a, 0Bh           ; loop count
; B is number of digits before decimal point
; C cntr for comma positions
loop2781:                              ;<--+ set a 1000s marker if needed,
                                       ;   | or a period, unless
                call  set_comma        ;   | more digits to emit
                push  bc               ;   | save regs
                push  af               ;   | 
                push  hl               ;   | 
                push  de               ;   | 
                call  fpaccu_to_fpreg  ;   | copy fpaccu to fpreg
                pop   hl               ;   | HL = powers of 10 table
                ld    b, CHAR_ZERO-1   ;   | preload '0'-1
loop278E:       inc   b                ;<+ | increment (accumulator of current digit)
                ld    a, e             ; | | subtract current power of 10
                sub   (hl)             ; | | 
                ld    e, a             ; | | 
                inc   hl               ; | | 
                ld    a, d             ; | | 
                sbc   a, (hl)          ; | | 
                ld    d, a             ; | | 
                inc   hl               ; | | 
                ld    a, xl            ; | | 
                sbc   a, (hl)          ; | | 
                ld    xl, a            ; | | 
                inc   hl               ; | | 
                ld    a, xh            ; | | 
                sbc   a, (hl)          ; | | 
                ld    xh, a            ; | | 
                inc   hl               ; | | 
                ld    a, c             ; | | 
                sbc   a, (hl)          ; | | 
                ld    c, a             ; | | 
                dec   hl               ; | | point back to current power
                dec   hl               ; | | 
                dec   hl               ; | | 
                dec   hl               ; | | 
                jr    nc, loop278E     ;-+ | still positive, loop
                call  add_mantissas    ;   | became negative, addcurrent power again
                inc   hl               ;   | advance to next position
                call  store_fpaccu     ;   | save the current result again
                ex    de, hl           ;   | DE is ptr to powers of 10, now next power
                pop   hl               ;   | restore ptr to number buf
                ld    (hl), b          ;   | save calculated digit
                inc   hl               ;   | advance to next buf position
                pop   af               ;   | restore A
                pop   bc               ;   | restore BC
                dec   a                ;   | decrement loop
                jr    nz, loop2781     ;---+ loop for 11 digits
                call  set_comma        ; set comma if needed
                ld    (hl), a          ; store terminating zero in buf
                pop   de               ; restore DE
                ret

powers10:       db    0, 0E4h, 0Bh, 54h, 2 ; constant 10000000000
                db    0, 0CAh, 9Ah, 3Bh, 0 ; constant 1000000000
                db    0, 0E1h, 0F5h, 5, 0  ; constant 100000000
                db    80h, 96h, 98h, 0, 0  ; constant 10000000
                db    40h, 42h, 0Fh, 0, 0  ; constant 1000000
                db    0A0h, 86h, 1, 0, 0   ; constant 100000
                db    10h, 27h, 0, 0, 0    ; constant 10000
                db    0E8h, 3, 0, 0, 0     ; constant 1000
                db    64h, 0, 0, 0, 0      ; constant 100
                db    0Ah, 0, 0, 0, 0      ; constant 10
                db    1, 0, 0, 0, 0        ; constant 1

add_zeros:      or    a                ; is cntr for zeros = 0?
                ret   z                ; yes exit
                dec   a                ; decrement count
                ld    (hl), CHAR_ZERO  ; put '0' in buf
                inc   hl               ; advance to next
                jr    add_zeros        ; loop

check_1000s_marker:
                ld    a, e             ; get E (-1)
                add   a, d             ; add field width (10)
                inc   a                ; add 1 for period (11)
                ld    b, a             ; put into B
                inc   a                ; add 1 (12)
loop2806:       sub   3                ;<+ calculate modulo 3
                jr    nc, loop2806     ;-+
                add   a, 5             ; add 5 to modulo
                ld    c, a             ; store into C (+5)
                ld    a, (fmt_flags)   ; get format flags
                and   40h              ; check comma flag
                ret   nz               ; exit with modulus+5 if set
                ld    c, a             ; return zero if not set
                ret

sub_2815:       jr    nz, pad_zeros
loop2817:       ret   z                ;<+
                call  set_comma        ; | 
pad_zeros:      ld    (hl), CHAR_ZERO  ; | put trailing zero in buf
                inc   hl               ; | advance
                dec   a                ; | decrement cntr
                jr    loop2817         ;-+ loop

; has seen PRINT USING...
printusing:     call  nextchar         ; get next token
                jr    nc, loc_2844     ; is not a digit, skip
                call  read_lineno      ; get lineno of USING statement ("!...")
                push  hl               ; save curlineptr
                call  find_line        ; search for USING line
                jp    nc, undef_stmt_error ; not found, error
                LDHL_BC                ; get position into HL
                inc   hl               ; advance to line body, skip lineno
                inc   hl
                inc   hl
                call  nextchar         ; get first char of line
                sub   9Ch              ; must be a ! token
                jp    nz, illfunc_error ; otherwise error
                ld    b, a             ; B is 0, store string terminator
                                       ; USING is only statement in line
                call  copy_0string     ; copy 0 terminated string in stringaccu
                pop   hl               ; restore curlineptr of PRINT statement
                jr    loc_2847         ; skip
loc_2844:       call  string_expression1 ; get a string expression
loc_2847:       call  skipspace        ; advance to next non-whitespace
                scf                    ; set CY
                jr    z, loc_2859      ; end of statement? skip
                cp    CHAR_COMMA       ; expect either comma or semicolon
                jr    z, loc_2856
                cp    CHAR_SEMI
                jp    nz, syntax_error ; otherwise syntax error
loc_2856:       call  nextchar         ; skip over delimiter
loc_2859:       ex    de, hl           ; save curlineptr
                ld    hl, (fpaccu_mant32) ; load string descriptor of USING
                db    1                ; LD BC, xxxx to skip next 2 instructions
                                       ; is uncritical because BC will be overwritten
loc_285E:       pop   de               ; **
                ex    de, hl           ; **
                push  hl               ; save ptr to USING string
                push  af               ; save nextchar after expression
                push  de               ; save DE
                ld    b, (hl)          ; get string length
                or    b
                jp    z, illfunc_error ; empty? error
                inc   hl               ; point to address of USING format
                inc   hl
                LDHL_M C               ; get USING format into HL
                jp    loc_2877         ; skip
loc_2871:       call  plus_if_D        ; print leading '+' if requested
                call  write_char       ; print the char in A
loc_2877:
                xor   a
                ld    e, a             ; numeric digits before decimal point
                                       ; (C will become digits after DP)
                ld    d, a             ; stores fmt_flag, initially 0
loop287A:       call  plus_if_D        ;<+ print leading '+' if D != 0
                ld    d, a             ; | store fmt_flag
                ld    a, (hl)          ; | get char from USING format
                inc   hl               ; | next position
                cp    CHAR_HASH        ; | is it a numeric digit?
                jp    z, using_numeric ; | 
                cp    CHAR_TIC         ; | TIC, is it a string field?
                jp    z, using_string  ; | 
                dec   b                ; | decrement length of format
                jp    z, using_end     ; | end of format? yes skip
                cp    CHAR_PLUS        ; | no, is it a '+'?
                ld    a, 8             ; | yes set bit3 in format flag (leading '+')
                jr    z, loop287A      ;-+ loop
                dec   hl               ; no wasn't a '+', reget the last format character
                ld    a, (hl)
                inc   hl
                cp    CHAR_PERIOD      ; a leading decimal point?
                jp    z, using_dp1     ; yes, count digits after DP
                cp    (hl)             ; duplicate characters?
                jr    nz, loc_2871     ; print non-format char
                cp    CHAR_DOLLAR      ; was the duplicate char a '$'?
                jr    z, using_dollar  ; yes, skip
                cp    CHAR_STAR        ; is '*'?
                jr    nz, loc_2871     ; no, print the non-format character
                ld    a, b             ; get format string length
                cp    2                ; at least more than 2 chars in format?
                inc   hl               ; advance to next format pos
                jr    c, loc_28B0      ; no, skip
                ld    a, (hl)          ; get next format char
                cp    CHAR_DOLLAR      ; is it a '$', i.e. sequence '**$'?
loc_28B0:       ld    a, 20h           ; set bit 5 of fmt_flag
                jr    nz, loc_28BB     ; not '**$', skip
                dec   b                ; decrement remaining format length
                inc   e                ; add one more digit before decimal point
                db    0FEh             ; CP AF to skip next instruction
using_dollar:   xor   a                ; ** clear fmt_flag
                add   a, 10h           ; set flag 4 of fmt_flag
                inc   hl               ; advance to next format character
loc_28BB:       inc   e                ; increment numeric digit count (for '*')
                add   a, d             ; set bits into fmt_flag
                ld    d, a
using_numeric:  inc   e                ; increment cntr for numeric digits
                ld    c, 0             ; clear cntr of digits after DP
                dec   b                ; decrement format length
                jr    z, loc_290A      ; end of format? skip
                ld    a, (hl)          ; get next char of format
                inc   hl               ; advance format ptr
                cp    CHAR_PERIOD      ; is it a decimal point?
                jr    z, using_dp      ; yes decimal
                cp    CHAR_HASH        ; is it another numeric digit?
                jr    z, using_numeric ; yes loop
                cp    CHAR_COMMA       ; is it a comma?
                jr    nz, loc_28EB
                set    6, d            ; set fmt_flag bit 6 (addcommas for 1000's)
                jr    using_numeric    ; loop
using_dp1:                             ; handle leading decimal point
                ld    a, (hl)          ; get next format char
                cp    CHAR_HASH        ; is it numeric?
                ld    a, CHAR_PERIOD   ; load decimal point
                jp    nz, loc_2871     ; not numeric, go, print the decimal point
                ld    c, 1             ; set count of digits after decimal point
                inc   hl               ; advance to next format position
using_dp:       inc   c                ; increment count of digits after decimal point
                dec   b                ; decrement format ptr
                jr    z, loc_290A      ; exit if zero
                ld    a, (hl)          ; get next format character
                inc   hl               ; advance format ptr
                cp    CHAR_HASH        ; is it '#'?
                jr    z, using_dp      ; continue counting digits after DP
                                       ; a non-# format char
loc_28EB:       push  de               ; save fmt_flag and digit count
                LDDE_HL                ; save current format pos into DE
                cp    CHAR_POWER       ; is it a ^ (exponent marker)
                jr    nz, loc_2908     ; no, skip
                cp    (hl)             ; check with next pos
                jr    nz, loc_2908     ; not a second ^, skip
                inc   hl
                cp    (hl)             ; check third pos
                jr    nz, loc_2908     ; no, not a third ^
                inc   hl
                cp    (hl)             ; check fourth pos
                jr    nz, loc_2908     ; no, not a fourth ^
                inc   hl
                ld    a, b             ; subtract 4 from string length
                sub   4
                jr    c, loc_2908      ; not enough chars left in format?
                pop   de               ; restore format flag and digit count
                ld    b, a             ; save string length back to B
                inc   d                ; set flag 0 in fmt
                inc   hl               ; advance to next position
                db    0CAh             ; JP Z, xxxx to skip next 2 instructions
                                       ; is uncritical because Z is never set here
loc_2908:       ex    de, hl           ;** restore old position of format ptr
                pop   de               ;** restore saved flags
loc_290A:       dec   hl               ; skip back to last char of format
                inc   e                ; reserve a digit for a potential sign
                bit   3, d             ; check sign flag
                jr    nz, loc_2923     ; is sign bit set
                dec   e                ; have a reserved sign position
                                       ; therefore don't reserve another one
                ld    a, b             ; get remaining format string length
                or    a
                jr    z, loc_2923      ; now at end? yes, skip
                ld    a, (hl)          ; no, is it a '-'?
                sub   CHAR_MINUS
                jr    z, using_minus   ; yes, skip
loc_291A:       cp    -2               ; was it a '+'?
                jr    nz, loc_2923     ; no, skip
                set   3, d             ; yes, it was, set BIT 3
using_minus:    set   2, d             ; set bit 2: print minus sign, but space for '+'
                dec   b                ; decrement format string length
loc_2923:       pop   hl               ; restore curlineptr
                pop   af               ; restore nextchar
                jr    z, loc_2978      ; is EOLN? yes skip
                push  bc               ; save format
                push  de               ; D = fmt_flag
                                       ; E = digits before DP
                                       ; C = digits after DP
                call  expression1      ; get expression to print
                pop   de               ; restore format
                pop   bc
                push  bc               ; save BC
                push  hl               ; save curlineptr
                ld    b, e             ; get digits before DP into E
                ld    a, b             ; calculate total length of field
                add   a, c
                cp    25               ; longer than 25? -> accuracy problem,
                                       ; we don't have that many significant digits
                jp    nc, illfunc_error ; yes, error
                ld    a, d             ; get format flag
                or    80h              ; set bit 7
                call  format_number_fmt ; format number in buf
                call  straccu_copy_print ; copy to straccu andprint it
print_mainloop: pop   hl               ; restore curlineptr
                call  skipspace        ; advance to next non-whitespace
                scf
                jr    z, loc_2954      ; end of line? yes, exit
                cp    CHAR_SEMI        ; semicolon follwing?
                jr    z, loc_2951      ; yes advance
                cp    CHAR_COMMA       ; comma following?
                jp    nz, syntax_error ; no, error
loc_2951:       call  nextchar         ; advance
loc_2954:       pop   bc               ; restore BC
                ex    de, hl           ; save curlinepos -> DE
                pop   hl               ; restore string descriptor to format
                push  hl               ; save it again
                push  af
                push  de               ; save curlineptr
                ld    a, (hl)          ; get string length
                sub   b                ; subtract format length
                inc   hl               ; advance to string ptr
                inc   hl
                LDHL_M C               ; get string address into HL
                ld    d, 0
                ld    e, a
                add   hl, de           ; advance to remaining format part
                ld    a, b             ; still chars in format string?
                or    a
                jp    nz, loc_2877     ; yes, do another formatting
                jr    loc_2973         ; otherwise exit
using_end:      call  plus_if_D
                call  write_char
loc_2973:       pop   hl               ; restore curlineptr
                pop   af               ; restore last char seen
                jp    nz, loc_285E     ; loop
loc_2978:       call  c, print_crlf    ; print new line
                ex    (sp), hl         ; save curlineptr to stack, restore
                                       ; string stack ptr
                call  pop_str_stringstk ; discard format/scratchpad from string stack
                pop   hl               ; restore curlineptr
                ret                    ; exit

; has seen a tic (') for a string field
using_string:   ld    c, 1             ; initialize field size cntr
                ld    e, 'L'           ; left justified
                dec   b                ; nothing left?, exit
                jr    z, loc_29A4
                ld    a, (hl)          ; get char after tic
                inc   hl               ; advance
                cp    'E'              ; is it an 'E' (left justify with extension)
                jr    z, loc_299A      ; yes, put into reg E
                cp    'R'              ; is it a 'R' (right justified)?
                jr    z, loc_299A      ; yes, put into reg E
                cp    'L'              ; is it an 'L' (left justified)?
                jr    z, loc_299A      ; yes, put into reg E
                cp    'C'              ; is it a 'C' (centered)?
                jr    nz, loc_29A4     ; no, skip, default reg E is 'L')
loc_299A:       ld    e, a             ; store the justification key in E
loc_299B:       inc   c                ; increment field size cntr
                dec   b                ; at end of line?
                jr    z, loc_29A4      ; yes, exit loop
                ld    a, (hl)          ; get next char
                inc   hl               ; advance
                cp    e                ; is it the same as previous one?
                jr    z, loc_299B      ; yes, loop
; end of USING string
;
; start here to emit string corresponding to format
loc_29A4:       call  plus_if_D        ; emit start of field
                pop   hl               ; restore curlineptr
                pop   af               ; and last char seen
                jr    z, loc_2978      ; EOLN? yes exit
                push  bc
                push  de
                call  string_expression1 ; get a string expression
                pop   de
                pop   bc
                push  bc               ; B = remaining format length
                                       ; C = field length
                                       ; E = justification
                push  hl               ; save curlineptr
                ld    hl, (fpaccu_mant32) ; get string descriptor in FPaccu
                ld    b, c             ; get field length
                ld    c, 0             ; cntr for trailing spaces
                ld    a, e             ; get justification
                cp    'E'              ; left with extension?
                jr    z, loc_29EA      ; yes, skip
                                       ; effectively just print the string as is
                push  de               ; save regs
                push  bc
                call  loc_15CD
                pop   bc
                pop   de
                ld    a, b
                sub   (hl)
                ld    b, a
                ld    a, e
                cp    'L'
                jr    z, loc_29DC
                cp    'R'
                jr    z, loc_29E7
                ld    a, b
                srl    b
                sub   b

; B = cnt for leading spaces
; A = cnt for trailing spaces
print_lead_field_trail:            
                ex    af, af'          ; save count for trailing spaces
                call  print_b_spaces   ; print spaces, count in B
                ex    af, af'          ; restore
print_field_and_trailing:
                ld    b, a             ; put cnt for trailing in B
loc_29DC:       push  bc
                call  straccu_print    ; print the string
                pop   bc
                call  print_b_spaces   ; print trailing spaces
                jp    print_mainloop   ; continue with print
loc_29E7:       xor   a                ; cntr for trailing spaces = 0
                jr    print_lead_field_trail ; enter printing loop
loc_29EA:       ld    a, b             ; get field length
                sub   (hl)             ; subtract string length
                jr    nc, print_field_and_trailing ; if less, store difference
                                       ; as cntr for trailing spaces
                xor    a               ; otherwise set trailing count = 0
                jr    print_field_and_trailing ; print the field

print_b_spaces: inc   b
loop29F2:       dec   b                ;<+
                ret   z                ; | 
                call  print_space      ; | 
                jr    loop29F2         ;-+

; in USING, print a leading or trailing '+' if D is non-zero
plus_if_D:      push  af               ; save A
                ld    a, d             ; get SIGN flag
                or    a
                ld    a, CHAR_PLUS     ; if set, print a '+'
                call  nz, write_char
                pop   af               ; restore A
                ret

; insert a change sign into return stack
; to be called when calling routine returns (for ATN)
push_changesign:
                ld    hl, fpaccu_changesign
                ex    (sp), hl
                jp    (hl)

const0_5:       db    0, 0, 0, 0, 0, 80h ; constant 0.5

; process SQR()
math_sqr:       call  push_fpaccu      ; push fpaccu
                ld    hl, const0_5     ; get constant
                call  mem_to_fpaccu    ; into fpaccu

; pop fpreg off stack and calc power of fpaccu
pop_fpreg_and_power:
                POP_FPREG              ; pop fpreg
; calculate fpreg ^ fpaccu => fpaccu
fpaccu_power:   call  fpaccu_sgn       ; get sign of powerexp
                jr    z, math_exp      ; is zero, then calculate exp(0) == 1
                                       ; note: this is inefficient
                ld    a, b             ; get exponent of base
                or    a
                jp    z, loc_200F      ; is zero? => result is zero
                PUSH_FPREG             ; push base again
                ld    a, c             ; get base
                or    7Fh
                call  fpaccu_to_fpreg  ; copy powerexp to fpreg
                jp    p, loc_2A44      ; is positive, skip
                PUSH_FPREG             ; push powerexp
                call  math_int         ; calculate int(powerexp)
                POP_FPREG              ; restore powerexp
                push  af               ; save base sign
                call  fpaccu_compare   ; compare INT(powerexp) with powerexp()
                pop   hl               ; restore base sign
                ld    a, h
                rra                    ; into CY
loc_2A44:       pop   hl               ; pop base into fpaccu
                ld    (fpaccu_mant6), hl
                pop   hl
                ld    (fpaccu_mant54), hl
                pop   hl
                ld    (fpaccu_mant32), hl
                call  c, push_changesign ; change sign afterwards
                call  z, fpaccu_changesign ; change sign now
                PUSH_FPREG             ; pop powerexp in to fpreg
                call  math_log         ; calculate LOG(base)
                POP_FPREG
                call  multiply_fpreg_fpaccu ; LOG(base)*powerexp

; process EXP()
math_exp:       FPREG_CONST 8138h, 0AA3Bh, 295Ch ; get constant 1/LOG(2)
                call  multiply_fpreg_fpaccu ; multiply with fpaccu
                ld    a, (fpaccu_exp)
                cp    88h
                jp    nc, loc_2280     ; exponent too large?
                                       ; if sign is negative, then result
                                       ; is zero, otherwise overflow error
                call  push_fpaccu      ; push arg
                call  math_int         ; do INT(arg)
                POP_FPREG              ; pop fpreg
                push  af               ; save sign
                call  subtr_fpreg_fpaccu ; calculate arg - INT(arg)
                ld    hl, EXP_poly_tbl ; load coefficient table
                call  fpaccu_polyeval  ; do polynomial eval
                ld    hl, fpaccu_exp   ; get exponent
                pop   af               ; restore
                or    a                ; check for exponent value
                jp    m, loc_2A97      ; negative, potential overflow
                add   a, (hl)          ; add exponent
                db 1                   ; LD BC, xxxx to skip next 2 instructions
                                       ; is uncritical because BC will be overwritten
loc_2A97:       add   a, (hl)          ;** 
                ccf                    ;** 
                ld    (hl), a          ; store resulting exponent
                ret   nc               ; return result if not overflow
                jp    loc_2280         ; overflow

EXP_poly_tbl:   db    0Ah
                db    0CCh, 0D5h, 45h, 56h, 15h, 6Ah   ; 0.00000014
                db    0CFh, 37h, 0A0h, 92h, 27h, 6Dh   ; 0.00000125
                db    0F5h, 95h, 0EEh, 93h, 0, 71h     ; 0.00001533
                db    0D0h, 0FCh, 0A7h, 78h, 21h, 74h  ; 0.00015399
                db    0B1h, 21h, 82h, 0C4h, 2Eh, 77h   ; 0.00133337
                db    82h, 58h, 58h, 95h, 1Dh, 7Ah     ; 0.00961813
                db    6Dh, 0CBh, 46h, 58h, 63h, 7Ch    ; 0.05550411
                db    0E9h, 0FBh, 0EFh, 0FDh, 75h, 7Eh ; 0.24022651
                db    0D2h, 0F7h, 17h, 72h, 31h, 80h   ; 0.69314718
                db    0, 0, 0, 0, 0, 81h               ; 1.0

; calculate X^2 first and then evaluate
; polynomial a0*X + a1*X^2 + a2*x^3 + a3*x^4 ...
fpaccu_polyeval_sqr:
                call  push_fpaccu      ; push fpaccu
                ld    de, pop_fpreg_and_mult ; push routine to multiply at the end
                push  de
                push  hl               ; save HL
                call  fpaccu_to_fpreg  ; copy to fpreg
                call  multiply_fpreg_fpaccu ; calculate square(fpaccu)
                pop   hl               ; restore hl
; calculate polynomial evaluation
; a0 + a1*X + a2*X^2 + a3*X^3 ...
; by Horner's evaluation:
; ((..a3)*X + a2)*X + a1) * X) + a0
fpaccu_polyeval:            
                call  push_fpaccu      ; push accu1 again
                ld    a, (hl)          ; get number of coefficients in table
                inc   hl               ; point to innermost coefficient
                call  mem_to_fpaccu    ; load into fpaccu
                db    0FEh             ; CP xx to skip next instruction
                                       ; uncritical because flags are never checked
                                       ; restore number of factors
loop2AF3:       pop   af               ;<+ ** only popped on second and following calls
                POP_FPREG              ; | pop fpreg
                dec   a                ; | complete factors done?
                ret   z                ; | yes, exit
                PUSH_FPREG             ; | push X again
                push  af               ; | 
                push  hl               ; | save HL
                call  multiply_fpreg_fpaccu ; multiply partial product
                                       ; | ((.(an*X+an-1)*X + an-k) with X
                pop   hl               ; | restore HL
                call  load_fpreg       ; | get next factor an-k-1
                push  hl               ; | save HL
                call  add_fpreg_fpaccu ; | add coefficient
                pop   hl               ; | restore HL
                jr    loop2AF3         ;-+ loop over all coefficients

math_rnd:       call  fpaccu_sgn       ; get sign of argument
                jp    m, loc_2B35      ; negative, dont calc 
                                       ; RND*11879546+0.000392... first
                ld    hl, rnd_mant23   ; get current random number into fpaccu
                call  mem_to_fpaccu
                ret   z                ; if argument is 0, return last random number
                FPREG_CONST 9835h, 447Ah, 0 ; constant 11879546
                call  multiply_fpreg_fpaccu ; multiply with random number
                FPREG_CONST 6828h, 0B146h, 0 ; constant 3.92767774E-4
                call  add_fpreg_fpaccu ; add to number
loc_2B35:       call  fpaccu_to_fpreg  ; copy to fpreg
                ld    a, e             ; rotate digits
                ld    e, c
                ld    c, a
                ld    (hl), 80h        ; HL points to exponent
                                       ; set exponent to range 0...1
                dec   hl
                ld    b, (hl)          ; get highest bit of mantissa
                ld    (hl), 80h        ; ensure high bit
                call  loc_1FF3         ; normalize mantissa
                ld    hl, rnd_mant23   ; load address of last random
                jp    fpaccu_to_mem    ; copy current random number

; process COS()
math_cos:       ld    hl, const_pi_div_2 ; load constant PI/2
                call  load_and_add_fpaccu ; addto argument

; process SIN(X)
math_sin:       call  push_fpaccu      ; push fpaccu (X)
                FPREG_CONST 8349h, 0FDAh, 0A221h ; constant 2*PI
                call  store_fpaccu     ; store in fpaccu
                POP_FPREG              ; restore X
                call  div_fpreg_fpaccu ; divide X / (2*PI)
                call  push_fpaccu      ; push X/2PI
                call  math_int         ; calculate INT part
                POP_FPREG              ; restore X/2PI
                call  subtr_fpreg_fpaccu ; calculate fractional part
                                       ; (X/2PI) - INT(X/2PI) = XREST
                ld    hl, const_0_25
                call  load_fpreg_and_subtr ; calculate 0.25 - XREST
                call  fpaccu_sgn       ; check sign
                scf
                jp    p, loc_2B88      ; is smaller than 0.25
                call  add_0_5          ; no, add 0.5
                call  fpaccu_sgn       ; check sign
                or    a                ; set sign flag
loc_2B88:       push  af               ; save it
                call  p, fpaccu_changesign ; was positive? change sign
                ld    hl, const_0_25   ; add constant 0.25
                call  load_and_add_fpaccu
                pop   af               ; restore flag
                call  nc, fpaccu_changesign ; correct sign again
                ld    hl, SIN_poly_tbl ; load SIN coefficient table
                jp    fpaccu_polyeval_sqr ; do polynomial eval

const_pi_div_2: db    21h, 0A2h, 0DAh, 0Fh, 49h, 81h ; constant PI/2
const_0_25:     db    0, 0, 0, 0, 0, 7Fh    ; constant 0.25
SIN_poly_tbl:   db    7
                db    90h, 0BAh, 34h, 76h, 6Ah, 82h    ; 3.66346472
                db    0E4h, 0E9h, 0E7h, 4Bh, 0F1h, 84h ; -15.08103172
                db    0B1h, 4Fh, 7Fh, 38h, 28h, 86h    ; 42.05517315
                db    31h, 86h, 64h, 69h, 99h, 87h     ; -76.70584506
                db    0E4h, 36h, 0E3h, 35h, 23h, 87h   ; 81.60524913
                db    24h, 31h, 0E7h, 5Dh, 0A5h, 86h   ; -41.34170224
                db    21h, 0A2h, 0DAh, 0Fh, 49h, 83h   ; 2*PI

; process TAN(X)
math_tan:       call  push_fpaccu      ; push fpaccu (X)
                call  math_sin         ; calculate SIN(X)
                POP_FPREG              ; restore argument again
                call  push_fpaccu_ex   ; push SIN(X)
                ex    de, hl           ; undo exchange
                call  store_fpaccu     ; store X
                call  math_cos         ; calculate COS(X)
                jp    pop_fpreg_and_div ; pop SIN(X) and calc SIN(X)/COS(X)

; process ATN()
math_atn:       call  fpaccu_sgn       ; get sign of argument
                call  m, push_changesign ; change sign on return
                call  m, fpaccu_changesign ; make now positive sign
                ld    a, (fpaccu_exp)  ; is value > 1?
                cp    81h
                jr    c, loc_2C0A      ; yes, skip
                ld    bc, 8100h        ; load constant 1.0 in fpreg
                ld    ix, 0
                ld    d, c
                ld    e, c
                call  div_fpreg_fpaccu ; divide by fpaccu (1/X)
                ld    hl, load_fpreg_and_subtr ; push routine to subtract
                                       ; fpaccu from constant at end
                push  hl
loc_2C0A:       ld    hl, ATN_poly_tbl ; load polynomial table for ATN
                call  fpaccu_polyeval_sqr
                ld    hl, const_pi_div_2 ; constant to subtract from
                ret

ATN_poly_tbl:   db    0Dh              ; count of polynomial parameters
                db    14h, 7, 0BAh, 0FEh, 62h, 75h     ; 0.00043296
                db    51h, 16h, 0CEh, 0D8h, 0D6h, 78h  ; -0.00327830
                db    4Ch, 0BDh, 7Dh, 0D1h, 3Eh, 7Ah   ; 0.01164663
                db    1, 0CBh, 23h, 0C4h, 0D7h, 7Bh    ; -0.02633864
                db    0DCh, 3Ah, 0Ah, 17h,    34h, 7Ch ; 0.04396729
                db    36h, 0C1h, 0A3h, 81h, 0F7h, 7Ch  ; -0.06042637
                db    0EBh, 16h, 61h, 0AEh, 19h, 7Dh   ; 0.07503963
                db    5Dh, 78h, 8Fh, 60h, 0B9h, 7Dh    ; -0.09051621
                db    0A2h, 44h, 12h, 72h, 63h, 7Dh    ; 0.11105742
                db    16h, 62h, 0FBh, 47h, 92h, 7Eh    ; -0.14285271
                db    0C0h, 0F0h, 0BFh, 0CCh, 4Ch, 7Eh ; 0.19999981
                db    7Eh, 8Eh, 0AAh, 0AAh, 0AAh, 7Fh  ; -0.33333333
                db    0F6h, 0FFh, 0FFh, 0FFh, 7Fh, 80h ; 1.0
				
				
				
token_tbl:      db    'E', 'N', 'D'+80h                ; token 0x80
                db    'F', 'O', 'R'+80h                ; token 0x81
                db    'N', 'E', 'X', 'T'+80h           ; token 0x82
                db    'D', 'A', 'T', 'A'+80h           ; token 0x83
                db    'I', 'N', 'P', 'U', 'T'+80h      ; token 0x84
                db    'D', 'I', 'M'+80h                ; token 0x85
                db    'R', 'E', 'A', 'D'+80h           ; token 0x86
                db    'L', 'E', 'T'+80h                ; token 0x87
                db    'G', 'O', ' ', 'T', 'O'+80h      ; token 0x88
                db    'F', 'N', 'E', 'N', 'D'+80h      ; token 0x89
                db    'I', 'F'+80h                     ; token 0x8a
                db    'R', 'E', 'S', 'T', 'O', 'R', 'E'+80h ; token 0x8b
                db    'G', 'O', ' ', 'S', 'U', 'B'+80h ; token 0x8c
                db    'R', 'E', 'T', 'U', 'R', 'N'+80h ; token 0x8d
                db    'R', 'E', 'M'+80h                ; token 0x8e
                db    'S', 'T', 'O', 'P'+80h           ; token 0x8f
                db    'O', 'U', 'T'+80h                ; token 0x90
                db    'O', 'N'+80h                     ; token 0x91
                db    'N', 'U', 'L', 'L'+80h           ; token 0x92
                db    'W', 'A', 'I', 'T'+80h           ; token 0x93
                db    'D', 'E', 'F'+80h                ; token 0x94
                db    'P', 'O', 'K', 'E'+80h           ; token 0x95
                db    'P', 'R', 'I', 'N', 'T'+80h      ; token 0x96
                db    '?'+80h                          ; token 0x97
                db    'L', 'I', 'S', 'T', 'E', 'N'+80h ; token 0x98
                db    'C', 'L', 'E', 'A', 'R'+80h      ; token 0x99
                db    'F', 'N', 'R', 'E', 'T', 'U', 'R', 'N'+80h ; token 0x9a
                db    'S', 'A', 'V', 'E'+80h           ; token 0x9b
                db    '!'+80h                          ; token 0x9c
                db    'U', 'S', 'I', 'N', 'G'+80h      ; token 0x9d
                db    'T', 'A', 'B', '('+80h           ; token 0x0e
                db    'T', 'O'+80h                     ; token 0x9f
                db    'F', 'N'+80h                     ; token 0xa0
                db    'S', 'P', 'C', '('+80h           ; token 0xa1
                db    'T', 'H', 'E', 'N'+80h           ; token 0xa2
                db    'N', 'O', 'T'+80h                ; token 0xa3
                db    'S', 'T', 'E', 'P'+80h           ; token 0xa4
                db    '+'+80h                          ; token 0xa5
                db    '-'+80h                          ; token 0xa6
                db    '*'+80h                          ; token 0xa7
                db    '/'+80h                          ; token 0xa8
                db    '^'+80h                          ; token 0xa9
                db    'A', 'N', 'D'+80h                ; token 0xaa
                db    'O', 'R'+80h                     ; token 0xab
                db    '>'+80h                          ; token 0xac
                db    '='+80h                          ; token 0xad
                db    '<'+80h                          ; token 0xae
                db    'S', 'G', 'N'+80h                ; token 0xaf
                db    'I', 'N', 'P'+80h                ; token 0xb0
                db    'A', 'B', 'S'+80h                ; token 0xb1
                db    'U', 'S', 'R'+80h                ; token 0xb2
                db    'F', 'R', 'E'+80h                ; token 0xb3
                db    'I', 'N', 'P'+80h                ; token 0xb4
                db    'P', 'O', 'S'+80h                ; token 0xb5
                db    'S', 'Q', 'R'+80h                ; token 0xb6
                db    'R', 'N', 'D'+80h                ; token 0xb7
                db    'L', 'O', 'G'+80h                ; token 0xb8
                db    'E', 'X', 'P'+80h                ; token 0xb9
                db    'C', 'O', 'S'+80h                ; token 0xba
                db    'S', 'I', 'N'+80h                ; token 0xbb
                db    'T', 'A', 'N'+80h                ; token 0xbc
                db    'A', 'T', 'N'+80h                ; token 0xbd
                db    'P', 'E', 'E', 'K'+80h           ; token 0xbe
                db    'L', 'E', 'N'+80h                ; token 0xbf
                db    'S', 'T', 'R', '$'+80h           ; token 0xc0
                db    'V', 'A', 'L'+80h                ; token 0xc1
                db    'A', 'S', 'C'+80h                ; token 0xc2
                db    'C', 'H', 'R', '$'+80h           ; token 0xc3
                db    'L', 'E', 'F', 'T', '$'+80h      ; token 0xc4
                db    'R', 'I', 'G', 'H', 'T', '$'+80h ; token 0xc5
                db    'M', 'I', 'D', '$'+80h           ; token 0xc6
                db    'L', 'P', 'O', 'S'+80h           ; token 0xc7
                db    'I', 'N', 'S', 'T', 'R'+80h      ; token 0xc8
                db    'E', 'L', 'S', 'E'+80h           ; token 0xc9
                db    'L', 'P', 'R', 'I', 'N', 'T'+80h ; token 0xca
                db    'T', 'R', 'A', 'C', 'E'+80h      ; token 0xcb
                db    'L', 'T', 'R', 'A', 'C', 'E'+80h ; token 0xcc
                db    'R', 'A', 'N', 'D', 'O', 'M', 'I', 'Z', 'E'+80h ; token 0xcd
                db    'S', 'W', 'I', 'T', 'C', 'H'+80h ; token 0xce
                db    'L', 'W', 'I', 'D', 'T', 'H'+80h ; token 0xcf
                db    'L', 'N', 'U', 'L', 'L'+80h      ; token 0xd0
                db    'W', 'I', 'D', 'T', 'H'+80h      ; token 0xd1
                db    'L', 'V', 'A', 'R'+80h           ; token 0xd2
                db    'L', 'L', 'V', 'A', 'R'+80h      ; token 0xd3
                db    'S', 'P', 'E', 'A', 'K'+80h      ; token 0xd4
                db    27h+80h                          ; "tic" token 0xd5
                db    'P', 'R', 'E', 'C', 'I', 'S', 'I', 'O', 'N'+80h ; token 0xd6
                db    'C', 'A', 'L', 'L'+80h           ; token 0xd7
                db    'K', 'I', 'L', 'L'+80h           ; token 0xd8
                db    'E', 'X', 'C', 'H', 'A', 'N', 'G', 'E'+80h ; token 0xd9
                db    'L', 'I', 'N', 'E'+80h           ; token 0xda
                db    'L', 'O', 'A', 'D', 'G', 'O'+80h ; token 0xdb
                db    'R', 'U', 'N'+80h                ; token 0xdc
                db    'L', 'O', 'A', 'D'+80h           ; token 0xdd
                db    'N', 'E', 'W'+80h                ; token 0xde
                db    'A', 'U', 'T', 'O'+80h           ; token 0xdf
                db    'C', 'O', 'P', 'Y'+80h           ; token 0xe0
                db    'A', 'L', 'O', 'A', 'D', 'C'+80h ; token 0xe1
                db    'A', 'M', 'E', 'R', 'G', 'E', 'C'+80h ; token 0xe2
                db    'A', 'L', 'O', 'A', 'D'+80h      ; token 0xe3
                db    'A', 'M', 'E', 'R', 'G', 'E'+80h ; token 0xe4
                db    'A', 'S', 'A', 'V', 'E'+80h      ; token 0xe5
                db    'L', 'I', 'S', 'T'+80h           ; token 0xe6
                db    'L', 'L', 'I', 'S', 'T'+80h      ; token 0xe7
                db    'R', 'E', 'N', 'U', 'M', 'B', 'E', 'R'+80h ; token 0xe8
                db    'D', 'E', 'L', 'E', 'T', 'E'+80h ; token 0xe9
                db    'E', 'D', 'I', 'T'+80h           ; token 0xea
                db    'C', 'O', 'N', 'T'+80h           ; token 0xeb
                db    0
serial:         dw    1234h            ; serial number
e_next_wo_for:  db    'N', 'E', 'X', 'T', ' ', 'W', '/', 'O', ' ', 'F', 'O', 'R'+80h
e_syntax_error: db    'S', 'Y', 'N', 'T', 'A', 'X', ' ', 'E', 'R', 'R', 'O', 'R'+80h
ret_wo_gosub:   db    'R', 'E', 'T', 'U', 'R', 'N', ' ', 'W', '/', 'O', ' '
                db    'G', 'O', 'S', 'U', 'B'+80h
e_out_of_data:  db    'O', 'U', 'T', ' ', 'O', 'F', ' ', 'D', 'A', 'T', 'A'+80h
e_ill_func:     db    'I', 'L', 'L', 'E', 'G', 'A', 'L', ' ', 'F', 'U', 'N'
                db    'C', 'T', 'I', 'O', 'N'+80h
e_arith_ov:     db    'A', 'R', 'I', 'T', 'H', 'M', 'E', 'T', 'I', 'C', ' '
                db    'O', 'V', 'E', 'R', 'F', 'L', 'O', 'W'+80h
e_out_of_mem:   db    'O', 'U', 'T', ' ', 'O', 'F', ' ', 'M', 'E', 'M', 'O', 'R', 'Y'+80h
e_undef_stmt:   db    'U', 'N', 'D', 'E', 'F', 'I', 'N', 'E', 'D', ' ', 'S'
                db    'T', 'A', 'T', 'E', 'M', 'E', 'N', 'T', ' '+80h
e_subscr_range: db    'S', 'U', 'B', 'S', 'C', 'R', 'I', 'P', 'T', ' ', 'O'
                db    'U', 'T', ' ', 'O', 'F', ' ', 'R', 'A', 'N', 'G', 'E'+80h
e_redim_array:  db    'R', 'E', '-', 'D', 'I', 'M', 'E', 'N', 'S', 'I', 'O'
                db    'N', 'E', 'D', ' ', 'A', 'R', 'R', 'A', 'Y'+80h
e_div0:         db    'C', 'A', 'N', 27h, 'T', ' ', '/', '0'+80h
e_ill_direct:   db    'I', 'L', 'L', 'E', 'G', 'A', 'L', ' ', 'D', 'I', 'R'
                db    'E', 'C', 'T'+80h
e_type_mis:     db    'T', 'Y', 'P', 'E', ' ', 'M', 'I', 'S', '-', 'M', 'A'
                db    'T', 'C', 'H'+80h
e_no_string:    db    'N', 'O', ' ', 'S', 'T', 'R', 'I', 'N', 'G', ' ', 'S'
                db    'P', 'A', 'C', 'E'+80h
e_stringlong:   db    'S', 'T', 'R', 'I', 'N', 'G', ' ', 'T', 'O', 'O', ' '
                db    'L', 'O', 'N', 'G'+80h
e_complex:      db    'T', 'O', 'O', ' ', 'C', 'O', 'M', 'P', 'L', 'E', 'X'+80h
e_cant_cont:    db    'C', 'A', 'N', 27h, 'T', ' ', 'C', 'O', 'N', 'T', 'I'
                db    'N', 'U', 'E'+80h
e_usercall:     db    'U', 'N', 'D', 'E', 'F', 'I', 'N', 'E', 'D', ' ', 'U'
                db    'S', 'E', 'R', ' ', 'C', 'A', 'L', 'L'+80h
e_file_n_found: db    'F', 'I', 'L', 'E', ' ', 'N', 'O', 'T', ' ', 'F', 'O'
                db    'U', 'N', 'D'+80h
e_ill_eof:      db    'I', 'L', 'L', 'E', 'G', 'A', 'L', ' ', 'E', 'O', 'F'+80h
e_files_differ: db    'F', 'I', 'L', 'E', 'S', ' ', 'D', 'I', 'F', 'F', 'E'
                db    'R', 'E', 'N', 'T'+80h
e_recover:      db    'R', 'E', 'C', 'O', 'V', 'E', 'R', 'E', 'D'+80h
e_fnreturn:     db    'F', 'N', 'R', 'E', 'T', 'U', 'R', 'N', ' ', 'W', '/'
                db    'O', ' ', 'F', 'U', 'N', 'C', 'T', 'I', 'O', 'N', ' '
                db    'C', 'A', 'L', 'L'+80h
e_miss_stmt:    db    'M', 'I', 'S', 'S', 'I', 'N', 'G', ' ', 'S', 'T', 'A'
                db    'T', 'E', 'M', 'E', 'N', 'T', ' ', 'N', 'U', 'M', 'B', 'E', 'R'+80h
a_invalid_input:db    '*', 'I', 'N', 'V', 'A', 'L', 'I', 'D', ' ', 'I', 'N'
                db    'P', 'U', 'T', '!+80h'
a_at_line:      db    ' ', '@', ' ', 'L', 'I', 'N', 'E', ' '+80h
a_ready:        db    CHAR_LF, 'R', 'E', 'A', 'D', 'Y', ':', '*'+80h
a_extralost:    db    '*', 'E', 'X', 'T', 'R', 'A', ' ', 'L', 'O', 'S', 'T', '*'+80h
a_break:        db    CHAR_LF, '*', 'B', 'R', 'E', 'A', 'K'+80h
                db    0
;
; Start of disposable part of BASIC
;
; undocumented internal diagnostic:
; print a hardcoded serial number

print_serial:   call  print_crlf       ; print a CRLF
                ld    hl, (serial)     ; print serial number?
                call  print_HL
                call  print_crlf       ; print a CRLF
loc_2FC3:       ld    hl, TDL_init_msg ; print out "TDL" init message
                call  print_string
;
; COLD START ENTRY POINT, initialize everything
coldstart:      xor    a               ; clear A, and CY
                ld    hl, iosuppress   ; start of program variables
loc_2FCD:       ccf                    ; set CY
loc_2FCE:       ld    (hl), a          ; clear cell
                inc   l                ; next cell
                jr    nz, loc_2FCE     ; no CY?, loop
                inc   h                ; increment H
                jr    c, loc_2FCD      ; was CY set, yes clear, and loop again
                                       ; effectively: clear memory range from 0100-02ff
                dec   hl               ; HL is 0300, decrement
                ld    sp, hl           ; initialize stack
                ld    (string_base), hl ; save stacktop
                ld    hl, 0FFFFh       ; set lineno to invalid
                ld    (lineno), hl
                ld    a, CHAR_COMMA    ; comma
                ld    (inputbuf-1), a  ; store
                ld    a, 0C3h          ; JP instruction
                ld    (resetvector), a ; store in reset vector
                ld    (outputvector), a ; store in output vector
                ld    (coldvector), a
                ld    hl, coldstart    ; address of coldstart
                ld    (cold_addr), hl  ; store it
                ld    iy, conparam     ; point to console parameter structure
                ld    hl, CONSOLEOUT
                ld    (output_addr), hl ; set output vector to console
                ld    a, 72            ; set line length to 72
                ld    (conparam.linelength), a ; store in console parameter set
                ld    (prtparam.linelength), a ; store in printer parameter set
                ld    a, 56            ; position of last complete print field
                                       ; print length is 14
                                       ; i.e. positions are 0,14,28,42,56
                ld    (conparam.last_field), a ; store in console parameter set
                ld    (prtparam.last_field), a ; store in printer parameter set
                ld    hl, WARMSTART    ; warm start address
                ld    (reset_addr), hl ; store in RESET vector
                ld    hl, stringstk    ; HL is addr of exprstack
                ld    (stringstkptr), hl ; store ptr
                ld    hl, 0            ; clear HL
                ld    (rnd_mant23), hl
                ld    (rnd_mant45), hl
                ld    (rndmant6_exp), hl
                ld    hl, highmem_msg  ; print "highest memory" message
                call  print_string
                call  get_input        ; get an input line
                call  nextchar         ; advance to find a number
                cp    'A'              ; was an A entered?
                jr    z, loc_2FC3      ; goto abort
                cpl                    ; complement input (obfuscate serial check)
                cp    0ACh             ; is it now AC, i.e. was 53h before, i.e. 'S' ?
                jp    z, print_serial  ; go print serial number
                inc   a                ; was FF?
                jr    nz, loc_3048     ; no, continue processing
; use memsize function get get max memory
                call  MEMSIZE          ; get the available memory size in B,A (high,low)
                ld    h, b             ; copy to HL
                ld    l, a
                jr    has_memsize      ; continue initializing
loc_3048:       ld    hl, inputbuf     ; point to inputbuf
                call  skipspace        ; skip space
                call  parse_number_fpaccu ; pack number in fpaccu
                ld    a, (hl)          ; get next char
                or    a                ; not end of buf?
                jp    nz, syntax_error ; oops, don't accept this
                call  fpaccu_to_u16    ; convert to u16 number in DE
                ex    de, hl           ; move to HL
                dec   hl               ; subtract 2 (end of memory)
                dec   hl
has_memsize:    ld    (memory_top), hl ; memory size in HL
                ld    (string_top), hl
                push  hl               ; save size
                ld    de, 300h         ; load base of memory
                or    a                ; clear CY
                sbc   hl, de           ; less than 0x300?
                pop   hl
loc_306A:       jp    c, out_of_memory_error ; too few memory
                ld    de, -100         ; subtract 100
                add   hl, de
                ld    de, 300h         ; subtract 0x300
                CPHL_DE   
                ld    de, print_serial ; start of disposable coldstart area
                jr    nc, loc_3082     ; larger than 0x300?
                ld    de, 300h         ; reserve space for stack
loc_3082:       CPHL_DE                ; at least enough memory for BASIC itself?
                jr    c, loc_306A      ; out of memory
                ld    sp, hl           ; put stack below top of memory
                ld    (string_base), hl
                ex    de, hl           ; top - 0x300
                ld    (start_memory), hl ; lowest memory usable
                call  check_memfree    ; verify still enough stack space
                or    a
                ex    de, hl
                sbc   hl, de           ; calculate difference
                ld    bc, -16          ; reserve 16 more bytes
                add   hl, bc
                call  print_crlf       ; do CRLF
                call  print_HL         ; print number in HL
                ld    hl, bytes_free_msg ; print bytes free message
                call  print_string
                ld    hl, print_string
                ld    (cold_addr), hl  ; put into cold addr (coldstart is now disposed)
                call  new_memory       ; enter interpreter loop
                jp    print_prompt     ; main loop
				
TDL_init_msg:   db    'T', '.', 'D', '.', 'L', '.', ' ', 'Z', '-', '8', '0', ' '
                db    'B', 'A', 'S', 'I', 'C', ' ', 'b', 'y', ' ', 'N', 'e', 'i'
                db    'l', ' ', 'C', 'o', 'l', 'v', 'i', 'n', ' ', '&', ' ', 'R'
                db    'o', 'g', 'e', 'r', ' ', 'A', 'm', 'i', 'd', 'o', 'n', CHAR_LF
                db    'M', 'a', 'y', ' ', ' ', '1', '9', '7', '7', CHAR_LF+80h
highmem_msg:    db    CHAR_LF, 'H', 'i', 'g', 'h', 'e', 's', 't', ' ', 'M', 'e', 'm'
                db    'o', 'r', 'y'+80h
bytes_free_msg: db    ' ', 'B', 'y', 't', 'e', 's', ' ', 'F', 'r', 'e', 'e', CHAR_LF
welcome_msg:    db    CHAR_LF, 'W', 'e', 'l', 'c', 'o', 'm', 'e', ' ', 't', 'o', ' '
                db    'B', 'A', 'S', 'I', 'C', ',', ' ', 'V', 'e', 'r', '.', ' '
                db    '2', '.', '1', CHAR_LF, '<', 'T', 'D', 'L', ' ', 'Z', '-', '8'
                db    '0', ' ', 'H', 'i', 'g', 'h', ' ', 'P', 'r', 'e', 'c', 'i'
                db    's', 'i', 'o', 'n', ' ', 'E', 'x', 't', 'e', 'n', 'd', 'e'
                db    'd', ' ', 'V', 'e', 'r', 's', 'i', 'o', 'n', '>', CHAR_LF+80h
                end
