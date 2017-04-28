/*
 Unschön:
 - Übergabe bei shift nicht im signed-Format
 - beim Laden und Speichern im Pixel bzw. Farb-RAM wird nach jedem Schritt
 geprüft, ob der nächste M011-RAm-Bereich aktiviert werden muss

 Fehler, gefixt:
 - Rahmen und Schatten werden bei großen X-Werten falsch berechnet.
 - wisave oder wiload restaurieren den Farb-RAM bei Fullscreen nicht korrekt.

 */

#include <stdio.h>
#include <stdint.h>
#include <caos.h>
#include <conio.h>
#include <screen.h>

void screen_init(void) {
    int i;
    char *dst = (void *) 0xba00;
    const char *src = screen_binary;
    //memcpy( (void *) 0xba00, &screen_binary , SCREEN_BINARY_LENGTH);
    for (i = 0; i < SCREEN_BINARY_LENGTH; i++) {
        char c = *src;
        *dst = c;
        src++;
        dst++;
    }
}

#define syscolor  *(volatile uint8_t*)0xb7a3

////////////////////////////////////////////////////////////
// Icon-/Symboldefinitioen

const unsigned char screen_logo[] = { 2, 2, 0x00, 0xaa, 0x55, 0xaa, 0x80, 0x81,
        0x83, 0x83, 0x00, 0xaa, 0x55, 0xaa, 0x01, 0xc1, 0x21, 0x01, 0x80, 0x80,
        0x86, 0x83, 0x80, 0xff, 0x00, 0x00, 0xc1, 0x61, 0x61, 0xc1, 0x01, 0xff,
        0x00, 0x00 };

const unsigned char floppy[] = { 2,
        2, //floppy 5 1/4
        0x00, 0x7F, 0x41, 0x41, 0x41, 0x7F, 0x7F, 0x7E, 0x00, 0xFE, 0xFE, 0xFE,
        0xFE, 0xFE, 0x7E, 0x3E,

        0x7F, 0x7F, 0x7F, 0x7F, 0x7F, 0x7F, 0x7F, 0x00, 0x7E, 0xFE, 0x7E, 0x7E,
        0x7E, 0x7E, 0xFE, 0x00,

        2,
        2, // floppy 3 1/2
        0x00, 0x00, 0x00, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x00, 0x00, 0x00, 0xF8,
        0xF8, 0xF8, 0xF8, 0xF8,

        0x1F, 0x18, 0x1B, 0x1B, 0x1B, 0x0F, 0x00, 0x00, 0xF8, 0x18, 0x18, 0x18,
        0x18, 0xF8, 0x00, 0x00,

        2,
        2, // hard disk
        0x00, 0x3F, 0x23, 0x24, 0x28, 0x30, 0x30, 0x30, 0x00, 0xFC, 0xC4, 0x24,
        0x14, 0x0C, 0x0C, 0xCC,

        0x31, 0x2F, 0x3E, 0x3D, 0x3F, 0x3F, 0x3F, 0x00, 0x8C, 0x14, 0x24, 0xC4,
        0x04, 0x04, 0xFC, 0x00, };

const unsigned char folder[] = { 2, 2, 0x00, 0x00, 0x00, 0x0F, 0x11, 0x20, 0x20,
        0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFC, 0x04, 0x04,

        0x20, 0x20, 0x20, 0x20, 0x3F, 0x00, 0x00, 0x00, 0x04, 0x04, 0x04, 0x04,
        0xFC, 0x00, 0x00, 0x00, 2,
        2, // folder_open
        0x00, 0x00, 0x00, 0x0F, 0x11, 0x20, 0x20, 0x2F, 0x00, 0x00, 0x00, 0x00,
        0x00, 0xFC, 0x04, 0xFE,

        0x28, 0x28, 0x30, 0x30, 0x3F, 0x00, 0x00, 0x00, 0x02, 0x02, 0x04, 0x04,
        0xFC, 0x00, 0x00, 0x00, };

