#include <stdio.h>
#include "handler.h"

unsigned char Handler::read_byte(int pos) {
    return buffer[pos];
}

unsigned short Handler::read_word(int pos) {
    return buffer[pos + 1] * 256 + buffer[pos];
}

void Handler::write_word(int offset, unsigned short data) {
    buffer[offset] = data & 0xff;
    buffer[offset + 1] = (data / 256) & 0xff;
}

void Handler::write_image(const char *name) {
    int bw;

    FILE *f = fopen(name, "wb+");
    if (!f) {
        printf("error: can't open file \"%s\"\n", name);
        return;
    }
    bw = fwrite(buffer, 1, size, f);
    if (bw != size) {
        printf("error: there was a problem writing to file \"%s\"\n", name);
    }

    fclose(f);
}

void Handler::append(unsigned char c) {
    if (size > 65535) {
        //exception?
        return;
    }
    buffer[size++] = c;
}

const char *Handler::get_state_str() {
    switch (state) {
    case STATE_UNKNOWN:
        return "STATE_UNKNOWN";
    case STATE_WAIT_FOR_SYNC:
        return "STATE_WAIT_FOR_SYNC";
    case STATE_WAIT_2ND_SYNC:
        return "STATE_WAIT_2ND_SYNC";
    case STATE_SAMPLE_DATA:
        return "STATE_SAMPLE_DATA";
    case STATE_ABORT:
        return "STATE_ABORT";
    default:
        break;
    }
    //exception
    return "illegal state";
}

