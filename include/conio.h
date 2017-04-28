/*
 * conio.h
 *
 * references:
 * http://en.wikipedia.org/wiki/Conio.h
 * http://code-reference.com/c/conio.h
 * http://conio.sourceforge.net/docs/conio.pdf
 * http://www.programmingsimplified.com/c/conio.h
 * version for KC85
 *
 * supported functions:
 *  cgets
 *  clrscr
 *  cputs
 *  delline
 *  getch
 *  getche
 *  gotoxy
 *  highvideo
 *  kbhit
 *  lowvideo
 *  putch
 *  textbackground
 *  textcolor
 *  textmode
 *  ungetch
 *  wherex
 *  wherey
 *  window
 *
 *
 * actually NOT supported functions:
 *  - clreol
 *  - cprintf
 *  - cscanf
 *  - getpass
 *  - gettext (could use UP28h, UP29h, 32h, 34h)
 *  - gettextinfo
 *  - insline
 *  - movetext
 *  - normvideo
 *  - puttext
 */
#ifdef __GNUC__
#define __z88dk_fastcall
#define __z88dk_callee
#endif

// colors for text and background
#ifdef __KC85__

#define BLACK         ( 0)
#define BLUE          ( 1)
#define RED           ( 2)
#define MAGENTA       ( 3)
#define GREEN         ( 4)
#define CYAN          ( 5)
#define BROWN         ( 6)
#define YELLOW        ( 6)
#define DARKGRAY      ( 7)
#define WHITE         ( 7)
// text colors can blink
#define BLINK         (16)

#elif defined(__Z9001__)
#define SCR_WIDTH  40
#define SCR_HEIGHT 24

#define BLACK         ( 0)
#define RED           ( 1)
#define GREEN         ( 2)
#define YELLOW        ( 3)
#define BLUE          ( 4)
#define MAGENTA       ( 5)
#define CYAN          ( 6)
#define WHITE         ( 7)

#define BLINK         (0x80)
#else
#define BLACK         ( 0)
#define RED           ( 1)
#define GREEN         ( 2)
#define YELLOW        ( 3)
#define BLUE          ( 4)
#define MAGENTA       ( 5)
#define CYAN          ( 6)
#define WHITE         ( 7)

#endif

/*
 * cscanf - Reads formatted values directly from the console.
 */
//extern unsigned char cscanf( void);
/*
 * cprintf - Formats values and writes them directly to the console.
 */
//extern unsigned char cprintf( void);
/*
 * cgets - Reads a string directly from the console.
 *
 * The cgets function gets a character string from the console and
 * stores it in the character array pointed to by buffer.
 * The array's first element, buffer[0], must contain the maximum
 * length, in characters, of the string to be read. The array's
 * second element, buffer[1], is where cgets stores the string's
 * actual length _cgets reads characters until it reads the
 * carriage-return/line-feed combination or the specifed maximum
 * number of characters.
 *
 * Return Value:
 * A pointer to the start of the string at buffer[2].
 * Returns no error.
 */
extern char* cgets(char* str);

/*
 * clrscr - Clear the whole screen and put the cursor into the top left corner
 */
extern void clrscr(void);

#define _NOCURSOR 0
#define _SOLIDCURSOR 100
void _setcursortype(int type);
/*
 screen10:  ;blinkcursor ein
 push   hl
 ld hl,(curs)
 ld de,0fc00h   ; -400h
 add    hl,de       ;Adr. Farbspeicher
 set    7,(hl)      ;Blinken aus
 pop    hl
 screen10a:
 ld a, 0        ; Grafik aus
 jr screen12
 ;
 screen11:  ;blinkcursor aus
 push   hl
 ld hl,(curs)
 ld de,0fc00h   ; -400h
 add    hl,de       ;Adr. Farbspeicher
 res    7,(hl)      ;Blinken aus
 pop    hl
 */

/*
 * cputs - Writes a string directly to the console. The newline character is not here appended to the string.
 */
extern unsigned char cputs(const char *str)
__z88dk_fastcall;

/*
 * delline - Delete the current line (line on which is cursor)
 *  DON'T move lines below one line up
 */
extern void delline(void);

/*
 * getch - Reads a character directly from the
 *  console without buffer, and without echo.
 */
extern char getch(void);

/*
 * getche - Reads a character directly from the
 * console without buffer, but with echo.
 */
extern char getche(void);

/*
 * gotoxy - Moves cursor to the specified position
 */
extern void gotoxy(unsigned char x, unsigned char y)
__z88dk_callee;

/*
 * highvideo - Used to select the highlighted character. 
 */
extern void highvideo(void);

/*
 * kbhit - Determines if a keyboard key was pressed.
 */
extern char kbhit(void);

/*
 * lowvideo - Used to deselect the highlighted character. 
 */
extern void lowvideo(void);

/*
 * putch - Writes a character directly to the console.
 */
extern void putch(char)
__z88dk_fastcall;

/*
 * textbackground - change of current background color
 */
extern void textbackground(unsigned char color)
__z88dk_fastcall;

/*
 * textcolor - change the color of drawing text
 */
extern void textcolor(unsigned char color)
__z88dk_fastcall;

/*
 * textmode - Changes screen mode (in text mode)
 *  toggle HRG/normal mode
 */
extern void textmode(void);

/*
 * ungetch - Puts the character c back into the keyboard buffers.
 */
extern char ungetch(char c);

/*
 * wherex - Return current horizontal cursor position 
 */
extern int wherex(void);

/*
 * wherey - Return current vertical cursor position 
 */
extern int wherey(void);

/*
 * window - Defines the active text mode window. 
 */
extern void window(unsigned char left, unsigned char top, unsigned char right,
		unsigned char bottom);

#ifdef __Z1013__
#define textcolor(X)
#define textbackground(X)
#define SCR_WIDTH  32
#define SCR_HEIGHT 32
#endif

#ifdef __GNUC__

#ifndef CONIO_RESOLUTION
#define CONIO_RESOLUTION R32X32
#endif

#if (CONIO_RESOLUTION==R32X32)
#define SCR_WIDTH  32
#define SCR_HEIGHT 32
#endif

#if (CONIO_RESOLUTION==R40X24)
#define SCR_WIDTH  40
#define SCR_HEIGHT 24
#endif
#endif
