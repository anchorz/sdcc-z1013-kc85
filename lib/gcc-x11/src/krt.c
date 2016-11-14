#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern unsigned char *colorRam;
extern unsigned int colorRamSize;
extern unsigned char z1013font[];

extern unsigned char *pixelRam;
extern unsigned int pixelRamSize;
extern unsigned int lineWidth;
extern unsigned int lines;

extern volatile int update;

void gfx_init();
void gfx_setKrtEnabled(int);

#define FONT_CHARACTERS 256
#define FONT_EXTRA_CHARACTERS 32
#define FONT_HEIGHT 8
#define FONT_WIDTH 1

#define COLOR_DEFAULT 0x70

static unsigned char _krtgcc_font_buffer[(FONT_CHARACTERS
        + FONT_EXTRA_CHARACTERS) * FONT_HEIGHT * FONT_WIDTH]; //Platz für 256+extra Zeichen
static unsigned char *_krtgcc_cursor_position;
static unsigned int _krtgcc_color;

void krt_init() {
    gfx_init();
    memset(_krtgcc_font_buffer, 0xff,
            (FONT_CHARACTERS + FONT_EXTRA_CHARACTERS) * FONT_HEIGHT * FONT_WIDTH);
    memcpy(_krtgcc_font_buffer, z1013font, 256 * 8);
    _krtgcc_cursor_position = pixelRam;
    _krtgcc_color = COLOR_DEFAULT;
    gfx_setKrtEnabled(1);
    update = 1;
}

void krt_off() {
    gfx_init();
    gfx_setKrtEnabled(0);
    update = 1;
}

unsigned short rol16(unsigned short value) {
    if (value & 0x8000)
        return value * 2 + 1;
    return value * 2;
}

void krt_clrscr(unsigned int pixel, unsigned int color) {
    int y = lines;

    //in der Originalroutine wird von unten gelöscht...
    gfx_init();

    // 16 auf einmal geschrieben...
    pixel = (pixel * 256) | pixel;

    unsigned int segmentSize = (lines / 8) * lineWidth;

    for (y = 0; y < 8; y++) {
        memset(pixelRam + y * segmentSize, pixel, (lines / 8) * lineWidth);
        // und nach jeder Zeile das Pattern rotiert
        pixel = rol16(pixel);
    }

    memset(colorRam, color, colorRamSize);
    update = 1;
}

void krt_gotoxy(unsigned int x, unsigned int y) {
    gfx_init();
    _krtgcc_cursor_position = pixelRam + y * lineWidth + x;
}

void krt_putchar(unsigned char *ptr, unsigned int c, unsigned int color) {
    int i;

    unsigned char *font = _krtgcc_font_buffer + c * (FONT_HEIGHT * FONT_WIDTH);

    unsigned int segmentSize = (lines / 8) * lineWidth;
    for (i = 0; i < 8; i++) {
        ptr[i * segmentSize] = *font++;
    }

    colorRam[(ptr - pixelRam) % segmentSize] = color;
    update = 1;
}

void krt_cputs(char *str) {
    unsigned char c;

    gfx_init();
    while ((c = *str++)) {
        krt_putchar(_krtgcc_cursor_position, c, _krtgcc_color);
        _krtgcc_cursor_position++;
    }
}

void krt_font_install(const unsigned char *source, unsigned int firstCharacter,
        unsigned int length) {
    if (firstCharacter >= FONT_CHARACTERS + FONT_EXTRA_CHARACTERS) {
        printf(
                "error: krt_font_install - firstCharacter(%d>=%d) out of range\n",
                firstCharacter, FONT_CHARACTERS + FONT_EXTRA_CHARACTERS);
        return;
    }
    if (firstCharacter + length > FONT_CHARACTERS + FONT_EXTRA_CHARACTERS) {
        printf("error: krt_font_install - length invalid(%d+%d>%d)\n",
                firstCharacter, length,
                FONT_CHARACTERS + FONT_EXTRA_CHARACTERS);
        return;
    }
    memcpy(_krtgcc_font_buffer + firstCharacter * FONT_HEIGHT, source,
            length * FONT_HEIGHT);
}

void krt_clear_textarea(unsigned int x, unsigned int y, unsigned int width,
        unsigned int height) {

    unsigned int segment, h;
    unsigned int segmentSize = (lines / 8) * lineWidth;

    for (segment = 0; segment < 8; segment++) {
        unsigned char *line = pixelRam + segment * segmentSize;
        line += y * lineWidth + x;
        h = height;
        for (; h;) {
            memset(line, 0x00, width);
            line += lineWidth;
            h--;
        }
    }
    update = 1;
}

void krt_textbackground(unsigned int color) {
    color &= 0x0f;
    _krtgcc_color = (_krtgcc_color & 0xf0) | color;
}

void krt_textcolor(unsigned int color) {
    color &= 0xf0;
    _krtgcc_color = (_krtgcc_color & 0x0f) | color;
}

#define GET_BANKED_ADDRESS(X,BANK) ( X+ (lines / 8) * lineWidth * BANK)

void krt_set_pixel(int x, int y) {
    int bank = (y & 0x7);
    int bit = 0x80 >> (x & 0x7);
    unsigned char *ptr = (unsigned char *) pixelRam + ((y >> 3) * lineWidth)
            + (x >> 3);
    *GET_BANKED_ADDRESS(ptr, bank) |= bit;
}

void krt_line(int x0, int y0, int x1, int y1) {
    int dx = abs(x1 - x0), sx = x0 < x1 ? 1 : -1;
    int dy = -abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
    int err = dx + dy, e2; /* error value e_xy */

    while (1) {
        krt_set_pixel(x0, y0);
        if (x0 == x1 && y0 == y1)
            break;
        e2 = 2 * err;
        if (e2 > dy) {
            err += dy;
            x0 += sx;
        } /* e_xy+e_x > 0 */
        if (e2 < dx) {
            err += dx;
            y0 += sy;
        } /* e_xy+e_y < 0 */
    }
}
