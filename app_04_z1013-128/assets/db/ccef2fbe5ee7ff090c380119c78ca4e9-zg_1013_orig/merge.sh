#header
dd if=../ccef2fbe5ee7ff090c380119c78ca4e9-zg_1013_orig/zg_1013_orig.z80 of=zg_1013_orig_uml.z80 bs=8 count=4
#original schachfiguren 00..1f
dd if=../ccef2fbe5ee7ff090c380119c78ca4e9-zg_1013_orig/zg_1013_orig.z80 of=zg_1013_orig_uml.z80 bs=8 skip=4 count=32 oflag=append conv=notrunc
#umlaute 20..7e
dd if=../128947d8f9a3fa363eb602b79615e858-zg_m_uml_+inv/zg_m_uml_+inv.z80 of=zg_1013_orig_uml.z80 bs=8 skip=36 count=95 oflag=append conv=notrunc
#original grafikzeichen 7f..ff
dd if=../ccef2fbe5ee7ff090c380119c78ca4e9-zg_1013_orig/zg_1013_orig.z80 of=zg_1013_orig_uml.z80 bs=8 skip=131 count=129 oflag=append conv=notrunc

hexdump -C zg_1013_orig_uml.z80
ls -la zg_1013_orig_uml.z80

