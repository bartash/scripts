rm -rf /tmp/chart_build
mkdir /tmp/chart_build
cp -r charts/dwx-common /tmp/chart_build
cp -r charts/impala-coordinator /tmp/chart_build
tar -C /tmp/chart_build   -czf /tmp/x.tar.tgz impala-coordinator
