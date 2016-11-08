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

    krt_clrscr(PIXEL_CHECKER, COLOR_EMPTY);
    krt_gotoxy(1, 1);
    krt_cputs("Xonix 2016 Ultraportable");
    krt_gotoxy(1, 3);
    krt_cputs("(C) 2016 Andreas Ziermann");
    krt_gotoxy(1, 5);
    krt_cputs(compiler);
    krt_cputs(" Version ");
    krt_cputs(version);
    krt_gotoxy(1, 7);
    krt_cputs("Dr\x85" "cken Sie eine Taste!");

    for (;;) {
        localInput = get_input();
        if (localInput)
           break;
    }
}
