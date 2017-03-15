#include <stdio.h>
#include <stdlib.h>
#include <krt.h>

#include "xonix.h"
#include "xonix_font.h"
#include "computer_font.h"

#define JOYSTICK_LEFT 1
#define JOYSTICK_RIGHT 2
#define JOYSTICK_DOWN 4
#define JOYSTICK_UP 8
#define JOYSTICK_FIRE 16

//TODO disable interrupt during stack manipulation

#ifdef __Z9001__
#define z1013_spvt_getst z9001_getst
#define z1013_spvt_poll z9001_poll
#define clrscr(X)
#define _setcursortype(X)
unsigned char z9001_getst() {return 0;}
unsigned char z9001_poll() {return 0;}
#endif

#define CHAR_HORIZONTAL_BAR 0xa0
#define CHAR_VERTICAL_BAR 0xa1
#define CHAR_CORNER_TOP_LEFT 0xa8
#define CHAR_CORNER_TOP_RIGHT 0xa9
#define CHAR_CORNER_BOTTOM_RIGHT 0xaa
#define CHAR_CORNER_BOTTOM_LEFT 0xa7
#define CHAR_MAN  0xc4

typedef unsigned char * ScreenPointer;

#define SET_SCREEN(PTR,CHAR) krt_putchar(PTR,CHAR, COLOR_DEFAULT )
#define GET_SCREEN(PTR) (*PTR) 

unsigned char *manPtr;
unsigned char manX, manY;
unsigned char manBelowCharacter;

#define W SCR_WIDTH
#define H (SCR_HEIGHT-1)

unsigned char field[W * H - 1]; //initialized with 0 per specification

unsigned char keyInput = 0;
#define TASK_MAN_MOVE 1
unsigned char taskBits = 0;

void man_set() {
    manBelowCharacter = GET_SCREEN(manPtr);
    SET_SCREEN(manPtr, CHAR_MAN);
}

//void man_remove()
//{
//    SET_SCREEN(manPtr,manBelowCharacter);
//}

void man_init() {
    manX = 0;
    manY = 0;
    manPtr = SCR_PTR + manY * SCR_WIDTH + manX + SCR_WIDTH;
    man_set();
}

const unsigned char mapRight[16] = { 0xa0, 0xa3, 0xa2, 0xa3,  //a0..a3
        0xa4, 0xa6, 0xa6, 0xa7,  //a4..a7
        0xa8, 0xa4, 0xa2, 0xa0,   //a8..ab
        0xa8, 0xa0, 0xa7, 'f'    //ac..af
        };

const unsigned char mapLeft[16] = { 0xa0, 0xa5, 0xa2, 0xa6,  //a0..a3
        0xa4, 0xa5, 0xa6, 0xa2,  //a4..a7
        0xa4, 0xa9, 0xaa, 0xa0,  //a8..ab
        0xa9, 0xa0, 0xaa, 'l'   //ac..af
        };

const unsigned char mapUp[16] = { 0xa2, 0xa1, 0xa2, 0xa3,  //a0..a3
        0xa6, 0xa5, 0xa6, 0xa7,  //a4..a7
        0xa3, 0xa5, 0xaa, 0xaa,  //a8..ab
        0xa1, 0xa7, 0xa1, 'a'   //ac..af
        };

const unsigned char mapDown[16] = { 0xa4, 0xa1, 0xa6, 0xa3,  //a0..a3
        0xa4, 0xa5, 0xa6, 0xa3,  //a4..a7
        0xa8, 0xa9, 0xa5, 0xa9,  //a8..ab
        0xa1, 0xa8, 0xa1, 'c'   //ac..af
        };

#define IS_FREE(PTR) (GET_SCREEN(PTR)==' ' || GET_SCREEN(PTR)=='a' || GET_SCREEN(PTR)=='A')

void man_left() {
    if (manX > 0) {
        SET_SCREEN(manPtr, mapLeft[manBelowCharacter - 0xa0]);
        manPtr--;
        manX--;
        if (IS_FREE(manPtr)) {
            manBelowCharacter = 0xad;
        } else {
            manBelowCharacter = mapRight[GET_SCREEN(manPtr) - 0xa0];
        }
        SET_SCREEN(manPtr, CHAR_MAN);
    }
}

void man_right() {
    if (manX < SCR_WIDTH - 1) {
        SET_SCREEN(manPtr, mapRight[manBelowCharacter - 0xa0]);
        manPtr++;
        manX++;
        if (IS_FREE(manPtr)) {
            manBelowCharacter = 0xab;
        } else {
            manBelowCharacter = mapLeft[GET_SCREEN(manPtr) - 0xa0];
        }
        SET_SCREEN(manPtr, CHAR_MAN);
    }
}

