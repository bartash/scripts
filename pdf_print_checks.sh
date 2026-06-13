#!/usr/bin/env bash
#
# check a pdf that is about to got to print shop.
#
set -e
if [ "$#" -ne 1 ]
then
 echo "usage $0 file.pdf"
 exit 1
fi
INPUT=$1
echo "Checking file $INPUT"

# Check for cmyk
if identify -verbose $INPUT | grep Colorspace | grep -i srgb > /dev/null;
then
  echo "❌ ERROR input file $INPUT has RGB"
else
  echo "✅ input  file $INPUT checked and has no rgb images"
  exit
fi

