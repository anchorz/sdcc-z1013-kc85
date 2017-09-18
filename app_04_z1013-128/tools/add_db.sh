#!/bin/bash

file=$1

dbroot=/home/andreas/ws/sdcc-z1013-kc85/app_04_z1013-128/assets/db
echo bewege \"$file\" in die Datenbank

md5=`md5sum -b $file | awk '{ print $1; }'`
base=`basename $file .z80`
mkdir "$dbroot/$md5-$base"

echo Ziel: "$dbroot/$md5-$base"
mv "$file" "$dbroot/$md5-$base/"
