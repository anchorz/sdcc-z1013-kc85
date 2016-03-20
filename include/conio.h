/*
 * conio.h
 *
 * references:
 * http://en.wikipedia.org/wiki/Conio.h
 * http://code-reference.com/c/conio.h
 * http://conio.sourceforge.net/docs/conio.pdf
 *
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


// colors for text and background
#define BLACK         ( 0)
#define BLUE          ( 1)
#define RED           ( 2)
#define MAGENTA       ( 3)
#define GREEN         ( 4)
#define CYAN          ( 5)
#define BROWN         ( 6)
#define DARKGRAY      ( 7)
// additional colors for text
#define LIGHTBLACK    ( 8)   
#define LIGHTBLUE     ( 9)
#define LIGHTRED      (10)
#define LIGHTMAGENTA  (11)  
#define LIGHTGREEN    (12)
#define LIGHTCYAN     (13)
#ifndef YELLOW
#define YELLOW        (14)
#endif
#ifndef WHITE
#define WHITE         (15)
#endif
// text colors can blink
#define BLINK         (16)





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
 */
extern char* cgets( char* str);


/*
 * clrscr - Clears the screen.
 */
extern void clrscr( void);


/*
 * cputs - Writes a string directly to the console.
 */
extern unsigned char cputs( const char *str);


/*
 * delline - Delete the current line (line on which is cursor)
 *  DON'T move lines below one line up
 */
extern void delline( void);


/*
 * getch - Reads a character directly from the
 *  console without buffer, and without echo.
 */
extern char getch( void);


/*
 * getche - Reads a character directly from the
 * console without buffer, but with echo.
 */
extern char getche( void);


/*
 * gotoxy - Moves cursor to the specified position
 */
extern void gotoxy( unsigned char x, unsigned char y);


/*
 * highvideo - Used to select the highlighted character. 
 */
extern void highvideo( void);


/*
 * kbhit - Determines if a keyboard key was pressed.
 */
extern char kbhit( void);


/*
 * lowvideo - Used to deselect the highlighted character. 
 */
extern void lowvideo( void);


/*
 * putch - Writes a character directly to the console.
 */
extern void putch( char);


/*
 * textbackground - change of current background color
 */
extern void textbackground( unsigned char color);


/*
 * textcolor - change the color of drawing text
 */
extern void textcolor( unsigned char color);


/*
 * textmode - Changes screen mode (in text mode)
 *  toggle HRG/normal mode
 */
extern void textmode( void);


/*
 * ungetch - Puts the character c back into the keyboard buffers.
 */
extern char ungetch( char c);


/*
 * wherex - Return current horizontal cursor position 
 */
extern int wherex( void);


/*
 * wherey - Return current vertical cursor position 
 */
extern int wherey( void);


/*
 * window - Defines the active text mode window. 
 */
extern void window(unsigned char left, unsigned char top, unsigned char right, unsigned char bottom);

