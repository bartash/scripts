#!/usr/bin/env bash
# add some lines after matching a pattern
gsed -i '/	numFiles/a  numFilesErasureCoded	0\t' $1
