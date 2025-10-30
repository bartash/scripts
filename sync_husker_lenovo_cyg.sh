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

for FROM in Amy2 Amy3 Default
do
  for TO in sunnyside balboa chrome1
  do
    SOURCE="/cygdrive/e/amy-chrome-profiles/User Data/$FROM"
    TARGET="/cygdrive/g/data/Profiles/$TO"
    # mkdir -p $TARGET/Default
    #
    # The profile directory (e.g. sunnyside) must be there on ALO side and populated.
    # Note that ALO must have full permissions on ghe Profile directory or you get
    # errors about the Profile.
    # After profile dir is made them chrome should be started using --user=data-dir
    # this will fill in the profile files.
    cp -v "$SOURCE"/Bookmarks $TARGET/Default/Bookmarks
    cp -v "$SOURCE"/History $TARGET/Default/History
    cp -v "$SOURCE"/History-journal $TARGET/Default/History-journal
    chown -R Amy $TARGET
    chgrp -R ac9 $TARGET
    chmod -R a+rwx $TARGET
  done
  break
done

exit 1

# Sessions/Tabs not easily copyable!!
## rm $TARGET/Default/Sessions/*
## cp -v "$SOURCE"/Sessions/* $TARGET/Default/Sessions

echo "copy thunderbird profile"
THUNDER_SRC="/cygdrive/e/amy-thunderbird-email/profiles/jfpbkkhj.default"
THUNDER_TARGET="/cygdrive/g/data/AmyThunderbirdProfile"
mkdir -p $THUNDER_TARGET
#ls -ld $THUNDER_SRC
#ls -ld $THUNDER_TARGET
rm -rf $THUNDER_TARGET/*
cp -r $THUNDER_SRC/* $THUNDER_TARGET
chown -R Amy $THUNDER_TARGET
chgrp -R ac9 $THUNDER_TARGET
chmod -R a+rwx $THUNDER_TARGET

RSYNC_CMD='rsync -av --delete \
           --exclude=*RECYCLE.BIN* \
           --exclude=*FVE2* \
           --exclude=AmyThunderbirdProfile/* \
           --exclude=AmyThunderbirdProfile \
           --exclude=Profiles/* \
           --exclude=Profiles \
           --no-owner --no-group --ignore-errors'

# sync g drive completely, use * so that anything else there is not deleted.
echo "backup g"
${RSYNC_CMD} ${BACKUP_DRIVE}/g_drive_copy/g/* /cygdrive/g  | delete_dir_lines_from_rsync



