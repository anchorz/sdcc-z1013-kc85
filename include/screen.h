/*
 * new init code,
 * copy screen data to the right address,
 * call once at startup
 */
#include <string.h>
#include "screen_binary.h"

/*
 * check if screen is loaded in memory
 */
#define jump                 *(unsigned char*)0xba44
#define screen_not_found()   (jump != 0xd9)


/*
WIINIT  Initialisieren eines Fensters und Festlegen des Speicherraums
        Farbe und Cursorposition werden im Fenstervektorspeicher abgelegt
    HL  links, oben
    DE  Spalten, Zeilen
    A   Fensternummer
*/
extern void wiinit( unsigned char links, unsigned char oben, unsigned char spalten, unsigned char zeilen, unsigned char nr);


/*
WISAVE  Retten eines Fensters. Es werden ASCII-, Pixel- und Farb-RAM gerettet
    A   Fensternummer
*/
extern void wisave( unsigned char nr);


/*
WILOAD  Laden eines geretteten Fensters
    A   Fensternummer
*/
extern void wiload( unsigned char nr);


/*
ASME    Retten eines Fensters, nur ASCII-RAM
    A   Fensternummer
*/
extern void asme( unsigned char nr);


/*
MEAS    Laden eines Fensters, nur ASCII-RAM
    A   Fensternummer
*/
extern void meas( unsigned char nr);


/*
SHIFT   Verschieben eines aktuellen Fensters
    H   vertikal, Bit 7 = 1 Richtung
    L   horizontal
*/
extern void shift( signed char hor, signed char vert);


/*
INVZEI  Invertieren einer Zeile im aktuellen Fenster
    D   zu invertierende Zeile (bezogen auf Fenster)
*/
extern void invzei( unsigned char zeile);


/*
INVWIN  Invertieren eines aktuellen Fensters
*/
extern void invwin( void);


/*
RAHM    Das aktuelle Fenster wird eingerahmt
*/
extern void rahm( void);


/*
LRAHM   Der Rahmen des aktuellen Fensters wird gelöscht
*/
extern void lrahm( void);


/*
SHADOW  Um das aktuelle Fenster wird ein "Schattenrahmen" gezogen
*/
extern void shadow( void);


/*
LSHAD   Der Schattenrahmen des Fensters wird gelöscht
*/
extern void lshad( void);


/*
ICON    Ausgabe von Icons
    A   Iconnummer
    HL  Adresse der Icon-Tabelle
    DE  Ausgabeposition (links, oben)
*/
extern void icon( unsigned char iconnr, unsigned int *table, unsigned char spalte, unsigned char zeile);


/*
PRIAT   Ausgabe auf festgelegter Position (analog PRINT AT in BASIC)
    H   Zeile
    L   Spalte
    DE  Adresse des Textes
*/
extern void priat( unsigned char spalte, unsigned char zeile, char*);


/*
INPAT   Auf der festgelegten Position wird der Cursor plaziert und eine Eingabe erwartet
    DE  Adresse des Textes
*/
extern char* inpat( void);


/*
 * TITEL  ergaenzt Fenstertitel
 * Fenster wird automatisch um
 *  zwei Spalten und
 *  vier Zeilen verkleinert und mit
 *  Rahmen versehen
 */
extern void titel( char* titeltext);
