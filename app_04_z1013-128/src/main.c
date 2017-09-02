#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <keys.h>
#include "menu.h"

static __at (0x800b) void (* execute)(unsigned int src,unsigned int des,unsigned int len,unsigned int start) __z88dk_callee;

#define MENU_W 21
#define MENU_X ((SCR_WIDTH-MENU_W-1)/2)
#define MENU_Y 5

//#define MENUITEM_END (MENU_Y-1)

void draw_main_menu() {
    char idx = MENU_Y + 1;

    for (int i = 0; i < menuEntriesCount; i++, idx += 2) {
        gotoxy(MENU_X + 4, idx);
        cputs(menuEntries[i].name);
    }
}

char active_item;

unsigned char handle_main_menu() {
    char c;

    for (;;) {
        gotoxy(MENU_X + 1, active_item * 2 + MENU_Y + 1);
        cputs("->");
        gotoxy(MENU_X + MENU_W - 1, active_item * 2 + 1 + MENU_Y);
        cputs("<-");
        c = getch();
        if (c == VK_DOWN) {
            gotoxy(MENU_X + 1, active_item * 2 + 1 + MENU_Y);
            cputs("  ");
            gotoxy(MENU_X + MENU_W - 1, active_item * 2 + 1 + MENU_Y);
            cputs("  ");
            active_item++;
            if (active_item >= menuEntriesCount)
                active_item = 0;
        } else if (c == VK_UP) {
            gotoxy(MENU_X + 1, active_item * 2 + 1 + MENU_Y);
            cputs("  ");
            gotoxy(MENU_X + MENU_W - 1, active_item * 2 + 1 + MENU_Y);
            cputs("  ");
            if (active_item == 0)
                active_item = menuEntriesCount;
            active_item--;
        }
        if (c == VK_ENTER) {
            break;
        }
        if (c == VK_ESCAPE) {
            return menuEntriesCount - 1;
        }
        if (c == VK_CTRL_C) {
            return menuEntriesCount - 1;
        }
    }
    //printf("%d ",active_item);
    return active_item;
}

void execute_item(char item) {
    execute(menuEntries[item].src, menuEntries[item].dst, menuEntries[item].len,
            menuEntries[item].start);
}

extern void win_msgbox(unsigned char x, unsigned char y, unsigned char w,
        unsigned char h)
__z88dk_callee;

int main() {

    char item;

    clrscr();
    menuEntriesCreate();

    do {
        gotoxy((SCR_WIDTH - 22) / 2, MENU_Y - 2);
        cputs("Z1013-128 VORFUEHRMODUS");
        win_msgbox(MENU_X, MENU_Y, MENU_W, 2 * menuEntriesCount - 1);
        draw_main_menu();
        item = handle_main_menu();
        if (item == menuEntriesCount - 1)
            break;
        else
            execute_item(item);
    } while (item != menuEntriesCount - 1);

    __asm__("jp 0xf000");
    return 0;
}
