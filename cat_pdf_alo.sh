#!/usr/bin/env bash
# concatenate pdfs
#
#
set -o errexit
OUTPUT=Revised_Walks_book_OHAIR_2026.pdf
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

echo "Processing PDF files in '$PDF_DIRECTORY'..."
echo running pdfunite [0-9]*.pdf $OUTPUT
pdfunite [0-9]*.pdf $OUTPUT
echo "Merged file is ${OUTPUT}."

LIST1=$(ls 0[1-7]*.pdf)
echo "building ONE ${OUTPUT1} from ${LIST1}"
pdfunite ${LIST1} ${OUTPUT1}

LIST2=$(ls  0[8-9]*.pdf 1[0-3]*.pdf)
echo "building TWO ${OUTPUT2} from ${LIST2}"
pdfunite ${LIST2} ${OUTPUT2}

LIST3=$(ls 1[4-9]*.pdf)
echo "building THREE ${OUTPUT3} from ${LIST3}"
pdfunite ${LIST3} ${OUTPUT3}

