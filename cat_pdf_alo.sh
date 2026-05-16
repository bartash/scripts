#!/usr/bin/env bash
# concatenate pdfs
#
#
set -o errexit
OUTPUT=Revised_Walks_book_OHAIR_2026.pdf
INPUT=RGB_Revised_Walks_book_OHAIR_2026.pdf

PDF_DIRECTORY=/mnt/h/data/Photos-Amy/432Flood-project/0-Sunnyside/05-Walks-Book/0_REMAKE_2/FINAL_03_PDFS

# Check if the specified directory exists.
if [ ! -d "$PDF_DIRECTORY" ]; then
    echo "Error: Directory '$PDF_DIRECTORY' not found."
    exit 1
fi

cd ${PDF_DIRECTORY}

if [ -f "$OUTPUT" ]; then
    echo "Error: file $OUTPUT exists."
    exit 1
fi

if [ -f "$INPUT" ]; then
    echo "Error: file $INPUT exists."
    exit 1
fi

echo "Processing PDF files in '$PDF_DIRECTORY'..."
echo running pdfunite [0-9]*.pdf $INPUT
pdfunite [0-9]*.pdf $INPUT
echo "Merged file is ${INPUT}."


if identify -verbose $INPUT | grep Colorspace | grep -i srgb > /dev/null;
then
  echo input file $INPUT has RGB
else
  echo input does not have rgb
  exit
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
  echo output file $OUTPUT does not have rgb
fi

## can check dpi with (see first 2 lines of output for header names)
# pdfimages -list $OUTPUT  | grep jpeg


## Check that print uses k channel only
# gs -o - -sDEVICE=inkcov $OUTPUT | sed -n '/Page 7/{n;p;q;}'
# should see
# 0.00000  0.00000  0.00000  0.11081 CMYK OK

