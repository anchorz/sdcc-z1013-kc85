#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    const unsigned char *name;
    const unsigned char *ptr;
    const unsigned int *len;
} MENU_ENTRY;

extern char menuEntriesCount;
extern const MENU_ENTRY menuEntries[];

#define MENU_W 18
#define MENU_X ((SCR_WIDTH-MENU_W-1)/2)
#define MENU_Y 5

#define MENUITEM_END (MENU_Y-1)

/*void msgbox(int x, int y, int w, int h) {

    for (int j = 0; j < h; j++) {
        y++;
        gotoxy(x, y);
        putch('\x9f');
        for (int i = 0; i < w; i++)
            putch(' ');
        putch('\xc0');
        putch('\xb4');
    }
    y++;
    gotoxy(x, y);
    putch('\x88');
    for (int i = w + 1; --i;)
        putch('\xf8');
    putch('\xc8');
    putch('\xb4');

    y++;
    gotoxy(x, y);
    putch('\xb1');
    for (int i = w + 2; --i;)
        putch('\xb6');
    cputs("\xb0");
}
*/
void draw_main_menu() {
    char idx = MENU_Y + 1;

    for (int i = 0; i < menuEntriesCount; i++, idx += 2) {
        gotoxy(MENU_X + 4, idx);
        cputs(menuEntries[i].name);
    }
}

char active_item = (MENU_Y + 1);

unsigned char handle_main_menu() {
    char c;

    for (;;) {
        gotoxy(MENU_X + 1, active_item);
        cputs("->");
        gotoxy(MENU_X + MENU_W - 1, active_item);
        cputs("<-");
        c = getch();
        if (c == 0x0a) {
            gotoxy(MENU_X + 1, active_item);
            cputs("  ");
            gotoxy(MENU_X + MENU_W - 1, active_item);
            cputs("  ");
            active_item += 2;
            if (active_item > (MENU_Y + menuEntriesCount * 2))
                active_item = (MENU_Y + 1);
        } else if (c == 0x0b) {
            gotoxy(MENU_X + 1, active_item);
            cputs("  ");
            gotoxy(MENU_X + MENU_W - 1, active_item);
            cputs("  ");
            active_item -= 2;
            if (active_item == (MENU_Y - 1))
                active_item = (MENU_Y + menuEntriesCount * 2 - 1);
        }
        if (c == 0x0d) {
            break;
        }
        if (c == 0x1b) {
            return MENUITEM_END;
        }
    }
    return (active_item - MENU_Y - 1) / 2;
}

typedef struct {
    unsigned char * aadr;
    unsigned char * eadr;
    unsigned char * sadr;
} Z80Header;

void call(unsigned char *ptr) __z88dk_fastcall
{
    ptr;
    __asm__("ld sp,#0x90");
    __asm__("push hl");
    __asm__("ret");
}

unsigned char *aadr, *sadr;
unsigned int len;
Z80Header *header;

void execute(char item) __z88dk_fastcall
{
    header = (Z80Header*) menuEntries[item].ptr;
    aadr = header->aadr;
    sadr = header->sadr;
    len = *(unsigned int *) menuEntries[item].len;
    memcpy(aadr, menuEntries[item].ptr + 32, len);
    call(sadr);
}

char item;

extern void win_msgbox(unsigned char x, unsigned char y, unsigned char w,
        unsigned char h) __z88dk_callee;

int main() {
    clrscr();
    win_msgbox(MENU_X, MENU_Y, MENU_W, 2 * menuEntriesCount - 1);
/*
    do {
        gotoxy((SCR_WIDTH - 22) / 2, MENU_Y - 2);
        cputs("Z1013-128 VORFUEHRMODUS");
        msgbox(MENU_X, MENU_Y, 2, 2 * menuEntriesCount - 1);
        draw_main_menu();
        item = handle_main_menu();
        if (item == menuEntriesCount - 1)
            break;
        else
            execute(item);
    } while (item != MENUITEM_END);

    __asm__("jp 0xf000");*/
    return 0;
}
