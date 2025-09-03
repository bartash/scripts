#!/usr/bin/env bash
# concatenate pdfs
#
#
set -o errexit
OUTPUT=merged_book.pdf

PDF_DIRECTORY=$WINHOME/tmp/testpdfs

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

IFS='\0'
# Find all files with the .pdf extension in the specified directory.
# The 'find ... -print0' command outputs file names separated by null characters.
# The 'sort -zV' command sorts this null-delimited list in numeric order.
# The 'readarray -t -d '' ' command reads the null-delimited list directly into the array.
readarray -t -d '' sorted_pdfs < <(find "$PDF_DIRECTORY" -maxdepth 1 -name "[0-9]*.pdf" -print0 | sort -zV)

echo "Number of files to process is ${#sorted_pdfs[@]}"

# Check if any PDF files were found.
if [ ${#sorted_pdfs[@]} -eq 0 ]; then
    echo "No PDF files found in '$PDF_DIRECTORY'."
    exit 0
fi

# Loop through the sorted array of PDF file paths.
for pdf_file in "${sorted_pdfs[@]}"; do
    # --- File Processing Logic ---
    # This is where you would add the command to process each PDF file.
    # For example, you can print the file name.
    echo "File to process: $pdf_file"

    # Example: If you wanted to do something with the file, you would put the command here.
    # For instance, to get the number of pages in the PDF:
    # pdftk "$pdf_file" dump_data | grep NumberOfPages
    # Replace the echo command above with your actual logic.
done

echo "pdfunite ${sorted_pdfs[@]} ${OUTPUT}"

echo "Merged file is ${OUTPUT}."

