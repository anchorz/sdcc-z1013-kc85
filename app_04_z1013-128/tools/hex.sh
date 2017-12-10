#!/bin/bash


pushd . >/dev/null

tools_root_rel=`dirname "$0"`;
cd $tools_root_rel
tools_root=`pwd`
popd >/dev/null

java -Dsun.java2d.uiScale=1 -jar "$tools_root/hexeditor.jar" "$*"


