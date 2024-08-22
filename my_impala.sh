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
    # export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:${LD_LIBRARY_PATH}
fi

# scripts to start and stop hadoop services
alias run-all='$IMPALA_HOME/testdata/bin/run-all.sh'
alias kill-all='$IMPALA_HOME/testdata/bin/kill-all.sh'
alias stop-all=kill-all
alias stop-impala-cluster='start-impala-cluster.py --kill'
alias ihome="cd $IMPALA_HOME"




case ${HOSTNAME} in
DISABLED_asherman-desktop*)
  echo "enabling distcc"
  # https://cloudera.atlassian.net/wiki/spaces/ENG/pages/100832437/Tips+for+Faster+Impala+Builds
  export BUILD_FARM="vc0332.halxg.cloudera.com/96,lzo vc0336.halxg.cloudera.com/96,lzo"
  source "${IMPALA_HOME}"/bin/distcc/distcc_env.sh
  # May be required to update the build parallelism if you changed BUILD_FARM.
  switch_compiler distcc
  # sudo ln -s $IMPALA_HOME/toolchain /opt/Impala-Toolchain
  
  # start clion from impala dir
  # look at IMPALA_BUILD_THREADS and set in clion settigns for -j 
  ;;

*)
  echo "not enabling distcc"
  ;;
esac


# Impyla stuff
export IMPALA_REPO=$IMPALA_HOME
export IMPYLA_REPO=~/git/cloudera/impyla
export IMPYLA_SKIP_HIVE_TESTS=True

export IMPALA_LINKER=mold
export IMPALA_MINIMAL_DEBUG_INFO=true

