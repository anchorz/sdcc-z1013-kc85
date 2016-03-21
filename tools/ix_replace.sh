#!/bin/sh

echo before ix replace:
echo "---------------------"
grep ix "$1" 
echo "---------------------"

sed -i -e 's/ix/iy/g'  "$1" 

echo after ix replace:
echo "---------------------"
grep ix "$1" 
echo "---------------------"


