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

export C1C_HOME=$HOME/git/c1c/c1c-oe

. ~/scripts/gosetup.sh


alias ihome="cd $C1C_HOME"

# USE_IMPALA_AUTOSCALER_IMAGE=false
export USE_IMPALA_AUTOSCALER_IMAGE=true

export OWNER='asherman@cloudera.com'

export PATH=$PATH:/usr/local/kubebuilder/bin

# The one true cluster
export KUBECONFIG=/home/asherman/.kube/liftie-rv5wb5cg

# new use aoc magic
. /home/asherman/.bashrc_aws-okta

# On cloudcat machine I get
# 'org.gnome.keyring.SystemPrompter' failed
# and I have not yet been able to fix this on a headless machine,
# Storing secret in file is bearable if passphrase is <CR>
if [[ "$HOSTNAME" == "asherman-cc.vpc.cloudera.com" ]]; then
    export AWS_OKTA_BACKEND=file
fi