void man_up() {
    if (manY > 0) {
        SET_SCREEN(manPtr, mapUp[manBelowCharacter - 0xa0]);
        manPtr -= SCR_WIDTH;
        manY--;
        if (IS_FREE(manPtr)) {
            manBelowCharacter = 0xac;
        } else {
            manBelowCharacter = mapDown[GET_SCREEN(manPtr) - 0xa0];
        }
        SET_SCREEN(manPtr, CHAR_MAN);
    }
}

void man_down() {
    if (manY < SCR_HEIGHT - 2) {
        SET_SCREEN(manPtr, mapDown[manBelowCharacter - 0xa0]);
        manPtr += SCR_WIDTH;
        manY++;
        if (IS_FREE(manPtr)) {
            manBelowCharacter = 0xae;
        } else {
            manBelowCharacter = mapUp[GET_SCREEN(manPtr) - 0xa0];
        }
        SET_SCREEN(manPtr, CHAR_MAN);
    }
}

#ifdef __SDCC
void DELAY()
{
    __asm__("ld c,#0x08");
    __asm__("m2:");
    __asm__("ld b,#0");
    __asm__("m1:");
    __asm__("djnz m1");
    __asm__("dec c");
    __asm__("jr nz,m2");
}
#else
void DELAY() {
}
#endif
//
//#define DELAY(X)

signed char ex, ey;
signed char vx, vy;
ScreenPointer ballPtr;

void ball_init() {
    signed char bx = 2, by = 1;
    ex = 0;
    ey = 0;
    vx = 16;
    vy = 32;

    ballPtr = SCR_PTR + by * SCR_WIDTH + bx + SCR_WIDTH;
    SET_SCREEN(ballPtr, 0x8c);
}

#ifndef __SDCC
#define __z88dk_fastcall
#define __naked
#endif

void ball_move() {
    char flag = 0;
    ScreenPointer oldScrPtr = ballPtr;

    //printf("\na move ex=0x%x ey=0x%x vx=0x%x vy=0x%x\n",ex,ey,vx,vy);
    ex += vx;
    ey += vy;
    //printf("b move ex=0x%x ey=0x%x vx=0x%x vy=0x%x\n",ex,ey,vx,vy);

    if (vx < 0) {
        if (ex < 0) {
            ex += 0x80;
            ballPtr--;
            flag = 1;
        }
    } else {
        //overflow test
        if (ex < 0) {
            ex -= 0x80;
            ballPtr++;
            flag = 1;
        }
    }

    if (vy < 0) {
        if (ey < 0) {
            ey += 0x80;
            ballPtr -= SCR_WIDTH;
            flag = 1;
        }
    } else {
        //overflow test
        if (ey < 0) {
            ey -= 0x80;
            ballPtr += SCR_WIDTH;
            flag = 1;
        }
    }

    if (flag) {
        if (IS_FREE(ballPtr)) {
            SET_SCREEN(oldScrPtr, ' ');
            SET_SCREEN(ballPtr, 0x8c);
        } else {
            char c = GET_SCREEN(ballPtr);
            switch (c & 0xf) {
            case 0:
            case 2:
            case 4:
                vy = -vy;
                break;
            case 1:
            case 3:
            case 5:
                vx = -vx;
                break;
            case 6:
            case 7:
            case 8:
            case 9:
            case 0xa:
                vy = -vy;
                vx = -vx;
                break;
            }
            //*oldScrPtr='a';
            //*scrPtr=0x8c;
            //*oldScrPtr=' ';
            //*scrPtr=0x8c;
            ballPtr = oldScrPtr;
            //that triggered immediate change in direction
            ex = (vx < 0) ? 0 : (0x80 - vx);
            ey = (vy < 0) ? 0 : (0x80 - vy);
            //ex=tx;
            //ey=ty;
            //printf("u move ex=0x%x ey=0x%x vx=0x%x vy=0x%x\n",ex,ey,vx,vy);
        }
    }

}

#ifdef __SDCC
#define KRT_GRAFIK
#else
#define inline
#endif

