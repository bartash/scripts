#!/usr/bin/env bash
set -e
if [ "$#" -ne 1 ]
then
 echo "usage $0 patch-file"
 exit 1
fi
FILE=$1
echo patch file is $FILE

sh ./testutils/ptest2/src/main/resources/smart-apply-patch.sh $FILE
AUTHOR=`grep Author: $FILE | sed 's/Author: //'`
if [ -z "$AUTHOR" ]
then
    echo could not find AUTHOR
    exit 1
fi

echo AUTHOR is $AUTHOR

SHORTAUTHOR=`echo $AUTHOR | sed 's/<.*//' | sed 's/ *$//'`
echo SHORTAUTHOR is $SHORTAUTHOR

MSG=`grep HIVE- $FILE | head -1 | sed 's/^ *//'`
echo MSG is $MSG

COMMITTER=`git config user.name`

git commit --author="$AUTHOR" -m "${MSG} (${SHORTAUTHOR}, reviewed by ${COMMITTER})"

echo

git log --pretty=fuller -1