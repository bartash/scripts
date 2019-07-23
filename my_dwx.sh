# setup for dwx

if [ -z "$AADWX" ]; then
    echo "Need to set AADWX"
    return 1
fi  

export GOPATH=$HOME/git/go
export GO111MODULE=on 
export DWX_HOME=$GOPATH/src/github.com/hortonworks/edws
. ~/scripts/gosetup.sh
export PATH=$PATH:/home/asherman/git/asf/Impala3/toolchain/cdh_components-1137441/hadoop-3.0.0-cdh6.x-SNAPSHOT/bin

. ~/Dropbox/work/cloudera/${AADWX}_env.sh
alias ihome="cd $DWX_HOME" 

