#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <delay.h>

extern char screenBackground;

static float b = 1.44644; //82deg
static float c;
static float v;
static float vc;
static float tx;
static float scale;

static int scale2;
static int dx;
static int t;
static int yf;

void draw_pixel(int x, int y) {
    if (y < 0 || y > 24 * 4)
        return;
    gotoxy(x, (SCR_HEIGHT -1) - y / 4);
    putch('\xdc' - (y & 0x3) * 4);
}

int winkel;
int geschwindigkeit;
char buffer[32];
char key;
unsigned char color[] = { RED, BLUE, GREEN, MAGENTA, CYAN, WHITE };
unsigned char colorIdx;
unsigned int height;

void parabel_demo() {
    winkel = 45;
    geschwindigkeit = 19;
    textbackground(screenBackground);
    clrscr();
    do {
        textcolor(YELLOW);
        gotoxy(0, 0);
        cputs("Winkel         : ");
        _uitoa(winkel, buffer, 10);
        cputs(buffer);
        gotoxy(20, 0);
        cputs("(\x9d/\x9a)");
        //buffer[0]=3;
        //cgets(buffer);
        gotoxy(0, 1);
        cputs("Geschwindigkeit: ");
        _uitoa(geschwindigkeit, buffer, 10);
        cputs(buffer);
        gotoxy(20, 1);
        cputs("(+/-)");
        gotoxy(0, 2);
        cputs("Verlassen=ESC, Neu=C");

        textcolor(color[colorIdx]);
        b = (winkel * 3.1415927) / 180;
        c = cosf(b) * cosf(b);
        v = 2 * geschwindigkeit * geschwindigkeit / 9.81;
        vc = (v * c);
        scale = (4 / vc);
        scale2 = 2 * scale*256;
        t = tanf(b) * vc * scale *256;
        tx = t;
        dx = scale;
        yf = 0;
        for (int i = 0; i < BPL; i++) {
            draw_pixel(i, yf>>8);
            dx += scale2;
            yf += t;
            yf -= dx;
        }

        key = getch();
        if (key == 0x03)
            key=0x1b;
        if (key == 0x0b)
            winkel += 1;
        if (key == 0x0a)
            winkel -= 1;
        if (key == '+')
            geschwindigkeit++;
        if (key == '-')
            geschwindigkeit--;
        if (key == 'C') {
            clrscr();
            colorIdx = 0;
        } else {
            colorIdx++;
            if (colorIdx == sizeof(color) / sizeof(color[0])) {
                colorIdx = 0;
            }
        }
    } while (key != 0x1b);
}

