
# aliases
alias ll='ls -l'
alias la='ls -a'
alias h=history
alias pu=pushd
alias po=popd
alias a=alias
alias fin='find . -type f -print > xref.all'

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
