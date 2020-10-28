#!/usr/bin/env bash
# download from azure WIP
#
# This assumes call to 'az' will work
# Go to https://portal.azure.com
# ->storage accounts
# -> cslazure130  (or whatever)
# -> Access keys
# export AZURE_STORAGE_CONNECTION_STRING=xxxx

if [ $# -ne 1 ] ; then
    	echo "Usage $0 path"
    	exit 0
fi
CONTAINER=logs
DOWNLOAD_PATH=$1
TMP1=/tmp/azure1$$
TMP2=/tmp/azure2$$
az storage fs file list -f $CONTAINER --path $DOWNLOAD_PATH > $TMP1
# FIXME check for continuation markers and deal
grep name $TMP1 | awk '{print $2}' | sed 's/\",//' | sed 's/\"//' | sed 's?.*/??' > $TMP2
for name in $(cat $TMP2)
do
	az storage fs file download  -f logs --path "$DOWNLOAD_PATH/$name"
	echo did $name
done
