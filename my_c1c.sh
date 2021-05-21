# setup for dwx

if [ -z "$AAC1C" ]; then
    echo "Need to set AAC1C"
    return 1
fi
if [ -z "$GOPATH" ]; then
    echo "Need to set GOPATH"
    return 1
fi

export MYPROMPT=$AAC1C

# export GO111MODULE=on

export C1C_HOME=$GOPATH/..

. ~/scripts/gosetup.sh


alias ihome="cd $C1C_HOME"

# USE_IMPALA_AUTOSCALER_IMAGE=false
export USE_IMPALA_AUTOSCALER_IMAGE=true

export OWNER='asherman@cloudera.com'

export PATH=$PATH:/usr/local/kubebuilder/bin

