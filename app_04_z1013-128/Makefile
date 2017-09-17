PLATFORM=z1013
OUT=kiosk
SDCC_OBJECTS=directory win_msgbox
OBJECTS=main
OPTION_SHOW_HEXDUMP=ON

Z1013_CODE=0x1000
Z1013_HEADER=0xfe0
Z1013_DATA=0x800

bin: obj/z1013 obj/z1013/kiosk.z80
	cp obj/z1013/kiosk.z80 obj/z1013/kiosk_komplett.z80
	#dd bs=1 if=obj/z1013/kiosk.z80 of="obj/z1013/rom_boot.bin" skip=32
	tools/gen_rom.pl
	#truncate -s 32768 "obj/z1013/rom_boot.bin"

include ../mk/rules.make

#src/kc_basic.z80.c : assets/kc_basic.z80
#	xxd -i "$<" "$@"
#	sed -i -e 's/unsigned/const unsigned/g' "$@"

#src/jumping_jack.z80.c : assets/jumping_jack.z80
#	xxd -i "$<" "$@"
#	sed -i -e 's/unsigned/const unsigned/g' "$@"#

#src/hase+wolf+joy.z80.c : assets/hase+wolf+joy.z80
#	xxd -i "$<" "$@"
#	sed -i -e 's/unsigned/const unsigned/g' "$@"

#src/minefild.z80.c : assets/minefild.z80
#	xxd -i "$<" "$@"
#	sed -i -e 's/unsigned/const unsigned/g' "$@"

copy:
	cp obj/z1013/rom_boot.bin ../../jkcemu/src/rom/z1013/