void pixel_border() {
    unsigned char x;
    unsigned char* ptr = SCR_PTR + SCR_WIDTH;
    unsigned char *field_ptr = field;
    x = SCR_WIDTH + 2;
    while (--x) {
        *field_ptr++ = FIELD_FULL;
        krt_putchar(ptr, FIELD_FULL, COLOR_FULL);
        ptr++;
    }
    ptr += SCR_WIDTH - 2;
    field_ptr += SCR_WIDTH - 2;
    x = SCR_HEIGHT - 2;

    while (--x) {
        krt_putchar(ptr++, FIELD_FULL, COLOR_FULL);
        krt_putchar(ptr, FIELD_FULL, COLOR_FULL);
        ptr += SCR_WIDTH - 1;

        *field_ptr++ = FIELD_FULL;
        *field_ptr = FIELD_FULL;
        field_ptr += SCR_WIDTH - 1;
    }
    ptr -= SCR_WIDTH - 2;
    field_ptr -= SCR_WIDTH - 2;

    x = SCR_WIDTH;
    while (--x) {
        krt_putchar(ptr++, FIELD_FULL, COLOR_FULL);
        *field_ptr++ = FIELD_FULL;
    }
}

void pixel_man_init() {
    manX = 0;
    manY = 0;
    manPtr = SCR_PTR + manY * SCR_WIDTH + manX + SCR_WIDTH;
    //TODO if empty FULL_MAN only on full fields
    krt_putchar(manPtr, FIELD_FULL_MAN, COLOR_FULL);
}


unsigned char keyNext = 0; //Zwischenspeicher falls während einer Animation eine Tastegedrückt wurde, so dass diese nicht verloren geht
unsigned char phase_right = 0;

const unsigned char animationenRightRight[3][8] = { { FIELD_CLAIMING_MAN,
FCLAIM_R1, FCLAIM_R1 + 1, FCLAIM_R1 + 2,
FCLAIM_R1 + 3, FCLAIM_R1 + 4, FCLAIM_R1 + 5,
FCLAIM_R1 + 6 }, // FIELD_EMPTY 0x00
        { FIELD_FULL_MAN, FIELD_FULL_R1, FIELD_FULL_R1 + 1, FIELD_FULL_R1 + 2,
        FIELD_FULL_R1 + 3, FIELD_FULL_R1 + 4, FIELD_FULL_R1 + 5, FIELD_FULL_R1
                + 6 }, // FIELD_FULL 0x01

        { FIELD_CLAIMING_MAN, FCLAIM_R1, FCLAIM_R1 + 1,
        FCLAIM_R1 + 2,
        FCLAIM_R1 + 3, FCLAIM_R1 + 4, FCLAIM_R1 + 5,
        FCLAIM_R1 + 6 }, // FIELD_CLAMING 0x02

        };

const unsigned char animationenRightLeft[3][8] = {

{ FIELD_CLAIMING, FCLAIM_L1, FCLAIM_L1 + 1, FCLAIM_L1 + 2,
FCLAIM_L1 + 3, FCLAIM_L1 + 4, FCLAIM_L1 + 5, FCLAIM_L1 + 6 }, // FIELD_EMPTY 0x00

        { FIELD_FULL, FIELD_FULL_L1, FIELD_FULL_L1 + 1, FIELD_FULL_L1 + 2,
        FIELD_FULL_L1 + 3, FIELD_FULL_L1 + 4, FIELD_FULL_L1 + 5, FIELD_FULL_L1
                + 6 }, // FIELD_FULL 0x01

        { FIELD_CLAIMING, FCLAIM_L1, FCLAIM_L1 + 1, FCLAIM_L1 + 2,
        FCLAIM_L1 + 3, FCLAIM_L1 + 4, FCLAIM_L1 + 5, FCLAIM_L1 + 6 }, // FIELD_CLAMING 0x02
        };

//Animationen zur linken Seite
const unsigned char animationenLeftRight[3][8] = { { FIELD_CLAIMING,
FCLAIM_R1, FCLAIM_R1 + 1, FCLAIM_R1 + 2,
FCLAIM_R1 + 3, FCLAIM_R1 + 4, FCLAIM_R1 + 5,
FCLAIM_R1 + 6 }, // FIELD_EMPTY 0x00
        { FIELD_FULL, FIELD_FULL_R1, FIELD_FULL_R1 + 1, FIELD_FULL_R1 + 2,
        FIELD_FULL_R1 + 3, FIELD_FULL_R1 + 4, FIELD_FULL_R1 + 5, FIELD_FULL_R1
                + 6 }, // FIELD_FULL 0x01

        { FIELD_CLAIMING, FCLAIM_R1, FCLAIM_R1 + 1,
        FCLAIM_R1 + 2,
        FCLAIM_R1 + 3, FCLAIM_R1 + 4, FCLAIM_R1 + 5,
        FCLAIM_R1 + 6 }, // FIELD_CLAMING 0x02

        };

