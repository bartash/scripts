#!/usr/bin/env bash
# gradually fetch the rest of a repo, maybe created with 'git clone --depth=1'

# edit depth when you start FIXME add parameter
depth=6000
while true
do
  depth=$((depth + 100))
  echo "depth is $depth"
  git fetch --depth $depth
  sleep 10
done