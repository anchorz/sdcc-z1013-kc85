#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "handler.h"
#include "kc85handler.h"
#include "turbo4handler.h"

Kc85Handler ha_kc85;
Turbo4Handler ha_turbo4;

Handler *formats[2] = { &ha_kc85, &ha_turbo4 };

void usage(const char *pname) {
    printf("konvertiert eine .WAV in eine .KCC-Datei\n\n");
    printf("Die folgenden Formate werden erkannt:\n");
    for (unsigned int i = 0; i < sizeof(formats) / sizeof(formats[0]); i++) {
        Handler *ha = formats[i];
        printf("%2d. %s - %s\n", i + 1, ha->get_name(), ha->get_comments());
    }
    printf("\nArgumente: %s [-hist <segments>] <.WAV>\n\n", pname);
    printf(
            "  -hist <segments>  Ausgabe des Histogramms der Nullstellenabstände [Hz]\n");
    printf("\n");
}

int readLeInt32(FILE *f) {
    unsigned char buffer[4];
    fread(buffer, 4, 1, f);
    return buffer[3] << 24 | buffer[2] << 16 | buffer[1] << 8 | buffer[0];
}

int readLeInt16(FILE *f) {
    unsigned char buffer[2];
    fread(buffer, 2, 1, f);
    return buffer[1] << 8 | buffer[0];
}

int wav_channels;
int wav_sample_rate;
int wav_byte_rate;
int wav_alignment;
int wav_bits_per_sample;
int wav_length;

FILE *f;

int read_wav(const char *filename) {
    char buffer[4];
    int len, pcm_size, pcm_format;

    f = fopen(filename, "rb+");
    if (!f) {
        printf("error: can't read file \"%s\"\n", filename);
        return -1;
    }

    fread(buffer, 4, 1, f);
    if (memcmp(buffer, "RIFF", 4) != 0) {
        printf("error: header should start with \"RIFF\"\n");
        fclose(f);
        return -1;
    }
    len = readLeInt32(f);
    fread(buffer, 4, 1, f);
    if (memcmp(buffer, "WAVE", 4) != 0) {
        printf("error: chuck should start with \"WAVE\"\n");
        fclose(f);
        return -1;
    }
    len -= 4;
    fread(buffer, 4, 1, f);
    if (memcmp(buffer, "fmt ", 4) != 0) {
        printf("error: chuck id should be \"fmt \"\n");
        fclose(f);
        return -1;
    }
    len -= 4;
    pcm_size = readLeInt32(f);
    if (pcm_size != 16) {
        printf("error: this doesn't looks like PCM data (size=%d)\n", pcm_size);
        fclose(f);
        return -1;
    }
    pcm_format = readLeInt16(f);
    if (pcm_format != 1) {
        printf(
                "error: this doesn't looks like uncompressed PCM data (format=%d)\n",
                pcm_format);
        fclose(f);
        return -1;
    }
    wav_channels = readLeInt16(f);
    wav_sample_rate = readLeInt32(f);
    wav_byte_rate = readLeInt32(f);
    wav_alignment = readLeInt16(f);
    wav_bits_per_sample = readLeInt16(f);

    fread(buffer, 4, 1, f);
    if (memcmp(buffer, "data", 4) != 0) {
        printf("error: chuck id should be \"data\"\n");
        fclose(f);
        return -1;
    }

    wav_length = readLeInt32(f) / wav_channels / wav_alignment;
    printf("PCM data (CH=%d, %d Hz, align=%d, %d Bits/sample, %d samples)\n",
            wav_channels, wav_sample_rate, wav_alignment, wav_bits_per_sample,
            wav_length);

    if (wav_channels != 1) {
        printf(
                "error: sorry only MONO format is supported. Use one channel only.\n");
        fclose(f);
        return -1;
    }

    if (wav_alignment != 2) {
        printf("error: sorry only 16-bit format is supported.\n");
        fclose(f);
        return -1;
    }

    return 0;
}

void wav_close() {
    fclose(f);
}

