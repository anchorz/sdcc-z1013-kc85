/*
 * realisierte Funktionen:
 crt
 kbd
 kbds
 bye
 kbdz
 colorup
 loop
 wait
 inlin
 errm
 hlhx
 hlde
 ahex
 cucp
 modu
 jump
 brkt
 space
 crlf
 home
 pude
 puse
 winin
 winak
 line
 circle
 sqr
 cstbt
 iniea
 inime
 zkout
 OSTR
 */

//////////////////////////
// Z80 common functions
//////////////////////////
extern unsigned char in( unsigned char port);
extern void          out( unsigned char port, unsigned char value);
extern unsigned char in16( unsigned int port);
extern void          out16( unsigned int port, unsigned char value);
extern unsigned char reg_r( void);
extern void          test_ix( void);


//////////////////////////
// KC85 IO definitions
//////////////////////////
__sfr __at 0x84 IO84H;      // IRM control, RAM8 bank sel
__sfr __at 0x86 IO86H;      // RAM4 bank, ROMC bank, CAOS ROMC

__sfr __at 0x88 PIOA_DATA;
__sfr __at 0x89 PIOB_DATA;
__sfr __at 0x8A PIOA_CTRL;  // ROME, RAM0, IRM, Keyboard, LED, ROMC
__sfr __at 0x8B PIOB_CTRL;  // Lautstärke, RAM8, blinken

__sfr __at 0x8C CTC0;
__sfr __at 0x8D CTC1;
__sfr __at 0x8E CTC2;
__sfr __at 0x8F CTC3;

__sfr __at 0x90 PIOJOY_DATA;
__sfr __at 0x91 PIOCEN_DATA;
__sfr __at 0x92 PIOJOY_CTRL;  // Joystick (M021)
__sfr __at 0x93 PIOCEN_CTRL;  // Drucker (M021)

__sfr __at 0x28 PIONETA_DATA;
__sfr __at 0x29 PIONETB_DATA;
__sfr __at 0x2a PIONETA_CTRL;
__sfr __at 0x2b PIONETB_CTRL;

__sfr __at 0x2c PIOUSBA_DATA;
__sfr __at 0x2d PIOUSBB_DATA;
__sfr __at 0x2e PIOUSBA_CTRL;
__sfr __at 0x2f PIOUSBB_CTRL;


//////////////////////////
// KC85 color definitions
//////////////////////////
#define BLACK   ( 0)
#define BLUE    ( 1)
#define RED     ( 2)
#define PURPLE  ( 3)
#define GREEN   ( 4)
#define CYAN    ( 5)
#define YELLOW  ( 6)
#define WHITE   ( 7)

// KC85 character define
#define BREAK   ( 0x03)
#define BEEP    ( 0x07)
#define CUL     ( 0x08)
#define CUR     ( 0x09)
#define CUD     ( 0x0a)
#define CUU     ( 0x0b)
#define CLS     ( 0x0c)
#define CR      ( 0x0d)
#define PAGE    ( 0x11)
#define SCROL   ( 0x12)
#define ESC     ( 0x1b)

