#include <stdio.h>
#include <z1013.h>

void main() {
    unsigned char c;

    PRST7("\rHello World!\rnow press any key:");
    c = INCH();
    OUTCH(c);
}
