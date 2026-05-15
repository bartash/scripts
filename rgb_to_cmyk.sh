#!/usr/bin/env bash
# convert rgb to cmyk
#
# sudo apt install imagemagick
set -o errexit
INPUT=Revised_Walks_book_OHAIR_2026.pdf
OUTPUT=CMYK_Revised_Walks_book_OHAIR_2026.pdf

if identify -verbose output_cmyk.pdf $INPUT 2> /dev/null| grep Colorspace | grep -i srgb > /dev/null;
then
  echo input has RGB
else
  echo input does not have rgb
fi