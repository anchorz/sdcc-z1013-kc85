CFLAGS=--std-sdcc99 --fomit-frame-pointer
LINK = sdldz80
AS = sdasz80
AR = sdar

#all: obj libc.lib
all: obj
	cd gcc-x11; make
	cd z1013; make
	cd kc85; make
	cd z9001; make
	
#libc.lib : obj/printf.rel
#	$(AR) rc "$@" $^
	
obj:
	mkdir obj
	
obj/%.rel : src/%.c
	sdcc -mz80 $(CFLAGS) -c -o $@ --nostdlib  --nostdinc -Iinclude -I../include $<

clean:
	cd z1013; make clean
	cd kc85; make clean
	cd z9001; make clean
	rm -rf obj
	rm -f *.bak
	rm -f *~
	rm -f src/*.bak
	rm -f src/*~

