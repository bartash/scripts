#!/usr/bin/env bash
# pretty-print pods on nodes
NODES=/tmp/nd$$

kubectl get nodes --no-headers  | awk '{print $1}' > $NODES
for node in $(cat $NODES)
do
  echo $node
  kubectl get pods --all-namespaces  --field-selector spec.nodeName=$node | grep -v ^cluster | grep -v ^kube-system
  echo "-----------"
done
