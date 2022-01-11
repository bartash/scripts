#!/usr/bin/env bash
#
# Brute force hack to find opening word pairs for wordle that cover etaionshrd
# e.g. "adore" "hints"
# or for "etaionshru" => "train" "house"
#
COMMON=/tmp/comm$$
CROSS=/tmp/cross$$
ET='[etaionshrdlucmf]'
egrep "^${ET}${ET}${ET}${ET}${ET}$" /usr/share/dict/american-english > $COMMON
for i in $(cat $COMMON)
do
	for j in $(cat $COMMON)
	do
	    candidate=$i$j
	    count=$(echo $candidate | sed 's/\(.\)/\1\n/g'  | sort -u | wc -l)
      if [[ "$count" != "11" ]]
      then
#        echo reject $candidate
        continue
#      else
#        echo ok $candidate
      fi

	  for k in $(cat $COMMON)
	  do
	    candidate=$i$j$k
	    count=$(echo $candidate | sed 's/\(.\)/\1\n/g'  | sort -u | wc -l)
            if [[ "$count" != "16" ]]
            then
      #        echo reject $candidate
              continue
      #      else
      #        echo ok $candidate
            fi
		  echo $i$j$k >> $CROSS
		done
	done
done

# this is now redundant
for word in $(cat $CROSS)
do
  count=$(echo $word | sed 's/\(.\)/\1\n/g'  | sort -u | wc -l)
  if [[ "$count" == "16" ]]
  then
    echo ${word:0:5}  ${word:5:10} ${word:10:15}
  fi
done
