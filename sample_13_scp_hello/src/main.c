#include <scpx.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#define REFERENCE(X) ((X)=(X))
#ifndef __SDCC
#define __z88dk_fastcall
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
    char c, len;
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

signed char p[4][2];
signed char m, n, d;
unsigned char t, found;

void init() {
    for (signed char j = 0; j < 2; j++) {
        for (signed char i = 0; i < 4; i++) {
            unsigned char c = rand() % 10;
            p[i][j] = c;
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
        if (c == 'J') {
            bdos(CPM_RCON, 0);
            break;
        }
        rand();
    } while (1);

    while (1) {
        init();
        t = 0;
        while (t < RUNDEN) {
            t++;
            print("\n\r\n\rRunde #$");
            print_int(t);
            print(" -- Wo koennte einer sein?\n\r$");
            //alternativ geht auch printf(), kostet aber etwa 3 KByte mehr Speicher
            //   printf("\n\r\n\rTURN NO. %d -- WHAT IS YOUR GUESS\n\r",t);
            print("nach Rechts: ?$");
            m = input_int();
            print("nach Oben  : ?$");
            n = input_int();
            for (char i = 0; i < 4; i++) {
                if (p[i][0] == -1)
                    continue;
                if (p[i][0] != m || p[i][1] != n) {
                    signed char d1, d2;
                    //printf("(%d) %d,%d\n\r",i,p[i][0],p[i][1]);
                    d1 = p[i][0] - m;
                    d2 = p[i][1] - n;
                    d = abs(d1) + abs(d2);
                    //print_int(d);printf("%d Schritte zum MUGWUMP\n\r$");
                    printf("%d Schritte zum MUGWUMP %d %d\n\r", d, d1, d2);
                } else {
                    p[i][0] = -1;
                    print("Sie sind haben einen MUGWUMP gefunden.\n\r$");
                }
            }
            found = 0;
            for (char i = 0; i < 4; i++) {
                if (p[i][0] == -1)
                    found++;
            }
            if (found == 4) {
                print("\n\rSie haben alle in $");
                print_int(t);
                print(" Runden gefunden.\n\r$");
                break;
            }
        }
        if (t >= RUNDEN) {
            print("\n\rDas waren $");
            print_int(t);
            print(" Versuche. Hier haben\n\r$");
            print("sie sich versteckt:\n\r$");
            for (signed char i = 0; i < 4; i++) {
                if (p[i][0] != -1) {
                    signed char x, y;
                    x = p[i][0];
                    y = p[i][1];
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
