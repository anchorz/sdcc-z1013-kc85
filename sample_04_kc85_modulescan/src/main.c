#include <stdio.h>
#include <caos.h>

#define CLS putchar( '\x0C');

void putstr(char *c) {
    while (*c != '\0') {
        putchar(*c);
        c++;
    }
}

void main() {

    // do a module scan on KC85
#if 1
    unsigned int port;

    unsigned char index;
    unsigned int value;

    //home();
    putchar('\x0C');

    // printf aus z80.lib verwendet IX :-(
    putstr("module scan:\r\n");
    index = 5;
    for (port = 0x00; port < 0xfc; port += 0x01) {
        value = modu(0, port, 0);
        value >>= 8;

        if (value < 0xff) {
            //printf( "%04X %02X  ", port, value);
            ahex(port);
            space();
            ahex(value);
            if (index == 0) {
                crlf();
                index = 6;
            } else {
                space();
            }
            index--;
        }
    }
    crlf();
#endif

    // window, wait, errm test
#if 0
    unsigned char res;

    res = winin( 1, 1, 7, 3, 1);
    colorup( 2, WHITE, YELLOW);
    CLS;
    wait( 500 / 6);
    errm();
    ahex( res & 0x01);

    res = winin( 10, 2, 7, 2, 2);
    colorup( 2, WHITE, RED);
    CLS;
    ahex( res & 0x01);

    res = winin( 20, 3, 7, 1, 3);
    colorup( 2, WHITE, GREEN);
    CLS;
    ahex( res & 0x01);

    winak( 0);

#endif

    // clear screen
#if 0
    putchar( '\x0C');
#endif

#if 0
    // geht, aber IRM flackert
    int a = -4;
    printf( "Zahl: %d\r\n", a);
#endif

#if 0
    // print hex (ahex), works
    unsigned char a = 0x12;
    ahex( a);
    crlf();
#endif

#if 0
    // print hex (hlhx), works
    unsigned int a = 0x1234;
    hlhx( a);
    crlf();
#endif

    // putstr, works
#if 0
    char tmp[6] = "abb";

    putstr( tmp);
    crlf();
#endif

    // putchar, works
#if 0
    putchar( 'a');
    putchar( 'b');
    putchar( 'c');
    crlf();
#endif
}
