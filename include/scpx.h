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
/* SCP3.0 */
#define CPM_RESET       37              /* Laufwerk zurücksetzen */
#define CPM_F_WRITEZF   40              /* Schreiben mit direktem Zugriff und Blockinitialisierung */
#define CPM_F_MULTISEC  44              /* Setzen Multisektorzähler */
#define CPM_F_ERRMODE   45              /* Setzen BDOS-Fehlermodus */
#define CPM_SPACE       46              /* Ermittlung freie Diskettenkapazität */
#define CPM_P_CHAIN     47              /* Programm anketten */
#define CPM_FLUSH       48              /* Säubern des Puffers */
#define SCP_FCB_SET     49              /* Ermitteln und Setzen FCB - Achtung nicht CP/M 3!*/
#define CPM_BIOS        50              /* direkter BIOS Aufruf */
#define CPM_P_LOAD      59              /* Laden Überlagerung */
#define CPM_CALL_RSX    60              /* Aufruf resistenter Systemerweiterung */
#define CPM_CLEANUP     98              /* freie Blöcke */
#define CPM_F_TRUNCATE  99              /* Datei kürzen */
#define CPM_SET_LABEL  100              /* Setze Verzeichnisskennzeichen */
#define CPM_GET_LABEL  101              /* Rückgabe Verzeichnisskennzeichendaten */
#define CPM_F_TIMEDATE 102              /* Lesen Datum und Passwort-Modus von Datei */
#define CPM_WRITEXFCB  103              /* Schreiben XFCB für Datei */
#define CPM_T_SET      104              /* Setzen Datum und Zeit */
#define CPM_T_GET      105              /* Abfrage von Datum und Zeit */
#define CPM_F_PASSWD   106              /* Setzen Standard-Password */
#define CPM_S_SERIAL   107              /* Rückgabe Seriennummer */
#define CPM_P_CODE     108              /* Abfrage/Setzen Programmrückkehrkode */
#define CPM_C_MODE     109              /* Abfrage/Setzen Konsolen-Modus */
#define CPM_C_DELIMIT  110              /* Abfrage/Setzen Ausgabenbegrenzer */
#define CPM_C_WRITEBLK 111              /* Block ausgeben */
#define CPM_L_WRITEBLK 112              /* Block listen */
#define CPM_F_PARSE    152              /* Umwandeln Dateiname */


unsigned int bdos(unsigned int foo, unsigned int param)
__z88dk_callee;

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
/* PC1715 0x0004 */
#define JP_CONOST   17 /* Konsole/Out-Status abfragen */
#define JP_AUXIST   18 /* READER Status abfragen */
#define JP_AUXOST   19 /* PUNCH-Status abfragen */
/* SCP3.0 */
#define JP_DEVTBL   20 /* Ermittelt Adresse für I/O-Gerätenamentabelle */
#define JP_DEVINI   21 /* initialisiert physikalisches Gerät in Tabelle */
#define JP_DRVTBL   22 /* ermittelt DPH-Adresse für Laufwerk */
#define JP_MULTIO   23 /* zählt fortlaufende Sektoren fpr READ und WRITE */
#define JP_FLUSH    24 /* löscht den physischen Sektorpuffer */
#define JP_MOVE     25 /* Blockverschiebung von DE zu HL Anzahl BC im Speicher */
#define JP_TIME     26 /* Zeit setzen/abfragen */
#define JP_SELMEM   27 /* Speicherbank A anwählen */
#define JP_SETBNK   28 /* Speicherbankn A für DMA Operation anwählen */
#define JP_XMOVE    29 /* setzt Zielbank B und Quellbank C für Funktion 25 falls Blockverschiebung zwischen verschiedenen Banken */

unsigned int bios(unsigned int foo, unsigned int param_bc,
        unsigned int param_de)
__z88dk_callee;
