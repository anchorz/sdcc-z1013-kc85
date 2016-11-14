/* Beispiel für die schnelle Berechnung der Adressen im Bildschirmspeicher, welche
 * auf dem KC85/3 und KC85/4 funktioniert.
 */
 

#include <stdio.h>
#include <stdint.h>

/* berechnung der Adressen im VideoRAM unter der Vorbedingung, dass 
 * die vertikale Adresse durch 8 teilbar ist (eigentlich hier sogar /4)
 *
 */
unsigned int lookup(unsigned int hl) __z88dk_fastcall
{   
        hl;
__asm
patch_addresse:
        ; assume V0..2 = 0 
        bit     5,l     ; l  0  0 H5 H4 | H3 H2 H1 H0 (H5=1)?
        jr      nz,right$

        ld      a,h     ; h V7 V6 V5 V4 | V3 V2 V1 V0
        rlca            ; a V6 V5 V4 V3 | V2 V1 V0 V7 
        rlca            ; a V5 V4 V3 V2 | V1 V0 V7 V6 
        rlca            ; a V4 V3 V2 V1 | V0 V7 V6 V5
        and     #0x60   ; a  0 V3 V2  0 |  0  0  0  0
        or      l       ; a  0 V3 V2 H4 | H3 H2 H1 H0 (H5=0!)
        ld      l,a     ; l  0 V3 V2 H4 | H3 H2 H1 H0 (V0=0!)  
        ld      a,h     ; a V7 V6 V5 V4 | V3 V2 V1 V0
        rra             ; a CF V7 V6 V5 | V4 V3 V2 V1 
        rra             ; a V0 CF V7 V6 | V5 V4 V3 V2
        rra             ; a V1 V0 CF V7 | V6 V5 V4 V3
        and     #0x1e   ; a  0  0  0 V7 | V6 V5 V4  0 (V0..2=0!)
        or      #0x80   ; a  1  0  0 V7 | V6 V5 V4  0
        ld      h,a     ; h  1  0  0 V7 | V6 V5 V4  0
        ret
right$:
        ld      a,l
        and     #0x7    ; a  0  0  0  0 |  0 H2 H1 H0
        ld      l,a     ; l  0  0  0  0 |  0 H2 H1 H0
        ld      a,h     ; a V7 V6 V5 V4 | V3 V2 V1 V0
        rlca            ; a V6 V5 V4 V3 | V2 V1 V0 V7 
        rlca            ; a V5 V4 V3 V2 | V1 V0 V7 V6 
        rlca            ; a V4 V3 V2 V1 | V0 V7 V6 V5
        ld      b,a     ; b V4 V3 V2 V1 | V0 V7 V6 V5
        and     a,#0x60 ; a  0 V3 V2  0 |  0  0  0  0
        or      l       ; a  0 V3 V2  0 |  0 H2 H1 H0
        ld      l,a     ; l  0 V3 V2  0 |  0 H2 H1 H0
        ld      a,h     ; a V7 V6 V5 V4 | V3 V2 V1 V0
        rra             ; a V0 V7 V6 V5 | V4 V3 V2 V1
        and     a,#0x18 ; a  0  0  0 V5 | V4  0  0  0
        or      l       ; a  (V0=0) V3 V2 V5 | V4 H2 H1 H0
        ld      l,a     ; OK now

        ld      a,b     ; a V4 V3 V2 V1 | V0 V7 V6 V5
        and     a,#0x06 ; a  0  0  0  0 |  0 V7 V6  0
        or      a,#0xa0 ; a  1  0  1  0 |  0 V7 V6  0(V1=0)
        ld      h,a     ; h  1  0  1  0 |  0 V7 V6  0(V1=0)
        ret
_hack_und_patch:
       ld      de,#patch_addresse 
       ld      hl,#kc854_routine$
       ld      bc,#(kc854_routine_ende$-kc854_routine$)
       ;ldir
       ret

kc854_routine$:
       ld      a,l
       ld      h,l
       or      #0x80
       ld      h,a
       ret
kc854_routine_ende$:

__endasm;
}

#define HW_KC85_4 1
#define HW_KC85_3 0
unsigned char get_machine_type()
{
__asm
        ld      hl,#0x0100 ; Adresse von Zeile 1
        call    #0xf003
        .db     0x34     ; PADR
        ; HW_KC85_4 return 0x8001
        ; KC_KC85_3 return 0x8080
        xor a,a ; #HW_KC85_3 
        bit     7,l
        ld      l,a
        ret     nz
        inc     l
__endasm;
}


/* modifiziert die Berechnung der Bildschirmadressen für den KC85/4
 */
void hack_und_patch();

void main() {
    unsigned int x,y,pair=0;

    if (get_machine_type()==HW_KC85_4)
    {
        printf("Ich bin ein KC85/4\n");
        hack_und_patch();
    } else
    {
        printf("Ich bin ein KC85/2 oder KC85/3\n");
    }
    
    printf("Bildschirmadressen\n (neu berechnet):\n");
    for (y=0; y<256; y+=8)
    {
        pair=256*y;
        printf ("%04x: ",pair);
        printf ("%04x ",lookup(pair |0));
        printf ("%04x ",lookup(pair |0x1f));
        printf ("%04x ",lookup(pair |0x20));
        printf ("%04x ",lookup(pair |0x28));
        printf("\n");
    }

}
