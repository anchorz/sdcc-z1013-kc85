#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
#include <delay.h>

#define MENU_W 15
#define BOX_W  29

#define BOX_X ((SCR_WIDTH-BOX_W-2)/2)
#define BOX_Y 1
#define MENU_X ((SCR_WIDTH-MENU_W-1)/2)
#define MENU_Y 5
unsigned char screenBackground = BLACK;
unsigned char boxBackground = BLUE;

const char *menuitems[] = { "PARABEL", "JOYSTICK", "SCROLLING", "ENDE" };
extern void joystick_demo();
extern void parabel_demo();
extern void scroll_demo();

typedef void (*VOID_FOO)();

VOID_FOO menufoo[] = { parabel_demo, joystick_demo, scroll_demo, NULL };
#define MENU_H (sizeof(menuitems)/sizeof(menuitems[0]))

#define MENUITEM_JOYSTICK 1
#define MENUITEM_END (MENU_Y-1)
void msgbox(int x, int y, int w, int h) {
	gotoxy(x, y);
	textbackground(boxBackground);
	putch('\xc1');
	for (int i = 0; i < w; i++)
		putch('\x9e');
	putch('\x89');
	textbackground(screenBackground);
	putch('\xb3');

	for (int j = 0; j < h; j++) {
		y++;
		gotoxy(x, y);
		textbackground(boxBackground);
		putch('\x9f');
		for (int i = 0; i < w; i++)
			putch(' ');
		putch('\xc0');
		textbackground(screenBackground);
		putch('\xb4');
	}
	y++;
	gotoxy(x, y);
	textbackground(boxBackground);
	putch('\x88');
	for (int i = w + 1; --i;)
		putch('\xf8');
	putch('\xc8');
	textbackground(screenBackground);
	putch('\xb4');

	y++;
	gotoxy(x, y);
	putch('\xb1');
	for (int i = w + 2; --i;)
		putch('\xb6');
	cputs("\xb0");
}

void draw_main_menu() {
	char idx = MENU_Y + 1;

	textbackground(boxBackground);
	for (int i = 0; i < sizeof(menuitems) / sizeof(menuitems[0]);
			i++, idx += 2) {
		gotoxy(MENU_X + 4, idx);
		cputs(menuitems[i]);
	}
}

char active_item = (MENU_Y + 1);

unsigned char handle_main_menu() {
	char c;
	textbackground(boxBackground);
	for (;;) {
		gotoxy(MENU_X + 1, active_item);
		cputs("->");
		gotoxy(MENU_X + 14, active_item);
		cputs("<-");
		mdelay(10); //Z1013 A2 Monitor sollte hier 200ms warten
		while (!kbhit()) {
		}
		c = getch();
		if (c == 0x0a) {
			gotoxy(MENU_X + 1, active_item);
			cputs("  ");
			gotoxy(MENU_X + 14, active_item);
			cputs("  ");
			active_item += 2;
			if (active_item > (MENU_Y + MENU_H * 2))
				active_item = (MENU_Y + 1);
		} else if (c == 0x0b) {
			gotoxy(MENU_X + 1, active_item);
			cputs("  ");
			gotoxy(MENU_X + 14, active_item);
			cputs("  ");
			active_item -= 2;
			if (active_item == (MENU_Y - 1))
				active_item = (MENU_Y + MENU_H * 2 - 1);
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

char text_buffer[16 + 3];
char *username;
unsigned char item;

int menuBoxOfs;

int main() {
	clrscr();
	textcolor(YELLOW);
	msgbox(BOX_X, BOX_Y, 29, 5);
	gotoxy(BOX_X + 1, BOX_Y + 1);
	textbackground(boxBackground);
	cputs("Hallo, dies ist ein Demo der");
	gotoxy(BOX_X + 1, BOX_Y + 2);
	cputs("CONIO Bibliothek.");
	gotoxy(BOX_X + 1, BOX_Y + 4);
	cputs("Geben Sie Ihren Namen ein: ");
	gotoxy(BOX_X + 1, BOX_Y + 5);

	text_buffer[0] = 8;
	username = cgets(text_buffer);

	clrscr();
	textbackground(screenBackground);
	cputs("Vielen Dank, ");
	cputs(username);
	cputs("!");

	menuBoxOfs=MENU_Y*SCR_WIDTH+MENU_X;
	do {
		boxBackground = MAGENTA;
		textcolor(YELLOW);
		msgbox(MENU_X, MENU_Y, MENU_W, 2 * MENU_H - 1);
		draw_main_menu();
		item = handle_main_menu();
		if (item == MENU_H - 1)
			break;
		else
			menufoo[item]();
	} while (item != MENUITEM_END);

	clrscr();
	textbackground(screenBackground);
	cputs("Das war's. Ende.");

	return 0;
}
