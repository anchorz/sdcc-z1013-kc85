#include <stdio.h>
#include <stdlib.h>
#include <krt.h>

#include "xonix.h"
#include "xonix_font.h"
#include "computer_font.h"

unsigned char *manPtr;
unsigned char manX, manY;

#define W SCR_WIDTH
#define H (SCR_HEIGHT-1)

unsigned char field[W * H]; //initialized with 0 per specification

unsigned char keyInput = 0;
#define TASK_MAN_MOVE 1
unsigned char taskBits = 0;

#ifdef __KC85__
#define SCR_ADD_LINE(SCR_PTR , N) ((SCR_PTR)+(N)*0x800)
#define SCR_INC(SCR_PTR) (SCR_PTR=normalized_inc(SCR_PTR))
#define SCR_ADD(SCR_PTR,N) (SCR_PTR=normalized_add(SCR_PTR,N))
#else
#define SCR_ADD_LINE(SCR_PTR , N) ((SCR_PTR)+SCR_WIDTH)
#define SCR_INC(SCR_PTR) ((SCR_PTR)++)
#define SCR_ADD(SCR_PTR,N) ((SCR_PTR)+=(N))
#endif

unsigned char *normalized_inc(unsigned int *ptr) __z88dk_fastcall
{
        ptr;
__asm
        inc l

        ld  a,l
        cp  #0x28
        jr  c,is_ok$
        sub #0x28 ; SCR_WIDTH
        ld  l,a
        ld  a,h
        add #0x8; PTR_VERTICAL_INC
        ld  h,a
is_ok$:
        ret

        .db 0x7f,0x7f
        .ascii 'XONIX'
        .db 0x01
        jp 0x200

__endasm;
}

unsigned char *normalized_add(unsigned int *ptr,unsigned int add) __z88dk_callee
{
        ptr;add;
__asm
        pop hl
        pop de
        ex (sp),hl

        ld  a,l
        add e
        ld  l,a
        ld  h,d

        cp  #0x28
        jr  c,is_ok1$
        sub #0x28 ; SCR_WIDTH
        ld  l,a
        ld  a,d
        add #0x8; PTR_VERTICAL_INC
        ld  h,a
is_ok1$:
__endasm;
}

void pixel_border() {
    unsigned char x;
    unsigned char* ptr = SCR_ADD_LINE(SCR_PTR, 1);
    unsigned char *field_ptr = field;
    x = SCR_WIDTH + 2;
    while (--x) {
        *field_ptr++ = FIELD_FULL;
        krt_putchar(ptr, FIELD_FULL, COLOR_FULL);
        SCR_INC(ptr);
    }
    SCR_ADD(ptr,SCR_WIDTH - 2);
    field_ptr += SCR_WIDTH - 2;

    x = SCR_HEIGHT - 3;
    while (--x) {
        krt_putchar(ptr, FIELD_FULL, COLOR_FULL);
        SCR_INC(ptr);
        krt_putchar(ptr, FIELD_FULL, COLOR_FULL);
        SCR_ADD(ptr,SCR_WIDTH - 1);

        *field_ptr++ = FIELD_FULL;
        *field_ptr = FIELD_FULL;
        field_ptr += SCR_WIDTH - 1;
    }

    krt_putchar(ptr, FIELD_FULL, COLOR_FULL);
    SCR_INC(ptr);
    *field_ptr++ = FIELD_FULL;

    x = SCR_WIDTH+1;
    while (--x) {
        krt_putchar(ptr, FIELD_FULL, COLOR_FULL);
        SCR_INC(ptr);
        *field_ptr++ = FIELD_FULL;
    }
}

void pixel_man_init() {
    manX = 0;
    manY = 0;
    manPtr = SCR_PTR + manY * SCR_WIDTH + manX + SCR_WIDTH;
    krt_putchar(manPtr, FIELD_FULL_MAN, COLOR_FULL);
}

#define FRAMES 8

