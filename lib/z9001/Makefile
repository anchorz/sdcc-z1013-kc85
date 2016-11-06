LINK = sdldz80
AS = sdasz80
AR = sdar

# files for krt library
KRT_SRC   = $(wildcard src/krt_*.s)
KRT_OBJ   = $(KRT_SRC:src/%.s=obj/%.rel)

all: obj crt0.rel kcc_header.rel ../z9001.lib ../z9001_krt.lib 

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

../z9001_krt.lib :  $(KRT_OBJ)
	$(AR) rc $@   $^

../caos.lib :  $(CAOS_OBJ)
	$(AR) rc $@   $^

../conio.lib : $(CONIO_OBJ)
	$(AR) rc $@   $^

../screen.lib : $(SCREEN_OBJ)
	$(AR) rc $@   $^

../z9001.lib  : obj/putchar.rel  obj/exit.rel
	$(AR) rc $@ $^

clean:
	rm -rf obj
	rm -f *.bak
	rm -f *~
	rm -f src/*.bak
	rm -f src/*~
