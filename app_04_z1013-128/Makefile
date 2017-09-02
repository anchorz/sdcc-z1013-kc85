PLATFORM=z1013
OUT=kiosk
SDCC_OBJECTS=copy win_msgbox
OBJECTS=main _menu
OPTION_SHOW_HEXDUMP=ON

SDAS_OPT=-plowff

bin: obj/z1013 obj/z1013/rom_boot.bin
	sdldz80 $(SDLD_OPT) obj/z1013/rom_boot.ihx obj/z1013/rom_boot.rel
	sdobjcopy -Iihex -Obinary  obj/z1013/rom_boot.ihx  obj/z1013/rom_boot.bin

	dd bs=1 if=obj/z1013/kiosk.z80 of="obj/z1013/rom_boot.bin" skip=0 seek=5 count=2 conv=notrunc
	perl -e "print pack('v',`stat -c %s obj/z1013/kiosk.z80`-32)" | dd bs=1 of="obj/z1013/rom_boot.bin" seek=7 count=2 conv=notrunc
	dd bs=1 if=obj/z1013/kiosk.z80 of="obj/z1013/rom_boot.bin" skip=4 seek=9 count=2 conv=notrunc
	dd bs=1 if=obj/z1013/kiosk.z80 of="obj/z1013/rom_boot.bin" skip=32 oflag=append conv=notrunc
	cp	obj/z1013/rom_boot.bin obj/z1013/rom_boot.header.bin
	tools/gen_rom.pl
	#cp obj/z1013/rom01.bin ../../jkcemu/src/rom/z1013/rom_boot.bin 
	cat obj/z1013/rom0[0-7]* >mega1.bin
	cat obj/z1013/rom0[8-9a-f]* >mega2.bin
	
obj/z1013/rom_boot.bin: obj/z1013/kiosk.z80 obj/z1013/rom_boot.rel
	sdldz80 $(SDLD_OPT) $(@:bin=ihx) obj/z1013/rom_boot.rel
	sdobjcopy -Iihex -Obinary  $(@:bin=ihx)  $@
	dd bs=1 if=obj/z1013/kiosk.z80 of="$@" skip=0 seek=5 count=2 conv=notrunc 
	dd bs=1 if=obj/z1013/kiosk.z80 of="$@" skip=4 seek=9 count=2 conv=notrunc 
	dd bs=1 if=obj/z1013/kiosk.z80 of="$@" skip=32 oflag=append conv=notrunc 


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
#cp obj/z1013/rom_boot.bin ../../jkcemu/src/rom/z1013/
