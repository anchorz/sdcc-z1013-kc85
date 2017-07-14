CFLAGS=--std-sdcc11 -Wall --Werror --fomit-frame-pointer
SDAS_OPT=-plowff

AS = sdasz80
AR = sdar

INC       = $(wildcard src/*.inc)
SCP_SRC   = $(wildcard src/scp_*.s)
SCP_C     = $(wildcard src/scp_*.c)
SCP_OBJ   = $(SCP_SRC:src/%.s=obj/%.rel) $(SCP_C:src/%.c=obj/%.rel) 

all: obj crt0.rel scp.lib

scp.lib: $(SCP_OBJ) $(INC)
	$(AR) rcD $@ $^

%.rel: obj/%.rel
	cp $< $@
	cp $(<:obj/%.rel=obj/%.lst) .

obj:
	mkdir obj

obj/%.rel : src/%.s
	$(AS) $(SDAS_OPT) $@ $<

obj/%.rel : src/%.c
	sdcc -mz80 -S -o $(@:obj/%.rel=obj/%.asm) --nostdlib  --nostdinc -I../../include $(CFLAGS) -D__SCP__ "$<"
	$(AS) $(SDAS_OPT) $@ $(@:obj/%.rel=obj/%.asm)

clean:
	rm -rf obj
	rm -f *.bak
	rm -f *.rst
	rm -f *~
	rm -f src/*.bak
	rm -f src/*~
