#!/usr/bin/env bash
#
# backup the phone, then run this script in the backup directory.
set -e
if [ "$#" -ne 1 ]
then
 echo "usage $0 arg1 are you sure, did you read the source?"
 exit 1
fi
arg=$1
echo arg is $arg

MONTHS=(ZERO Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)


TARGET="/cygdrive/g/data/Home Photos/Phone_1_Photos"
if [ ! -d "$TARGET" ]
then
	echo "no target dir $TARGET"
	exit 1
fi

for file in $(ls)
do
	# echo "file=$file"
	year=$(echo $file | cut -c 1-4)
	# echo "year=$year"
	month=$(echo $file | cut -c 5-6)
	# 10# prefix forces months like 09 to not be octal
	month_name=$(echo ${MONTHS[10#$month]})
	# echo "month=$month or $month_name"
	DIR="$TARGET/$year/$month_name"
	if [ ! -d "$DIR" ]
		then
		echo "no target month dir $DIR - creating it"
		mkdir -p "$DIR"
	fi
	if [ -f "$DIR/$file" ] 
	then
		# echo "file $DIR/$file exists already"
		:
	else
		cp -v "$file" "$DIR" 
	fi
done

