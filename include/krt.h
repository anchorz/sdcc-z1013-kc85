/*
 * initialisiert den Grafiktreiber schaltet in den Grafikmodus
 *
 * Beispiel für eine KRT Applikation:
 *
 * int main() {
 *   krt_init();
 *   krt_font_install(computer_font, 0x20, sizeof(computer_font) / 8);
 *   krt_clrscr(PIXEL_ERASE, COLOR_DEFAULT);
 *   krt_gotoxy(0, 0);
 *   krt_cputs("Punkte: ...... Leben: ..  30/80%");
 *  ...
 * }
 *
 * Anmerkung:
 * Beim Z9001 werden z.B. dabei die Systemzellen ab 0xEFC0 mit in den Grafikspeicher kopiert.
 */
void krt_init() __z88dk_callee;

/*
 * schaltet zurück in den Textmodus
 *
 */
void krt_off() __z88dk_callee;

/*
 * Füllt den Grafikspeicher mit dem Pixel- und Farbwert.
 *
 * PIXEL_ERASE    "löscht" den Speicher und füllt mit 0x00
 * PIXEL_FILL     setzt alle Pixel
 * PIXEL_CHECKER  setzt die Pixel alternierend schwarz/weiss
 *
 * Anmerkung:
 * Normalweise wäre zu erwarten, dass der Wert 0xff weiße Punkte setzt. Auf manchen Z1013 erfolgt allerdings die Darstellung
 * invers. Unabhängig davon wird hier der Wert 0x00 als gelöscht definiert.
 *
 * Der Farbwert wird nur für den Z9001 deren Nachfolger verwendet.
 * krt_clrscr((ATTR_BLINK|COLOR_FG_RED|COLOR_BG_BLACK),PIXEL_ERASE)
 */

#define PIXEL_ERASE    0x0000
#define PIXEL_FILL     0x00ff
#define PIXEL_CHECKER  0x00aa

#define COLOR_DEFAULT   (COLOR_FG_WHITE|COLOR_BG_BLACK)

#define COLOR_BG_BLACK   0x00
#define COLOR_BG_RED     0x01
#define COLOR_BG_GREEN   0x02
#define COLOR_BG_YELLOW  0x03
#define COLOR_BG_BLUE    0x04
#define COLOR_BG_MAGENTA 0x05
#define COLOR_BG_CYAN    0x06
#define COLOR_BG_WHITE   0x07

#define COLOR_FG_BLACK   0x00
#define COLOR_FG_RED     0x10
#define COLOR_FG_GREEN   0x20
#define COLOR_FG_YELLOW  0x30
#define COLOR_FG_BLUE    0x40
#define COLOR_FG_MAGENTA 0x50
#define COLOR_FG_CYAN    0x60
#define COLOR_FG_WHITE   0x70

#define ATTR_BLINK       0x80

void krt_clrscr(unsigned int pixel, unsigned int color) __z88dk_callee;

/*
 * zeichnet das vorgegebene Zeichen 'c' and die angegebene Bildschirmposition
 *
 * Anmerkung:
 * Die Annahme ist hier im Moment, dass alle Zeichen 8-Bit bzw. 1 Byte breit sind, so dass
 * ptr++ gleich auf das nächste Zeichen zeigt. Das muss nicht immer so bleiben.
 *
 */
void krt_putchar(unsigned char *ptr, unsigned int c, unsigned int color) __z88dk_callee;

/*
 * liefert die Breite eine Bildschirmzeile in Bytes
 *
 * Anmerkung:
 * Der Wert kann sich zur Laufzeit ändern, wenn z.B. eine andere Bildschirmauflösung
 * 64x32 oder 80x24 eingeschalten wird.
 */
unsigned char krt_get_screen_width() __z88dk_callee;

/*
 * liefert Anzahl der Bildschirmzeilen
 *
 * Anmerkung:
 * Der Wert kann sich zur Laufzeit ändern, wenn z.B. eine andere Bildschirmauflösung
 * 64x32 oder 80x24 eingeschalten wird.
 */
unsigned char krt_get_screen_height() __z88dk_callee;

/*
 * Kopiert 'length' Zeichen vom angegebenen Zeichensatz 'source' in den Fontpuffer
 * an das Zeichen 'firstCharacter'.
 *
 * Man kann aus mehreren Zeichensätzen so einen neuen zusammenkopieren.
 *
 * Anmerkung:
 * Aus Geschwindigkeitsgründen kann der Fontpuffer in einem anderen Speicherbereich liegen, um
 * so z.B. in der selben Bank wie der Bildschirmspeicher zu liegen oder ggf der Originalfont kann
 * intern auch umgearbeitet werden um Inversdarstellung auszugleichen.
 *
 * Intern können mehr als 256 Zeichen unterstützt werden, z.B. für UTF-8 Zeichen, die nicht im normalen
 * Zeichensatz vorhanden sind.
 *
 */
void krt_font_install(unsigned char *source, unsigned int firstCharacter,
        unsigned int length) __z88dk_callee;

void krt_gotoxy(unsigned int x, unsigned int y) __z88dk_callee;
void krt_cputs(unsigned char *str)
__z88dk_callee;
