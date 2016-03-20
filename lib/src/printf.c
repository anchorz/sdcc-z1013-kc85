#include <stdarg.h>
#include <stdio.h>

const char hexTable[] = "0123456789abcdef";

void print_hx4(unsigned char u) {
    u &= 0xf;
    putchar(hexTable[u]);
}

void print_hx8(unsigned char u) {
    print_hx4(u >> 4);
    print_hx4(u);
}

void print_hx16(unsigned int u) {
    print_hx8(u >> 8);
    print_hx8(u);
}

void print_str(char *str) {
    char c;
    while ((c = *str)) {
        putchar(c);
        str++;
    }
}

void printf(const char *fmt, ...) {
    char *s;
    char c;
    unsigned int u;

    va_list arg;
    va_start(arg, fmt);

    while ((c = *fmt)) {
        if (c == '%') {
            ++fmt;
            for (;;) {
                c = *fmt;
                if (c < '0' || c > '9')
                    break;
                ++fmt;
            }
            switch (c) {
            case 's':
                s=va_arg(arg,char *);
                print_str(s);
                break;
            case 'c':
                c=va_arg(arg,unsigned int);
                putchar(c);
                break;
            case 'x':
                u=va_arg(arg,unsigned int);
                print_hx16(u);
                break;
            default:
                break;
            }
        } else {
            putchar(c);
        }
        fmt++;
    }
}
