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
$IHOME/mutater

echo "Write $DIR into $NEWFILE"
tar czf  $NEWFILE  $DIR
