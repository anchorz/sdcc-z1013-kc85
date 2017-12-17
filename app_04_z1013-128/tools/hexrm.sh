#!/bin/bash

file=$1
file=`eval echo \"$file\"` 

pushd . >/dev/null

command -v greadlink >/dev/null
if [ $? -eq 0 ];then
   dbroot_rel=`greadlink -f "$0"`
else
    dbroot_rel=`readlink -f "$0"`
fi
dbroot_rel=`dirname "$dbroot_rel"`
dbroot_rel=`dirname "$dbroot_rel"`
dbroot_rel="$dbroot_rel/assets/";
dbroot=$dbroot_rel
cd $dbroot
dbroot=`pwd`
popd >/dev/null

find $dbroot -name "*.hex" -exec rm {} \;
