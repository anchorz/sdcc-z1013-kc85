CFLAGS=--std-sdcc99
LINK = sdldz80
AS = sdasz80
AR = sdar

# files for krt library
KRT_SRC   = $(wildcard src/krt_*.s)
KRT_OBJ   = $(KRT_SRC:src/%.s=obj/%.rel)

all: obj crt0.rel header.rel ../z1013.lib  ../z1013_krt.lib

%.rel: obj/%.rel
	cp $< $@

obj:
	mkdir obj

obj/%.rel : src/%.s
	$(AS) -plosff $@ $<

../z1013_krt.lib :  $(KRT_OBJ)
	$(AR) rc $@   $^

../z1013.lib : obj/putchar.rel obj/outhx.rel  obj/inkey.rel obj/outch.rel obj/inch.rel obj/exit.rel \
    obj/z1013_spvt_poll.rel obj/z1013_spvt_getst.rel \
    obj/conio_clrscr.rel obj/conio_setcursortype.rel obj/conio_cputs.rel obj/conio_getch.rel \
    obj/conio_kbhit.rel
	$(AR) r $@ $^
	
clean:
	rm -rf obj
	rm -f *.bak
	rm -f *~
	rm -f src/*.bak
	rm -f src/*~