//////////////////////////
// dont use colon (:) in OSTR, this gives assembler error
// (mabye a wrong construct with label or so)
#define OSTR( X) \
    __asm__( "call 0xf003"); \
    __asm__( ".db 0x23 ;OSTR"); \
    __asm__( ".asciz "#X"");


//////////////////////////
// KC85/CAOS specific functions
//////////////////////////


/*
 * Zeichenausgabe auf Bildschirm
 */
extern void crt( unsigned char);


/*
 * Tasteneingabe mit Einblendung des Cursors, 
 * wartet, bis Taste gedrückt bzw. liefert die 
 * Codefolge von vorher betätigter F-Taste
 * out:
 *   high - Taste
 *   low  - 1, Taste gedrückt
 */
extern unsigned char kbd( void);


/*
 * Tastenstatusabfrage ohne Quittierung 
 * der Taste
 *  high byte = Taste
 *  low byte  = 1, Taste gedrückt
 */
extern unsigned int kbds( void);


/*
 * Sprung auf RESET (Warmstart des Systems)
 */
extern void bye( void);


/*
 * Tastenstatusabfrage mit Quittierung 
 * der Taste (Autorepeat)
 *  high byte = Taste
 *  low byte  = Bit 0, Taste gedrückt
 */
extern unsigned int kbdz( void);


/*
 * Farbe einstellen
 */
extern void colorup( unsigned char argn, unsigned char foreground, unsigned char background);


/*
 * Rückgabe der Steuerung an CAOS ohne Speicherinitialisierung
 */
extern void loop( void);


/*
 * Warteschleife (tick = 6 ms)
 */
extern void wait( unsigned char t);


/*
 * Eingabe einer Zeile mit Funktion aller Cursortasten, 
 * Abschluss mit <ENTER> oder Abbruch <BRK>
 *
 *  Zeiger auf Adresse des Zeilenanfangs des eingestellten Fensters im Video-RAM
 */
extern char* inlin( void);


/*
 * Ausschrift des Textes „ERROR“
 */
extern void errm( void);


/*
 * Ausgabe des Wertes des Registers HL als Hexzahl
 * und danach ein Leerzeichen
 */
extern void hlhx( unsigned int);


/*
 * Ausgabe der Register HL und DE als Hexzahlen
 */
extern void hlde( unsigned int, unsigned int);


/*
 * Ausgabe Register A als Hexzahl
 */
extern void ahex( unsigned char);


/*
 * Komplementiere Cursor
 */
extern void cucp( void);


/*
 * Modulsteuerung
 *   = Lesen des Modultyps (anzahl < 2)
 *   = Aussenden des Steuercodes (anzahl ≥ 2)
 * out:
 *   high - Modultyp (Strukturbyte)
 *   low  - Modulsteuerbyte
 */
extern unsigned int modu( unsigned char anzahl, unsigned char steckplatz, unsigned char steuerbyte);


/*
 * Sprung in ein neues Betriebssystem, 
 *  Abschalten von CAOS-ROM, USER-ROM und aller Speichermodule.
 */
extern void jump( unsigned char modulsteckplatz);


/*
 * Test auf Unterbrechungsanforderung
 * out:
 *   high - Taste
 *   low  - 1, wenn BREAK
 *          0, sonst
 */
extern unsigned int brkt( void);


/*
 * Ausgabe eines Leerzeichens über UP-Nr. 24H
 */
extern void space( void);


/*
 * Ausgabe von „NEWLINE“ (Codes 0DH=CR und 0AH=LF)
 */
extern void crlf( void);


/*
 * Ausgabe des Steuerzeichens „HOME“ (Code 10H)
 */
extern void home( void);


/*
 * Löschen eines Bildpunktes
 * MSB = Farbbyte
 * LSB = Status 
 *   Bit 0 (CY) = 1, Punkt außerhalb 
 *   Bit 6 (Z)  = 1, Punkt nicht gesetzt
 */
extern unsigned int pude( unsigned int x, unsigned char y);


/*
 * Setzen eines Bildpunktes
 *
 * Bedeutung von color:
 *   Bit 0 = 1 XOR-Funktion
 *   Bit 1 = 1 Linie löschen
 *   Bit 3 - 7 Farbe (Vordergrund)
 */
extern unsigned int puse( unsigned int x, unsigned char y, unsigned char color);


/*
 * Initialisierung eines neuen Fensters
 *  in:
 *   Fensternummer
 *   links
 *   oben
 *   Spalten
 *   Zeilen
 *  out:
 *   Bit 0 = 1, Fehler
 */
extern unsigned char winin( unsigned char links, unsigned char oben, unsigned char spalten, unsigned char zeilen, unsigned char nr);


/*
 * Aufruf eines Fensters über seine Nummer 
 * mit Abspeicherung des aktuellen Fenstervektors
 *  in:
 *   Fensternummer
 */
extern unsigned char winak( unsigned char nr);


/*
 * Zeichnen einer Linie mit dem eingestellten Linientyp
 * auf dem Bildschirm von X0/Y0 nach X1/ Y1
 *
 * Bedeutung von color:
 *   Bit 0 = 1 XOR-Funktion
 *   Bit 1 = 1 Linie löschen
 *   Bit 3 - 7 Farbe (Vordergrund)
 */
extern void line( unsigned int x0, unsigned int y0, unsigned int x1, unsigned int y1, unsigned char color);


/*
 * Zeichnen eines Kreises mit dem eingestellten Linientyp
 * auf dem Bildschirm mit Mittelpunkt XM/YM und Radius R
 *
 * Bedeutung von color:
 *   Bit 0 = 1 XOR-Funktion
 *   Bit 1 = 1 Linie löschen
 *   Bit 3 - 7 Farbe (Vordergrund)
 */
extern void circle( unsigned int xm, unsigned int ym, unsigned int r, unsigned char color);


/*
 * Berechnen der Quadratwurzel
 */
extern unsigned char sqr( unsigned int);

/*
 * Zeichenausgabe mit Negation des Bits 3 des Steuerbytes (STBT) 
 * des Bildschirmprogramms (Ausführung der Steuerzeichen/
 * Abbildung der Steuerzeichen)
 */
extern void cstbt( unsigned char);


/*
 * Initialisieren eines E/A-Kanals ueber Tabelle
 */
extern void iniea( unsigned char* table);


/*
 * Initialisieren mehrerer E/A-Kaenale ueber Tabelle(n)
 */
extern void inime( unsigned char* table, unsigned char count);


/*
 * Ausgabe einer über Register HL adressierten Zeichenkette
 */
extern void zkout( unsigned char*);