const unsigned char animationenRightLeft[3][FRAMES] = { { //FIELD_EMPTY left part animation
        FIELD_FULL_L1 + 0, //phase 0
        FIELD_FULL_L1 + 1, //phase 1
        FIELD_FULL_L1 + 2, //phase 2
        FIELD_FULL_L1 + 3, //phase 3
        FIELD_FULL_L1 + 4, //phase 4
        FIELD_FULL_L1 + 5, //phase 5
        FIELD_FULL_L1 + 6, //phase 6
        FIELD_FULL }, { // FIELD_FULL left part animation
        FIELD_FULL_L1 + 0, //phase 0
        FIELD_FULL_L1 + 1, //phase 1
        FIELD_FULL_L1 + 2, //phase 2
        FIELD_FULL_L1 + 3, //phase 3
        FIELD_FULL_L1 + 4, //phase 4
        FIELD_FULL_L1 + 5, //phase 5
        FIELD_FULL_L1 + 6, //phase 6
        FIELD_FULL }, { // FIELD_CLAIMING left part animation
        FIELD_FULL_L1 + 0, //phase 0
        FIELD_FULL_L1 + 1, //phase 1
        FIELD_FULL_L1 + 2, //phase 2
        FIELD_FULL_L1 + 3, //phase 3
        FIELD_FULL_L1 + 4, //phase 4
        FIELD_FULL_L1 + 5, //phase 5
        FIELD_FULL_L1 + 6, //phase 6
        FIELD_FULL } };

const unsigned char animationenRightRight[3][8] = { { //FIELD_EMPTY right part animation
        FIELD_FULL_R1 + 0, //phase 0
        FIELD_FULL_R1 + 1, //phase 1
        FIELD_FULL_R1 + 2, //phase 2
        FIELD_FULL_R1 + 3, //phase 3
        FIELD_FULL_R1 + 4, //phase 4
        FIELD_FULL_R1 + 5, //phase 5
        FIELD_FULL_R1 + 6, //phase 6
        FIELD_FULL_MAN }, { // FIELD_FULL right part animation
        FIELD_FULL_R1 + 0, //phase 0
        FIELD_FULL_R1 + 1, //phase 1
        FIELD_FULL_R1 + 2, //phase 2
        FIELD_FULL_R1 + 3, //phase 3
        FIELD_FULL_R1 + 4, //phase 4
        FIELD_FULL_R1 + 5, //phase 5
        FIELD_FULL_R1 + 6, //phase 6
        FIELD_FULL_MAN }, { // FIELD_CLAIMING right part animation
        FIELD_FULL_R1 + 0, //phase 0
        FIELD_FULL_R1 + 1, //phase 1
        FIELD_FULL_R1 + 2, //phase 2
        FIELD_FULL_R1 + 3, //phase 3
        FIELD_FULL_R1 + 4, //phase 4
        FIELD_FULL_R1 + 5, //phase 5
        FIELD_FULL_R1 + 6, //phase 6
        FIELD_FULL_MAN } };

const unsigned char animationenLeftLeft[3][FRAMES] = { { //FIELD_EMPTY left part animation
        FIELD_FULL_L1 + 6, //phase 0
        FIELD_FULL_L1 + 5, //phase 1
        FIELD_FULL_L1 + 4, //phase 2
        FIELD_FULL_L1 + 3, //phase 3
        FIELD_FULL_L1 + 2, //phase 4
        FIELD_FULL_L1 + 1, //phase 5
        FIELD_FULL_L1 + 0, //phase 6
        FIELD_FULL_MAN }, { // FIELD_FULL left part animation
        FIELD_FULL_L1 + 6, //phase 0
        FIELD_FULL_L1 + 5, //phase 1
        FIELD_FULL_L1 + 4, //phase 2
        FIELD_FULL_L1 + 3, //phase 3
        FIELD_FULL_L1 + 2, //phase 4
        FIELD_FULL_L1 + 1, //phase 5
        FIELD_FULL_L1 + 0, //phase 6
        FIELD_FULL_MAN }, { // FIELD_CLAIMING left part animation
        FIELD_FULL_L1 + 6, //phase 0
        FIELD_FULL_L1 + 5, //phase 1
        FIELD_FULL_L1 + 4, //phase 2
        FIELD_FULL_L1 + 3, //phase 3
        FIELD_FULL_L1 + 2, //phase 4
        FIELD_FULL_L1 + 1, //phase 5
        FIELD_FULL_L1 + 0, //phase 6
        FIELD_FULL_MAN } };

