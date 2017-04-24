// Z1013 Sprungverteiler
// http://hc-ddr.hucki.net/wiki/doku.php/z1013:software:sprungverteiler
/*
 FFFDH - JMP INKEY
 holt ein Zeichen von Tastatur in den Akku;
 kommt beim 2. Aufruf nur zurück, wenn Taste
 zwischendurch losgelassen wurde
 */
extern unsigned char z1013_spvt_inkey();

/*
 FFFAH - JMP POLL
 bringt immer ein Zeichen im Akku zurück, egal
 ob Taste losgelassen wurde oder nicht
 */
extern unsigned char z1013_spvt_poll();

/*
 FFF7H - JMP STAT
 übergibt Tastaturstatus im Akku
 A=0   - keine Taste gedrückt
 A=FFH - Taste gedrückt
 die Abfrage erfolgt ohne Rücksicht, ob die
 Taste schon vor dem Aufruf gedrückt war und
 hinterlässt trotz gedrückter Taste den Status
 'letztes Zeichen war 0' ((Zelle 4)=0) um eine
 evtl. nachfolgenden INKEY-Routine nicht zu
 sperren
 */
extern unsigned char z1013_spvt_stat();

/*
 FFF4H - JMP SARUF
 ruft die SAVE-Routine des Headersave
 ! zerstört 1. Registersatz + AF'
 Parameterübergabe:
 Zellen 1BH - anfadr.
 1DH - endadr.
 23H - strtadr.
 Akku   3AH - Wiederholen der SAVE-Funktion mit
 gleichem Kopf
 H(IY)  Typvorgabe (in ASCII), sonst 0
 */
extern void z1013_spvt_saruf();

/*
 FFF1H - JMP LORUF
 ruft LOAD-Routine des Headersave
 ! zerstört 1. Registersatz + AF'
 Parameterübergabe:
 Zellen 1BH - neue Anfangsadresse des Files
 sonst 0
 Akku   0   - ohne signifikante Kontrolle
 4EH - mit signifikanter Kopfkontrolle
 (Typ) + Namenabfrage
 H(IY)  0   - Typ wird abgefragt
 Typkennzeichen (in ASCII), keine Typabfr.
 L(IY)  20H - Freigabe Autostart bei COM-Files
 */
extern void z1013_spvt_loruf();

/*
 FFEEH - JMP ZMINI
 Initialisierung der Z-Monitorrufe auf B0H
 */
extern void z1013_spvt_zmini();

/*
 FFEBH - JMP DRDEL
 setzt den logischen Druckertreiber zurück
 */
extern void z1013_spvt_drdel();

/*
 FFE8H - JMP DRAKK
 übergibt den Akkuinhalt an den logischen
 Druckertreiber

 Standardmäßig wird nur ein Sprung auf Adresse 0E806H ausgeführt. Dort muss dann
 der Druckertreiber stehen.
 */
extern void z1013_spvt_drakk(unsigned char c);

/*FFE5H - JMP BSDR
 druckt den Inhalt des BWS und kehrt in das
 rufende Programm zurück

 (Anm. VP) Im BROSIG-Monitor ist bereits eine Routine enthalten, die allerdings
 den Bildschirm nur bis zum Cursor bzw. dem Graphikzeichen 0FFH druckt
 und außerdem die Verarbeitung von Graphikzeichen dem Drucker überläßt.
 */
extern void z1013_spvt_bsdr();

/*
 FFE2H - JMP HARDC
 übergibt den Akkuinhalt an logischen Drucker-
 treiber wenn ein Flag im Rechner gesetzt ist;
 wandelt CR (0DH) in NL (0DH-0AH)

 Standardmäßig wird nur ein Sprung auf Adresse 0E80FH ausgeführt. Dort muss dann
 der Druckertreiber stehen.

 Das Flag wird nicht überall beachtet.
 */
extern void z1013_spvt_hardc(unsigned char c);

/*
 FFDFH - JMP DRZEL
 wie DRAKK, nur das der Inhalt von 1BH übergeben
 wird (vorgesehen, um im BASIC mit POKE zu drucken)

 Standardmäßig wird nur ein Sprung auf Adresse 0E803H ausgeführt. Dort muss dann
 der Druckertreiber stehen.

 (Anm. VP) DRZEL - eigentlich, um aus BASIC heraus zu drucken; wird m.E. nicht genutzt
 */
extern void z1013_spvt_drzel();

/*
 FFDCH - JMP BEEP
 erzeugen eines kurzen Signals
 */
extern void z1013_spvt_beep();

/*
 FFD9H - JMP ASTA
 Ausgabe Akkuinhalt als ASCII-Zeichen an PUNCH
 */
extern void z1013_spvt_asta(unsigned char);

/*
 FFD6H - JMP BSTA
 Ausgabe Akkuinhalt als Hexadezimalwert an PUNCH
 */
extern void z1013_spvt_bsta();

