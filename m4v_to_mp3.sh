#!/usr/bin/env bash
# convert ripped dvd into mp3

find . -type f -name "*.m4v" -print0 | while IFS= read -r -d '' file; do
	echo "file = '$file'"
	new=$(echo $file | sed 's/.m4v/.mp3/' | sed 's?./??')
	echo new=$new
	echo ffmpeg -i $file -q:a 0 -map a $new
done

