#!/usr/bin/env bash
# convert ripped dvd into mp3

find . -type f -name "*.m4v" -print0 | while IFS= read -r -d '' file; do
    echo "file = '$file'"
done

