#!/usr/bin/env bash
git log | grep ^Author: | awk '{print $2, $3}' | awk '{count[$0]++} END {for (j in count) print count[j], j}'  | sort -rn