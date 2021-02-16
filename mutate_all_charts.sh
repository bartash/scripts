#!/usr/bin/env bash

# run mutate for all releases
# release list from https://docs.google.com/spreadsheets/d/1fzkw7TIAIbDvoZeTvi8ahvXm8it2ZeXHhHFk2JaLgR8
for release in 1.1.1.0-24 1.1.1.1-4 1.1.2-b1021 1.1.2-b340 1.1.2-b383 1.1.2-b448 1.1.2-b648 1.1.2-b718 1.1.2-b947 1.1.2-b982 1.1.2-h1-b1 1.1.2-h1-b3 1.1.2-h2-b3 1.1.2-h4-b1
do
  file=impala-coordinator-${release}.tgz
  if [ ! -f $file ]; then
    echo "cannot find file $file"
    exit 1
  else
    echo "found file $file"
  fi
#  mutate_chart.sh ${release}
done