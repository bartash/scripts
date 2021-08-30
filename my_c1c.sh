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

# for now allow a switch to other cluster
alias c1c-env1='export KUBECONFIG=/home/asherman/.kube/liftie-rv5wb5cg'
alias c1c-env2='export KUBECONFIG=/home/asherman/.kube/liftie-4mrnzc7k'
alias c1c-mini='export KUBECONFIG=/home/asherman/.kube/minikube'
alias c1c-kind='export KUBECONFIG=/home/asherman/.kube/kind'

# switch to tenant2
alias c1c-tenant1='export C1C_TENANT=xcu2-8y8x'
alias c1c-tenant2='export C1C_TENANT=ycu2-8y8x'


# new use aoc magic
. /home/asherman/.bashrc_aws-okta

# On cloudcat machine I get
# 'org.gnome.keyring.SystemPrompter' failed
# and I have not yet been able to fix this on a headless machine,
# Storing secret in file is bearable if passphrase is <CR>
if [[ "$HOSTNAME" == "asherman-cc.vpc.cloudera.com" ]]; then
    export AWS_OKTA_BACKEND=file
fi


