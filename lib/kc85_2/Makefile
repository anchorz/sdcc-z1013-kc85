CFLAGS=--std-sdcc99
LINK = sdldz80
AS = sdasz80
AR = sdar

all: obj crt0.rel kcc_header.rel ../libkc85_2.lib 

%.rel: obj/%.rel 
	cp $< $@

obj:
	mkdir obj

obj/%.rel : src/%.s
	$(AS) -plosgff $@ $<
 
../libkc85_2.lib  : obj/kc85_5.rel obj/putchar.rel obj/common.rel
	$(AR) r $@ $^
	
clean:
	rm -rf obj
	rm -f *.bak
	rm -f src/*.bak

