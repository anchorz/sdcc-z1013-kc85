#include <stdio.h>
#include <stdlib.h>
#include <krt.h>

#include "xonix.h"
#include "xonix_font.h"
#include "computer_font.h"

unsigned char *manPtr;
unsigned char field[SCR_WIDTH * SCR_HEIGHT-1]; //initialized with 0 per specification

void pixel_border() {
    unsigned char x;
    unsigned char* ptr = SCR_PTR + SCR_WIDTH;
    unsigned char *field_ptr = field;
    x = SCR_WIDTH + 2;
    while (--x) {
        *field_ptr++ = FIELD_FULL;
        krt_putchar(ptr, FIELD_FULL, COLOR_FULL);
        ptr++;
    }
    ptr += SCR_WIDTH - 2;
    field_ptr += SCR_WIDTH - 2;
    x = SCR_HEIGHT - 2;

    while (--x) {
        krt_putchar(ptr++, FIELD_FULL, COLOR_FULL);
        krt_putchar(ptr, FIELD_FULL, COLOR_FULL);
        ptr += SCR_WIDTH - 1;

        *field_ptr++ = FIELD_FULL;
        *field_ptr = FIELD_FULL;
        field_ptr += SCR_WIDTH - 1;
    }
    ptr -= SCR_WIDTH - 2;
    field_ptr -= SCR_WIDTH - 2;

    x = SCR_WIDTH;
    while (--x) {
        krt_putchar(ptr++, FIELD_FULL, COLOR_FULL);
        *field_ptr++ = FIELD_FULL;
    }
}

void pixel_man_init() {
    manPtr = SCR_PTR + 0 * SCR_WIDTH + 0 + SCR_WIDTH;
    krt_putchar(manPtr, FIELD_FULL_MAN, COLOR_FULL);
}

int main() {
    krt_init();
    krt_font_install(xonix_font, 0, sizeof(xonix_font) / 8); //zeichen 0x00..0x1F
    krt_font_install(xonix_animations, 0x88, sizeof(xonix_animations) / 8); //Zeichen >0x80
    krt_font_install(computer_font, 0x20, sizeof(computer_font) / 8);
    title_screen();
    krt_clrscr(PIXEL_ERASE, COLOR_EMPTY);
    pixel_border();
    pixel_man_init();
    krt_gotoxy(0, 0);
    krt_cputs("Punkte: 000000 Leben: 05");
    krt_gotoxy(SCR_WIDTH-5,0);
    krt_cputs("0/80%");

    while(1);
    return 0;
}

