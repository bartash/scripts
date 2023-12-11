#!/usr/bin/env bash
# unzip a zip file into a directory named for the zip file
if [ "$#" -ne 1 ]
then
 echo "usage $0 <file.zip>"
 exit 1
fi
NAME=$1
dir=$(echo $NAME | sed 's/\.zip//')
echo "dir=$dir"
mkdir $dir
cd $dir || exit 1
unzip  ../$NAME