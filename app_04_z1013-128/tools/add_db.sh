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

#mv ~/jkcemu.gif "$dbroot/$md5-$base/"
avconv -i ~/jkcemu.gif -y "$dbroot/$md5-$base/animation.mp4"
mv ~/jkcemu.gif ~/jkcemu.gif.old

cp "$dbroot/info.txt" "$dbroot/$md5-$base/"

echo "$dbroot/$md5-$base/"