const unsigned char home_icon[] = { 2, 2, 0x00, 0x19, 0x1B, 0x1E, 0x1C, 0x18,
        0x30, 0x60, 0x00, 0x80, 0xC0, 0x60, 0x30, 0x18, 0x0C, 0x06,

        0x2E, 0x2A, 0x2E, 0x20, 0x20, 0x20, 0x3F, 0x00, 0xF4, 0x94, 0x94, 0x94,
        0x94, 0x94, 0xFC, 0x00, };

const unsigned char kc85_4[] = { 4, 1, 0xFF, 0xBF, 0xBF, 0x80, 0x89, 0x80, 0xFF,
        0x18, 0xFF, 0xE7, 0xE7, 0x00, 0x00, 0x00, 0xFF, 0x00, 0xFF, 0xFC, 0xFC,
        0x00, 0x18, 0x00, 0xFF, 0x00, 0xFE, 0x02, 0x02, 0x02, 0x62, 0x02, 0xFE,
        0x18, };

const unsigned char kc85_D002[] = { 4, 1, 0xFF, 0xBF, 0xBF, 0x80, 0xBF, 0xBF,
        0xFF, 0x18, 0xFF, 0xE7, 0xE7, 0x00, 0xE7, 0xE7, 0xFF, 0x00, 0xFF, 0xFC,
        0xFC, 0x00, 0xFC, 0xFC, 0xFF, 0x00, 0xFE, 0x02, 0x02, 0x02, 0x62, 0x02,
        0xFE, 0x18, };

const unsigned char kc85_D004[] = { 4, 1, 0xFF, 0x80, 0x80, 0x80, 0xBF, 0xBF,
        0xFF, 0x18, 0xFF, 0x00, 0x00, 0x00, 0xE7, 0xE7, 0xFF, 0x00, 0xFF, 0x00,
        0x00, 0x00, 0xFC, 0xFC, 0xFF, 0x00, 0xFE, 0x02, 0x02, 0x02, 0x62, 0x02,
        0xFE, 0x18, };

const unsigned char kc85_floppy[] = { 4, 1, 0xFF, 0x80, 0xBF, 0xBF, 0xBF, 0x80,
        0xFF, 0x18, 0xFF, 0x00, 0xFC, 0xFC, 0xFC, 0x00, 0xFF, 0x00, 0xFF, 0x00,
        0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0xFE, 0x02, 0x02, 0x02, 0x62, 0x02,
        0xFE, 0x18, };

const unsigned char keyboard[] =
        { 3, 2, 0x00, 0x00, 0x3F, 0x40, 0x5B, 0x40, 0x5B, 0x40, 0x00, 0x00,
                0xFF, 0x00, 0x6D, 0x00, 0x6D, 0x00, 0x40, 0x20, 0xFC, 0x02,
                0x92, 0x02, 0xAA, 0x02,

                0x4D, 0x40, 0x5B, 0x40, 0x43, 0x40, 0x3F, 0x00, 0xB6, 0x00,
                0x6D, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xD2, 0x02, 0x92, 0x02,
                0x82, 0x02, 0xFC, 0x00, };

const unsigned char tape[] = { 2, 2, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x7F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFE,

        0x4C, 0x5E, 0x5E, 0x4C, 0x43, 0x47, 0x7F, 0x00, 0x32, 0x7A, 0x7A, 0x32,
        0xC2, 0xE2, 0xFE, 0x00, 2,
        2, // tape_load
        0x00, 0x01, 0x03, 0x07, 0x01, 0x01, 0x00, 0x7F, 0x00, 0x80, 0xC0, 0xE0,
        0x80, 0x80, 0x00, 0xFE,

        0x4C, 0x5E, 0x5E, 0x4C, 0x43, 0x47, 0x7F, 0x00, 0x32, 0x7A, 0x7A, 0x32,
        0xC2, 0xE2, 0xFE, 0x00, 2,
        2, // tape_save
        0x00, 0x01, 0x01, 0x07, 0x03, 0x01, 0x00, 0x7F, 0x00, 0x80, 0x80, 0xE0,
        0xC0, 0x80, 0x00, 0xFE,

        0x4C, 0x5E, 0x5E, 0x4C, 0x43, 0x47, 0x7F, 0x00, 0x32, 0x7A, 0x7A, 0x32,
        0xC2, 0xE2, 0xFE, 0x00, };

