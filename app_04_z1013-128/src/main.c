#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <keys.h>
#include <delay.h>
#include <z1013.h>

#include "menu.h"
#include "joystick.h"
#include "version.h"

#ifndef __SDCC
#define __z88dk_fastcall
#define __z88dk_callee
#define __naked
#define __sfr char
#define __banked
#define __at(X)
#define inline
#endif

extern void win_msgbox(unsigned char x, unsigned char y, unsigned char w,
        unsigned char h) __z88dk_callee;

void help();

extern const DIRECTORY dir;

#define MENU_W 24
#define MENU_X ((SCR_WIDTH-MENU_W-1)/2)
#define MENU_Y 5
#define MENU_H 9

char active_item;
char first_visible_item;
char last_item;
char cnt;

#define PROGRESS_BAR
#ifdef PROGRESS_BAR
#define PROGRESS_BAR_W 2
#endif

char getKey() __naked {
    __asm__("xor a");
    __asm__("ld (0x0004),a");
    __asm__("rst 0x20");
    __asm__(".db 0x04");
    __asm__("ld l,a");
    __asm__("ret");
}

char getchEx() {
    char c;
    mdelay(100);

    c = getKey();

    if (c) {
        return c;
    }

    c = joystick_get_selected();

    if (c == 0x07) {
        return VK_PAGE_UP; //PG_UP
    }
    if (c == 0x0b) {
        return VK_PAGE_DOWN; //PG_DOWN
    }
    if (!(c & 0x04)) {
        return VK_DOWN;
    }
    if (!(c & 0x08)) {
        return VK_UP;
    }
    if (!(c & 0x01)) {
        return VK_LEFT;
    }
    if (!(c & 0x02)) {
        return VK_RIGHT;
    }
    if (!(c & 0x10)) {
        return VK_ENTER;
    }
    return 0;
}

void print_name(const char *ptr) __z88dk_fastcall
{
    char len = 17;
    for (; --len;) {
        putch(*ptr++);
    }
}

void paint_items() {
    char count = MENU_H;
    const ENTRY *ptr = dir.menuEntries;
    char y = MENU_Y + 1;
    char id = first_visible_item;

    if (dir.menuEntriesCount < count)
        count = dir.menuEntriesCount;
    count++;
    ptr += first_visible_item;

    while (--count) {
        gotoxy(MENU_X + 1, y);
        if (active_item == id) {
            cputs("-> ");
        } else {
            cputs("   ");
        }
        print_name(ptr->name);
        if (active_item == id) {
            cputs(" <-");
        } else {
            cputs("   ");
        }
        ptr += 1;
        y += 2;
        id++;
    }
}

void cursor_next(char c) __z88dk_fastcall
{
    char *ptr=Z1013_CURSR;
    *ptr=c;
    ptr+=32;
    Z1013_CURSR=ptr;
}

void paint_scrollbar() {

    char checkLine;
    char cnt,height;
    int c;

    height=MENU_H*2-1;
    c = first_visible_item;
    c *= (MENU_H * 8 - 4);
    checkLine = c / dir.menuEntriesCount;
    GOTOXY(MENU_X + MENU_W, MENU_Y+1);
    cnt = checkLine >> 2;
    while (cnt) {
        cursor_next(' ');
        cnt--;
        height--;
    }
    cnt = checkLine & 0x03;
    if (cnt) {
        cursor_next(0xe8-cnt);
        height--;
    }
    checkLine = (MENU_H * (MENU_H * 8 - 4)) / dir.menuEntriesCount;
    checkLine -= cnt;
    cnt = checkLine >> 2;
    while (cnt) {
        cursor_next('\xe8');
        cnt--;
        height--;
    }
    cnt = checkLine & 0x03;
    if (cnt) {
        cursor_next(0xe8+cnt);
        height--;
    }
    cnt=height;
    while (cnt) {
        cursor_next(' ');
        cnt--;
    }
}

void paint() {
    paint_items();
    if (dir.menuEntriesCount > MENU_H) {
        paint_scrollbar();
    }
}

void handle_end() {
    char m;
    first_visible_item = last_item;
    m = dir.menuEntriesCount;
    --m;
    active_item = m;
}

void handle_home() {
    first_visible_item = 0;
    active_item = 0;
}

void handle_pg_down() {
    if (active_item < last_item)
        active_item += MENU_H;
    first_visible_item += MENU_H;
    if (first_visible_item > last_item)
        first_visible_item = last_item;
}

void handle_pg_up() {
    if (active_item < MENU_H)
        return;
    active_item -= MENU_H;
    if (first_visible_item >= MENU_H) {
        first_visible_item -= MENU_H;
    } else {
        first_visible_item = 0;
    }
}

void handle_down() {
    char m = active_item + 1;
    if (m < dir.menuEntriesCount) {
        char t = first_visible_item + MENU_H;
        if (m == t) {
            first_visible_item++;
        }
        active_item = m;
    }
}

void handle_up() {
    char m = active_item;
    if (m > 0) {
        char t = first_visible_item;
        if (m == t) {
            first_visible_item--;
        }
        active_item = m - 1;
    }
}

void paint_frame() {
    clrscr();
    gotoxy((SCR_WIDTH - 22) / 2, MENU_Y - 2);
    cputs("Z1013-128 VORFUEHRMODUS");
    win_msgbox(MENU_X, MENU_Y, MENU_W, 2 * MENU_H - 1);
    gotoxy(27, 31);
    cputs("R"VERSION);
}

unsigned char handle_main_menu() {
    for (;;) {
        char c = getchEx();
        switch (c) {
        case VK_END:
            handle_end();
            break;
        case VK_HOME:
            handle_home();
            break;
        case VK_PAGE_DOWN:
            handle_pg_down();
            break;
        case VK_PAGE_UP:
            handle_pg_up();
            break;
        case ' ':
        case VK_DOWN:
            handle_down();
            break;
        case 'U':
        case VK_UP:
            handle_up();
            break;
        case '?':
        case 'H':
            help();
            break;
        case VK_ENTER:
            return active_item;
        default:
            continue;
        }
        paint();
    }
}

void execute_item(const ENTRY * item) __z88dk_fastcall
{
    item = item;
    __asm__("ld de,#18");
    //add name[16]+hw+typ -> ENTRY.bankStart
    __asm__("add hl,de");
    __asm__("ld a,(hl)");
    //ENTRY.bankStart
    __asm__("inc hl");
    __asm__("ld e,(hl)");
    //ENTRY.bankOffset
    __asm__("inc hl");
    __asm__("ld d,(hl)");
    __asm__("inc hl");
    __asm__("ld c,(hl)");
    //ENTRY.length
    __asm__("inc hl");
    __asm__("ld b,(hl)");
    __asm__("call _banked_copy");
}

int main() __naked {

    char item;

    last_item = dir.menuEntriesCount - MENU_H;

    joystick_initialize();

    paint_frame();
    paint();
    do {
        item = handle_main_menu();
        if (item == dir.menuEntriesCount - 1)
            break;
        else
            execute_item(&dir.menuEntries[item]);
    } while (item != dir.menuEntriesCount - 1);

    __asm__("jp 0xf000");
}
