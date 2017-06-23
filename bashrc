
# aliases
alias ll='ls -l'
alias la='ls -a'
alias l='ls -F'
alias h=history
alias pu=pushd
alias po=popd
alias a=alias
alias cx='chmod a+x'
alias fin='find . -type f -print  | fgrep -v /.git/  > xref.all'

# alias vvbtlinux43='vncserver -geometry 1450x980 :2'
# alias vvb='vncserver -geometry 1900x1050  :1'
# alias vv='vncserver -geometry 1900x1000  :1'
alias vvlenovo='vncserver -geometry 1300x680 :3'
# alias ff='/scratch/apsherma/bin/firefox/firefox'

alias unsethttp='unset http_proxy ; unset https_proxy'

# https://stackoverflow.com/questions/30247603
alias amend='EDITOR=gvim git commit --amend'

# stop errors like "readlink: illegal option -- f"
# export SPARK_HOME=foo
export HIVE_SKIP_SPARK_ASSEMBLY=true
export PATH="/usr/local/opt/protobuf@2.5/bin:$PATH"

export AAHADOOP_VERSION=2.8.0
alias hstart="/usr/local/Cellar/hadoop/${AAHADOOP_VERSION}/sbin/start-dfs.sh;/usr/local/Cellar/hadoop/${AAHADOOP_VERSION}/sbin/start-yarn.sh"
alias hstop="/usr/local/Cellar/hadoop/${AAHADOOP_VERSION}/sbin/stop-yarn.sh;/usr/local/Cellar/hadoop/${AAHADOOP_VERSION}/sbin/stop-dfs.sh"


# after brew install findutils
alias find=gfind
