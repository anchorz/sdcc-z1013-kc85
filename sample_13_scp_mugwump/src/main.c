#include <scpx.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#define REFERENCE(X) ((X)=(X))

#define DISTANCE_FLOAT 1

#ifndef __SDCC
#define __z88dk_fastcall
#endif

#ifdef DISTANCE_FLOAT
unsigned int sqrti(unsigned int num) {
    short res = 0;
    short bit = 1 << 14; // The second-to-top bit is set: 1 << 30 for 32 bits

    // "bit" starts at the highest power of four <= the argument.
    while (bit > num)
        bit >>= 2;

    while (bit != 0) {
        if (num >= res + bit) {
            num -= res + bit;
            res = (res >> 1) + bit;
        } else
            res >>= 1;
        bit >>= 2;
    }
    return res;
}
#endif

void print(const char *text) __z88dk_fastcall
{
    REFERENCE(text);
    __asm__("ld c,#9 ;CPM_PRNT");
    __asm__("ex de,hl");
    __asm__("call 5");
}

void putchar(char c) {
    bdos(CPM_WCON, c);
}

char ibuf[8];
void print_int(int i) {
    char c = i, len;
    _itoa(i, ibuf, 10);
    len = strlen(ibuf);
    for (c = 0; c < len; c++)
        putchar(ibuf[c]);
}

char buffer[10];

int input_int() {
    buffer[0] = 10 - 2 - 1; //plus 1 abschliessendes NULL-Byte
    bdos(CPM_RCOB, (int) buffer);
    buffer[buffer[1] + 2] = 0; //abschliessendes NULL-Byte
    print("\n\r$");
    return atoi(buffer + 2);
}

typedef struct {
    int x;
    int y;
} Position;

Position p[4];
signed char m, n;

unsigned char t, found;

//mod operator entfernen
unsigned char rand10() {
    unsigned char c;
    do {
        c = rand();
        c &= 0x0f;
    } while (c >= 10);
    return c;
}

int occupied(int x, int y) {
    for (int i = 0; i < 4; i++) {
        if (p[i].x == x && p[i].y == y)
            return 1;
    }
    return 0;
}

void init() {
    for (int i = 0; i < 4;) {
        int x = rand10();
        int y = rand10();
        if (!occupied(x, y)) {
            p[i].x = x;
            p[i].y = y;
            i++;
        }
    }
}

#define RUNDEN 10

int main() {
    print("\014                 MUGWUMP\n\r$");
    print("CREATIVE COMPUTING MORRISTOWN,NEW JERSEY\n\r\n\r$");
    /* COURTESY PEOPLE'S COMPUTER COMPANY */
    print("Das Ziel ist es 4 MUGWUMPs zu finden,\n\r$");
    print("die sich auf einem 10x10 Feld versteckt\n\r$");
    print("haben. Die Basis ist auf Position 0,0.\n\r\n\r$");
    print("Ein Versuch besteht aus zwei Zahlen von\n\r$");
    print("0-9. Die erste Zahl ist die Entfernung\n\r$");
    print("nach Rechts von der Basis. Die zweite\n\r$");
    print("Nummer ist die Entfernung nach Oben.\n\r\n\r$");
    print("Du hast $");
    print_int(RUNDEN);
    print(" Versuche. Nach jedem Versuch\n\r$");
    print("zeige ich dir die Entfernung zu jedem\n\r$");
    print("MUGWUMP. OK? (J/N)$");
    do {
        char c;
        c = bdos(CPM_ICON, 0);
        if (c != 0) {
            c = bdos(CPM_RCON, 0);
            if (c == 'J') {
                break;
            }
        }
        rand();
    } while (1);

    while (1) {
        init();
        t = 0;
        while (t < RUNDEN) {
            t++;
            print("\n\rRunde #$");
            print_int(t);
            print(" -- Wo koennte einer sein?\n\r$");
            //alternativ geht auch printf(), kostet aber etwa 3 KByte mehr Speicher
            //   printf("\n\r\n\rTURN NO. %d -- WHAT IS YOUR GUESS\n\r",t);
            print("nach Rechts: ?$");
            m = input_int();
            print("nach Oben  : ?$");
            n = input_int();
            for (int i = 0; i < 4; i++) {
                int posx, posy;
                Position *pos;
                pos = p + i;
                posx = pos->x;
                posy = pos->y;
                if (posx == -1)
                    continue;
                if (posx != m || posy != n) {
                    int d1, d2, distance;
                    //printf("(%d) %d,%d\n\r", i, posx, posy);
#ifdef DISTANCE_FLOAT
                    d1 = (posx - m) * 10;
                    d2 = (posy - n) * 10;
                    distance = d1 * d1 + d2 * d2;
                    distance = sqrti(4*distance);
                    distance++;
                    distance/=2;
                    print_int(distance / 10); //+98 Bytes
                    putchar(',');
                    print_int(distance % 10); //+36 Bytes
#else
                            d1 = p[i][0] - m;
                            d2 = p[i][1] - n;
                            distance = abs(d1) + abs(d2);
                            print_int(d);
#endif
                    print(" Schritte zum MUGWUMP\n\r$");
                    //printf("%d Schritte zum MUGWUMP %d %d\n\r", d, d1, d2);
                } else {
                    pos->x = -1;
                    print("Sie sind haben einen MUGWUMP gefunden.\n\r$");
                }
            }
            found = 0;
            for (int i = 0; i < 4; i++) {
                Position *pos = p + i;
                if (pos->x == -1)
                    found++;
            }
            if (found == 4) {
                print("\n\rSie haben alle in $");
                print_int(t);
                print(" Runden gefunden.\n\r$");
                break;
            }
        }
        if (t > RUNDEN) {
            print("\n\rDas waren $");
            print_int(t);
            print(" Versuche. Hier haben\n\r$");
            print("sie sich versteckt:\n\r$");
            for (int i = 0; i < 4; i++) {
                Position *pos = p + i;
                if (pos->x != -1) {
                    signed char x, y;
                    x = pos->x;
                    y = pos->y;
                    print("MUGWUMP $");
                    print_int(i + 1);
                    print(" ist auf Position ($");
                    print_int(x);
                    print(",$");
                    print_int(y);
                    print(")\n\r$");
                }
            }
        }
        print(
                "\n\rDas hat Spass gemacht!!! Lass uns\n\rnochmal spielen (J/N) $");
        do {
            char c;
            c = bdos(CPM_RCON, 0);
            if (c == 'J') {
                print(
                        "\n\rVier weitere MUGWUMPS haben sich\n\rwieder versteckt.\n\r$");
                break;
            }
            if (c == 'N') {
                return 0;
            }
        } while (1);

    }
}
