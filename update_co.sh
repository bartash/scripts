#!/usr/bin/env bash
FROM_VERSION=2022.0.7.1-2
TO_VERSION=2022.0.8.0-82


if [ "$#" -ne 1 ]
then
	echo "usage: $0 coordinator|executor|catalog|statestore"
	exit 1;
fi

case $1 in
coordinator*)
  echo "update coordinator"
  POD_NAME=coordinator-0
  IMAGE_NAME=impalad_coordinator
  ;;
executor*)
  echo "update executor"
  POD_NAME=impala-executor-000-1
  IMAGE_NAME=impalad_executor
  ;;
catalog*)
  echo "update executor"
  POD_NAME=catalog
  IMAGE_NAME=catalogd
  ;;
statestore*)
  echo "update executor"
  POD_NAME=statestore
  IMAGE_NAME=statestored
  ;;
*)
  echo "unrecognized option"
  exit 1
  ;;
esac


if [ "$KUBECONFIG" == "" ]; then
  echo "$PROGNAME: Please set the KUBECONFIG env var."
  exit 1
fi
if [ "$NS" == "" ]; then
  echo "$PROGNAME: Please set the NS env var."
  exit 1
fi

POD=$(kubectl get pods -n $NS | grep $POD_NAME | awk '{print $1}')
echo "POD=$POD"
if [ "$POD" == "" ]; then
  echo "$PROGNAME: could not find pod, maybe ns $NS is wrong."
  exit 1
fi
TMP1=/tmp/from$$
TMP2=/tmp/to$$
kubectl get pod $POD -n $NS -o yaml > $TMP1

sed "s/${IMAGE_NAME}:${FROM_VERSION}/${IMAGE_NAME}:${TO_VERSION}/" < $TMP1 > $TMP2
diff $TMP1 $TMP2

if [[ $? -eq 0 ]]; then
	echo "No diff $TMP1 $TMP2"
	exit 1
fi

kubectl replace -f $TMP2


