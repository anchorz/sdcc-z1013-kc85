#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <delay.h>
#include <keys.h>

extern char screenBackground;

// DATA-Zeilen kopiert aus R+MEMORY Programm
// 32 Zeichen + 1 verdeckt + 1 entfernt
char cmap[] = { 178, 255, 179, 182, 255, 182, 178, 255, 179, 32, 157, 32, 148,
		32, 151, 32, 154, 32, 188, 32, 189, 32, 255, 32, 187, 32, 186, 199, 32,
		199, 32, 199, 32, 199, 32, 199, 174, 199, 173, 199, 199, 199, 171, 199,
		172, 180, 180, 180, 180, 180, 180, 180, 180, 180, 200, 158, 136, 159,
		207, 192, 137, 248, 193, 190, 143, 32, 190, 143, 32, 190, 143, 32, 142,
		199, 191, 199, 199, 199, 143, 199, 190, 32, 131, 32, 129, 140, 128, 149,
		161, 146, 190, 191, 143, 142, 201, 190, 191, 143, 142, 142, 191, 191,
		142, 32, 190, 143, 143, 190, 131, 129, 128, 130, 175, 131, 129, 128,
		130, 255, 141, 255, 141, 255, 141, 255, 141, 255, 166, 160, 166, 161,
		32, 161, 166, 160, 166, 193, 154, 137, 151, 32, 148, 136, 157, 200, 175,
		175, 175, 175, 175, 175, 175, 175, 175, 174, 130, 173, 128, 140, 129,
		171, 131, 172, 175, 157, 175, 148, 32, 151, 175, 154, 175, 188, 189, 32,
		187, 186, 189, 32, 187, 186, 184, 184, 184, 184, 184, 184, 184, 184,
		184, 190, 32, 143, 191, 255, 142, 32, 255, 32, 174, 131, 173, 129, 140,
		128, 171, 130, 172, 193, 158, 137, 159, 196, 192, 171, 248, 172, 174,
		154, 173, 151, 140, 148, 171, 157, 172, 174, 173, 32, 171, 144, 173, 32,
		171, 172, 188, 182, 189, 180, 32, 181, 187, 183, 186, 140, 140, 140,
		140, 140, 140, 140, 140, 140, 174, 158, 173, 171, 248, 172, 32, 161, 32,
		200, 154, 136, 151, 32, 148, 137, 157, 193, 168, 164, 169, 163, 166,
		165, 167, 162, 170, 174, 158, 173, 255, 255, 255, 171, 248, 172, 199,
		199, 199, 199, 199, 199, 199, 199, 199, 32, 32, 32, 32, 32, 32, 32, 32,
		32 };

#define CH_WIDTH 3
#define CH_HEIGHT 3
#define CH_SIZE (CH_WIDTH*CH_HEIGHT)

//32 Zeichen + 2 extra (hidden&empty)
#define CH_ANZAHL 32
#define CH_HIDDEN 32
#define CH_EMPTY  33
//verdeckte Karte
#define CH_UNKNOWN 0xff

static char key;
static char select[CH_ANZAHL];
//Anzahl sichtbarer Karten := Zeilen x Spalten
//hängt von der Bildschirmauflösung ab
static char selectedX, selectedY;
static char visibleCardValue;
static char visibleCardX, visibleCardY;
static char cardsLeft,rounds;
static char _card[CH_ANZAHL * 2];

#define CARDS_PER_LINE ((SCR_WIDTH - 1) / (CH_WIDTH + 1)) 
#define LINES ((SCR_HEIGHT - 2) / (CH_HEIGHT + 1))
#define COUNT ((LINES * CARDS_PER_LINE)&0xfe)

static void initCards() {

	char *ptr = select;
	for (char c = 0; c < sizeof(select); c++) {
		*ptr++ = 0;
	}
	ptr = _card;
	//assert (count&1) - gerade Anzahl der Karten
	for (char c = 0; c < COUNT / 2; c++) {
		char choose;
		do {
			choose = rand() % (COUNT / 2);
		} while (select[choose]);
		select[choose] = 1;
		*ptr = choose;
		ptr++;
		*ptr = choose;
		ptr++;
	}
}

static void showCard(char x, char y, char id) {
	char * ptr = cmap + id * CH_SIZE;
	for (char l = 0; l < 3; l++) {
		gotoxy(x * (CH_WIDTH + 1) + 1, (y * (CH_HEIGHT + 1)) + l + 2);
		for (char i = 0; i < CH_WIDTH; i++) {
			putch(*ptr);
			ptr++;
		}
	}
}

static void shuffleCards() {
	for (char i = COUNT - 1; i > 0; i--) {
		char j = rand() % (i + 1);
		char tmp = _card[i];
		_card[i] = _card[j];
		_card[j] = tmp;
	}
}

static void eraseCardFrame() {
	char x = selectedX * (CH_WIDTH + 1);
	char y = selectedY * (CH_WIDTH + 1) + 1;
	gotoxy(x, y);
	for (char c = 0; c < CH_WIDTH + 2; c++)
		putch(' ');
	for (char l = 0; l < CH_HEIGHT; l++) {
		y++;
		gotoxy(x, y);
		putch(' ');
		gotoxy(x + CH_WIDTH + 1, y);
		putch(' ');
	}
	y++;
	gotoxy(x, y);
	for (char c = 0; c < CH_WIDTH + 2; c++)
		putch(' ');
}

