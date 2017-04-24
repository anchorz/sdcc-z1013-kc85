#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
#include <delay.h>

extern char screenBackground;

static char transition_right[] = "\xee\x20\xef\xeb\xf0\xec\xf1\xed\x20\xee";
static signed char phase = 8;
static char x = 20;
static char key;

void joystick_demo() {
    clrscr();
    textbackground(screenBackground);
    do {
        for (int i = 0; i < 4; i++) {
            gotoxy(x, 20);
            putch(transition_right[phase]);
            putch(transition_right[phase + 1]);
            mdelay(50);

            key = *(char *)0x25; //getch();
            //*(char *)0x25=0; //getch();
            *(char *)0x23=0x1;
            if (key == 9 && x<BPL) {

                phase += 2;
                if (phase == 10) {
                    phase = 2;
                    x++;
                }
            }
            if (key == 8 && x>0) {
                phase -= 2;
                if (phase < 0) {
                    phase = 8;
                    x--;
                }
            }
        }
    } while (key != 0x1b);
}