int wav_read_left() {
    return (signed short) readLeInt16(f);
}

int sgn(int x) {
    return (x < 0) ? -1 : 1;
}

#define HIST_MAX print_histogram
//kHz
#define HIST_UPPER 8000

int print_histogram = 0;
unsigned int *hist = NULL;
int hist_total = 0;

void hist_add(double value) {
    if (!print_histogram)
        return;

    if (!hist) {
        hist = (unsigned int *) malloc(print_histogram * sizeof(int));
        memset(hist, 0, print_histogram * sizeof(int));
    }
    int v = (int) (value * HIST_MAX) / HIST_UPPER;

    if (v >= HIST_MAX) {
        v = HIST_MAX - 1;
    }
    //printf("h[v]=%d value=%f\n",v,value);
    hist[v] += 1;
    hist_total++;
}

void hist_print() {
    if (hist == NULL) {
        printf("Histogramm ohne Daten\n");
        return;
    }
    for (int k = 0; k < (HIST_MAX + 2) / 3; k++) {
        int i = k;
        printf("%3d %6.0f <%6.0f : %6d %6.2f%%   |   ", k,
                (1.0 * i * HIST_UPPER) / HIST_MAX,
                ((i + 1.0) * HIST_UPPER) / HIST_MAX, hist[i],
                100.0 * hist[i] / hist_total);
        i = k + (HIST_MAX + 2) / 3;
        printf("%6.0f <%6.0f : %6d %6.2f%%   |   ",
                (1.0 * i * HIST_UPPER) / HIST_MAX,
                ((i + 1.0) * HIST_UPPER) / HIST_MAX, hist[i],
                100.0 * hist[i] / hist_total);
        i = k + 2 * ((HIST_MAX + 2) / 3);
        if (i < HIST_MAX)
            printf("%6.0f <%6.0f : %6d %6.2f%%",
                    (1.0 * i * HIST_UPPER) / HIST_MAX,
                    ((i + 1.0) * HIST_UPPER) / HIST_MAX, hist[i],
                    100.0 * hist[i] / hist_total);
        printf("\n");
    }
    printf("\n");
}

#define SYNC 2
#define ONE 1
#define ZERO 0

const char * input_map[3] = { "ZERO", "ONE", "SYNC" };

#define S_UNKNOWN 0
#define WAIT_FOR_2N_ZERO 1
#define WAIT_FOR_SYNC1 2
#define WAIT_FOR_SYNC2 3
#define SAMPLE_DATA 4
int state = S_UNKNOWN;
int bytes;
int cnt;
int data;

int pos = 0;

int block_count = 0;
int block_adr = 0;
int block[32];
int crc;

void print_block() {
    printf("%04x ", block_adr);
    for (int i = 0; i < 32; i++) {
        printf("%02x ", block[i]);
    }
    printf(" %03x\n", crc);
}

void handle_byte(unsigned char b) {
    //printf("%02x (%d)",b,block_count);
    if (block_count == 0) {
        block_adr = b;
    }
    if (block_count == 1) {
        block_adr = b * 256 + block_adr;
    }
    if (block_count > 1 && block_count < 34) {
        block[block_count - 2] = b;
    }
    if (block_count == 34) {
        crc = b;
    }
    block_count++;
    if (block_count == 35) {
        print_block();
        block_count = 0;
    }
}

