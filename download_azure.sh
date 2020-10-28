# downlaod from azure
container=logs
PATH=$1
TMP1=/tmp/azure1$$
TMP2=/tmp/azure2$$
az storage fs file list -f $container --path $1 > $AZURE1
# FIXME check for containuation markers
grep name $TMP1 | awk '{print $2}' | sed 's/",//' | sed 's/"//' | sed 's?.*/??' > $TMP2
for i in $(cat $TMP2);
do i
	az storage fs file download  -f logs --path "$PATH/$i"
	echo did $i
done
