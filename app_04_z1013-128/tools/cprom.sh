#!/bin/sh

echo kopiert ein 32K ROM image in den Emulator
echo dieses File wird beim Z1013-128 automatisch geladen

cp obj/z1013/rom0$1.bin ../../jkcemu/src/rom/z1013/rom_boot.bin 

