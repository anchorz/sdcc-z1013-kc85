#include <stdio.h>
#include <stdint.h>
#include <caos.h>
#include <conio.h>

void next() {
    kbd();
    clrscr();
}

const int graphic_widht = 320;
const int graphic_widht2 = 160;
const int graphic_heigth = 256;
const int graphic_heigth2 = 128;

uint16_t index;
uint8_t color = 0;
uint16_t result;
uint16_t x;
uint8_t y;
uint8_t data[] = { 1, 0, 1, 1, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 1, 0, 1, 1,
        0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0,
        1, 0, 1, 1, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 1, 0, 1, 1 };
uint8_t *screen;

void main() {
    clrscr();

    for (index = 0; index < graphic_heigth; index += 5) {
        line(0, index, graphic_widht - 1, graphic_heigth - 1 - index, color);
        color = 0x7f & (color + 0x08);
    }

    for (index = 0; index < graphic_widht; index += 5) {
        line(graphic_widht - 1 - index, 0, index, graphic_heigth - 1, color);
        color = 0x7f & (color + 0x08);
    }
    next();
    // circle demo
    color = 0;

    for (index = 10; index < graphic_widht2; index += 2) {
        circle(graphic_widht2, graphic_heigth2, index, color);
        color = 0x7f & (color + 0x08);
    }
    next();

    // pixel demo
    color = 0;

    home();

    for (index = 0; index < graphic_heigth; index++) {
        // set
        puse(graphic_heigth - 1 - index, index, color);
        puse(graphic_heigth - index, index, color);
        puse(graphic_heigth + 1 - index, index, color);
        color = 0x7f & (color + 0x08);
    }
    next();

    // pixel delete demo
    putchar('\x0c');
    home();
    putchar('f');
    crlf();

    for (y = 255; y > 247; y--) {
        for (x = 0; x < 8; x++) {
            result = pude(x, y);

            if ((result & 0x01) == 0x01) {
                putchar('E');
            } else {
                if ((result & 0x40) == 0x00) {
                    putchar('o');
                } else {
                    putchar('.');
                    puse(x, y, (WHITE << 3));
                }
            }

        }
        crlf();
    }
    next();

    // pixel set demo
    index = 0;

    for (y = 255; y > 247; y--) {
        for (x = 0; x < 8; x++) {
            puse(x, y, ((YELLOW - data[index]) << 3) + (data[index] << 1));
            index++;
        }
    }
    next();

    // direct BWS access
    screen = (uint8_t *) 0x8000;

    for (index = 0; index < 0x2800; index++) {
        //screen[ index] = (uint8_t)( rand() % 256);
        screen[index] = reg_r();
    }
}
