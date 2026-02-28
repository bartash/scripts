
# /screen: Lowest quality, smallest size (72 dpi). Good for email, bad for printing.
# /ebook: Medium quality (150 dpi). Usually the "sweet spot" for readability vs. size.
# /printer: High quality (300 dpi). Best if you still plan to print the document.
# /prepress: Highest quality (300 dpi, preserves color). Use this if color accuracy is your #1 priority
INPUT=$1
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=printer_$INPUT $INPUT
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=ebook_$INPUT $INPUT
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile=screen_$INPUT $INPUT
