#!/usr/bin/env bash
# add some lines after matching a pattern
TMP=/tmp/add_lines$$
grep .q.out  xref.all | xargs grep -l '\tnumFiles' > $TMP
wc -l $TMP
for file in `cat $TMP`
do
    gsed -i '/	numFiles/a\\tnumFilesErasureCoded	0                   ' $file
done
