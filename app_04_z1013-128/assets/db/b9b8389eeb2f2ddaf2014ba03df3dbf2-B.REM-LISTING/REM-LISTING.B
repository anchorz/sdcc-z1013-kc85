Zeichensatz UTF-8+Z1013()+CTRL()-ohne Umlaute(äöüß)

   10 WINDOW:CLS:LINES 16:LIST:REM       BESCHREIBUNG REM-LISTING   
   11!----------------------------
   12!Programme koennen auf viel-     faeltige Weise dokumentiert
   13!werden. Hier soll eine ein-     fache Art aufgezeigt und
   14!demonstriert werden. Der        Grundgedankte besteht in
   15!der Speicherung des Textes      in REM-Programmzeilen.
   16!Hierzu ist kein weiteres        Programm erforderlich, um
   17!den Text zu laden oder an-      zuzeigen. Das Laden kann
   18!mit CLOAD"NAME" oder mit        LOAD#1"NAME"{zeilennr}
   19!erfolgen, je nachdem, wie       das Programm auf Kassette
   20!gespeichert wurde, also ent-    weder mit CSAVE"NAME" oder
   21!mit LIST#1"NAME"{zeilennr}.     Vorteilhaft ist dieses Ver-
   22!fahren besonders beim Z 1013    mit nur 16-KByte-RAM, da
   23!jetzt zur Textspeicherung       fast 5 KByte zur Verfuegung
   24!stehen. Auch ist jede Zeile     editierbar, mit Hilfe des
   25!LIST#1- und des CSAVE-Kom-      mandos koennen Bloecke aus-
   26!gelagert und neu platziert      werden. Durch das LIST#1-
   27!koennen die Textzeilen dann     beim Laden bereits ange-
   28!zeigt werden, was mit dem       CLOAD-Kommando nicht reali-
   29!siert werden kann. Weiterhin    ist es moeglich, bis zu 60
   30!Programmeilen mit etwa 120      Textzeilen zu je 28 Zeichen
   31!zu speichern. Guenstigerwei-    se sollten die Programmzei-
   32!len 2-stellig sein, um ein      akzeptables Schriftbild zu
   33!erhalten. 
