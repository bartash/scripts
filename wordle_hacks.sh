#!/usr/bin/env bash
#
# Brute force hack to find opening word pairs for wordle that cover etaionshrd
# e.g. "adore" "hints"
# or for "etaionshru" => "train" "house"
#
COMMON=/tmp/comm$$
CROSS=/tmp/cross$$
ET='[etaionshru]'
egrep "^${ET}${ET}${ET}${ET}${ET}$" /usr/share/dict/american-english > $COMMON
for i in $(cat $COMMON)
do
	for j in $(cat $COMMON)
	do
		echo $i$j >> $CROSS
	done
done

for word in $(cat $CROSS)
do
  count=$(echo $word | sed 's/\(.\)/\1\n/g'  | sort -u | wc -l)
  if [[ "$count" == "11" ]]
  then
    echo ${word:0:5}  ${word:5:10}
  fi
done
