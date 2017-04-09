#include <stdio.h>
#include <stdint.h>
#include <caos.h>
#include <conio.h>

void next() {
    kbd();
}

unsigned char version;

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
    version=caos_version();

    // links, oben, rechts, unten
    if (version>=0x31)
       window(3, 3, 30, 30);
    clrscr();
    for (color = 0; color < 16; color++) {
        textcolor(color);
        for (bg = 0; bg < 8; bg++) {
            textbackground(bg);
            if (version>=0x31)
                cstbt(0x1b);
        }
        if (version>=0x31)
            cputs("  Hello KC85!\r\n");
        else {
            printf("  Hello KC85!\n");
        }
    }
    x = wherex();
    y = wherey();

    gotoxy(0, 3);
    delline();
    gotoxy(0, 5);
    delline();
    if (version>=0x31)
        cputs("test");
    else {
        printf("test");
    }
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
        if (version>=0x31)
            cputs("press key\r\n");
        else {
            printf("press key\n");
        }
    }
    textcolor(WHITE);

    while (kbhit()) {
        if (version>=0x31)
           cputs("you have touched key.\r\n");
        else {
           printf("you have touched key.\n");
        }
    }
    if (version>=0x31)
           cputs("done\r\n");
    else {
           printf("done\n");
    }
    next();

    // delline
    if (version>=0x31)
        cputs("This line will be deleted.");
    else {
        printf("This line will be deleted.");
    }
    getch();
    delline();
    if (version>=0x31)
        cputs("Line deleted successfully.");
    else {
        printf("Line deleted successfully.");
    }
    getch();
    crlf();

    // inlin

    if (version>=0x31)
        cputs("Zeug eingeben: ");
    else {
        printf("Zeug eingeben: ");
    }
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
    if (version>=0x31)
        cputs("Zeug eingeben: ");
    else {
        printf("Zeug eingeben: ");
    }
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
    if (version>=0x31)
    {
        a = sqr(100);
    } else {
        a = 10;
    }
    b = puse(10, 10, 10);
    b = b + a;
    hlhx(b);
    crlf();
}
