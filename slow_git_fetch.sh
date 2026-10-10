#!/usr/bin/env bash
# gradually fetch the rest of a repo, maybe created with 'git clone --depth=1'

REMOTE=origin
if [[ $# -ne 0 ]] ; then
    REMOTE=$1
fi
# edit depth when you start FIXME add parameter
depth=1
while true
do
  echo "git fetch --depth $depth $REMOTE"
  git fetch --depth $depth $REMOTE
  depth=$((depth + 100))
  sleep 10
done