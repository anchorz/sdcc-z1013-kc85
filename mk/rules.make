#CFLAGS=--opt-code-speed 
# --profile 
CFLAGS=--std-sdcc99 -Wall

LINK    = sdldz80
AS      = sdasz80
OBJCOPY = objcopy

all: $(addprefix obj/,$(PLATFORM)) $(addsuffix /bin,$(addprefix obj/,$(PLATFORM)))

obj:
	mkdir obj

obj/gcc:
	mkdir -p "$@"

obj/gcc/bin: obj/gcc/$(OUT)
	
obj/gcc/$(OUT): $(addsuffix .o,$(addprefix obj/gcc/,$(OBJECTS)))
	gcc -o "$@" "$<"
	
obj/gcc/%.o : src/%.c
	gcc -Wall -pedantic -std=c99 -c -o "$@" "$<"

.PRECIOUS: obj/z1013/%.asm 

obj/z1013:
	mkdir -p "$@"

obj/z1013/bin: obj/z1013/$(OUT).z80

obj/z1013/$(OUT).z80: ../lib/z1013/crt0.rel $(addsuffix .rel,$(addprefix obj/z1013/,$(OBJECTS)))
	$(LINK) -mjwx -b _CODE=0x0100 $(LD_FLAGS) -i "obj/z1013/$(OUT).ihx" -k ../lib/ -l libc -l libz1013 $^
	$(OBJCOPY) -Iihex -Obinary "obj/z1013/$(OUT).ihx" "$@"
	echo -n $(OUT) >obj/filename.txt
	dd bs=1 if=obj/filename.txt of="$@" seek=16 conv=notrunc
	hexdump -C "$@"
	
obj/z1013/%.asm : src/%.c
	sdcc -mz80 $(CFLAGS) -S -o "$@" --nostdlib  --nostdinc -Iinclude -I../include $(CFLAGS) "$<"
	
obj/z1013/%.rel : obj/z1013/%.asm
  ifdef ENABLED_BANKED
	../lib/bank_replace.pl "$<"
  endif
	$(AS) -plosgff -Iinclude "$@" "$<"
	
################
#
#  KC85/2
#
################
.PRECIOUS: obj/kc85_2/%.asm

obj/kc85_2:
	mkdir -p "$@"

obj/kc85_2/bin: obj/kc85_2/$(OUT).kcc

obj/kc85_2/$(OUT).kcc: obj/kc85_2/prolog.rel ../lib/kc85_2/crt0.rel ../lib/kc85_2/kcc_header.rel  $(addsuffix .rel,$(addprefix obj/kc85_2/,$(OBJECTS)))
	$(LINK)     -mjwx -b _KCC_HEADER=0x180 -b _CODE=0x0200 $(LD_FLAGS) -i "obj/kc85_2/$(OUT).ihx" -k ../lib/ -l libc -l libkc85_2 $^
	$(OBJCOPY) -Iihex -Obinary "obj/kc85_2/$(OUT).ihx" "$@"
	
	@# include filename
	/bin/echo -n $(OUT) >obj/kc85_2/filename.txt
	dd bs=1 if=obj/kc85_2/filename.txt of="$@" count=8 seek=0 conv=notrunc,ucase
	#dd bs=1 if=obj/filename.txt of="$@" count=8 seek=130 conv=notrunc,ucase
	hexdump -C "$@"

obj/kc85_2/prolog.rel:
	echo ".area _CODE" >obj/kc85_2/prolog.asm
	echo ".dw 0x7f7f" >>obj/kc85_2/prolog.asm
	echo -n ".ascii '" >>obj/kc85_2/prolog.asm
	echo -n $(OUT) | tr '[:lower:]' '[:upper:]'  >>obj/kc85_2/prolog.asm
	echo "'" >>obj/kc85_2/prolog.asm
	echo ".db 0x01" >>obj/kc85_2/prolog.asm
	$(AS) -plosgff -Iinclude "$@" obj/kc85_2/prolog.asm
	
obj/kc85_2/%.asm : src/%.c
	sdcc -mz80 $(CFLAGS) -S -o "$@" --nostdlib  --nostdinc -Iinclude -I../include $(CFLAGS) "$<"

obj/kc85_2/%.rel : obj/kc85_2/%.asm
  ifdef ENABLED_BANKED
	../lib/bank_replace.pl "$<"
  endif
	$(AS) -plosgff -Iinclude "$@" "$<"
	
clean:
	rm -rf obj
	rm -f *.bak
	rm -f src/*.bak