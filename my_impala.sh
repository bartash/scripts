if [ -z "$IMPALA_HOME" ]; then
    echo "Need to set IMPALA_HOME"
    return 1
fi  
# unset IMPALA_TOOLCHAIN
unset IMPALA_LOGS_DIR
unset IMPALA_AUX_TEST_HOME
unset HADOOP_LZO
unset IMPALA_LZO
unset METASTORE_DB
unset SENTRY_POLICY_DB

IMPALA_BIN=${IMPALA_HOME}/bin
if [ -f "${IMPALA_BIN}/impala-config.sh" ]; then
    . ${IMPALA_BIN}/impala-config.sh
    export PATH="${IMPALA_BIN}:${PATH}"
    export PATH="${IMPALA_HOME}/toolchain/llvm-5.0.1-p1/bin:${PATH}"
    export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:${LD_LIBRARY_PATH}
fi

# scripts to start and stop hadoop services
alias run-all='$IMPALA_HOME/testdata/bin/run-all.sh'
alias kill-all='$IMPALA_HOME/testdata/bin/kill-all.sh'
alias stop-all=kill-all
alias stop-impala-cluster='start-impala-cluster.py --kill'
alias ihome="cd $IMPALA_HOME"
