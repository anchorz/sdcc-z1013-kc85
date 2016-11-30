#include <stdio.h>
#include <string.h>

#include "handler.h"
#include "turbo4handler.h"

const char * Turbo4Handler::get_token_str(int token) {
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
    //exception?
    return "illegal token";
}

int Turbo4Handler::get_token(double ns) {
    if (ns > 5050)
        return TOKEN_ZERO;
    if (ns > 3400)
        return TOKEN_ONE;
    return TOKEN_SYNC;
}

void Turbo4Handler::print_header() {
    int aadr, eadr, sadr, type;

    const char *type_str;
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
    type = read_byte(OF_CASS_SYSTEM);
    switch (type) {
    case CASS_SYSTEM_Z9001:
        type_str = "Z9001..KC85/1..KC87";
        break;
    case CASS_SYSTEM_KC85:
        type_str = "KC85/2..3..4..5";
        break;
    default:
        type_str = "unknown";
    }
    len = eadr - aadr + 1;
    system = type;
    if (system == CASS_SYSTEM_KC85) {
        write_word(OF_CASS_EADR, eadr + 1);
    }
    printf("%04x %04x %04x (%s)\n", aadr, eadr, sadr, type_str);
}

int Turbo4Handler::handle_data_bits(int token) {
    //printf("%s\n",get_token_str(token));
    //test assumption
    if (token != TOKEN_ZERO && token != TOKEN_ONE) {
        state = STATE_ABORT;
        return 1;
    }
    if (token == TOKEN_ONE) {
        data |= 0x01 << (7 - bit_counter);
    }
    bit_counter++;
    if (bit_counter == 8) {
        if (data_counter == 0) {
            if (block_counter == 1) {
                print_header();
            }
            data_crc = data;
            current_crc = 0;
        } else {
            current_crc += data;
            current_crc &= 0xff;
            //printf("%02x (%02x)\n",data,current_crc);
            append(data);
        }
        bit_counter = 0;
        data = 0;
        data_counter++;
        if (data_counter == BLOCKLEN + 1) {
            if (data_crc != current_crc) {
                printf(
                        "warning: crc-error(%02x) expected was %02x. ignore further input data.\n",
                        current_crc, data_crc);
                state = STATE_ABORT;
                return 1; //mark as handled
            }
            printf("%02x> ", block_counter + 1);
            data_counter = 0;
            cnt=9;  //skip sync bits
            state = STATE_WAIT_FOR_SYNC;
            block_counter++;
            if (!(block_counter % 0x10)) {
                printf("\n");
            }
            if (block_counter > 1 && (block_counter-1) * BLOCKLEN >= len) {
                printf("OK. output is: \"%s\"\n", file_name);
                write_image(file_name);
            }
        }
    }
    return 1;
}

void Turbo4Handler::check(double ns, int pos) {
    int token = get_token(ns);

    //printf("b %s pos=%d cnt=%d\n",get_token_str(token),pos,cnt);

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
            cnt=0;
            return;
        }
        if (token == TOKEN_ONE) {
            cnt++;
            return;
        }
        if (token == TOKEN_SYNC) {
            if (cnt>8)
            {
                cnt=0; //wait for starting tone
                state = STATE_SAMPLE_DATA;
            }
            return;
        }
        break;
    case STATE_SAMPLE_DATA:
        if (token == TOKEN_SYNC) {
            // unknown it may not be a start of a block - wait for next one
            state = STATE_UNKNOWN;
            //this is a problem only if we have converted already something ... otherwise it is noise
            //printf ("warning: unexpected input sequence (diff=%5.2f, pos=%d) %s. We need either '0' or '1'.\n",ns,pos,get_state_str());
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

const char *Turbo4Handler::get_name() const {
    return "Turbo4         ";
}

const char *Turbo4Handler::get_comments() const {
    return "Peak Frequenz ~6100 Hz";
}

