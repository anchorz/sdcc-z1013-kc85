#!/bin/bash

file=$1
file=`eval echo \"$file\"` 

#echo \"$file\"
#exit


pushd . >/dev/null

dbroot_rel="$0";
dbroot_rel=`readlink -f $dbroot_rel`
dbroot_rel=`dirname "$dbroot_rel"`
dbroot_rel=`dirname "$dbroot_rel"`
dbroot_rel="$dbroot_rel/assets/";
dbroot=$dbroot_rel
cd $dbroot
dbroot=`pwd`
popd >/dev/null

find $dbroot -name "*.hex" -exec rm {} \;