void putstr(char *c) {
    while (*c != '\0') {
        putchar(*c);
        c++;
    }
}

enum winnr {
    original,
    startwin,
    menuwin,
    demowin,
    shiftwin,
    selectionwin,
    descrwin,
    iconwin,
    testwin
};

enum auswahl_t {
    rahmen, schatten, beides, verschieb, symbole, nutzung, ende, auswahl_anzahl
};

#define TEXTWIDTH  (40)
#define TEXTHEIGHT (32)

#define TRUE    ( 1 == 1)
#define FALSE   ( 1 != 1)

//////////////////////////////
// Unterprogramm für Fensterdemo
void fenster(uint8_t art) {
    uint8_t x;
    uint8_t y;
    uint8_t color = art;

    winak(original);
    textbackground(WHITE);
    clrscr();

    for (y = 0; y < 4; y++) {
        for (x = 0; x < 4; x++) {
            wiinit(3 + x * 9, 1 + y * 8, 7, 6, demowin);
            textbackground(color);
            clrscr();
            if ((art & 0x01) == 0x01)
                rahm();
            if ((art & 0x02) == 0x02)
                shadow();
            /*
             //priat( 1 , 1, "Fenster 1");
             */
            color += 5;
        }
    }
    while (!kbhit())
        ;
    getch();
}
//////////////////////////////
// Demo der shift-Funktion
// Leertaste -> invertieren
void winverschieb(void) {
    uint8_t eingabe;

    // Fenster anlegen
    wiinit( TEXTWIDTH / 2, TEXTHEIGHT / 2, 3, 3, shiftwin);
    textbackground(BLUE);
    clrscr();
    gotoxy(1, 0);
    cstbt(CUU);
    gotoxy(0, 1);
    cstbt(CUL);
    cstbt(0x00);
    cstbt(CUR);
    gotoxy(1, 2);
    cstbt(CUD);

    do {
        while (!kbhit())
            ;
        eingabe = getch();

        switch (eingabe) {
        case CUU:
            shift(0, (signed char) 0x81);
            break;
        case CUD:
            shift(0, 1);
            break;
        case CUL:
            shift((signed char) 0x81, 0);
            break;
        case CUR:
            shift(1, 0);
            break;
        case ' ':
            invwin();
            break;
        }
    } while (eingabe != BREAK && eingabe != CR);

}

//////////////////////////////
// Zeichnet KC-System mit unterschiedlichen Ausbaustufen (0..4)
void kcsystem(uint8_t size) {
    switch (size) {
    case 4:
        icon(0, (void *) &kc85_floppy, 2, 1);
        icon(0, (void *) &kc85_floppy, 2, 0);
    case 3:
        icon(0, (void *) &kc85_D004, 2, 2);
    case 2:
        icon(0, (void *) &kc85_D002, 2, 3);
    case 1:
        icon(0, (void *) &keyboard, 1, 5);
    case 0:
        icon(0, (void *) &kc85_4, 2, 4);
    }
}

