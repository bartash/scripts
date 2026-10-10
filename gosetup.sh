if [[ ! -v GOPATH ]]
then
  echo GOPATH not set
fi

if [[ ! -v GOROOT ]]
then
  echo GOROOT not set
fi

export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
