PLATFORM=z1013
OUT=demo
OBJECTS=main menu
OPTION_SHOW_HEXDUMP=OFF

Z1013_CODE=0x8000
Z1013_DATA=0x7C00

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
