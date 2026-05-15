#!/usr/bin/env bash
# convert rgb to cmyk
#
# sudo apt install imagemagick
set -o errexit
INPUT=Revised_Walks_book_OHAIR_2026.pdf
OUTPUT=CMYK_Revised_Walks_book_OHAIR_2026.pdf

if identify -verbose $INPUT | grep Colorspace | grep -i srgb > /dev/null;
then
  echo input has RGB
else
  echo input does not have rgb
fi

# https://gemini.google.com/app/c44b6ec45425466b
gs -o $OUTPUT \
   -sDEVICE=pdfwrite \
   -dPDFSETTINGS=/prepress \
   -sColorConversionStrategy=CMYK \
   -dProcessColorModel=/DeviceCMYK \
   -dEncodeColorImages=true \
   -dDownsampleColorImages=false \
   -dCompatibilityLevel=1.4 \
   $INPUT


if identify -verbose $OUTPUT | grep Colorspace | grep -i srgb > /dev/null;
then
  echo output has RGB
else
  echo output does not have rgb
fi

## can check dpi with (see first 2 lines of output for header names)
# pdfimages -list $OUTPUT  | grep jpeg


## Check that print uses k channel only
# gs -o - -sDEVICE=inkcov $OUTPUT | sed -n '/Page 7/{n;p;q;}'
# should see
# 0.00000  0.00000  0.00000  0.11081 CMYK OK

