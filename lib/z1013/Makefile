CFLAGS=--std-sdcc99
LINK = sdldz80
AS = sdasz80
AR = sdar

all: obj crt0.rel header.rel ../z1013.lib 

%.rel: obj/%.rel
	cp $< $@

obj:
	mkdir obj

obj/%.rel : src/%.s
	$(AS) -plosgff $@ $<
 
../z1013.lib : obj/putchar.rel obj/outch.rel obj/inch.rel obj/exit.rel
	$(AR) r $@ $^
	
clean:
	rm -rf obj
	rm -f *.bak
	rm -f *~
	rm -f src/*.bak
	rm -f src/*~

