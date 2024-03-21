#
git log | grep Reviewed-by:  | cut -c 18-  | awk '{count[$0]++} END {for (j in count) print count[j], j}'  | sort -rn
