#!/usr/bin/env bash
#
# backup phone by dragging Camera folder to g:/data/CameraPhotosBackup
# after mvoging old folder.
# Then run this script in the backup directory (Camera).
set -e
if [ "$#" -ne 1 ]
then
 echo "usage $0 arg1 are you sure, did you read the source? arg is junk"
 exit 1
fi
arg=$1
echo arg is $arg

MONTHS=(ZERO Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)


TARGET="/cygdrive/g/data/Home Photos/0-Phone-1-Photos"
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
	month_name=$(echo ${MONTHS[10#$month]}-${year})
	# echo "month=$month or $month_name"
	DIR="$TARGET/$year/$month_name"
	if [ ! -d "$DIR" ]
		then
		echo "no target month dir $DIR - creating it"
		mkdir -p "$DIR"
		# exit 1
	fi
	if [ -f "$DIR/$file" ] 
	then
		echo "file $DIR/$file exists already"
		:
	else
		cp -uv "$file" "$DIR" 
	fi

	
done

