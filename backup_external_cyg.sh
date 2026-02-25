(set -o igncr) 2>/dev/null && set -o igncr; # comment is needed

cd /cygdrive
echo backup_external ...

SOURCE=h
BACK=e


if [ ! -d ${BACK} ]; then
	echo Could not find ${BACK} volume
	exit 1
else
	echo found ${BACK}
fi
if [ ! -d ${BACK}/backup ]; then
	echo "Could not find ${BACK}/backup, maybe wrong drive mounted"
	exit 1
else
	echo found ${BACK}
fi
if [ ! -d ${SOURCE} ]; then
	echo Could not find ${SOURCE} volume
	exit 1
else
	echo found ${SOURCE}
fi
echo "source is $SOURCE backup to $BACK"
echo "backup data"
rsync -av --exclude '*.lnk'  --exclude '.canary' --delete  --no-owner --no-group   $SOURCE/data $BACK/backup | ~/scripts/delete_dir_lines_from_rsync
echo "backup everything on $SOURCE"
rsync -av --exclude '*.lnk'  --exclude '.canary' --delete  --no-owner --no-group   $SOURCE/* $BACK/backup | ~/scripts/delete_dir_lines_from_rsync
