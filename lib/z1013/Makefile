CFLAGS=--std-sdcc99
LINK = sdldz80
AS = sdasz80
AR = sdar

all: obj crt0.rel ../libz1013.lib 

crt0.rel: obj/crt0.rel
	cp $< $@

obj:
	mkdir obj

obj/%.rel : src/%.s
	$(AS) -plosgff $@ $<
 
../libz1013.lib : obj/putchar.rel
	$(AR) r $@ $^
	
clean:
	rm -rf obj
	rm -f *.bak
	rm -f src/*.bak

