#!/usr/bin/env bash
# add some lines after matching a pattern
INPUT=xref.all
if [ "$#" -eq 1 ]
then
  INPUT=$1
fi
TMP=/tmp/add_lines$$

pushd /Users/asherman/git/bartash/experiments/dice/src
javac ./com/bartash/dice/FixNumFilesLine.java
popd

grep .q.out  $INPUT | grep -v erasurecoding | xargs grep -l 'numFiles' > $TMP
wc -l $TMP
for file in `cat $TMP`
do
    java -cp /Users/asherman/git/bartash/experiments/dice/src  com.bartash.dice.FixNumFilesLine $file
done