/*
 FFD3H - JMP AIN
 Eingabe eines ASCII-Zeichens vom LBL in den Akku

 Wenn die Funktion nicht implementiert ist, ist der Rückgabewert nicht
 spezifiziert.
 */
extern unsigned char z1013_spvt_ain();

/*
 FFD0H - JMP BIN
 Eingabe eines Bytes vom LBL in den Akku

 Wenn die Funktion nicht implementiert ist, ist der Rückgabewert nicht
 spezifiziert.
 */
extern unsigned char z1013_spvt_bin();

/*
 FFCDH - JMP DRINI
 Initialisierung des logischen Druckertreibers
 */
extern void z1013_spvt_drini();

/*
 FFCAH - JMP ZEIDR
 übergibt ein Zeichen im Akku an physischen
 Druckertreiber

 Standardmäßig wird nur ein Sprung auf Adresse 0E809H ausgeführt. Dort muss dann
 der Druckertreiber stehen.

 Andere ROM Versionen senden das Zeichen direkt über die Centronics-Schnittstelle auf
 Port 04+06.
 */
extern void z1013_spvt_zeidr(unsigned char c);

/*
 FFC7H - JMP BLMK
 Lesen eines Blocks vom Headersave
 Parameterübergabe:
 Zellen 25H/26H * Kopfinhalt des zu lesenden Bl.
 HL             * Ladeadresse des Blocks
 Return:
 Zellen 25H/26H * Kopfinhalt + 20H
 HL             * HL:=HL+20H
 Abbruch des Lesens bei Kopfinhalt=0FFFFH
 oder DMA > Endadr in ARG2 (1DH)
 */
extern void z1013_spvt_blmk();

/*
 FFC4H - JMP BSMK
 Schreiben eines Blocks im Headersave
 Parameterübergabe:
 HL  * Quelladresse Block
 IX  * Kopfinhalt
 DE  * Anzahl der Sync.-Bits
 Return:
 HL  * HL:=HL+20H
 */
extern unsigned int z1013_spvt_bsmk(unsigned int HL, unsigned int IX,
        unsigned int DE);

/*
 FFC1H - JMP SUCHK
 Suchen eines Kopfblocks und Übergabe des Inhalts
 im Kopfpuffer (E0-FF), keine Auswertung
 */
extern void z1013_spvt_suchk();

/*
 FFBEH - JMP AKP
 Aufbereitung Kopfpuffer mit Namenabfrage
 Parameterübergabe wie bei SARUF
 */
extern void z1013_spvt_akp();

#define JOYSTICK_LEFT 1
#define JOYSTICK_RIGHT 2
#define JOYSTICK_DOWN 4
#define JOYSTICK_UP 8
#define JOYSTICK_FIRE 16

/*
 FFBBH - JMP GETST
 Abfrage der Joysticks und Übergabe des Er-
 gebnisses in BC (B-links,C-rechts) mit folgen-
 den Bit-Bedeutungen (Belegung mit 1):
 Bit 0 - links
 1 - rechts
 2 - runter
 3 - hoch
 4 - Aktionstaste
 */
extern unsigned int z1013_spvt_getst();

/*FFB8H - JMP SOUND
 Ausgabe einer vollen Periode auf die Tonband-
 buchse, sowie auf Bit 7 vom Systemport (User-P)
 Übergabe der Periodendauer mit
 T=n*33mks+20mks (2MHz)
 */
extern void z1013_spvt_sound(unsigned char periode);

/*
 FFB5H - JMP BSAVE:
 Saven im BASIC-Code-Format

 (Anm. VP) In practic 1/90, S. 41 wurde eine Erweiterung des Sprungverteilers
 für BASICODE-Save und -Load vorgeschlagen. Das hat aber keinerlei praktische
 Anwendung mehr erfahren. Es gab auch keine Hinweise zu Aufrufparametern und
 auch keine Referenzimplementierung.

 Verfügbarkeit muss vorher getestet werden. [ffb5]=C3 'JMP'
 */
extern void z1013_spvt_bsave();

/*
 FFB2H - JMP BLOAD:
 Laden im BASIC-Code-Format

 Verfügbarkeit muss vorher getestet werden. [ffb2]=C3 'JMP'
 */
extern void z1013_spvt_bload();

#ifdef __SDCC
#define PRST7(X) \
  __asm__("rst 0x20"); \
  __asm__(".db 2 ;PRST7"); \
  __asm__(".ascis "#X);
#endif

extern void OUTCH(unsigned char); //UP:00
extern unsigned char INCH();  //UP:01
extern unsigned char INKEY();  //UP:04
extern void OUTHX(unsigned char); //UP:06

__at (0x04) unsigned char Z1013_KEYCODE;
__at (0x1f) unsigned char Z1013_CODE;
__at (0x2b) unsigned char * Z1013_CURSR;
__at (0xec00) unsigned char Z1013_BWS[32*32];

/*
 BYTES PER LINE
 Anzahl der Zeichen pro Zeile
 */
#define BPL 32
