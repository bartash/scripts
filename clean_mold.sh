#!/usr/bin/env bash
# clean files left by mold lin ker
TMP=/tmp/clean_mold$$
find | egrep /.mold-...... > $TMP 
num=$(cat $TMP | wc -l)
echo "removing $num mold files"
if [[ "$num" == "0" ]] ; then
	echo no files
	exit 1
fi
cat $TMP | xargs rm