const unsigned char animationenLeftRight[3][8] = { { //FIELD_EMPTY right part animation
        FIELD_FULL_R1 + 6, //phase 0
        FIELD_FULL_R1 + 5, //phase 1
        FIELD_FULL_R1 + 4, //phase 2
        FIELD_FULL_R1 + 3, //phase 3
        FIELD_FULL_R1 + 2, //phase 4
        FIELD_FULL_R1 + 1, //phase 5
        FIELD_FULL_R1 + 0, //phase 6
        FIELD_FULL }, { // FIELD_FULL right part animation
        FIELD_FULL_R1 + 6, //phase 0
        FIELD_FULL_R1 + 5, //phase 1
        FIELD_FULL_R1 + 4, //phase 2
        FIELD_FULL_R1 + 3, //phase 3
        FIELD_FULL_R1 + 2, //phase 4
        FIELD_FULL_R1 + 1, //phase 5
        FIELD_FULL_R1 + 0, //phase 6
        FIELD_FULL }, { // FIELD_CLAIMING right part animation
        FIELD_FULL_R1 + 6, //phase 0
        FIELD_FULL_R1 + 5, //phase 1
        FIELD_FULL_R1 + 4, //phase 2
        FIELD_FULL_R1 + 3, //phase 3
        FIELD_FULL_R1 + 2, //phase 4
        FIELD_FULL_R1 + 1, //phase 5
        FIELD_FULL_R1 + 0, //phase 6
        FIELD_FULL } };

const unsigned char animationenDownTop[3][FRAMES] = { { //FIELD_EMPTY top part animation
        FIELD_FULL_T1 + 0, //phase 0
        FIELD_FULL_T1 + 1, //phase 1
        FIELD_FULL_T1 + 2, //phase 2
        FIELD_FULL_T1 + 3, //phase 3
        FIELD_FULL_T1 + 4, //phase 4
        FIELD_FULL_T1 + 5, //phase 5
        FIELD_FULL_T1 + 6, //phase 6
        FIELD_FULL }, { // FIELD_FULL top part animation
        FIELD_FULL_T1 + 0, //phase 0
        FIELD_FULL_T1 + 1, //phase 1
        FIELD_FULL_T1 + 2, //phase 2
        FIELD_FULL_T1 + 3, //phase 3
        FIELD_FULL_T1 + 4, //phase 4
        FIELD_FULL_T1 + 5, //phase 5
        FIELD_FULL_T1 + 6, //phase 6
        FIELD_FULL }, { // FIELD_CLAIMING top part animation
        FIELD_FULL_T1 + 0, //phase 0
        FIELD_FULL_T1 + 1, //phase 1
        FIELD_FULL_T1 + 2, //phase 2
        FIELD_FULL_T1 + 3, //phase 3
        FIELD_FULL_T1 + 4, //phase 4
        FIELD_FULL_T1 + 5, //phase 5
        FIELD_FULL_T1 + 6, //phase 6
        FIELD_FULL } };

const unsigned char animationenDownBottom[3][8] = { { //FIELD_EMPTY bottom part animation
        FIELD_FULL_B1 + 0, //phase 0
        FIELD_FULL_B1 + 1, //phase 1
        FIELD_FULL_B1 + 2, //phase 2
        FIELD_FULL_B1 + 3, //phase 3
        FIELD_FULL_B1 + 4, //phase 4
        FIELD_FULL_B1 + 5, //phase 5
        FIELD_FULL_B1 + 6, //phase 6
        FIELD_FULL_MAN }, { //FIELD_EMPTY bottom part animation
        FIELD_FULL_B1 + 0, //phase 0
        FIELD_FULL_B1 + 1, //phase 1
        FIELD_FULL_B1 + 2, //phase 2
        FIELD_FULL_B1 + 3, //phase 3
        FIELD_FULL_B1 + 4, //phase 4
        FIELD_FULL_B1 + 5, //phase 5
        FIELD_FULL_B1 + 6, //phase 6
        FIELD_FULL_MAN }, { //FIELD_EMPTY bottom part animation
        FIELD_FULL_B1 + 0, //phase 0
        FIELD_FULL_B1 + 1, //phase 1
        FIELD_FULL_B1 + 2, //phase 2
        FIELD_FULL_B1 + 3, //phase 3
        FIELD_FULL_B1 + 4, //phase 4
        FIELD_FULL_B1 + 5, //phase 5
        FIELD_FULL_B1 + 6, //phase 6
        FIELD_FULL_MAN } };

