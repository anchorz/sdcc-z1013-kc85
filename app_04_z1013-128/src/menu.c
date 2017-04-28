typedef struct {
    const unsigned char *name;
    const unsigned char *ptr;
    const unsigned int *len;
} MENU_ENTRY;

//#include "kc_basic.z80.c"
//#include "jumping_jack.z80.c"
//#include "minefild.z80.c"
//#include "hase+wolf+joy.z80.c"

const char menuEntriesCount = sizeof(menuEntries)/sizeof(menuEntries)[0];

const MENU_ENTRY menuEntries[] = { //
        { "KC-BASIC", 0, 0 }, //
                { "JUMPING JACK", 0, 0 }, //
                { "HASE+WOLF (J)", 0, 0 }, //
                { "MINEFIELD", 0, 0 }, //

                { "  ..EXIT", 0, 0 } //
        };
