#!/usr/bin/env bash
# need to copy to cygwin with
#  cp backup_hp_husker_cyg.sh /mnt/c/cygwin64/home/Andrew/scripts
#
if $(id -G | grep -qE '\<(114|544)\>')
then
	echo "running as admin"
else
	echo "not admin"
	exit 1
fi

current_hostname=$(hostname)
expected_hostname="HP2-DiningRoom"
if [[ "$current_hostname" != "$expected_hostname" ]]; then
	echo "Hostname is not as expected was: $current_hostname (expected: $expected_hostname)"
	exit 1
fi

BACKUP_VOL=husker
BACKUP_DRIVE=f


cd /cygdrive
b_str=$(cat $BACKUP_DRIVE/VOLUME.txt)
if [  "$b_str" != ${BACKUP_VOL} ]; then
    	echo "/cygdrive/$BACKUP_DRIVE is not ${BACKUP_VOL} volume, is $b_str"
	exit 1
fi


RSYNC_CMD='rsync -av --delete --exclude=*RECYCLE.BIN*  --no-owner --no-group --ignore-errors'

# copy g drive completely
echo "backup g"
# ${RSYNC_CMD} /cygdrive/g ${BACKUP_DRIVE}/g_drive_copy | delete_dir_lines_from_rsync 
${RSYNC_CMD} /cygdrive/g ${BACKUP_DRIVE}/g_drive_copy 
