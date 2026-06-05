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

PDF_DIRECTORY=/mnt/c/Users/ac9/tmp/New_PDFs_4

# Check if the specified directory exists.
if [ ! -d "$PDF_DIRECTORY" ]; then
    echo "Error: Directory '$PDF_DIRECTORY' not found."
    exit 1
fi

cd ${PDF_DIRECTORY}


# https://gemini.google.com/app/c44b6ec45425466b
# Note gs will not see user-specific fonts in %APPDATA%/...
gs -o $OUTPUT \
   -sDEVICE=pdfwrite \
   -dPDFSETTINGS=/prepress \
   -sColorConversionStrategy=UseDeviceIndependentColor
   -sColorConversionStrategyForImages=CMYK \
   -dProcessColorModel=/DeviceCMYK \
   -dEncodeColorImages=true \
   -dDownsampleColorImages=false \
   -dCompatibilityLevel=1.4 \
   -dSubsetFonts=false \
   -dCannotEmbedFontPolicy=/Error \
   -dEmbedAllFonts=true \
   -dSubsetFonts=false \
   -dNoOutputFonts=false \
   -dCompressFonts=false \
   -sFONTPATH="/mnt/c/Windows/Fonts" \
   $INPUT




