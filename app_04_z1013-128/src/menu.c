typedef struct {
	const unsigned char *name;
	const unsigned char *ptr;
	const unsigned int *len;
} MENU_ENTRY;

#include "kc_basic.z80.c"
#include "jumping_jack.z80.c"
#include "minefild.z80.c"
//#include "hase+wolf+joy.z80.c"

const MENU_ENTRY menuEntries[] = { //
		{ "KC-BASIC", assets_kc_basic_z80, &assets_kc_basic_z80_len }, //
				{ "JUMPING JACK", assets_jumping_jack_z80,
						&assets_jumping_jack_z80_len }, //
				//{ "HASE+WOLF (J)", assets_hase_wolf_joy_z80,
				//	&assets_hase_wolf_joy_z80_len }, //
				{ "MINEFIELD", assets_minefild_z80, &assets_minefild_z80_len }, //
				{ "  ..EXIT", 0, 0 } //
		};
