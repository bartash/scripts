#!/usr/bin/env bash

if [ "$KUBECONFIG" == "" ]; then
  echo "$PROGNAME: Please set the KUBECONFIG env var."
  exit 1
fi
if [ "$NS" == "" ]; then
  echo "$PROGNAME: Please set the NS env var."
  exit 1
fi

POD=$(kubectl get pods -n $NS | grep statestore | awk '{print $1}')
echo "POD=$POD"
if [ "$POD" == "" ]; then
  echo "$PROGNAME: could not find pod, maybe ns $NS is wrong."
  exit 1
fi
TMP1=/tmp/from$$
TMP2=/tmp/to$$
kubectl get pod $POD -n $NS -o yaml > $TMP1

sed 's/statestored:2022.0.7.1-2/statestored:2022.0.8.0-82/' < $TMP1 > $TMP2
diff $TMP1 $TMP2

if [[ $? -eq 0 ]]; then
	echo "No diff $TMP1 $TMP2"
	exit 1
fi

kubectl replace -f $TMP2


