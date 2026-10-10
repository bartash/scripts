
# /screen: Lowest quality, smallest size (72 dpi). Good for email, bad for printing.
# /ebook: Medium quality (150 dpi). Usually the "sweet spot" for readability vs. size.
# /printer: High quality (300 dpi). Best if you still plan to print the document.
# /prepress: Highest quality (300 dpi, preserves color). Use this if color accuracy is your #1 priority
INPUT=$1
# gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=printer_$INPUT $INPUT
# gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=ebook_$INPUT $INPUT
# gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile=screen_$INPUT $INPUT


# gs -sDEVICE=pdfwrite -dNOPAUSE -dQUIET -dBATCH \
   # -dColorImageFilter=/DCTEncode -dColorImageResolution=150 \
   # -dGrayImageFilter=/DCTEncode -dGrayImageResolution=150 \
   # -dMonoImageFilter=/CCITTFaxEncode -dMonoImageResolution=300 \
   # -sOutputFile=150_$INPUT $INPUT
# 
# gs -sDEVICE=pdfwrite -dNOPAUSE -dQUIET -dBATCH \
   # -dColorImageFilter=/DCTEncode -dColorImageResolution=100 \
   # -dGrayImageFilter=/DCTEncode -dGrayImageResolution=100 \
   # -dMonoImageFilter=/CCITTFaxEncode -dMonoImageResolution=300 \
   # -sOutputFile=100_$INPUT $INPUT

# Sometimes "print as image" doesn't create one big photo of a page; it creates thousands of tiny "image masks" for every letter. Ghostscript’s standard image compressors often ignore these small fragments to prevent quality loss.
# The "Shrink My Image-Text" Command
# 
# If you want to force that "text-image" to actually get smaller, use this combination. It lowers the DPI and forces JPEG compression:
gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dQUIET \
   -dPDFSETTINGS=/ebook \
   -dColorImageFilter=/DCTEncode \
   -dAutoFilterColorImages=false \
   -dColorImageResolution=150 \
   -dGrayImageResolution=150 \
   -sOutputFile=shrunk_$INPUT $INPUT
