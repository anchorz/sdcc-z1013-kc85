#!/bin/bash

file=$1

pushd . >/dev/null

dbroot=`dirname "$0"`
cd $dbroot
dbroot=`pwd`
popd >/dev/null

echo suche \"$file\" in der Datenbank

find $dbroot/../assets -type f -exec $dbroot/fingerprint.pl $file {} \; | tee found

sort -rn found