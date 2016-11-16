AS = sdasz80
AR = sdar

INC         = $(wildcard src/*.inc)
# files for conio library
CONIO_SRC   = $(wildcard src/conio_*.s)
CONIO_OBJ   = $(CONIO_SRC:src/%.s=obj/%.rel)
# files for krt library
KRT_SRC   = $(wildcard src/krt_*.s)
KRT_OBJ   = $(KRT_SRC:src/%.s=obj/%.rel)

all: obj crt0.rel header.rel krt.lib conio.lib \
          z9001.lib

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

z9001.lib: obj/putchar.rel obj/exit.rel 
	$(AR) rcD $@ $^

conio.lib: $(CONIO_OBJ) $(INC)
	$(AR) rcD $@ $(CONIO_OBJ)

krt.lib:  $(KRT_OBJ) $(INC)
	$(AR) rcD $@ $(KRT_OBJ)


clean:
	rm -rf obj
	rm -f *.bak
	rm -f *~
	rm -f src/*.bak
	rm -f src/*~

