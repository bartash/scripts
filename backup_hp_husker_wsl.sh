#!/usr/bin/env bash
#
# Check if the effective user ID is not 0 (i.e., not root)
if (( EUID != 0 )); then
  echo "Error: This script must be run as root or with sudo." >&2
  exit 1
fi


current_hostname=$(hostname)
expected_hostname="HP2-DiningRoom"
if [[ "$current_hostname" != "$expected_hostname" ]]; then
	echo "Hostname is not as expected was: $current_hostname (expected: $expected_hostname)"
fi

SOURCE_VOL=elvis
SOURCE_DRIVE=g
BACKUP_VOL=husker
BACKUP_DRIVE=f

exit 1

cd /cygdrive
b_str=$(cat $BACKUP_DRIVE/VOLUME.txt)
s_str=$(cat $SOURCE_DRIVE/VOLUME.txt)
if [  "$s_str" != ${SOURCE_VOL} ]; then
    	echo "/cygdrive/$SOURCE_DRIVE is not ${SOURCE_VOL} volume, is $s_str"
	exit 1
else
	echo found ${SOURCE_VOL}
fi
if [  "$b_str" != ${BACKUP_VOL} ]; then
    	echo "/cygdrive/$BACKUP_DRIVE is not ${BACKUP_VOL} volume, is $b_str"
	exit 1
else
	echo found ${BACKUP_VOL}
fi

RSYNC_CMD='rsync -av --delete   --no-owner --no-group --ignore-errors'


# copy Elvis completely
echo "backup dvd"
${RSYNC_CMD} ${SOURCE_DRIVE}/dvd ${BACKUP_DRIVE}/from_elvis/Elvis | delete_dir_lines_from_rsync echo "backup docs"
${RSYNC_CMD} ${SOURCE_DRIVE}/docs ${BACKUP_DRIVE}/from_elvis/Elvis | delete_dir_lines_from_rsync
echo "backup the from_home dir"
${RSYNC_CMD} ${SOURCE_DRIVE}/from_home ${BACKUP_DRIVE}/from_elvis/Elvis | delete_dir_lines_from_rsync
echo "backup itunes"
${RSYNC_CMD} ${SOURCE_DRIVE}/itunes ${BACKUP_DRIVE}/from_elvis/Elvis | delete_dir_lines_from_rsync
