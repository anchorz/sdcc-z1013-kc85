#CFLAGS=--std-sdcc99 --fomit-frame-pointer
LINK = sdldz80
AS = sdasz80
AR = sdar

# files for CAOS library
CAOS_SRC   = $(wildcard src/caos_*.s)
CAOS_OBJ   = $(CAOS_SRC:src/%.s=obj/%.rel)
# files for conio library
CONIO_SRC   = $(wildcard src/conio_*.s)
CONIO_OBJ   = $(CONIO_SRC:src/%.s=obj/%.rel)
# files for screen library
SCREEN_SRC   = $(wildcard src/screen_*.s)
SCREEN_OBJ   = $(SCREEN_SRC:src/%.s=obj/%.rel)

all: obj crt0.rel kcc_header.rel ../kc85.lib  ../caos.lib ../conio.lib ../screen.lib

%.rel: obj/%.rel 
	cp $< $@

obj:
	mkdir obj

obj/%.rel : src/%.s
	$(AS) -plosgff $@ $<

../caos.lib :  $(CAOS_OBJ)
	$(AR) rc $@   $^
 
../conio.lib : $(CONIO_OBJ)
	$(AR) rc $@   $^
 
../screen.lib : $(SCREEN_OBJ)
	$(AR) rc $@   $^

../kc85.lib  : obj/putchar.rel obj/common.rel obj/exit.rel
	$(AR) rc $@ $^
	
clean:
	rm -rf obj
	rm -f *.bak
	rm -f *~
	rm -f src/*.bak
	rm -f src/*~

