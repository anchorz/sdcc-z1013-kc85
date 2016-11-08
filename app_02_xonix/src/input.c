#include <conio.h>
#include "xonix.h"

#ifdef __Z1013__
#include <z1013.h>
#else
unsigned char z1013_spvt_getst() {
    return 0;
}
unsigned char z1013_spvt_poll() {
    return 0;
}
#endif

unsigned char get_input() {
#ifdef __Z9001__
    __asm__("ld hl,#0x25");
    __asm
    ld a,(hl)
    ld c,a
    xor a,a
    ld (hl),a
    ld l,c
    __endasm;
#elif defined(__Z1013__)
    unsigned char c;
    c=z1013_spvt_poll();
#define IOSEL_3 0x0c
    __asm
    out (IOSEL_3),a; workaround umschalten in den Grafik mode nach Tastatureingabe
    __endasm;
    return c;
#else
    //conio
    if(kbhit())
    {
        return getch();
    }
    return 0;
#endif
}
