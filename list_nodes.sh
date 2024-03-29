#!/usr/bin/env bash
# pretty-print pods on nodes
NODES=/tmp/nd$$

kubectl get nodes --no-headers  | awk '{print $1}' > $NODES
for node in $(cat $NODES)
do
  id=$(kubectl describe node $node | grep ProviderID: | awk '{print $2}')
  echo "NODE $node $id"
  kubectl get pods --all-namespaces  --field-selector spec.nodeName=$node | grep -v ^cluster | grep -v ^kube-system |\
  awk '{printf "%-55s %-20s\n", $2, $1}'
  echo "-----------"
done
