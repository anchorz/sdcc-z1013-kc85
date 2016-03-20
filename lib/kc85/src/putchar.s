; see:
; http://www.cpcmania.com/Docs/Programming/Introduction_to_programming_in_SDCC_Compiling_and_testing_a_Hello_World.htm

        .module putchar
        .include 'caos.inc'  
        .include 'codes.inc'  
        .area   _CODE

_putchar::
        ld      hl, #2
        add     hl, sp

        ld      a,( hl)

    	cp	a, #UNIX_STYLE_NEW_LINE
    	jr	NZ, print_character
    	ld	a, #VK_ENTER
        call    PV1
        .db     FNCRT
    	ld	a, #UNIX_STYLE_NEW_LINE

print_character:
        call    PV1
        .db     FNCRT

        ret