//////////////////////////////
// Unterprogramm für Icondemo
void icon_menu() {
    const uint8_t icon_anzahl = 5;
    const uint8_t spalte = 3;
    uint8_t eingabe;
    uint8_t auswahl = 0;
    uint8_t subicon = 0;
    uint16_t count = 0;

    wiinit(4, 4, 21, icon_anzahl + 4, selectionwin);
    clrscr();
    rahm();
    shadow();

    priat(1, 1, "Home");
    priat(1, 2, "Ordner");
    priat(1, 3, "Laufwerke");
    priat(1, 4, "Kassette");
    priat(1, 5, "KC85");
    priat(1, icon_anzahl + 1, "Zur\175ck");

    // Iconbereich
    wiinit(17, 5, 7, 8, iconwin);
    // Menuebereich
    wiinit(5, 5, 12, icon_anzahl, descrwin);
    do {
        invzei(auswahl);

        count = 1;
        subicon = 0;
        while (!kbhit()) {
            if (count == 1) {
                winak(iconwin);
                clrscr();
                switch (auswahl) {
                case 0:
                    icon(0, (void *) &home_icon, spalte, 1);
                    break;
                case 1:
                    icon(subicon, (void *) &folder, spalte, 1);
                    subicon = (subicon + 1) % 2;
                    count = 5000;
                    break;
                case 2:
                    icon(subicon, (void *) &floppy, spalte, 1);
                    subicon = (subicon + 1) % 3;
                    count = 4000;
                    break;
                case 3:
                    icon(subicon, (void *) &tape, spalte, 1);
                    subicon = (subicon + 1) % 3;
                    count = 3000;
                    break;
                case 4:
                    kcsystem(subicon);
                    subicon = (subicon + 1) % 5;
                    count = 7000;
                    break;
                }
            }
            if (count > 0) {
                count--;
            }
        }
        eingabe = getch();

        winak(descrwin);
        invzei(auswahl);

        if (eingabe == CUU)
            auswahl = (auswahl > 0) ? auswahl - 1 : icon_anzahl;
        if (eingabe == CUD)
            auswahl = (auswahl + 1) % (icon_anzahl + 1);
        if (eingabe == PAGE)
            auswahl = 0;
        if (eingabe == SCROL)
            auswahl = icon_anzahl - 1;

    } while (eingabe != BREAK && eingabe != CR && eingabe != CUL);
}

void help_00() {
    putstr("Kurzerkl\173rung,");
    crlf();
    crlf();
    //       12345678901234567890123
    putstr("wie die Funktionen aus");
    crlf();
    putstr("screen.lib bzw.");
    crlf();
    putstr("screen.h in eigenen");
    crlf();
    putstr("C-Programmen genutzt");
    crlf();
    putstr("werden k\174nnen.");
    crlf();
    crlf();
    crlf();
    putstr("Hardwarevoraussetzung:");
    crlf();
    putstr("- KC85/4 oder KC85/5");
    crlf();
    putstr("- M011 64k-RAM-Modul");
    crlf();
    crlf();
    crlf();
    //       1234567890123456789012
    putstr("Das Einbinden erfolgt");
    crlf();
    putstr("im Quelltext mit:");
    crlf();
    crlf();
    putstr("#include <screen.h>");
    crlf();
    crlf();
    putstr("Beim Linken mu\176 der");
    crlf();
    putstr("Parameter \"-l screen\"");
    crlf();
    putstr("erg\173nzt werden.");
}

void help_01() {
    //       1234567890123456789012
    putstr("wiinit( ");
    crlf();
    putstr("    links,");
    crlf();
    putstr("    oben,");
    crlf();
    putstr("    breite,");
    crlf();
    putstr("    hoehe,");
    crlf();
    putstr("    fenster_nr);");
    crlf();
    crlf();
    //       1234567890123456789012
    putstr("Initialisiert ein");
    crlf();
    putstr("Fenster");
    crlf();
    crlf();
    putstr("Achtung, fenster_nr");
    crlf();
    putstr("mu\176 wegen der");
    crlf();
    putstr("Speicherverwaltung");
    crlf();
    putstr("aufsteigend vergeben");
    crlf();
    putstr("werden.");
    crlf();
    putstr("Es werden maximal 10");
    crlf();
    putstr("verschiedene Fenster");
    crlf();
    putstr("unterst\175tzt.");
    crlf();
    crlf();
    putstr(" siehe auch:");
    crlf();
    putstr("  wisave,");
    crlf();
    putstr("  wiload,");
    crlf();
    putstr("  rahm,");
    crlf();
    putstr("  shadow");
    crlf();
}

void help_02() {
    //       1234567890123456789012
    putstr("wisave( fenster_nr);");
    crlf();
    crlf();
    //       1234567890123456789012
    putstr("Sichert den");
    crlf();
    putstr("Fensterinhalt");
    crlf();
    crlf();
    putstr("Es werden Pixel-,");
    crlf();
    putstr("Farb- und ASCII-RAM");
    crlf();
    putstr("gesichert.");
    crlf();
    crlf();
    putstr(" siehe auch:");
    crlf();
    putstr("  wiload,");
    crlf();
    putstr("  asme");
    crlf();
}

