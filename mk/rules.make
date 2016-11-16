#--fomit-frame-pointer important for KC85/3 - don't use IX register
# for compatibility reasons we keep that setting for all libraries
CFLAGS=--std-sdcc11 -Wall --fomit-frame-pointer

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
	#gcc -o "$@" $^ -print-search-dirs -L ../lib/gcc-x11 -lX11 -lpthread -lgcc-conio-x11 
	gcc -g -o "$@" $^ ../lib/gcc-x11/gcc-conio-x11.a -lX11 -lpthread -lm
	
obj/gcc/%.o : src/%.c
	#gcc -Wall  -Wno-main -pedantic -std=c99 -S -o "$@.asm" "$<"
	gcc -g -Wall -pedantic -std=c99 -Werror -Iinclude -I../include-gcc -c -o "$@" $^

.PRECIOUS: obj/z1013/%.asm 

obj/z1013:
	mkdir -p "$@"

obj/z1013/bin: obj/z1013/$(OUT).z80

obj/z1013/$(OUT).z80: ../lib/z1013/crt0.rel ../lib/z1013/header.rel  $(addsuffix .rel,$(addprefix obj/z1013/,$(OBJECTS)))
	$(LINK) -mjwx -b _HEADER=0x00e0  -b _CODE=0x0100  $(LD_FLAGS) -i "obj/z1013/$(OUT).ihx" -k ../lib/z1013 -k ../lib/ -l z1013 -l krt -l conio -l z80_ix $^
	$(OBJCOPY) -Iihex -Obinary "obj/z1013/$(OUT).ihx" "$@"
	echo -n $(OUT) | dd bs=1 of="$@" seek=16 conv=notrunc
	@if [ "OFF" != "$(OPTION_SHOW_HEXDUMP)" ]; then hexdump -C "$@"; fi
	
obj/z1013/%.asm : src/%.c
	sdcc -mz80 -S -o "$@" --nostdlib  --nostdinc -Iinclude -I../include $(CFLAGS) -D__Z1013__ "$<"
	
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
#  Z9001
#
################
.PRECIOUS: obj/z9001/%.asm

obj/z9001:
	mkdir -p "$@"

obj/z9001/bin: obj/z9001/$(OUT).kcc

obj/z9001/$(OUT).kcc: ../lib/z9001/crt0.rel ../lib/z9001/header.rel  $(addsuffix .rel,$(addprefix obj/z9001/,$(OBJECTS)))
	$(LINK)     -mjwx -b _KCC_HEADER=0x280 -b _CODE=0x300 $(LD_FLAGS) -i "obj/z9001/$(OUT).ihx" -k ../lib/z9001 -k ../lib/ -l z9001 -l conio -l krt -l z80_ix $^
	$(OBJCOPY) -Iihex -Obinary "obj/z9001/$(OUT).ihx" "$@"
	@/bin/echo -n $(OUT) >obj/z9001/filename.txt
	dd bs=1 if=obj/z9001/filename.txt of="$@" count=8 seek=0 conv=notrunc,ucase
	dd bs=1 if=obj/z9001/filename.txt of="$@" count=8 seek=131 conv=notrunc,ucase
	@if [ "OFF" != "$(OPTION_SHOW_HEXDUMP)" ]; then hexdump -C "$@"; fi
    
obj/z9001/%.asm : src/%.c
	sdcc -mz80 -S -o "$@" --nostdlib  --nostdinc -Iinclude -I../include $(CFLAGS) -D__Z9001__ "$<"

obj/z9001/%.rel : src/%.s
  ifdef ENABLED_BANKED
	../tools/bank_replace.pl "$<"
  endif
	$(AS) -plosgff -Iinclude "$@" "$<"

obj/z9001/%.rel : obj/z9001/%.asm
  ifdef ENABLED_BANKED
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

obj/kc85/$(OUT).kcc: ../lib/kc85/crt0.rel ../lib/kc85/header.rel  $(addsuffix .rel,$(addprefix obj/kc85/,$(OBJECTS)))
	$(LINK)     -mjwx -b _KCC_HEADER=0x180 -b _CODE=0x200 $(LD_FLAGS) -i "obj/kc85/$(OUT).ihx" -k ../lib/kc85 -k ../lib/ -l kc85 -l caos -l conio -l screen -l krt -l z80_noix $^
	$(OBJCOPY) -Iihex -Obinary "obj/kc85/$(OUT).ihx" "$@"
	/bin/echo -n $(OUT) >obj/kc85/filename.txt
	dd bs=1 if=obj/kc85/filename.txt of="$@" count=8 seek=0 conv=notrunc,ucase
	@if [ "OFF" != "$(OPTION_SHOW_HEXDUMP)" ]; then hexdump -C "$@"; fi

obj/kc85/%.asm : src/%.c
	sdcc -mz80 $(CFLAGS) -S -o "$@" --nostdlib  --nostdinc -Iinclude -I../include -D__KC85__ "$<"
#	sdcc -mz80 $(CFLAGS) --reserve-regs-iy -S -o "$@" --nostdlib  --nostdinc -Iinclude -I../include "$<"
#	../tools/ix_replace.sh "$@"

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

run.gcc:
	@echo "******************************************************"
	@echo "*" 
	@echo "* starting application: obj/gcc/$(OUT)"
	@echo "*" 
	@echo "******************************************************"
	obj/gcc/$(OUT) &

run.z1013:
	@echo "******************************************************"
	@echo "*" 
	@echo "* starting application: jkcemu Z1013 obj/z1013/$(OUT).z80"
	@echo "*" 
	@echo "******************************************************"
	jkcemu Z1013 obj/z1013/$(OUT).z80 &

run.kc85:
	@echo "******************************************************"
	@echo "*" 
	@echo "* starting application: jkcemu KC85 obj/kc85/$(OUT).kcc"
	@echo "*" 
	@echo "******************************************************"
	jkcemu KC85 obj/kc85/$(OUT).kcc &

run.z9001:
	@echo "******************************************************"
	@echo "*" 
	@echo "* starting application: jkcemu Z9001 obj/z9001/$(OUT).kcc"
	@echo "*" 
	@echo "******************************************************"
	jkcemu Z9001 obj/z9001/$(OUT).kcc &

run: 
	for name in $(PLATFORM); do make run.$$name; done

.SILENT: stop
.IGNORE: stop

stop:
	pgrep -f 'jkcemu.*obj/' | xargs kill
	pgrep -f 'obj/gcc/$(OUT)' | xargs kill
		
clean:
	rm -f Makefile~
	rm -f a.out
	rm -f *.bak
	rm -rf obj
	rm -f src/*~
	rm -f src/*.bak
