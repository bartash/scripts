#!/usr/bin/env bash
# embed fonts as a singe step
#

set -o errexit
OUTPUT=4Revised_Walks_book_OHAIR_2026.pdf
INPUT=3Revised_Walks_book_OHAIR_2026.pdf

PDF_DIRECTORY=/mnt/h/data/Photos-Amy/432Flood-project/0-Sunnyside/05-Walks-Book/00_REMAKE_4/New_PDFs_4/

# Check if the specified directory exists.
if [ ! -d "$PDF_DIRECTORY" ]; then
    echo "Error: Directory '$PDF_DIRECTORY' not found."
    exit 1
fi

cd ${PDF_DIRECTORY}

# https://gemini.google.com/app/74b9884d80a0e2a1
gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite \
   -dPDFSETTINGS=/prepress \
   -dEmbedAllFonts=true \
   -dSubsetFonts=true \
   -dCannotEmbedFontPolicy=/Error \
   -sFONTPATH="/mnt/c/Windows/Fonts" \
   -sOutputFile=$OUTPUT \
   $INPUT
