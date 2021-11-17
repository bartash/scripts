#!/usr/bin/env bash
# clean Downlaods reliably and not ~
CMF="asherman-cmf.vpc.cloudera.com"
if [[ ${HOSTNAME} != ${CMF}* ]];then
	echo you are on the wrong machine, you should be on ${CMF}
	exit 1
fi
rm -rf ~/Downloads/*
