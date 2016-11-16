/*
 * Demo: Linien- und 3D Grafik
 */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <krt.h>
#include <math.h>
#include <conio.h>

//#define USE_DEBUG_PRINTF
#ifdef USE_DEBUG_PRINTF
//quick hack - debug output via printf()
#ifdef __SDCC
extern unsigned int krt_cursor;

void putchar(unsigned char c)
{
    char str[2];

    if (c=='\n')
    {
        unsigned int cr=(unsigned int)(krt_cursor-0xec00);
        cr+=SCR_WIDTH;
        cr-=(cr%SCR_WIDTH);
        krt_cursor=0xec00+cr;
    } else
    {
        str[0]=c;
        str[1]=0;

        krt_cputs(str);
    }
}
#endif
#endif

void circle() {
    float x, y, pi2, pi4;
    int cnt, segments = 47;
    pi2 = 2 * 3.14159268;
    pi4 = 3.14159268 / 2;

    for (cnt = 0; cnt < segments; cnt++) {
        x = cosf((cnt * pi2) / segments - pi4) * 80;
        y = sinf((cnt * pi2) / segments - pi4) * 80;
        krt_line(100, 100, 100 + x, 100 + y);
    }
}

void animation() {
    char c;
    p1: krt_clrscr(PIXEL_ERASE, COLOR_DEFAULT);
    krt_textcolor(COLOR_FG_YELLOW);
    krt_gotoxy(0, 0);
    krt_cputs("Drehen...");
#include "lines.c"
    while (!kbhit()) {
    }
    if (getch() == 0x08)
        goto p7;
    p2: krt_clrscr(PIXEL_ERASE, COLOR_DEFAULT);
#include "lines_a.c"
    while (!kbhit()) {
    }
    if (getch() == 0x08)
        goto p1;
    p3: krt_clrscr(PIXEL_ERASE, COLOR_DEFAULT);
#include "lines_b.c"
    while (!kbhit()) {
    }
    if (getch() == 0x08)
        goto p2;
    p4: krt_clrscr(PIXEL_ERASE, COLOR_DEFAULT);
#include "lines_c.c"
    while (!kbhit()) {
    }
    if (getch() == 0x08)
        goto p3;
    p5: krt_clrscr(PIXEL_ERASE, COLOR_DEFAULT);
#include "lines_d.c"
    while (!kbhit()) {
    }
    if (getch() == 0x08)
        goto p4;
    p6: krt_clrscr(PIXEL_ERASE, COLOR_DEFAULT);
#include "lines_e.c"
    while (!kbhit()) {
    }
    if (getch() == 0x08)
        goto p5;
    p7: krt_clrscr(PIXEL_ERASE, COLOR_DEFAULT);
#include "lines_f.c"
    while (!kbhit()) {
    }
    c = getch();
    if (c == 0x08)
        goto p6;
    if (c == 0x09)
        goto p1;
}

void enter() {
    krt_gotoxy(0, SCR_HEIGHT - 1);
    krt_cputs("<ENTER>");
    while (!kbhit()) {
    }
    getch();
}

int main() {
    int cnt, _x0, _y0;
    int y0, x0, x1, y1;

    krt_init();
    krt_clrscr(PIXEL_ERASE, COLOR_DEFAULT);
    animation();
    enter();

    krt_clrscr(PIXEL_ERASE, COLOR_DEFAULT);
    krt_textcolor(COLOR_FG_YELLOW);
    krt_gotoxy(0, 0);
    krt_cputs("Gleitkommazahlen und Linien");
    circle();
    enter();
    krt_clrscr(PIXEL_ERASE, COLOR_DEFAULT);
    krt_gotoxy(0, 0);
    krt_cputs("besser geht es mit Linen,");

    _y0 = rand() % PIXEL_HEIGHT;
    _x0 = rand() % PIXEL_WIDTH;
    x0 = _x0;
    y0 = _y0;
    for (cnt = 0; cnt < 100; cnt++) {
        y1 = rand() % PIXEL_HEIGHT;
        x1 = rand() % PIXEL_WIDTH;
        krt_line(x0, y0, x1, y1);
        x0 = x1;
        y0 = y1;
    }
    krt_line(x0, y0, _x0, _y0);
    krt_gotoxy(2, 2);
    krt_cputs("ohne teure Gleitkomma-dings..");
    enter();
    krt_gotoxy((SCR_WIDTH - 4) / 2, SCR_HEIGHT / 2);
    krt_clear_textarea(((SCR_WIDTH) - 4) / 2 - 1, SCR_HEIGHT / 2 - 1, 6, 3);
    krt_cputs("Ende");
    enter();
    krt_off();
    return 0;
}
