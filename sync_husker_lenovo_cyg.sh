#!/usr/bin/env bash
#
if $(id -G | grep -qE '\<(114|544)\>')
then
	echo "running as admin"
else
	echo "not admin"
	exit 1
fi

current_hostname=$(hostname)
expected_hostname="LENOVO-DINING"
if [[ "$current_hostname" != "$expected_hostname" ]]; then
	echo "Hostname is not as expected was: $current_hostname (expected: $expected_hostname)"
	exit 1
fi

BACKUP_VOL=husker
BACKUP_DRIVE=e


cd /cygdrive
b_str=$(cat $BACKUP_DRIVE/VOLUME.txt)
if [  "$b_str" != ${BACKUP_VOL} ]; then
    	echo "/cygdrive/$BACKUP_DRIVE is not ${BACKUP_VOL} volume, is $b_str"
	exit 1
fi



echo "cp chrome profiles"

AMY2="/cygdrive/e/amy-chrome-profiles/User Data/Amy2"
AMY2_TARGET="/cygdrive/g/data/Profiles/sunnyside"

cp -v "$AMY2"/Bookmarks $AMY2_TARGET/Default/Bookmarks
cp -v "$AMY2"/History $AMY2_TARGET/Default/History
cp -v "$AMY2"/History-journal $AMY2_TARGET/Default/History-journal

# Sessions/Tbas not easily copyable!!
## rm $AMY2_TARGET/Default/Sessions/*
## cp -v "$AMY2"/Sessions/* $AMY2_TARGET/Default/Sessions

echo "exiting early -FIXME remove"
exit 1


RSYNC_CMD='rsync -av --delete --exclude=*RECYCLE.BIN* --exclude=*FVE2* --no-owner --no-group --ignore-errors'

# sync g drive completely, use * so that anything else ther is not deleted.
echo "backup g"
${RSYNC_CMD} ${BACKUP_DRIVE}/g_drive_copy/g/* /cygdrive/g  | delete_dir_lines_from_rsync



