if [ -z "$IMPALA_HOME" ]; then
    echo "Need to set IMPALA_HOME"
    return 1
fi  
unset IMPALA_TOOLCHAIN
unset IMPALA_LOGS_DIR
unset IMPALA_AUX_TEST_HOME
unset HADOOP_LZO
unset IMPALA_LZO
unset METASTORE_DB
unset SENTRY_POLICY_DB

AAIMPALA_BIN=${IMPALA_HOME}/bin
if [ -f "${AAIMPALA_BIN}/impala-config.sh" ]; then
    . ${AAIMPALA_BIN}/impala-config.sh
    export PATH="${AAIMPALA_BIN}:$PATH"
fi
# start hadoop services

alias run-all='$IMPALA_HOME/testdata/bin/run-all.sh'
alias kill-all='$IMPALA_HOME/testdata/bin/kill-all.sh'
