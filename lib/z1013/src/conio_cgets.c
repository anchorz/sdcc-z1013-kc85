#include <z1013.h>

char * cgets(char *buffer) {
    char *input = buffer + 2;
    char c;
    unsigned char max = buffer[0];
    unsigned char len = 0;
    unsigned char cur = 0;
    char *ptr = Z1013_CURSR;

    for (int i = 0; i < max; i++) {
        *ptr++ = '_';
    }

    ptr = buffer + 2;
    for (int i = 0; i < max; i++) {
        *ptr++ = 0;
    }

    Z1013_CODE = *Z1013_CURSR;
    *Z1013_CURSR = 0xff;
    do {
        c = INCH();
        if (c < 0x20) {
            //1f DEL 7f BACKSP
            if (c == 8 && len) {
                *Z1013_CURSR-- = Z1013_CODE;
                *Z1013_CURSR = '_'; //blank
                Z1013_CODE = '_';
                *Z1013_CURSR = 0xff;
                *input-- = 0;
                len--;
            }
            //special handling for kc85/4
            if (c == 0x03) {
                buffer[1] = 0;
                buffer[2] = 0;
                c = 0x0d;
            }
        } else {
            if (len < max) {
                *Z1013_CURSR++ = c;
                Z1013_CODE = *Z1013_CURSR;
                *Z1013_CURSR = 0xff;
                *input++ = c;
                len++;
            }
        }

    } while (c != 0x0d);

    buffer[1] = len;
    *input = 0;
    *Z1013_CURSR = Z1013_CODE; //cursor off

    return buffer + 2;
}
