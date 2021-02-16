#!/usr/bin/env bash
#
# Edit a chart ot make it helm3 compatible
#

if [ "$#" -ne 1 ]
then
 echo "usage $0 <chart tgz file>"
 exit 1
fi
ORIG=$1
if [ ! -f $ORIG ] ; then
  echo "file $ORIG not found"
  exit 1
fi

NEWFILE=$(echo $ORIG | sed 's/.tgz/-helm3.tgz/')
#echo ORIG=$ORIG
#echo NEWFILE=$NEWFILE
DIR=impala-coordinator
rm -rf $DIR

echo "Extract from $ORIG"
tar xf $ORIG

IHOME=/home/asherman/git/go4/src/github.com/hortonworks/edws
pushd $IHOME
make mutate
popd
# mutater works on $DIR
$IHOME/mutater
LINT_OUT=$(helm3 lint impala-coordinator |& grep -v INFO |\
  grep -v deprecated |\
  grep -v 'chart metadata is missing these dependencies: dwx-common' |\
  grep -v 'Error: 1 chart(s) linted, 1 chart(s) failed' |\
  grep -v '==> Linting impala-coordinator' |\
  grep -v ^$
)
if [ ! -z "$LINT_OUT" ]; then
  echo "************ lint $LINT_OUT"
else
  echo lint clean
fi

echo "Write $DIR into $NEWFILE"
tar czf  $NEWFILE  $DIR
