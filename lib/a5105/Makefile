PLATFORM=__A5105__
CFLAGS=--std-sdcc11 -Wall --Werror --fomit-frame-pointer

AS = sdasz80
AR = sdar

SDAS_OPT=-plowgff

INC         = $(wildcard src/*.inc)

# files for conio library
CONIO_SRC   = $(wildcard src/conio_*.s)
CONIO_C     = $(wildcard src/conio_*.c)
CONIO_OBJ   = $(CONIO_SRC:src/%.s=obj/%.rel) $(CONIO_C:src/%.c=obj/%.rel)

# files for krt library
KRT_SRC   = $(wildcard src/krt_*.s)
KRT_OBJ   = $(KRT_SRC:src/%.s=obj/%.rel)

all: obj basic_frame.rel crt0.rel a5105.lib
    
    #header.rel krt.lib conio.lib \
          z1013.lib

a5105.lib: obj/exit.rel obj/putchar.rel
	$(AR) rcD $@ $^

%.rel: obj/%.rel
	cp $< $@
	cp $(<:.rel=.lst) .

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
	$(AS) $(SDAS_OPT) $@ $<

obj/%.rel : src/%.c
	sdcc -mz80 -S -o $(@:obj/%.rel=obj/%.asm) --nostdlib  --nostdinc -I../../include $(CFLAGS) -D$(PLATFORM) "$<"
	$(AS) $(SDAS_OPT) $@ $(@:obj/%.rel=obj/%.asm)

conio.lib: $(CONIO_OBJ) $(INC)
	$(AR) rcD $@ $(CONIO_OBJ)

krt.lib:  $(KRT_OBJ) $(INC)
	$(AR) rcD $@ $(KRT_OBJ)

clean:
	rm -rf obj
	rm -f *.bak
	rm -f *.rst
	rm -f *~
	rm -f src/*.bak
	rm -f src/*~

