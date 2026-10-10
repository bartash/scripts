(set -o igncr) 2>/dev/null && set -o igncr; # this comment is needed
#
# Convert pdf to text
# Andrew Sherman 21-feb-2015
#
# cd /cygdrive/g/data/wget/cpuc/ftp2.cpuc.ca.gov
ALL_PDFS=all_pdfs$$.tmp
if [ $# -ne 1 ] ; then
    	echo 'You need a single directory as argument'
    	exit 0
fi

if [[ ! -d $1 ]] ; then 
	echo $1 is not a directory
	exit 1
fi

# find "$1" -type f -print | grep .pdf | head > $ALL_PDFS
find "$1" -type f -print | grep .pdf > $ALL_PDFS

while read line
do
	file=`echo $line | sed 's/.pdf/.txt/' | sed 's/PG&E20150130ResponseToA1312012Ruling/PGE_text/'`
	dir=`dirname $file`
	mkdir -p $dir
	if [ -f $file ] ; then
		echo xxxx skip file $file exists already
	else
		echo $file will be created
		'c:/Program Files (x86)/Calibre2'/ebook-convert.exe  "$line" "$file" --asciiize
	fi
done < $ALL_PDFS
