#!/bin/sh

dd if="$1" of=padded.z80 bs=32 conv=sync
mv padded.z80 "$1" 
