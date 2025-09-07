#!/usr/bin/env bash
# concatenate pdfs
#
#
set -o errexit
OUTPUT=OHAIR_2025_09_history_walks.pdf

PDF_DIRECTORY=/mnt/g/data/Photos-Amy/432Flood-project/0-Sunnyside/05-Walks-Book/REMAKE/PDFs_rev

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

