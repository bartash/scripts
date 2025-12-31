#!/usr/bin/env bash
# concatenate pdfs
#
#
set -o errexit
OUTPUT=Walks_book_OHAIR_2026.pdf
OUTPUT1=ONE_Walks_book_OHAIR_2026.pdf
OUTPUT2=TWO_Walks_book_OHAIR_2026.pdf
OUTPUT3=THREE_Walks_book_OHAIR_2026.pdf

PDF_DIRECTORY=/mnt/g/data/Photos-Amy/432Flood-project/0-Sunnyside/05-Walks-Book/0_REMAKE_2/FINAL_03_PDFS

# Check if the specified directory exists.
if [ ! -d "$PDF_DIRECTORY" ]; then
    echo "Error: Directory '$PDF_DIRECTORY' not found."
    exit 1
fi

cd ${PDF_DIRECTORY}

# Iterates over all PDF files in directory,
# sorting them in numeric order before processing.
# Replace this with the path to your directory.


echo "Processing PDF files in '$PDF_DIRECTORY'..."

echo running pdfunite [0-9]*.pdf $OUTPUT
pdfunite [0-9]*.pdf $OUTPUT

echo "Merged file is ${OUTPUT}."

echo "building ONE ${OUTPUT1} from "
ls 0[1-7]*.pdf
pdfunite 0[1-7]*.pdf ${OUTPUT1}

echo "building TWO ${OUTPUT2} from "
ls  0[8-9]*.pdf 1[0-3]*.pdf
pdfunite 0[8-9]*.pdf 1[0-3]*.pdf ${OUTPUT2}

echo "building THREE ${OUTPUT3} from "
ls 1[4-9]*.pdf
pdfunite 1[4-9]*.pdf ${OUTPUT3}

