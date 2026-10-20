#!/usr/bin/env bash
#
# make_plex_extras_dirs.sh
#
# Creates the standard Plex "local extras" subdirectories inside a movie folder.
#
# Usage:
#   ./make_plex_extras_dirs.sh "/path/to/Movies/Movie Name (2020)"
#   ./make_plex_extras_dirs.sh          # uses current directory if no path given

set -euo pipefail

TARGET_DIR="${1:-.}"

if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: '$TARGET_DIR' is not a directory." >&2
    exit 1
fi

EXTRAS_DIRS=(
    "Behind The Scenes"
    "Deleted Scenes"
    "Featurettes"
    "Interviews"
    "Scenes"
    "Shorts"
    "Trailers"
    "Other"
)

for dir in "${EXTRAS_DIRS[@]}"; do
    mkdir -p "$TARGET_DIR/$dir"
    echo "Created: $TARGET_DIR/$dir"
done

echo "Done. Plex extras subdirectories are ready in: $TARGET_DIR"
