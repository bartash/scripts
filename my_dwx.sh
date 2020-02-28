# setup for dwx

if [ -z "$AADWX" ]; then
    echo "Need to set AADWX"
    return 1
fi
if [ -z "$GOPATH" ]; then
    echo "Need to set GOPATH"
    return 1
fi

export MYPROMPT=$AADWX
export GO111MODULE=on
export DWX_HOME=$GOPATH/src/github.com/hortonworks/edws
. ~/scripts/gosetup.sh

# dwx needs hadoop on dir path
hadoop_dirs=$(find ~/git/asf/Impala/toolchain -name hadoop-3.0.0-cdh6.x-SNAPSHOT)
hadoop_dir_list=($hadoop_dirs)
# just take first one, they are not sorted
hadoop_dir=${hadoop_dir_list[0]}
export PATH=$PATH:$hadoop_dir/bin

. ~/Dropbox/work/cloudera/${AADWX}_env.sh
alias ihome="cd $DWX_HOME"

# USE_IMPALA_AUTOSCALER_IMAGE=false
export USE_IMPALA_AUTOSCALER_IMAGE=true

export OWNER='asherman@cloudera.com'

export PATH=$PATH:/usr/local/kubebuilder/bin
