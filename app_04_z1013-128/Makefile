PLATFORM=z1013
OUT=kiosk
SDCC_OBJECTS=win_msgbox
OBJECTS=main menu
OPTION_SHOW_HEXDUMP=ON

include ../mk/rules.make

src/kc_basic.z80.c : assets/kc_basic.z80
	xxd -i "$<" "$@"
	sed -i -e 's/unsigned/const unsigned/g' "$@"

src/jumping_jack.z80.c : assets/jumping_jack.z80
	xxd -i "$<" "$@"
	sed -i -e 's/unsigned/const unsigned/g' "$@"

src/hase+wolf+joy.z80.c : assets/hase+wolf+joy.z80
	xxd -i "$<" "$@"
	sed -i -e 's/unsigned/const unsigned/g' "$@"

src/minefild.z80.c : assets/minefild.z80
	xxd -i "$<" "$@"
	sed -i -e 's/unsigned/const unsigned/g' "$@"
