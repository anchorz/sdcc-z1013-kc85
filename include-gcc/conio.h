/* http://conio.sourceforge.net/docs/conio.pdf */

extern void clrscr( void);

#define _NOCURSOR 0
#define _SOLIDCURSOR 100
void _setcursortype (int type);

extern unsigned char cputs( const char *str);