const unsigned char animationenLeftLeft[3][8] = { { FIELD_CLAIMING_MAN, //phase 0
        FCLAIM_L1,  //phase 1
        FCLAIM_L1 + 1, //phase 2
        FCLAIM_L1 + 2, //phase 3
        FCLAIM_L1 + 3, //phase 4
        FCLAIM_L1 + 4, //phase 5
        FCLAIM_L1 + 5, //phase 6
        FCLAIM_L1 + 6 //phase 7
}, // FIELD_EMPTY 0x00

        { FIELD_FULL_MAN, FIELD_FULL_L1, FIELD_FULL_L1 + 1, FIELD_FULL_L1 + 2,
        FIELD_FULL_L1 + 3, FIELD_FULL_L1 + 4, FIELD_FULL_L1 + 5, FIELD_FULL_L1
                + 6 }, // FIELD_FULL 0x01

        { FIELD_CLAIMING_MAN, FCLAIM_L1, FCLAIM_L1 + 1, FCLAIM_L1 + 2,
        FCLAIM_L1 + 3, FCLAIM_L1 + 4, FCLAIM_L1 + 5, FCLAIM_L1 + 6 }, // FIELD_CLAMING 0x02
        };

const unsigned char * mapRightBottom;
const unsigned char * mapRightTop;
const unsigned char * mapLeftTop;
const unsigned char * mapLeftBottom;

inline void set_field(unsigned char x, unsigned char y, unsigned char c) {
    field[y * W + x] = c;
}

inline unsigned char get_field(unsigned char x, unsigned char y) {
    return field[y * W + x];
}

void pixel_man_left() {
    if (manX > 0 || phase_right) {
        unsigned char nextField, thisField;

        phase_right--;
        phase_right &= 7;
        if (phase_right == 7) {
            manPtr--;
            manX--;
        }

        nextField = get_field(manX + 1, manY);
        thisField = get_field(manX, manY);
        if (thisField != FIELD_FULL) {
            set_field(manX, manY, FIELD_CLAIMING);
        }
        mapLeftBottom = animationenLeftRight[nextField];
        mapLeftTop = animationenLeftLeft[thisField];

        if (phase_right == 0) {
            taskBits &= ~TASK_MAN_MOVE;
        } else {
            taskBits |= TASK_MAN_MOVE;
        }

        SET_SCREEN(manPtr, mapLeftTop[phase_right]);
        SET_SCREEN(manPtr + 1, mapLeftBottom[phase_right]);
    }
}

void pixel_man_right() {
    if (manX < SCR_WIDTH - 1) {
        unsigned char nextField, thisField;

        phase_right++;
        phase_right &= 7;

        nextField = get_field(manX + 1, manY);
        thisField = get_field(manX, manY);
        if (nextField != FIELD_FULL) {
            set_field(manX + 1, manY, FIELD_CLAIMING);
        }
        mapRightBottom = animationenRightRight[nextField];
        mapRightTop = animationenRightLeft[thisField];

        if (phase_right == 0) {
            taskBits &= ~TASK_MAN_MOVE;
        } else {
            taskBits |= TASK_MAN_MOVE;
        }

        SET_SCREEN(manPtr, mapRightTop[phase_right]);
        SET_SCREEN(manPtr + 1, mapRightBottom[phase_right]);

        if (phase_right == 0) {
            manPtr++;
            manX++;
        }
    }
}

unsigned char phase_down = 0;

const char mapDownTop[] = { FIELD_FULL, FIELD_FULL_T1, FIELD_FULL_T1 + 1,
FIELD_FULL_T1 + 2,
FIELD_FULL_T1 + 3, FIELD_FULL_T1 + 4, FIELD_FULL_T1 + 5, FIELD_FULL_T1 + 6 }; // FULL T1 T2 T2 T3 T5 T6 T7
const char mapDownBottom[] = { FIELD_FULL_MAN, FIELD_FULL_B1, FIELD_FULL_B1 + 1,
FIELD_FULL_B1 + 2,
FIELD_FULL_B1 + 3, FIELD_FULL_B1 + 4, FIELD_FULL_B1 + 5, FIELD_FULL_B1 + 6 }; // FULL+MAN B1 B2 B2 B3 B5 B6 B7

