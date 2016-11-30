#include <stdio.h>
#include <string.h>

#include "handler.h"
#include "kc85handler.h"

const char * Kc85Handler::get_token_str(int token) {
    switch (token) {
    case TOKEN_ZERO:
        return "ZERO";
    case TOKEN_ONE:
        return "ONE";
    case TOKEN_SYNC:
        return "SYNC";
    default:
        break;
    }
    //exception?q
    return "illegal token";
}

int Kc85Handler::get_token(double ns) {
    if (ns > 1500)
        return TOKEN_ZERO;
    if (ns > 800)
        return TOKEN_ONE;
    return TOKEN_SYNC;
}

int id = 0;

void Kc85Handler::print_header() {
    int aadr, eadr, sadr;

    printf("\"");
    for (int i = 0; i < SIZE_CASS_NAME; i++) {
        char c = read_byte(i);
        if (c < 0x20 || c > 0x7e) {
            c = '.';
        }
        file_name[i] = c;
        printf("%c", c);
    }
    strcpy(file_name + SIZE_CASS_NAME, ".KCC");

    printf("\": ");
    aadr = read_word(OF_CASS_AADR);
    eadr = read_word(OF_CASS_EADR);
    sadr = read_word(OF_CASS_SADR);
    if (system == CASS_SYSTEM_KC85) {
        len = eadr - aadr; //mh that is different on KC85 and KC87, KC87 requires additional +1
    } else {
        len = eadr - aadr + 1; //mh that is different on KC85 and KC87, KC87 requires additional +1
    }
    printf("%04x %04x %04x\n", aadr, eadr, sadr);
}

int Kc85Handler::handle_data_bits(int token) {
    //test assumption
    if (token != TOKEN_ZERO && token != TOKEN_ONE) {
        state = STATE_ABORT;
        return 0;
    }
    if (bit_counter % 2) {
        if (token != last_bit) {
            printf(
                    "warning: unexpected input sequence Bit(%s) does not match the previous one(%s)\n",
                    get_token_str(token), get_token_str(last_bit));
            return 0;
        }
        if (token == TOKEN_ONE) {
            data |= 0x01 << (bit_counter / 2);
        }
        bit_counter++;
        if (bit_counter == 16) {
            if (data_counter > 0 && data_counter < 129) {
                append(data);
                data_crc += data;
                data_crc &= 0xff;
            }
            //printf("data[%3d] %02x %02x %d\n",data_counter,data,data_crc,bit_counter/2);
            if (data_counter < 129) {
                state = STATE_WAIT_FOR_SYNC;
                data_counter++;
            } else {
                if (data_crc != data) {
                    printf("warning: crc-error(%02x) expected was %02x.\n",
                            data_crc, data);
                    state = STATE_ABORT;
                    return 0;
                }
                block_counter++;
                printf("%02x> ", block_counter);
                if (block_counter == 1) {
                    print_header();
                }
                if (!(block_counter % 0x10)) {
                    printf("\n");
                }
                if (block_counter > 1 && block_counter * BLOCKLEN > len) {
                    printf("OK. output is: \"%s\"\n", file_name);
                    write_image(file_name);
                }
                data_counter = 0;
                data_crc = 0;
                state = STATE_UNKNOWN;
            }
            bit_counter = 0;
            data = 0;
        }
        return 1;
    }
    last_bit = token;
    bit_counter++;
    return 1;
}

void Kc85Handler::check(double ns, int pos) {
    int token = get_token(ns);

    switch (state) {
    case STATE_UNKNOWN:
        if (token == TOKEN_ZERO)
            return;
        if (token == TOKEN_ONE) {
            state = STATE_WAIT_FOR_SYNC;
            return;
        }
        if (token == TOKEN_SYNC)
            return;
        break;
    case STATE_WAIT_FOR_SYNC:
        if (token == TOKEN_ZERO) {
            state = STATE_UNKNOWN;
            return;
        }
        if (token == TOKEN_ONE) {
            return;
        }
        if (token == TOKEN_SYNC) {
            state = STATE_WAIT_2ND_SYNC;
            return;
        }
        break;
    case STATE_WAIT_2ND_SYNC:
        if (token == TOKEN_ZERO) {
            state = STATE_UNKNOWN;
            return;
        }
        if (token == TOKEN_ONE) {
            state = STATE_UNKNOWN;
            return;
        }
        if (token == TOKEN_SYNC) {
            state = STATE_SAMPLE_DATA;
            return;
        }
        break;
    case STATE_SAMPLE_DATA:
        if (token == TOKEN_SYNC) {
            //this is a problem
            printf(
                    "warning: unexpected input sequence (diff=%5.2f, pos=%d) %s. We need either '0' or '1'.\n",
                    ns, pos, get_state_str());
            return;
        }
        if (handle_data_bits(token)) {
            return;
        }
        break;
    case STATE_ABORT:
        //skip to the next start of another file or exit
        return;
    }
    printf("check %5.2f @ %d %s\n", ns, pos, get_token_str(token));
    printf("unhandled input(%s) in state %s\n", get_token_str(token),
            get_state_str());
    state = STATE_UNKNOWN;
}

const char *Kc85Handler::get_name() const {
    return "KC85/3 Original";
}

const char *Kc85Handler::get_comments() const {
    return "kann zu Fehlern bei Dateien vom Z9001 führen, da die Blocklänge wird anders berechnet wird";
}

