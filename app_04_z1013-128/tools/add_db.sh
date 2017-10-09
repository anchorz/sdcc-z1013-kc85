#!/bin/bash

file=$1
file=`eval echo \"$file\"` 

#echo \"$file\"
#exit


pushd . >/dev/null

dbroot=`dirname "$0"`/../assets/db
cd $dbroot
dbroot=`pwd`
popd >/dev/null

echo bewege \"$file\" in die Datenbank

md5=`md5sum -b "$file" | awk '{ print $1; }'`
base=`basename "$file" .z80`
mkdir "$dbroot/$md5-$base"

echo Ziel: "$dbroot/$md5-$base"
mv "$file" "$dbroot/$md5-$base/"

echo list.txt:
echo db/$md5-$base/$file
echo Kompatibilitätsliste.txt:
echo $md5 "*"$file

mv ~/jkcemu.gif "$dbroot/$md5-$base/"
echo '<kurz></kurz>' >"$dbroot/$md5-$base/info.txt"
echo '<lang></lang>' >>"$dbroot/$md5-$base/info.txt"
echo '<required></required>' >>"$dbroot/$md5-$base/info.txt"
