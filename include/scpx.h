//http://www.seasip.info/Cpm/bdos.html
#define CPM_WBOOT        0              /* Warmstart, Steuerung geht an CCP zurück */
#define CPM_RCON         1              /* Konsoleneingabe */
#define CPM_WCON         2              /* Konsolenausgabe */
#define CPM_RRDR         3              /* Lesereingabe */
#define CPM_WPUN         4              /* Stanzerausgabe */
#define CPM_WLST         5              /* Druckerausgabe */
#define CPM_DCIO         6              /* direkte Konsoleneingabe (param=CPM_DCIO_INPUT), sonst Ausgabe */
   #define CPM_DCIO_INPUT 0xff
#define CPM_GIOB         7              /* I/O Byte holen */
#define CPM_SIOB         8              /* I/O Byte setzen */
#define CPM_PRNT         9              /* Zeichenkette ausgeben */
#define CPM_RCOB        10              /* Konsolenpuffer lesen*/
#define CPM_ICON        11              /* Konsolenstatus holen*/
#define CPM_VERS        12              /* Versionsnummer */
#define CPM_RDS         13              /* Diskettensystem rücksetzen */
#define CPM_LGIN        14              /* Laufwerk anwählen */
#define CPM_OPN         15              /* Datei eröffnen */
#define CPM_CLS         16              /* Datei schließen */
#define CPM_FFST        17              /* Erste Datei suchen */
#define CPM_FNXT        18              /* Nächste Datei suchen */
#define CPM_DEL         19              /* Datei löschen */
#define CPM_READ        20              /* Sequentielles Lesen  */
#define CPM_WRIT        21              /* Sequentielles Schreiben */
#define CPM_MAKE        22              /* Neue Datei anlegen */
#define CPM_REN         23              /* Datei umbenennen */
#define CPM_ILOG        24              /* Anwahlvektor holen */
#define CPM_IDRV        25              /* Bereitstellen des aktuellen Laufwerkes */
#define CPM_SDMA        26              /* DMA Adresse setzen */
#define CPM_ALLOC_VEC   27              /* Belegungsvektor holen */
#define CPM_SETRO       28              /* Schreibschutz */
#define CPM_ROVEC       29              /* Schreibschutzvektor holen */
#define CPM_F_ATTRIB    30              /* Datei-Attribute setzen */
#define CPM_DPB         31              /* DPB-Adresse holen */
#define CPM_F_USERNUM   32              /* Nutzerbereichsnummer holen/setzen */
#define CPM_F_READRAND  33              /* Wahlfrei lesen */
#define CPM_F_WRITERAND 34              /* Wahlfrei schreiben */
#define CPM_F_SIZE      35              /* Dateigröße berechnen */
#define CPM_F_RANDREC   36              /* Feld für wahlfreien Zugriff */

unsigned int bdos(unsigned int foo,unsigned int param) __z88dk_callee;

#define JP_BOOT      0 /* Kaltstartinitialisierung */
#define JP_WBOOT     1 /* Warmstart ausführen */
#define JP_CONST     2 /* Konsolenstatus abfragen */
#define JP_CONIN     3 /* Konsoleneingabe */
#define JP_CONOUT    4 /* Konsolenausgabe */
#define JP_LIST      5 /* Druckerausgabe */
#define JP_PUNCH     6 /* Lochstreifenstanzer */
#define JP_READER    7 /* Lochstreifenleser */
#define JP_HOME      8 /* Lese-/Schreibkopf auf Spur 0 stellen */
#define JP_SELDSK    9 /* Laufwerk auswählen */
#define JP_SETTRK   10 /* Spur auswählen */
#define JP_SETSEC   11 /* Aufzeichnungsabschnitt wählen, Sektornummer */
#define JP_SETDMA   12 /* Datenpufferadresse setzen */
#define JP_READ     13 /* Aufzeichnungsabschnitt lesen */
#define JP_WRITE    14 /* Aufzeichnungsabschnitt schreiben */
#define JP_LISTST   15 /* Druckerstatus abfragen */
#define JP_SECTRAN  16 /* Aufzeichnungsnummer übersetzen */
/* PC1715 SCPX 4 */
#define JP_CONOST   17 /* Konsole/Out-Status abfragen */
#define JP_AUXIST   18 /* READER Status abfragen */
#define JP_AUXOST   19 /* PUNCH-Status abfragen */

unsigned int bios(unsigned int foo,unsigned int param_bc,unsigned int param_de) __z88dk_callee;
