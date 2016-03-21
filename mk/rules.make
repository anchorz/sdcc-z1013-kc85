#CFLAGS=--opt-code-speed 
# --profile 
CFLAGS=--std-sdcc99 -Wall --fomit-frame-pointer

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
	
	#
obj/gcc/%.o : src/%.c
	#gcc -Wall  -Wno-main -pedantic -std=c99 -S -o "$@.asm" "$<"
	gcc -Wall  -Wno-main -Wno-main-return-type -pedantic -std=c99 -c -o "$@" "$<"

.PRECIOUS: obj/z1013/%.asm 

obj/z1013:
	mkdir -p "$@"

obj/z1013/bin: obj/z1013/$(OUT).z80

obj/z1013/$(OUT).z80: ../lib/z1013/crt0.rel ../lib/z1013/header.rel  $(addsuffix .rel,$(addprefix obj/z1013/,$(OBJECTS)))
	$(LINK) -mjwx -b _HEADER=0x00e0  -b _CODE=0x0100  $(LD_FLAGS) -i "obj/z1013/$(OUT).ihx" -k ../lib/ -l libc -l z1013 $^
	$(OBJCOPY) -Iihex -Obinary "obj/z1013/$(OUT).ihx" "$@"
	echo -n $(OUT) >obj/filename.txt
	dd bs=1 if=obj/filename.txt of="$@" seek=16 conv=notrunc
	hexdump -C "$@"
	
obj/z1013/%.asm : src/%.c
	sdcc -mz80 -S -o "$@" --nostdlib  --nostdinc -Iinclude -I../include $(CFLAGS)  "$<"
	
obj/z1013/%.rel : src/%.s
  ifdef ENABLED_BANKED
	pwd
	../tools/bank_replace.pl "$<"
  endif
	$(AS) -plosgff -Iinclude "$@" "$<"

obj/z1013/%.rel : obj/z1013/%.asm
  ifdef ENABLED_BANKED
	pwd
	../tools/bank_replace.pl "$<"
  endif
	$(AS) -plosgff -Iinclude "$@" "$<"
		
################
#
#  KC85/2
#
################
.PRECIOUS: obj/kc85/%.asm

obj/kc85:
	mkdir -p "$@"

obj/kc85/bin: obj/kc85/$(OUT).kcc

obj/kc85/$(OUT).kcc: ../lib/kc85/crt0.rel ../lib/kc85/kcc_header.rel  $(addsuffix .rel,$(addprefix obj/kc85/,$(OBJECTS)))
	$(LINK)     -mjwx -b _KCC_HEADER=0x180 -b _CODE=0x200 $(LD_FLAGS) -i "obj/kc85/$(OUT).ihx" -k ../lib/ -l libc -l kc85 -l caos  -l conio -l screen $^
	$(OBJCOPY) -Iihex -Obinary "obj/kc85/$(OUT).ihx" "$@"
	/bin/echo -n $(OUT) >obj/kc85/filename.txt
	dd bs=1 if=obj/kc85/filename.txt of="$@" count=8 seek=0 conv=notrunc,ucase
	hexdump -C "$@"

obj/kc85/%.asm : src/%.c
#	sdcc -mz80 $(CFLAGS) -S -o "$@" --nostdlib  --nostdinc -Iinclude -I../include "$<"
	sdcc -mz80 $(CFLAGS) --reserve-regs-iy -S -o "$@" --nostdlib  --nostdinc -Iinclude -I../include "$<"
	../tools/ix_replace.sh "$@"

obj/kc85/%.rel : src/%.s
  ifdef ENABLED_BANKED
	../tools/bank_replace.pl "$<"
  endif
	$(AS) -plosgff -Iinclude "$@" "$<"

obj/kc85/%.rel : obj/kc85/%.asm
  ifdef ENABLED_BANKED
	../tools/bank_replace.pl "$<"
  endif
	$(AS) -plosgff -Iinclude "$@" "$<"
	
clean:
	rm -f Makefile~
	rm -f a.out
	rm -f *.bak
	rm -rf obj
	rm -f src/*~
	rm -f src/*.bak
