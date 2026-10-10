# backup camera on cygwin
# Notes are https://docs.google.com/document/d/1GOjqgzrKrjrBY74cffm2znBrGzxVfVQm7giK_9Zt6aU/edit

#  mtpmount-x64 mount "Galaxy A03s" "Internal storage" W

WIN_HOME="/cygdrive/c/Users/ac9"
BACK_DIR="$WIN_HOME/backup"
PICS_DIR="$BACK_DIR/camera_pictures"
CAMERA="/cygdrive/w/DCIM/Camera"

mkdir -p $PICS_DIR
rsync -av --delete --no-owner --no-group $CAMERA $PICS_DIR