void help_03() {
    //       1234567890123456789012
    putstr("wiload( fenster_nr);");
    crlf();
    crlf();
    //       1234567890123456789012
    putstr("Restauriert den");
    crlf();
    putstr("Fensterinhalt");
    crlf();
    crlf();
    putstr("Es werden Pixel-,");
    crlf();
    putstr("Farb- und ASCII-RAM");
    crlf();
    putstr("wiederhergestellt.");
    crlf();
    crlf();
    putstr(" siehe auch:");
    crlf();
    putstr("  wisave,");
    crlf();
    putstr("  meas");
    crlf();
}

void help_asme() {
    //       1234567890123456789012
    putstr("asme( fenster_nr);");
    crlf();
    crlf();
    //       1234567890123456789012
    putstr("Sichert den");
    crlf();
    putstr("Fensterinhalt");
    crlf();
    crlf();
    putstr("Es wird nur der");
    crlf();
    putstr("ASCII-RAM gesichert.");
    crlf();
    crlf();
    putstr(" siehe auch:");
    crlf();
    putstr("  wisave,");
    crlf();
    putstr("  meas");
    crlf();
}

void help_meas() {
    //       1234567890123456789012
    putstr("meas( fenster_nr);");
    crlf();
    crlf();
    //       1234567890123456789012
    putstr("Restauriert den");
    crlf();
    putstr("Fensterinhalt");
    crlf();
    crlf();
    putstr("Es wird nur der");
    crlf();
    putstr("ASCII-RAM wiederher-");
    crlf();
    putstr("gestellt.");
    crlf();
    crlf();
    putstr(" siehe auch:");
    crlf();
    putstr("  wiload,");
    crlf();
    putstr("  asme");
    crlf();
}

void help_shift() {
//       1234567890123456789012
    putstr("shift( x, y);");
    crlf();
    crlf();
    //       1234567890123456789012
    putstr("Verschiebt den");
    crlf();
    putstr("Fensterinhalt");
    crlf();
    crlf();
    putstr("Wenn das MSB gesetzt");
    crlf();
    putstr("ist (\1340x80), wird");
    crlf();
    putstr("nach links bzw. oben");
    crlf();
    putstr("verschoben. Der ur-");
    crlf();
    putstr("spr\175ngliche Fenster-");
    crlf();
    putstr("inhalt wird nicht ge-");
    crlf();
    putstr("l\174scht.");
    crlf();
    crlf();
    putstr(" siehe auch:");
    crlf();
    putstr("  wiinit,");
    crlf();
    putstr("  wisave");
    crlf();
}

void help_invzei() {
    //       1234567890123456789012
    putstr("invzei( zeile);");
    crlf();
    crlf();
    //       1234567890123456789012
    putstr("Invertiert eine Zeile");
    crlf();
    putstr("im aktuellen Fenster.");
    crlf();
    crlf();
    putstr(" siehe auch:");
    crlf();
    putstr("  invwin");
    crlf();
}

void help_invwin() {
    //       1234567890123456789012
    putstr("invwin();");
    crlf();
    crlf();
    //       1234567890123456789012
    putstr("Invertiert den Inhalt");
    crlf();
    putstr("des aktuellen");
    crlf();
    putstr("Fensters.");
    crlf();
    crlf();
    putstr(" siehe auch:");
    crlf();
    putstr("  invzei");
    crlf();
}

void help_rahm() {
    //       1234567890123456789012
    putstr("rahm();");
    crlf();
    crlf();
    //       1234567890123456789012
    putstr("Zeichnet einen Rahmen");
    crlf();
    putstr("um das aktuelle");
    crlf();
    putstr("Fenster.");
    crlf();
    crlf();
    //       1234567890123456789012
    putstr("Der Rahmen wird nicht");
    crlf();
    putstr("durch wiload bzw.");
    crlf();
    putstr("wisave ber\175cksichtigt.");
    crlf();
    crlf();
    putstr(" siehe auch:");
    crlf();
    putstr("  shadow,");
    crlf();
    putstr("  lrahm");
    crlf();
}