const char mapUpTop[] = { FIELD_FULL_MAN, FIELD_FULL_T1, FIELD_FULL_T1 + 1,
FIELD_FULL_T1 + 2,
FIELD_FULL_T1 + 3, FIELD_FULL_T1 + 4, FIELD_FULL_T1 + 5, FIELD_FULL_T1 + 6 }; // FULL+MAN T1 T2 T2 T3 T5 T6 T7
const char mapUpBottom[] = { FIELD_FULL, FIELD_FULL_B1, FIELD_FULL_B1 + 1,
FIELD_FULL_B1 + 2,
FIELD_FULL_B1 + 3, FIELD_FULL_B1 + 4, FIELD_FULL_B1 + 5, FIELD_FULL_B1 + 6 }; // FULL B1 B2 B2 B3 B5 B6 B7

void pixel_man_up() {
    if (manY > 0 || phase_down) {
        phase_down--;
        phase_down &= 7;

        if (phase_down == 7) {
            manPtr -= SCR_WIDTH;
            manY--;
        }
        SET_SCREEN(manPtr, mapUpTop[phase_down]);
        SET_SCREEN(manPtr+SCR_WIDTH, mapUpBottom[phase_down]);
        if (phase_down == 0) {
            taskBits &= ~TASK_MAN_MOVE;
        } else {
            taskBits |= TASK_MAN_MOVE;
        }
    }
}

void pixel_man_down() {
    if (manY < SCR_HEIGHT - 2) {
        unsigned char nextField, thisField;

        phase_down++;
        phase_down &= 7;

        nextField = get_field(manX + 1, manY);
        thisField = get_field(manX, manY);
        if (nextField != FIELD_FULL) {
            set_field(manX + 1, manY, FIELD_CLAIMING);
        }
        mapRightBottom = animationenRightRight[nextField];
        mapRightTop = animationenRightLeft[thisField];

        if (phase_down == 0) {
            taskBits &= ~TASK_MAN_MOVE;
        } else {
            taskBits |= TASK_MAN_MOVE;
        }

        SET_SCREEN(manPtr, mapDownTop[phase_down]);
        SET_SCREEN(manPtr+SCR_WIDTH, mapDownBottom[phase_down]);
        if (phase_down == 0) {
            manPtr += SCR_WIDTH;
            manY++;
        }
    }
}

#ifndef __SDCC
int usleep(unsigned long usec);
#endif

void check_for_tasks2() {
    while (taskBits != 0) {
        if (taskBits & TASK_MAN_MOVE) {
            unsigned char tmpKeyInput = get_input();
            switch (keyInput) {
            case CURSOR_LEFT:
                pixel_man_left();
                break;
            case CURSOR_RIGHT:
                pixel_man_right();
                break;
            case CURSOR_DOWN:
                pixel_man_down();
                break;
            case CURSOR_UP:
                pixel_man_up();
                break;
            default:
                break;
            }
            /*            unsigned char tmpKeyInput=get_input();
             if (tmpKeyInput!=0)
             {
             keyInput=tmpKeyInput;
             }

             if (keyInput==CURSOR_DOWN)
             {
             pixel_man_down();
             } else
             {
             pixel_man_up();
             }
             */
#ifdef __SDCC
            DELAY();
#endif
        }
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


/*
int main2() {

    clrscr();
    _setcursortype(_NOCURSOR);
    // border();
    man_init();
    ball_init();

    for (;;) {
        unsigned char c;
        ball_move();

        c = z1013_spvt_poll();
        switch (c) {
        case 0x03:
        case 0x1b:
            goto end;
            break;
        case 0x08:
            man_left();
            break;
        case 0x09:
            man_right();
            break;
        case 0x0a:
            man_down();
            break;
        case 0x0b:
            man_up();
            break;
        default:
            break;
        }
#ifndef __SDCC
        if (c != 0)
            printf("GCC c=%x\n", c);
        usleep(100000);
#else
        DELAY();
#endif
    }
    end: return 0;
}
*/

/*
 screen10:	;blinkcursor ein
 push	hl
 ld	hl,(curs)
 ld	de,0fc00h	; -400h
 add	hl,de		;Adr. Farbspeicher
 set	7,(hl)		;Blinken aus
 pop	hl
 screen10a:
 ld	a, 0		; Grafik aus
 jr	screen12
 ;
 screen11:	;blinkcursor aus
 push	hl
 ld	hl,(curs)
 ld	de,0fc00h	; -400h
 add	hl,de		;Adr. Farbspeicher
 res	7,(hl)		;Blinken aus
 pop	hl
 */

int main() {
    krt_init();
    krt_font_install(xonix_font, 0, sizeof(xonix_font) / 8); //zeichen 0x00..0x1F
    krt_font_install(xonix_animations, 0x88, sizeof(xonix_animations) / 8); //Zeichen >0x80
    krt_font_install(computer_font, 0x20, sizeof(computer_font) / 8);
    title_screen();
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

