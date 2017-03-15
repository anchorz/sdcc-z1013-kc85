all : obj turbo.wav x.wav
	hexdump -C obj/turbo.kcc
	grep isr obj/turbo.map 
	#play turbo.wav

save: obj/header.rel obj/save.rel obj/load.rel obj/hist.rel  obj/shared.rel
	#sdldz80 -mjwx -b _CODE=0x7000 -i obj/save.ihx obj/header.rel obj/save.rel obj/load.rel obj/hist.rel obj/shared.rel
	sdldz80 -mjwx -b _CODE=0x7000 -i obj/save.ihx obj/header.rel obj/hist.rel  obj/shared.rel
	objcopy -Iihex -Obinary obj/save.ihx obj/save.kcc
	../tools/kcc2wav/kcc2wav obj/save.kcc save.wav
	grep isr obj/save.map 

obj/%.rel : src/%.asm
	sdasz80 -plosff $@ $<

obj:
	mkdir obj

x.wav: ../tools/kcc2wav/nrz ../tools/kcc2wav/tl4 xonix.kcc
	../tools/kcc2wav/tl4 xonix.kcc x.wav 2500 18000 -1000 10000

turbo.wav: ../tools/kcc2wav/nrz  obj/turbo.kcc
	../tools/kcc2wav/kcc2wav obj/turbo.kcc turbo.wav
#	../tools/kcc2wav/kcc2wav obj/turbo8.kcc turbo8.wav

obj/turbo.kcc: obj/turbo.ihx
	objcopy -Iihex -Obinary obj/turbo.ihx obj/turbo.kcc
#	objcopy -Iihex -Obinary obj/turbo8.ihx obj/turbo8.kcc

obj/turbo.ihx : obj/turbo.rel obj/sample.rel 
	sdldz80 -mjwx -b _CODE=0x7080 -i obj/turbo.ihx obj/turbo.rel
#	sdldz80 -mjwx -b _CODE=0x3b80 -i obj/turbo.ihx obj/turbo.rel obj/sample.rel

ok:
	sdasz80 -plosff obj/turbo_ok.rel src/turbo_ok.asm
	sdldz80 -mjwx -b _CODE=0xba00 -i obj/turbo8.ihx obj/turbo_ok.rel
	objcopy -Iihex -Obinary obj/turbo8.ihx obj/turbo8.kcc
	../tools/kcc2wav/kcc2wav obj/turbo8.kcc turbo8.wav

obj/turbo.rel : src/turbo.asm
	sdasz80 -plosff obj/turbo.rel src/turbo.asm

obj/sample.rel : src/sample.asm
	sdasz80 -plosff obj/sample.rel src/sample.asm


clean:
	rm -rf obj


