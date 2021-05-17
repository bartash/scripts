#
# run helm template on chart
#
BUILD_DIR=/tmp/chart_build
rm -rf ${BUILD_DIR}
mkdir ${BUILD_DIR}
cp -r charts/impala-coordinator ${BUILD_DIR}
rm -rf ${BUILD_DIR}/impala-coordinator/charts/dwx-common
TMP_FILE=/tmp/foo$$
cp ${BUILD_DIR}/impala-coordinator/Chart.yaml ${TMP_FILE}
grep -v dwx-common ${TMP_FILE} >${BUILD_DIR}/impala-coordinator/Chart.yaml
tar -C ${BUILD_DIR} -czf /tmp/x.tar.tgz impala-coordinator
helm3 template /tmp/x.tar.tgz
