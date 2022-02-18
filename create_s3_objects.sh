#!/usr/bin/env bash
END=4
DIR=smalldir

for i in $(seq 1 $END)
do
  echo $i
  echo $i > foo
  aws s3api put-object --bucket asherman-cluster --key testdata/$DIR/data${i}.txt --body foo
done