#!/usr/bin/env bash
NUM_FILES_TO_CREATE=4
DIR=smalldir
BUCKET=asherman-cluster

for i in $(seq 1 $NUM_FILES_TO_CREATE)
do
  echo "create file $i"
  echo $i > foo
  aws s3api put-object --bucket $BUCKET --key testdata/$DIR/data${i}.txt --body foo
done