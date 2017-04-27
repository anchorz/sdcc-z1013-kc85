#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <delay.h>
#include <keys.h>

extern int menuBoxOfs;
#define MENU_W 15

static char buffer[MENU_W];

void scroll_demo() {

	do {
		char *dst = (void*) (menuBoxOfs + 0xec01+ SCR_WIDTH);
		char *src = (void*) (menuBoxOfs + 0xec01 + 2 * SCR_WIDTH);
		memcpy(buffer, dst, MENU_W);
		for (char c = 0; c < 6; c++) {
			memcpy(dst, src, MENU_W);
			dst += SCR_WIDTH;
			src += SCR_WIDTH;
		}
		memcpy(dst, buffer, MENU_W);
		mdelay(200);
		mdelay(200);
	} while (!kbhit());
}
