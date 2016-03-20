#include <stdio.h>
#include <stdint.h>
#include <caos.h>
#include <conio.h>

void next() {
    kbd();
}

void main() {
    // clrscr
    uint8_t color;
    uint8_t bg;
    uint8_t x, y;
    uint8_t a;
    uint16_t b;
    char c;
    char *vram;
    unsigned char index;
    char buffer[20];
    unsigned char offs;

    // links, oben, rechts, unten
    window(3, 3, 30, 30);
    clrscr();
    for (color = 0; color < 16; color++) {
        textcolor(color);
        for (bg = 0; bg < 8; bg++) {
            textbackground(bg);
            cstbt(0x1b);
        }
        cputs("  Hello KC85!\r\n");
    }
    x = wherex();
    y = wherey();

    gotoxy(0, 3);
    delline();
    gotoxy(0, 5);
    delline();
    cputs("test");

    gotoxy(x, y);

    c = getche();
    putch(c);
    crlf();

    // kbhit

    textcolor(BROWN);
    clrscr();

    for (index = 0; index < 20; index++) {
        if ((index & 0x01) == 0x01)
            highvideo();
        else
            lowvideo();
        cputs("press key\r\n");
    }
    textcolor(WHITE);

    while (kbhit())
        cputs("you have touched key.\r\n");
    cputs("done\r\n");
    next();

    // delline
    cputs("This line will be deleted. press key.");
    getch();
    delline();
    cputs("Line deleted successfully.");
    getch();
    crlf();

    // inlin

    cputs("Zeug eingeben: ");
    offs = wherex();
    vram = inlin();
    vram += offs;
    crlf();

    index = 0;
    while (*vram != '\0') {
        buffer[index] = *vram;
        index++;
        vram++;
    }
    ahex(index);
    while (index > 0) {
        index--;
        ahex(buffer[index]);
        space();
    }
    next();
    crlf();

    // cgets
    cputs("Zeug eingeben: ");
    buffer[0] = 10;
    vram = cgets(buffer);
    crlf();
    delline();
    index = buffer[1];
    ahex(index);
    space();
    space();

    while (index > 0) {
        index--;
        ahex(*vram);
        space();
        vram++;
    }
    ahex(*vram);
    crlf();

    // add test
    a = sqr(100);
    b = puse(10, 10, 10);
    b = b + a;
    hlhx(b);
    crlf();
}
