LINK = sdldz80
AS = sdasz80
AR = sdar

# files for krt library
CONIO_SRC   = $(wildcard src/conio_*.s)
CONIO_OBJ   = $(CONIO_SRC:src/%.s=obj/%.rel)

# files for krt library
KRT_SRC   = $(wildcard src/krt_*.s)
KRT_OBJ   = $(KRT_SRC:src/%.s=obj/%.rel)

all: obj crt0.rel kcc_header.rel ../z9001.lib ../z9001_krt.lib ../z9001_conio.lib

%.rel: obj/%.rel 
	cp $< $@

obj:
	mkdir obj

# p disable automatic listing pagination
# l create list file
# o create object file .rel
# s create symbol table .sym
# ff ?? Flag relocatable references by mode in listing file
#removed: 
# g all unresolved symbols are external - not declaring externals hides too many problems
obj/%.rel : src/%.s
	$(AS) -plosff $@ $<

../z9001_krt.lib :  $(KRT_OBJ) src/z9001.inc
	$(AR) rc $@ $(KRT_OBJ)

../z9001_conio.lib : $(CONIO_OBJ) src/z9001.inc
	$(AR) rc $@  $(CONIO_OBJ)

../z9001.lib  : obj/putchar.rel  obj/exit.rel 
	$(AR) rc $@ $^

clean:
	rm -rf obj
	rm -f *.bak
	rm -f *~
	rm -f src/*.bak
	rm -f src/*~
