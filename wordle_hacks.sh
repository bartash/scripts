#!/usr/bin/env bash
#
# Brute force hack to find opening word impala for wordle that cover etaionshrd
# e.g. "adore" "hints"
# or for "etaionshru" => "train" "house"
# With 3 words there are more examples, e.g. ached flour mints
#
# Maybe the appraoch in https://garethrees.org/2022/01/08/wordle/ is better
#
COMMON=/tmp/comm$$
ET='[etaionshrdlucmy]'
egrep "^${ET}${ET}${ET}${ET}${ET}$" /usr/share/dict/american-english > $COMMON
for i in $(cat $COMMON)
do
	for j in $(cat $COMMON)
	do
	    candidate=$i$j
	    count=$(echo $candidate | sed 's/\(.\)/\1\n/g'  | sort -u | wc -l)
      if [[ "$count" != "11" ]]
      then
        # reject this candidate
        continue
      fi

	  for k in $(cat $COMMON)
	  do
	    candidate=$i$j$k
	    count=$(echo $candidate | sed 's/\(.\)/\1\n/g'  | sort -u | wc -l)
            if [[ "$count" != "16" ]]
            then
              # reject this candidate
              continue
            fi
		  echo $i$j$k
		done
	done
done