void help_lrahm() {
    //       1234567890123456789012
    putstr("lrahm();");
    crlf();
    crlf();
    //       1234567890123456789012
    putstr("Der Rahmen um das");
    crlf();
    putstr("aktuelle Fenster wird");
    crlf();
    putstr("mit der eingestellten");
    crlf();
    putstr("Hintergundfarbe ge-");
    crlf();
    putstr("l\174scht.");
    crlf();
    crlf();
    putstr(" siehe auch:");
    crlf();
    putstr("  rahm,");
    crlf();
    putstr("  lshad");
    crlf();
}

void help_shadow() {
    //       1234567890123456789012
    putstr("shadow();");
    crlf();
    crlf();
    //       12345678901234567890123
    putstr("Zeichnet einen Schatten");
    putstr("unter dem aktuellen");
    crlf();
    putstr("Fenster.");
    crlf();
    crlf();
    //       12345678901234567890123
    putstr("Der Schatten wird");
    crlf();
    putstr("nicht durch wiload bzw.");
    putstr("wisave ber\175cksichtigt.");
    crlf();
    crlf();
    putstr(" siehe auch:");
    crlf();
    putstr("  rahm,");
    crlf();
    putstr("  lshad");
    crlf();
}

void help_lshad() {
    //       12345678901234567890123
    putstr("lshad();");
    crlf();
    crlf();
    //       12345678901234567890123
    putstr("Der Schatten unter dem");
    crlf();
    putstr("aktuellen Fenster wird");
    crlf();
    putstr("gel\174scht.");
    crlf();
    crlf();
    putstr("Es wird die einge-");
    crlf();
    putstr("stellte Hintergundfarbe");
    putstr("genutzt.");
    crlf();
    crlf();
    putstr(" siehe auch:");
    crlf();
    putstr("  shadow,");
    crlf();
    putstr("  lrahm");
    crlf();
}

void help_icon() {
    //       1234567890123456789012
    putstr("icon(");
    crlf();
    putstr("    icon_nr,");
    crlf();
    putstr("    &icon_def,");
    crlf();
    putstr("    spalte,");
    crlf();
    putstr("    zeile);");
    crlf();
    crlf();
    //       12345678901234567890123
    putstr("Stellt einen Icon auf");
    crlf();
    putstr("dem Bildschirm dar.");
    crlf();
    crlf();
    putstr("Die Gr\174\176e des Icons ist");
    putstr("nur durch den Bild-");
    crlf();
    putstr("schirm beschr\173nkt.");
    crlf();
    //       12345678901234567890123
    putstr("Die Definition des Icon");
    putstr("kann z.B. so erfolgen:");
    crlf();
    crlf();
    putstr("const unsigned char");
    crlf();
    putstr("  icondef\033C[] = {");
    crlf();
    putstr("    breite, hoehe,");
    crlf();
    putstr("    data_0..data_n}\033C");
    crlf();
    crlf();
    //       12345678901234567890123
    putstr("Die Daten beschreiben");
    crlf();
    putstr("immer ein 8x8-Feld. Die");
    putstr("Reihenfolge ist von");
    crlf();
    putstr("links nach rechts und");
    crlf();
    putstr("von oben nach unten.");
    crlf();
    // Beispiel:
    // const unsigned char beispiel_icon[] = { 2, 1,
    // 0xff, 0x80, 0x80, 0x80,  0x80, 0x80, 0x80, 0xff,
    // 0xff, 0x03, 0x03, 0x03,  0x03, 0x03, 0x03, 0xff };
    // Mehrere Icons können in einer Deinition zusammengefasst werden. Die Auswahl erfolgt dann über die icon_nr.
}

