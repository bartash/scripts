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
ZIP_FILE=/tmp/x.tar.tgz

rm -rf ${BUILD_DIR}
mkdir ${BUILD_DIR}
cp -r charts/impala-coordinator ${BUILD_DIR}
rm -rf ${BUILD_DIR}/impala-coordinator/charts/dwx-common
# remove reference to dwx-common from Chart.yaml
TMP_FILE=/tmp/foo$$
cp ${BUILD_DIR}/impala-coordinator/Chart.yaml ${TMP_FILE}
grep -v dwx-common ${TMP_FILE} >${BUILD_DIR}/impala-coordinator/Chart.yaml
# build .tgz file
tar -C ${BUILD_DIR} -czf ${ZIP_FILE} impala-coordinator

for saml in true false
do
  for proxy in true false
  do
    OUTPUT="helm_output-proxy=${proxy}-saml=${saml}.out"
    echo "OUTPUT=${OUTPUT}"
    helm3 --set "samlCallbackUrl=${saml},impalaEnableProxy=${proxy}"  template ${ZIP_FILE} > ${OUTPUT}
    echo diff ${OUTPUT} ~/tmp/orig/${OUTPUT}
    diff ${OUTPUT} ~/tmp/orig/${OUTPUT}
  done
done

# diff helm_output-proxy=false-saml=true.out helm_output-proxy=true-saml=true.out

