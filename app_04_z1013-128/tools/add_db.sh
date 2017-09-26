#!/bin/bash

file=$1

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
