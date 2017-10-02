PLATFORM=z1013
OUT=kiosk
SDCC_OBJECTS=directory win_msgbox copy
OBJECTS=main joystick_pa0188 help
OPTION_SHOW_HEXDUMP=OFF

Z1013_CODE=0x8000
Z1013_HEADER=0x7fe0
Z1013_DATA=0x7800

bin: obj/z1013 obj/z1013/kiosk.z80 assets/list.txt
	#no point to padd this file dd if=obj/z1013/kiosk.z80 of=obj/z1013/kiosk_pad.z80 obs=32 conv=osync
	tools/gen_rom.pl obj/z1013/kiosk.z80 assets obj/z1013/rom_boot.z80
	LC_CTYPE="C"; dd if=/dev/zero ibs=512k count=1 | tr "\000" "\377" > obj/z1013/rom_boot.bin
	dd if=obj/z1013/rom_boot.z80 of=obj/z1013/rom_boot.bin ibs=1 skip=32 conv=notrunc
    #obs=524288 conv=osync

include ../mk/rules.make

copy:
	cp obj/z1013/rom_boot.bin ../../jkcemu/src/rom/z1013/