const unsigned char animationenUpTop[3][FRAMES] = { { //FIELD_EMPTY top part animation
        FIELD_FULL_T1 + 6, //phase 6
        FIELD_FULL_T1 + 5, //phase 5
        FIELD_FULL_T1 + 4, //phase 4
        FIELD_FULL_T1 + 3, //phase 3
        FIELD_FULL_T1 + 2, //phase 2
        FIELD_FULL_T1 + 1, //phase 1
        FIELD_FULL_T1 + 0, //phase 0
        FIELD_FULL_MAN }, { // FIELD_FULL top part animation
        FIELD_FULL_T1 + 6, //phase 6
        FIELD_FULL_T1 + 5, //phase 5
        FIELD_FULL_T1 + 4, //phase 4
        FIELD_FULL_T1 + 3, //phase 3
        FIELD_FULL_T1 + 2, //phase 2
        FIELD_FULL_T1 + 1, //phase 1
        FIELD_FULL_T1 + 0, //phase 0
        FIELD_FULL_MAN }, { // FIELD_CLAIMING top part animation
        FIELD_FULL_T1 + 6, //phase 6
        FIELD_FULL_T1 + 5, //phase 5
        FIELD_FULL_T1 + 4, //phase 4
        FIELD_FULL_T1 + 3, //phase 3
        FIELD_FULL_T1 + 2, //phase 2
        FIELD_FULL_T1 + 1, //phase 1
        FIELD_FULL_T1 + 0, //phase 0
        FIELD_FULL_MAN } };

const unsigned char animationenUpBottom[3][8] = { { //FIELD_EMPTY bottom part animation
        FIELD_FULL_B1 + 6, //phase 0
        FIELD_FULL_B1 + 5, //phase 1
        FIELD_FULL_B1 + 4, //phase 2
        FIELD_FULL_B1 + 3, //phase 3
        FIELD_FULL_B1 + 2, //phase 4
        FIELD_FULL_B1 + 1, //phase 5
        FIELD_FULL_B1 + 0, //phase 6
        FIELD_FULL }, { //FIELD_EMPTY bottom part animation
        FIELD_FULL_B1 + 6, //phase 0
        FIELD_FULL_B1 + 5, //phase 1
        FIELD_FULL_B1 + 4, //phase 2
        FIELD_FULL_B1 + 3, //phase 3
        FIELD_FULL_B1 + 2, //phase 4
        FIELD_FULL_B1 + 1, //phase 5
        FIELD_FULL_B1 + 0, //phase 6
        FIELD_FULL }, { //FIELD_EMPTY bottom part animation
        FIELD_FULL_B1 + 6, //phase 0
        FIELD_FULL_B1 + 5, //phase 1
        FIELD_FULL_B1 + 4, //phase 2
        FIELD_FULL_B1 + 3, //phase 3
        FIELD_FULL_B1 + 2, //phase 4
        FIELD_FULL_B1 + 1, //phase 5
        FIELD_FULL_B1 + 0, //phase 6
        FIELD_FULL } };

unsigned char phase = 0;
const unsigned char * animation_current;
const unsigned char * animation_next;

inline void set_field(unsigned char x, unsigned char y, unsigned char c) {
    field[y * W + x] = c;
}

inline unsigned char get_field(unsigned char x, unsigned char y) {
    return field[y * W + x];
}

void pixel_man_left() {
    if (manX > 0) {
        unsigned char next_field, this_field;
        taskBits |= TASK_MAN_MOVE;
        phase = 0;
        this_field = get_field(manX, manY);
        next_field = get_field(manX - 1, manY);
        animation_current = animationenLeftRight[this_field];
        animation_next = animationenLeftLeft[next_field];
    }
}

void pixel_man_right() {
    if (manX < W) {
        unsigned char next_field, this_field;
        taskBits |= TASK_MAN_MOVE;
        phase = 0;
        this_field = get_field(manX, manY);
        next_field = get_field(manX + 1, manY);
        animation_current = animationenRightLeft[this_field];
        animation_next = animationenRightRight[next_field];
    }
}

void pixel_man_up() {
    if (manY > 0) {
        unsigned char next_field, this_field;
        taskBits |= TASK_MAN_MOVE;
        phase = 0;
        this_field = get_field(manX, manY);
        next_field = get_field(manX, manY - 1);
        animation_current = animationenUpBottom[this_field];
        animation_next = animationenUpTop[next_field];
    }
}

