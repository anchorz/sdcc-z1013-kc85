#include <stdio.h>
#include <conio.h>
#include <krt.h>

#include "xonix.h"

#define MODE_GRAFIK 0
#define MODE_INTERN ~0

extern unsigned char *manPtr;

static unsigned char mode;

void display_internal_field() {
    unsigned char x, y;
    unsigned char *ptr = SCR_PTR + SCR_WIDTH;
    unsigned char *field_ptr = field;

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
            krt_putchar(ptr++, c, color);
        }
    }
}

void display_grafik() {
    unsigned char x, y;
    unsigned char *ptr = SCR_PTR + SCR_WIDTH;
    unsigned char *field_ptr = field;

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
            krt_putchar(ptr++, c, color);
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
