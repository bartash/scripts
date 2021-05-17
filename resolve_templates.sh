#
# run helm templatye on chart
#
rm -rf /tmp/chart_build
mkdir /tmp/chart_build
cp -r charts/impala-coordinator /tmp/chart_build
# cp -r charts/dwx-common /tmp/chart_build
rm -rf /tmp/chart_build/impala-coordinator/charts/dwx-common
cp /tmp/chart_build/impala-coordinator/Chart.yaml /tmp/foo
grep -v dwx-common /tmp/foo > /tmp/chart_build/impala-coordinator/Chart.yaml
tar -C /tmp/chart_build   -czf /tmp/x.tar.tgz impala-coordinator
helm3 template /tmp/x.tar.tgz
