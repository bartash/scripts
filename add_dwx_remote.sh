#!/usr/bin/env bash
if [ "$#" -ne 1 ]
then
 echo "usage $0 login-name"
 exit 1
fi
NAME=$1
git remote add $NAME git@github.infra.cloudera.com:$NAME/dwx.git
git fetch $NAME

