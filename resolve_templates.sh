#!/usr/bin/env bash
#
# run helm template on chart
#

if [[ ! -d charts/impala-coordinator ]]
then
  echo "must be in DWX home"
  exit 1
fi

BUILD_DIR=/tmp/chart_build
rm -rf ${BUILD_DIR}
mkdir ${BUILD_DIR}
cp -r charts/impala-coordinator ${BUILD_DIR}
rm -rf ${BUILD_DIR}/impala-coordinator/charts/dwx-common
# remove reference to dwx-common from Chart.yaml
TMP_FILE=/tmp/foo$$
cp ${BUILD_DIR}/impala-coordinator/Chart.yaml ${TMP_FILE}
grep -v dwx-common ${TMP_FILE} >${BUILD_DIR}/impala-coordinator/Chart.yaml
# build .tgz file
tar -C ${BUILD_DIR} -czf /tmp/x.tar.tgz impala-coordinator

for saml in true false
do
  echo "saml=$saml"
done
for proxy in true false
do
  echo "proxy=$proxy"
done
helm3 --set 'samlCallbackUrl=true,impalaEnableProxy=true'  template /tmp/x.tar.tgz > /tmp/ssss