#!/usr/bin/env bash
# unzip a zip file into a directory named for the zip file
if [ "$#" -ne 1 ]
then
 echo "usage $0 <file>"
 exit 1
fi
NAME=$1
if [[ ! -f $NAME ]]
then
  echo "file $NAME does not exist"
  exit 1
fi

if [[ $NAME == *.zip ]]
then
  dir=$(echo $NAME | sed 's/\.zip//')
  mkdir $dir
  cd $dir || exit 1
  unzip  ../$NAME
  # note unzip can return 1 if there were warnings, e.g. warning:  stripped absolute path spec 
elif [[ $NAME == *.tar.gz ]]
then
  dir=$(echo $NAME | sed 's/\.tar.gz//')
  mkdir $dir
  cd $dir || exit 1
  tar xvzf ../$NAME
else
   echo "file $NAME does not have a supported extension"
   exit 1
fi
if [[ $? -eq 0 ]]; then
    echo "exit code was 0, remove $NAME"
    rm ../$NAME
else
    echo "exit code was $? leaving $NAME"
fi

echo
echo "target dir: cd $dir"
