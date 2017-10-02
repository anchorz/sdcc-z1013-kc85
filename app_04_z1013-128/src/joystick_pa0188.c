void joystick_initialize()
{
    __asm__("ld a,#0xcf"); //bitwise io
    __asm__("out (0x1),a"); //PIOA-CONTROL
    __asm__("ld a,#0x1f"); //bit 0..4 input
    __asm__("out (0x1),a"); //PIOA-CONTROL
    __asm__("ld a,#0x00"); //JOYSTICK 1&2 - both active by default
    __asm__("out (0x0),a"); //PIOA-DATA
}

unsigned int joystick_get() __naked
{
    __asm__("ld c,#0x1f"); //bitmask ?-(Auswahl 1)-(Auswahl 2)-Feuer-Oben-Unten-Rechts-Links
    __asm__("ld a,#0x20"); //select JOYSTICK 2
    __asm__("out (0x0),a"); //PIOA-DATA
    __asm__("in a,(0x0)"); //PIOA-DATA
    __asm__("and c"); 
    __asm__("scf");
    __asm__("ld l,a");
    __asm__("ld h,a");
    __asm__("ret z"); 
    __asm__("cpl"); 
    __asm__("and c"); 
    __asm__("ld h,a"); 
    __asm__("ld a,#0x40"); //select JOYSTICK 1
    __asm__("out (0x0),a"); //PIOA-DATA
    __asm__("in a,(0x0)"); //PIOA-DATA
    __asm__("cpl"); 
    __asm__("and c"); 
    __asm__("ld l,a"); 
    __asm__("ret");
}

unsigned int joystick_get_selected() __naked
{
    __asm__("in a,(0x0)"); //PIOA-DATA
    __asm__("and #0x1f");
    __asm__("ld l,a");     
    __asm__("ret");
}
