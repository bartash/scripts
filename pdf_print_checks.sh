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
TMP=/tmp/check_fonts$$

# Check for cmyk
if identify -verbose $INPUT | grep Colorspace | grep -i srgb > /dev/null;
then
  echo "❌ ERROR input file $INPUT has RGB"
#  exit
else
  echo "✅ input  file $INPUT checked and has no rgb images"
fi

# check for embedded fonts
pdffonts $INPUT > $TMP
check=$(head -1 $TMP  |cut -c 73-75)
count=$(cat $TMP | wc -l)
body=$((count -2))
echo check is $check
echo count is $count
echo body is $body
if [[ "$check" == "emb" ]]; then
    echo "✅ pdffonts output is OK"
else
    echo "❌ ERROR pdffonts output looks wrongg"
fi
embedded=$(cat $TMP | tail -$body | cut -c 73-75 | sort -u)
echo embeded = $embedded
if echo $embedded | grep no > /dev/null
then
  echo "saw no"
else
  echo no no
fi