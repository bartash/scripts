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
# Pass 1: embed fonts properly with Unicode CMap
gs -o embedded_temp.pdf \
   -sDEVICE=pdfwrite \
   -dCompatibilityLevel=1.6 \
   -dEmbedAllFonts=true \
   -dSubsetFonts=false \
   -dCannotEmbedFontPolicy=/Error \
   -sFONTPATH="/mnt/c/Windows/Fonts" \
   $INPUT

# Pass 2: CMYK conversion on the now-embedded PDF
gs -o $OUTPUT \
   -sDEVICE=pdfwrite \
   -dPDFSETTINGS=/prepress \
   -sColorConversionStrategy=CMYK \
   -dProcessColorModel=/DeviceCMYK \
   -dEncodeColorImages=true \
   -dDownsampleColorImages=false \
   -dCompatibilityLevel=1.6 \
   -dEmbedAllFonts=true \
   -dSubsetFonts=false \
   -dCannotEmbedFontPolicy=/Error \
   -sFONTPATH="/mnt/c/Windows/Fonts" \
   embedded_temp.pdf



