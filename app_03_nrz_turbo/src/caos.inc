    V_PIOA  .equ 0x1e4  ; Interrupt PIO Kanal A - Kassetteneingabe
    IV_PIOB .equ 0x1e6  ; Interrupt PIO Kanal B - Tastatur
    IV_CTC0 .equ 0x1e8  ; kein Interrupt, Tonhöhe 1
    IV_CTC1 .equ 0x1ea  ; Interrupt CTC Kanal 1 - Kassettenausgabe, Tonhöhe 2
    IV_CTC2 .equ 0x1ec  ; Interrupt CTC Kanal 2 - Tondauer, Blinkfrequenz
    IV_CTC3 .equ 0x1ee  ; Interrupt CTC Kanal 3 - Tastatur

    PORT_CTC	.equ 0x8c
    
    PIO_BASE			 .equ 0x88
	PIO_A_DATA			 .equ (PIO_BASE+0)
	PIO_B_DATA		 	 .equ (PIO_BASE+1)
	PIO_A_CONTROL		 .equ (PIO_BASE+2)
	PIO_B_CONTROL 		 .equ (PIO_BASE+3)
    
	;CLK_KC854 	.equ 1,773 447 6
    ;CLK KC854       1,773 447 5 WIKI
    ;CLK_KC852       1,750 000  
	
		PV1				 .equ 0xf003
    UP_INLIN         .equ 0x17 ; Eingabe Zeile 
	UP_HLHX			 .equ 0x1a ; HL 
	UP_HLDE			 .equ 0x1b ; HLDE 
	UP_AHEX			 .equ 0x1c ; A 
	UP_OSTR			 .equ 0x23 ; print string
	UP_OCHR			 .equ 0x24
	UP_SPACE         .equ 0x2b ; ' '
	UP_CRLF			 .equ 0x2c ; new line 0x0d 0x0a

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

; IX Arbeitszellen

CASS_L = 5
CASS_H = 6
	