void check(int input) {
    switch (state) {
    case S_UNKNOWN:
        if (input == ZERO) {
            state = WAIT_FOR_2N_ZERO;
            return;
        }
        if (input == SYNC) {
            return;
        }
        break;

    case WAIT_FOR_2N_ZERO:
        if (input == ZERO) {
            state = WAIT_FOR_SYNC1;
            return;
        }
        break;
    case WAIT_FOR_SYNC1:
        if (input == ONE) {
            state = S_UNKNOWN;
            return;
        }
        if (input == ZERO) {
            return;
        }
        if (input == SYNC) {
            state = WAIT_FOR_SYNC2;
            return;
        }
        break;
    case WAIT_FOR_SYNC2:
        if (input == SYNC) {
            state = SAMPLE_DATA;
            bytes = 35;
            cnt = 0;
            data = 0;
            return;
        } else {
            state = S_UNKNOWN;
            return;
        }

        break;
    case SAMPLE_DATA:
        //printf("bytes=%d bits=%d %s\n",bytes,cnt,input_map[input]);
        if (input == ONE) {
            data *= 2;
            data++;
            cnt++;
            if (cnt == 8) {
                handle_byte(data);
                cnt = 0;
                data = 0;
                bytes--;
                if (bytes == 0) {
                    state = S_UNKNOWN;
                }
            }
            return;
        }
        if (input == ZERO) {
            data *= 2;
            cnt++;
            if (cnt == 8) {
                handle_byte(data);
                cnt = 0;
                data = 0;
                bytes--;
                if (bytes == 0) {
                    state = S_UNKNOWN;
                }
            }
            return;
        }
    }
    printf("unhandled input %s in state %d pos=%d\n", input_map[input], state,
            pos);
}

int ns = 0;
int ns_rest_y = 0;
int ns_rest_dy = 1;

void find_zero_crossings(Handler &ha) {
    int last_sample = wav_read_left();
    int last_sample_sign = sgn(last_sample);
    for (pos = 1; pos < wav_length; pos++) {
        int val = wav_read_left();
        int s = sgn(val);
        //printf("sample[%d]=%d\n",pos,val);
        //printf("%d\n",ns);        
        if (s != last_sample_sign) {
            int new_ns, new_ns_rest_y, new_ns_rest_dy;
            if (val != 0) {
                new_ns_rest_dy = last_sample ? val - last_sample : 0;
                new_ns_rest_y = last_sample;
                new_ns = pos - 1;
            } else {
                new_ns_rest_dy = 0;
                new_ns_rest_y = 0;
                new_ns = pos;
            }
            int diff = new_ns - ns;
            //printf("diff=%d (%d[%d/%d] - %d[%d/%d] s=%d)\n",diff,new_ns,new_ns_rest_y,new_ns_rest_dy,  ns,ns_rest_y,ns_rest_dy,s);

            double w1 = -ns_rest_y;
            if (ns_rest_dy)
                w1 /= ns_rest_dy;

            double w2 = -new_ns_rest_y;
            if (new_ns_rest_dy)
                w2 /= new_ns_rest_dy;

            double d = diff + (w2 - w1);
            if (d) {
                //printf("diff=%f w1=%f w2=%f\n",d,w1,w2);
                d = ((double) wav_sample_rate) / (2 * d);
                ha.check(d, pos);
                hist_add(d);
            }
            ns = new_ns;
            ns_rest_y = new_ns_rest_y;
            ns_rest_dy = new_ns_rest_dy;

        }
        last_sample = val;
        last_sample_sign = s;
    }
}

int filter_arguments(int argc, char **argv) {
    for (int i = 0; i < argc; i++) {
        if (strcmp(argv[i], "-hist") == 0) {
            memcpy(argv + i, argv + i + 1, (argc - i - 1) * sizeof(void*));
            argc--;
            print_histogram = 100;
            if (i < argc) {
                int segments = atoi(argv[i]);
                if (segments <= 1)
                    segments = 100;
                memcpy(argv + i, argv + i + 1, (argc - i - 1) * sizeof(void*));
                argc--;
                print_histogram = segments;
            }
        }
    }
    return argc;
}

int main(int argc, char **argv) {
    int ret;

    argc = filter_arguments(argc, argv);

    if (argc != 2) {
        usage(argv[0]);
        return -1;
    }

    for (unsigned int i = 0; i < sizeof(formats) / sizeof(formats[0]); i++) {
        Handler *ha = formats[i];
        printf("Versuch %d: %s\n", i + 1, ha->get_name());
        ret = read_wav(argv[1]);
        if (ret) {
            return -1;
        }
        find_zero_crossings(*ha);
        wav_close();
        printf("\n");
    }
    if (print_histogram) {
        hist_print();
    }
    return ret;
}

