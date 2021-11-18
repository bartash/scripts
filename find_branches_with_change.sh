#!/usr/bin/env bash
if [ "$#" -ne 1 ]
then
	echo "usage: $0 IMPALA-XXXXX"
	exit 1;
fi

for commit in $(git log --all | grep -B 4  $1  | grep ^commit | awk '{print $2}')
do
  echo $commit
  git branch -r --contains $commit
done
