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
TMP2=/tmp/check_2fonts$$

# Check for cmyk
if identify -verbose $INPUT | grep Colorspace | grep -i srgb > /dev/null;
then
  echo "❌ ERROR input file $INPUT has RGB, needs CMYK"
  echo "needs exit"
else
  echo "✅ input  file $INPUT checked and has no rgb images"
fi

# check for embedded fonts
pdffonts $INPUT > $TMP
check=$(head -1 $TMP  |cut -c 73-75)
count=$(cat $TMP | wc -l)
body=$((count -2))
if [[ "$check" == "emb" ]]; then
    echo "✅ pdffonts output is OK"
else
    echo "❌ ERROR pdffonts output looks wrong"
    echo "needs exit"
fi
embedded=$(cat $TMP | tail -$body | cut -c 73-75 | sort -u)
if echo $embedded | grep no > /dev/null
then
  echo "❌ ERROR pdffonts sees un-embedded font"
  echo "needs exit"
else
  echo "✅ all fonts are embedded"
fi

# check for low dpi images
pdfimages -list $INPUT > $TMP2
echo
echo "Please check x-dpi and y-dpi look good below"
echo "Use 'pdfimages -list' to see all images"
cat $TMP2 | head -24