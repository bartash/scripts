# add some lines after matching a pattern
sed -i .tmp '/	numFiles/a\
	numFilesErasureCoded	0
' $1