static void selectCard(char x, char y) {
	eraseCardFrame();
	selectedX = x;
	selectedY = y;
	x *= CH_WIDTH + 1;
	y = selectedY * (CH_WIDTH + 1) + 1;
	gotoxy(x, y);
	putch('\xa8'); // ┏
	for (char c = 0; c < CH_WIDTH; c++)
		putch('\xa0'); // ━
	putch('\xa9'); // ┓
	for (char l = 0; l < CH_HEIGHT; l++) {
		y++;
		gotoxy(x, y);
		putch('\xa1'); // ┃
		gotoxy(x + CH_WIDTH + 1, y);
		putch('\xa1'); // ┃
	}
	y++;
	gotoxy(x, y);
	putch('\xa7'); // ┗
	for (char c = 0; c < CH_WIDTH; c++)
		putch('\xa0'); // ━
	putch('\xaa'); // ┛
}

static void handleRight() {
	char newX = selectedX + 1;
	char newY = selectedY;
	if (newX >= CARDS_PER_LINE) {
		newX = 0;
		newY++;
		if (newY >= LINES)
			return;
	}
	selectCard(newX, newY);
}

static void handleLeft() {
	signed char newX = selectedX - 1;
	signed char newY = selectedY;
	if (newX < 0) {
		newX = CARDS_PER_LINE - 1;
		newY--;
		if (newY < 0)
			return;
	}
	selectCard(newX, newY);
}

static void handleUp() {
	signed char newX = selectedX;
	signed char newY = selectedY - 1;
	if (newY < 0) {
		newY = LINES - 1;
		newX--;
		if (newX < 0)
			return;
	}
	selectCard(newX, newY);
}

static void handleDown() {
	char newX = selectedX;
	char newY = selectedY + 1;
	if (newY >= LINES) {
		newY = 0;
		newX++;
		if (newX >= CARDS_PER_LINE)
			return;
	}
	selectCard(newX, newY);
}

static void updateCardsLeft()
{
	char buffer[6];
	_uitoa(cardsLeft,buffer,10);
	gotoxy(7,0);
	cputs(buffer);
	putch(' ');
}

static void updateCardRounds()
{
	char buffer[6];
	_uitoa(rounds,buffer,10);
	gotoxy(21,0);
	cputs(buffer);
}

static void handleEnter() {
	char index, value;

	index = selectedY * CARDS_PER_LINE + selectedX;
	if (index >= COUNT) {
		return;
	}
	value = _card[index];

	if (visibleCardValue == CH_UNKNOWN) {
		if (value == CH_EMPTY) {
			return;
		}
		showCard(selectedX, selectedY, value);
		visibleCardX = selectedX;
		visibleCardY = selectedY;
		visibleCardValue = value;
		return;
	}
	if (visibleCardX == selectedX && visibleCardY == selectedY) {
		return;
	}
	if (value == CH_EMPTY) {
		return;
	}

	showCard(selectedX, selectedY, value);

	if (value != visibleCardValue) {
		rounds++;
		updateCardRounds();
		for (int c = 0; c < 8; c++) {
			if (kbhit())
				break;
			mdelay(200);
		}
		value = CH_HIDDEN;
	} else {
		cardsLeft--;
		updateCardsLeft();
		for (int c = 0; c < 5; c++) {
			if (kbhit())
				break;
			mdelay(200);
		}
		value = CH_EMPTY;
		_card[index] = value;
		_card[visibleCardY * CARDS_PER_LINE + visibleCardX] = value;
	}
	showCard(visibleCardX, visibleCardY, value);
	showCard(selectedX, selectedY, value);
	visibleCardValue = CH_UNKNOWN;
}

void joystick_demo() {

	char *ptr = cmap;
	char cnt = 0;
	char y = 0;
	cardsLeft=(COUNT/2);

	clrscr();
	textbackground(screenBackground);
	gotoxy(0,0);
	cputs("PAARE: ");
    updateCardsLeft();
	gotoxy(11,0);
	cputs("VERSUCHE: ");
    updateCardRounds();

    initCards();
	shuffleCards();
	visibleCardValue = CH_UNKNOWN;

	do {
		for (int x = 0; x < CARDS_PER_LINE; x++) {
			if (cnt < COUNT)
				showCard(x, y, CH_HIDDEN);
			cnt++;
		}
		y++;
	} while (cnt < COUNT);
	selectCard(0, 0);

	do {
		while (!kbhit())
			;
		key = getch();
		switch (key) {
		case VK_LEFT:
			handleLeft();
			break;
		case VK_RIGHT:
			handleRight();
			break;
		case VK_DOWN:
			handleDown();
			break;
		case VK_UP:
			handleUp();
			break;
		case VK_ENTER:
			handleEnter();
			break;
		default:
			break;
		}

	} while (key != VK_ESCAPE && key!=VK_CTRL_C && cardsLeft!=0);
}
