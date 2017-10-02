#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <keys.h>
#include <delay.h>
#include <z1013.h>

#ifndef __SDCC
#define __z88dk_fastcall
#define __z88dk_callee
#define __naked
#define __sfr char
#define __banked
#define __at(X)
#define inline
#endif

char getchEx();
void paint_frame();

void putchRepeat(unsigned int code) __z88dk_fastcall {
#ifdef __SDCC
    code = code;
#endif
    __asm__("ld b,h");
    __asm__("ld c,l");
    __asm__("_putchRepeat$1:");
    __asm__("ld l,c");
    __asm__("call _putch");
    __asm__("djnz _putchRepeat$1");
}

#define PUTCH_REPEAT(R,C) putchRepeat((R)*256+(C))

void cputs_ctrl_space(unsigned int code) __z88dk_fastcall {
#ifdef __SDCC
    code = code;
#endif
    __asm__("ex de,hl");
    __asm__("ld l,#'^'");
    __asm__("call _putch");
    __asm__("ld  l,e");
    __asm__("call _putch");
    __asm__("ld  h,d");
    __asm__("ld  l,#' '");
    __asm__("call _putchRepeat");
}

#define CPUTS_CTRL(R,C) cputs_ctrl_space((R)*256+(C))

void help() {
    char c;
    clrscr();
    GOTOXY(0, 0);
    cputs("Steuertasten oder Joystick");
    GOTOXY(0, 1);
    PUTCH_REPEAT(26, '=');
    GOTOXY(0, 3);
    cputs("<Hoch>   U      Hoch");
    GOTOXY(0, 4);
    cputs("<Runter> <Leer> Runter");
    GOTOXY(0, 5);
    CPUTS_CTRL(7,'A');
    cputs("S4-I   Seite vor");
    GOTOXY(0, 6);
    CPUTS_CTRL(7,'E');
    cputs("S4-M   Seite zurueck");
    GOTOXY(0, 7);
    CPUTS_CTRL(14,'X');
    cputs("Ende");
    GOTOXY(0, 8);
    CPUTS_CTRL(14,'Y');
    cputs("Anfang");
    GOTOXY(0, 9);
    cputs("?        H      Hilfe");
    GOTOXY(0, 11);
    cputs("<Enter> Programm starten");
#ifdef __SDCC
    GOTOXY(0, 31);
    cputs ("SDCC ");
    putch('0'+__SDCC_VERSION_MAJOR);
    putch('.');
    putch('0'+__SDCC_VERSION_MINOR);
    putch('.');
    putch('0'+__SDCC_VERSION_PATCH);
    putch(',');
    cputs (" "__DATE__" "__TIME__);
#endif

    while (1) {
        c = getchEx();
        if (c == '?')
            break;
        if (c == 'H')
            break;
        if (c == VK_ENTER)
            break;
    }
    paint_frame();
}
