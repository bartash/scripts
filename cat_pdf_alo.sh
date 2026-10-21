#!/usr/bin/env bash
# concatenate pdfs
#
# possible blackmagic, I also did
#  sudo apt-get install fonts-sil-gentiumplus
#  sudo apt install fonts-croscore
#
set -o errexit
OUTPUT=Revised_Walks_book_OHAIR_2026.pdf
INPUT=RGB_Revised_Walks_book_OHAIR_2026.pdf

PDF_DIRECTORY=/mnt/h/data/Photos-Amy/432Flood-project/0-Sunnyside/05-Walks-Book/00_REMAKE_4//New_PDFs_4/

# Check if the specified directory exists.
if [ ! -d "$PDF_DIRECTORY" ]; then
    echo "Error: Directory '$PDF_DIRECTORY' not found."
    exit 1
fi

cd ${PDF_DIRECTORY}

if [ -f "$OUTPUT" ]; then
    echo "Error: file $OUTPUT exists in $PDF_DIRECTORY."
    exit 1
fi

if [ -f "$INPUT" ]; then
    echo "Error: file $INPUT exists in $PDF_DIRECTORY."
    exit 1
fi

echo "Processing PDF files in '$PDF_DIRECTORY'..."
echo running pdfunite [0-9]*.pdf $INPUT
pdfunite REV4_[0-9]*.pdf $INPUT
echo "Merged file is ${INPUT}."


if identify -verbose $INPUT | grep Colorspace | grep -i srgb > /dev/null;
then
  echo input file $INPUT has RGB
else
  echo input does not have rgb
  exit
fi

# https://gemini.google.com/app/c44b6ec45425466b
# Note gs will not see user-specific fonts in %APPDATA%/...

#
# NOTE! https://claude.ai/chat/a4dc643c-73f2-4946-8076-cfe9aacc25d5
# If you ever return to a GS-based workflow and want proper ICC color management, the flags to add would be:
#  -sOutputICCProfile=/path/to/JapanColor2001Coated.icc \
#  -sDefaultRGBProfile=/path/to/sRGB.icc \
#  -dRenderIntent=1 \
# Where -dRenderIntent=1 is Relative Colorimetric. But given the font embedding problems
# you've encountered, Acrobat is the better tool for this particular document.

gs -o $OUTPUT \
   -sDEVICE=pdfwrite \
   -dPDFSETTINGS=/prepress \
   -sColorConversionStrategy=CMYK \
   -dProcessColorModel=/DeviceCMYK \
   -dEncodeColorImages=true \
   -dDownsampleColorImages=false \
   -dCompatibilityLevel=1.4 \
   -dEmbedAllFonts=true \
   -dSubsetFonts=false \
   -dCannotEmbedFontPolicy=/Error \
   -sFONTPATH="/mnt/c/Windows/Fonts" \
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

