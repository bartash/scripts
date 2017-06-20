
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

alias vvbtlinux43='vncserver -geometry 1450x980 :2'
alias vvb='vncserver -geometry 1900x1050  :1'
alias vv='vncserver -geometry 1900x1000  :1'
alias vvlenovo='vncserver -geometry 1300x680 :3'
alias ff='/scratch/apsherma/bin/firefox/firefox'

alias sethttp='export http_proxy=www-proxy.us.oracle.com:80 ; export https_proxy=www-proxy.us.oracle.com:80'
alias unsethttp='unset http_proxy ; unset https_proxy'


# setup a 3node
3node() {
  node1=$1
  if [ -z $node1 ];
  then
      echo INTERNAL_HTTPS_REGISTRYSERVICE_URL = $INTERNAL_HTTPS_REGISTRYSERVICE_URL
      echo EXTERNAL_REGISTRYSERVICE_URL =  $EXTERNAL_REGISTRYSERVICE_URL
      echo APMAAS_EMAAS_REGISTRYSERVICE_URL = $APMAAS_EMAAS_REGISTRYSERVICE_URL
  else
      export INTERNAL_HTTPS_REGISTRYSERVICE_URL="https://${node1}.us.oracle.com:7005/registry/servicemanager/registry/v1/"
      export EXTERNAL_REGISTRYSERVICE_URL="https://${node1}.us.oracle.com:4443/registry/"
      export APMAAS_EMAAS_REGISTRYSERVICE_URL="http://${node1}.us.oracle.com:7004/registry/servicemanager/registry/v1/"
  fi
}

unset SSH_ASKPASS