void pixel_man_down() {
    if (manY < H - 1) {
        unsigned char next_field, this_field;
        taskBits |= TASK_MAN_MOVE;
        phase = 0;
        this_field = get_field(manX, manY);
        next_field = get_field(manX, manY + 1);
        animation_current = animationenDownTop[this_field];
        animation_next = animationenDownBottom[next_field];
    }
}

//TODO statt putchar ist es schneller, wenn man die Adresse der Animation direkt verwendet
void animation_right() {
    krt_putchar(manPtr, animation_current[phase], COLOR_DEFAULT);
    krt_putchar(manPtr + 1, animation_next[phase], COLOR_DEFAULT);
    phase++;
    if (phase == FRAMES) {
        taskBits &= ~TASK_MAN_MOVE;
        manPtr++;
        manX++;
    }
}

void animation_left() {
    krt_putchar(manPtr, animation_current[phase], COLOR_DEFAULT);
    krt_putchar(manPtr - 1, animation_next[phase], COLOR_DEFAULT);
    phase++;
    if (phase == FRAMES) {
        taskBits &= ~TASK_MAN_MOVE;
        manPtr--;
        manX--;
    }
}

void animation_up() {
    krt_putchar(manPtr, animation_current[phase], COLOR_DEFAULT);
    krt_putchar(manPtr - SCR_WIDTH, animation_next[phase], COLOR_DEFAULT);
    phase++;
    if (phase == FRAMES) {
        taskBits &= ~TASK_MAN_MOVE;
        manPtr -= SCR_WIDTH;
        manY--;
    }
}

void animation_down() {
    krt_putchar(manPtr, animation_current[phase], COLOR_DEFAULT);
    krt_putchar(manPtr + SCR_WIDTH, animation_next[phase], COLOR_DEFAULT);
    phase++;
    if (phase == FRAMES) {
        taskBits &= ~TASK_MAN_MOVE;
        manPtr += SCR_WIDTH;
        manY++;
    }
}

#ifndef __SDCC
int usleep(unsigned long usec);
#endif

void delay() {
#ifdef __SDCC
    __asm__("ld c,#0x08");
    __asm__("m2:");
    __asm__("ld b,#0");
    __asm__("m1:");
    __asm__("djnz m1");
    __asm__("dec c");
    __asm__("jr nz,m2");
#endif
}

void check_for_tasks2() {
    while (taskBits != 0) {
        if (taskBits & TASK_MAN_MOVE) {
            //unsigned char tmpKeyInput = get_input();
            switch (keyInput) {
            case CURSOR_RIGHT:
                animation_right();
                break;
            case CURSOR_LEFT:
                animation_left();
                break;
            case CURSOR_DOWN:
                animation_down();
                break;
            case CURSOR_UP:
                animation_up();
                break;
            default:
                break;
            }
        }
        delay();
    }
}

inline void check_for_tasks() {
#ifndef __SDCC
    if (taskBits)
        check_for_tasks2();
    usleep(0x25000);
#else
    __asm__("ld a,(#_taskBits)");
    __asm__("or a,a");
    __asm__("call nz,_check_for_tasks2");
#endif
}

int main() {
    krt_init();
    krt_font_install(xonix_font, 0, sizeof(xonix_font) / 8); //zeichen 0x00..0x1F
    krt_font_install(xonix_animations, 0x88, sizeof(xonix_animations) / 8); //Zeichen >0x80
    krt_font_install(computer_font, 0x20, sizeof(computer_font) / 8);
    //title_screen();
    krt_clrscr(PIXEL_ERASE, COLOR_EMPTY);
    krt_textcolor(COLOR_FG_YELLOW);
    pixel_border();
    pixel_man_init();
    krt_gotoxy(0, 0);
    krt_cputs("Punkte: 000000 Leben: 05");
    krt_gotoxy(SCR_WIDTH - 5, 0);
    krt_cputs("0/80%");
    for (;;) {
        unsigned char localInput;
        check_for_tasks();
        localInput = get_input();
        keyInput = localInput;
        if (localInput) {
            switch (keyInput) {
            case 0x03:
            case 0x1b:
                goto end;
            case 0x08:
                pixel_man_left();
                break;
            case 0x09:
                pixel_man_right();
                break;
            case 0x0b:
                pixel_man_up();
                break;
            case 0x0a:
                pixel_man_down();
                break;
            case 'T':
            case 't':
                toggle();
                break;
            default:
                break;
            }
        }
    }
    end: krt_off();
    return 0;
}