void help_priat() {
    //       12345678901234567890123
    putstr("priat(");
    crlf();
    putstr("  spalte,");
    crlf();
    putstr("  zeile,");
    crlf();
    putstr("  text);");
    crlf();
    crlf();
    //       12345678901234567890123
    putstr("Gibt einen Text an der");
    crlf();
    putstr("entsprechenden Stelle");
    crlf();
    putstr("im Fenster aus.");
    crlf();
    crlf();
    putstr(" siehe auch:");
    crlf();
    putstr("  inpat");
    crlf();
}

void help_inpat() {
    //       12345678901234567890123
    putstr("inpat(");
    crlf();
    putstr("  spalte,");
    crlf();
    putstr("  zeile);");
    crlf();
    crlf();
    //       12345678901234567890123
    putstr("Setzt den Cursor auf");
    crlf();
    putstr("die entsprechende Posi-");
    putstr("tion und erwartet eine");
    crlf();
    putstr("Eingabe. R\175ckgabewert");
    crlf();
    putstr("ist ein Zeiger auf den");
    crlf();
    putstr("ASCII-RAM mit den Ein-");
    crlf();
    putstr("gabewerten.");
    crlf();
    crlf();
    putstr(" siehe auch:");
    crlf();
    putstr("  priat");
    crlf();
}

void help_titel() {
    //       12345678901234567890123
    putstr("titel( text);");
    crlf();
    crlf();
    //       12345678901234567890123
    putstr("Dekoriert ein Fenster");
    crlf();
    putstr("mit einer Titelzeile,");
    crlf();
    putstr("einem Titeltext und");
    crlf();
    putstr("einem Rahmen. Die Fens-");
    putstr("tergr\174\176e wird entspre-");
    crlf();
    putstr("chend verkleinert.");
    crlf();
    crlf();
    putstr(" siehe auch:");
    crlf();
    putstr("  wiinit");
    crlf();
}

//////////////////////////////
// Bedienungsanleitung screen.h
void anleitung_screen(void) {
    const uint8_t item_anzahl = 16;
    uint8_t eingabe;
    uint8_t auswahl = 0;

    wiinit(4, 4, 8, 19, selectionwin);
    wisave(selectionwin);
    clrscr();
    rahm();

    wiinit(14, 2, 25, 28, descrwin);
    wisave(descrwin);
    clrscr();
    rahm();

    wiinit(15, 3, 23, 26, testwin);

    winak(selectionwin);
    putstr(
            "\r\n Index\r\n wiinit\r\n wisave\r\n wiload\r\n asme\r\n meas\r\n shift\r\n invzei\r\n invwin\r\n rahm\r\n lrahm\r\n shadow\r\n lshad\r\n icon\r\n priat\r\n inpat\r\n titel");
    do {
        winak(testwin);
        clrscr();
        switch (auswahl) {
        case 0:
            help_00();
            break;
        case 1:
            help_01();
            break;
        case 2:
            help_02();
            break;
        case 3:
            help_03();
            break;
        case 4:
            help_asme();
            break;
        case 5:
            help_meas();
            break;
        case 6:
            help_shift();
            break;
        case 7:
            help_invzei();
            break;
        case 8:
            help_invwin();
            break;
        case 9:
            help_rahm();
            break;
        case 10:
            help_lrahm();
            break;
        case 11:
            help_shadow();
            break;
        case 12:
            help_lshad();
            break;
        case 13:
            help_icon();
            break;
        case 14:
            help_priat();
            break;
        case 15:
            help_inpat();
            break;
        case 16:
            help_titel();
            break;
        }

        winak(selectionwin);
        invzei(auswahl + 1);
        while (!kbhit()) {
        }
        eingabe = getch();

        invzei(auswahl + 1);

        if (eingabe == CUU)
            auswahl = (auswahl > 0) ? auswahl - 1 : item_anzahl;
        if (eingabe == CUD)
            auswahl = (auswahl + 1) % (item_anzahl + 1);
        if (eingabe == PAGE)
            auswahl = 0;
        if (eingabe == SCROL)
            auswahl = item_anzahl - 1;
    } while (eingabe != BREAK && eingabe != CR && eingabe != CUL);

    winak(descrwin);
    lrahm();
    wiload(descrwin);

    winak(selectionwin);
    lrahm();
    wiload(selectionwin);
}

