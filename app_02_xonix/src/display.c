#include <stdio.h>
#include <conio.h>
#include <krt.h>

#include "xonix.h"

#ifdef __KC85__
#define SCR_ADD_LINE(SCR_PTR , N) ((SCR_PTR)+(N)*0x800)
#define SCR_INC(SCR_PTR) (SCR_PTR=normalized_inc(SCR_PTR))
#define SCR_ADD(SCR_PTR,N) (SCR_PTR=normalized_add(SCR_PTR,N))

unsigned char *normalized_inc(unsigned int *ptr) __z88dk_fastcall;
unsigned char *normalized_add(unsigned int *ptr,unsigned int add) __z88dk_callee;


#else
#define SCR_ADD_LINE(SCR_PTR , N) ((SCR_PTR)+SCR_WIDTH)
#define SCR_INC(SCR_PTR) ((SCR_PTR)++)
#define SCR_ADD(SCR_PTR,N) ((SCR_PTR)+=(N))
#endif

#define MODE_GRAFIK 0
#define MODE_INTERN ~0

extern unsigned char *manPtr;

static unsigned char mode;

void display_internal_field() {
    unsigned char x, y;
    unsigned char *ptr=SCR_PTR;
    unsigned char *field_ptr = field;

    SCR_ADD(ptr,SCR_WIDTH );
    for (y = 0; y < SCR_HEIGHT - 1; y++) {
        for (x = 0; x < SCR_WIDTH; x++) {
            unsigned char c = *field_ptr;
            unsigned char color = (COLOR_FG_RED | COLOR_BG_YELLOW);
            field_ptr++;
            switch (c) {
            case FIELD_FULL:
                c = 'F';
                color = COLOR_FULL;
                break;
            case FIELD_CLAIMING:
                c = 'C';
                color = COLOR_CLAIMING;
                break;
            case FIELD_EMPTY:
                c = '.';
                color = COLOR_EMPTY;
                break;
            default:
                c = '?';
            }
            krt_putchar(ptr, c, color);
            SCR_INC(ptr);
        }
    }
}

void display_grafik() {
    unsigned char x, y;
    unsigned char *ptr = SCR_PTR;
    unsigned char *field_ptr = field;

    SCR_ADD(ptr,SCR_WIDTH );

    for (y = 0; y < SCR_HEIGHT - 1; y++) {
        for (x = 0; x < SCR_WIDTH; x++) {
            unsigned char c = *field_ptr;
            unsigned char color = (COLOR_FG_RED | COLOR_BG_YELLOW);
            field_ptr++;
            switch (c) {
            case FIELD_FULL:
                color = COLOR_FULL;
                break;
            case FIELD_CLAIMING:
                color = COLOR_CLAIMING;
                break;
            case FIELD_EMPTY:
                color = COLOR_EMPTY;
                break;
            default:
                c = '?';
            }
            krt_putchar(ptr, c, color);
            SCR_INC(ptr);
        }
    }
    krt_putchar(manPtr, FIELD_FULL_MAN, COLOR_FULL);
}

void toggle() {
    mode = ~mode;

    if (mode) {
        display_internal_field();
    } else {
        display_grafik();
    }
}
