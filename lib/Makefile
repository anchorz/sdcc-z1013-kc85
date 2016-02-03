CFLAGS=--std-sdcc99
LINK = sdldz80
AS = sdasz80
AR = sdar

all: obj libc.lib

libc.lib : obj/printf.rel
	$(AR) r "$@" $^
	
obj:
	mkdir obj
	
obj/%.rel : src/%.c
	sdcc -mz80 $(CFLAGS) -c -o $@ --nostdlib  --nostdinc -Iinclude -I../include $<

clean:
	rm -rf obj
	rm -f *.bak
	rm -f src/*.bak