#!/usr/bin/env bash
# add some lines after matching a pattern
gsed -i '/	numFiles/a\\tnumFilesErasureCoded	0\t' $1
