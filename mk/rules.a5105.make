ifndef A5105_CODE
A5105_CODE=0x8000
endif

################
#
#  A5105
#
################
.PRECIOUS: obj/a5105/%.asm 

obj/a5105:
	mkdir -p "$@"
    
obj/a5105/bin: obj/a5105/$(OUT).bas
    
obj/a5105/$(OUT).bas: ../lib/a5105/basic_frame.rel ../lib/a5105/crt0.rel $(addsuffix .rel,$(addprefix obj/a5105/,$(OBJECTS) $(SDCC_OBJECTS)))
	$(LINK) $(SDLD_OPT) -b _CODE=$(A5105_CODE)  $(LD_FLAGS) -i "obj/a5105/$(OUT).ihx" -k ../lib/a5105 -k ../lib/ -l a5105 -l z80_ix $^
	$(OBJCOPY) -Iihex -Obinary "obj/a5105/$(OUT).ihx" "$@"
	dd if="$@" of=padded.z80 bs=128 conv=sync
	mv padded.z80 "$@"
	@if [ "OFF" != "$(OPTION_SHOW_HEXDUMP)" ]; then hexdump -C "$@"; fi

obj/a5105/%.asm : src/%.c
	sdcc -mz80 -S -o "$@" --nostdlib  --nostdinc -Iinclude -I../include $(CFLAGS) -D__A5105__ "$<"
	
obj/a5105/%.rel : src/%.s
	$(AS) -plosgff -Iinclude "$@" "$<"

obj/a5105/%.rel : obj/a5105/%.asm
  ifdef ENABLED_BANKED
	pwd
	../tools/bank_replace.pl "$<"
  endif
	$(AS) -plosgff -Iinclude "$@" "$<"
	