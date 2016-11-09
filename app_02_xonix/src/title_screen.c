#include <stdio.h>
#include <string.h>
#include <conio.h>
#include <krt.h>

#include "xonix.h"

void title_screen() {
    unsigned char localInput;
    char version[6];
    char compiler[6];

    version[0] = '?';
    version[1] = '.';
    version[2] = '?';
    version[3] = '.';
    version[4] = '?';
    version[5] = '\0';

    strcpy(compiler,"C?");

#ifdef __SDCC
    strcpy(compiler,"SDCC");
    version[0]='0'+__SDCC_VERSION_MAJOR;
    version[2]='0'+__SDCC_VERSION_MINOR;
    version[4]='0'+__SDCC_VERSION_PATCH;
#elif defined(__GNUC__)
    strcpy(compiler,"GCC");
    version[0]='0'+__GNUC__;
    version[2]='0'+__GNUC_MINOR__;
    version[4]='0'+__GNUC_PATCHLEVEL__;
#endif

    krt_clrscr(PIXEL_CHECKER, 0x70);
    krt_textcolor(COLOR_FG_GREEN);
    //krt_clear_textarea(1, 1,1,1);
    krt_clear_textarea(1, 1,SCR_WIDTH-2,4);
    krt_gotoxy(2, 2);
    krt_cputs("Xonix - Ultraportable");
    krt_gotoxy(4, 3);
    krt_cputs("(C) 2016 Andreas Ziermann");

    krt_clear_textarea(1, 6,SCR_WIDTH-2,6);
    krt_gotoxy(2, 7);
    krt_cputs("f\x85r Z1013, Z9001 und Linux-");
    krt_gotoxy(2, 8);
    krt_cputs("X11 aus dem selben Quellkode.");

    krt_gotoxy(2, 10);
    krt_cputs(compiler);
    krt_cputs(" Version ");
    krt_cputs(version);

    krt_clear_textarea(1, SCR_HEIGHT-4,SCR_WIDTH-2,3);
    krt_gotoxy((SCR_WIDTH-23)/2, SCR_HEIGHT-3);
    krt_cputs("Dr\x85""cken Sie eine Taste!");

    for (;;) {
        localInput = get_input();
        if (localInput)
           break;
    }
}