enum auswahl_t auswahl = rahmen;
char eingabe;
char beenden = FALSE;
uint8_t color_save;
const uint8_t auswahl_max = auswahl_anzahl;

//////////////////////////////
// Hauptprogramm
void main() {
    printf("Gefunden: CAOS Version %x\n", caos_version());

    if (caos_version() < 0x41) {
        printf("l\173uft nur auf CAOS 4.1 und sp\173ter.\n");
        return;
    }

    screen_init();
    // Abspeichern des Originalfensters
    color_save = syscolor;
    wiinit(0, 0, 40, 32, original);

    textbackground(WHITE);
    clrscr();

    textbackground(GREEN);
    wiinit(2, 2, 14, auswahl_anzahl + 6, startwin);
    clrscr();
    rahm();
    shadow();

    wiinit( TEXTWIDTH * 0.45, TEXTHEIGHT * 1 / 9, TEXTWIDTH * 0.5,
    TEXTHEIGHT / 6, testwin);
    clrscr();
    priat(2, 2, "Einfaches Fenster");

    wiinit( TEXTWIDTH * 0.45, TEXTHEIGHT * 3 / 9, TEXTWIDTH * 0.5,
    TEXTHEIGHT / 6, testwin);
    clrscr();
    priat(1, 2, "Fenster mit Rahmen");
    rahm();

    wiinit( TEXTWIDTH * 0.45, TEXTHEIGHT * 5 / 9, TEXTWIDTH * 0.5,
    TEXTHEIGHT / 6 - 1, testwin);
    clrscr();
    priat(1, 1, "Fenster mit Rahmen");
    priat(3, 2, "und Schatten");
    rahm();
    shadow();

    wiinit( TEXTWIDTH * 0.45, TEXTHEIGHT * 7 / 9 - 1, TEXTWIDTH * 0.5,
    TEXTHEIGHT / 6 + 2, testwin);
    clrscr();
    titel("Fenster");
    priat(2, 1, "mit Titelzeile");

    winak(startwin);
    priat(1, 1, "SCREEN");
    priat(2, 2, "Demo");
    priat(1, 3, __DATE__);
    icon(0, (unsigned int *) &screen_logo, 10, 1);

    // Auswahlmenue
    wiinit(3, 7, 12, auswahl_anzahl, menuwin);
    priat(0, 0, "Rahmen");
    priat(0, 1, "Schatten");
    priat(0, 2, "Beides (R+S)");
    priat(0, 3, "Schieben");
    priat(0, 4, "Symbole");
    priat(0, 5, "Nutzung");
    priat(0, 6, "Ende");
    wisave(startwin);
    winak(menuwin);

    // Menuschleife
    while (!beenden) {
        invzei(auswahl);
        while (!kbhit()) {
        }
        eingabe = getch();
        invzei(auswahl);
        if (eingabe == CUU)
            auswahl = (auswahl > 0) ? auswahl - 1 : auswahl_max - 1;
        if (eingabe == CUD) {
            auswahl++;
            if (auswahl >= auswahl_max)
                auswahl = 0;
        }
        if (eingabe == PAGE)
            auswahl = 0;
        if (eingabe == SCROL)
            auswahl = auswahl_max - 1;

        if (eingabe == BREAK)
            beenden = TRUE;

        if ((eingabe == CR) || (eingabe == CUR)) {
            switch (auswahl) {
            case rahmen:
                fenster(1);
                break;

            case schatten:
                fenster(2);
                break;

            case beides:
                fenster(3);
                break;

            case verschieb:
                winverschieb();
                break;

            case symbole:
                icon_menu();
                break;

            case nutzung:
                anleitung_screen();
                break;

            case ende:
                beenden = TRUE;
                break;
            }

            // menu restaurieren
            if (auswahl != ende) {
                wiload(startwin);
                rahm();
                shadow();
                winak(menuwin);
            }
        }
    }

    // Bildschirm aufrauemen
    winak(original);
    syscolor = color_save;
    clrscr();

}
