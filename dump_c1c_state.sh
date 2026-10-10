#!/usr/bin/env bash
#
# save off c1c state

FILE=~/tmp/c1c_save_$$
rm -f $FILE
echo "output is $FILE"
echo "==pods==" > $FILE
kubectl get pods --all-namespaces  >> $FILE
echo "--------"  >> $FILE
echo "==tenants==" >> $FILE
kubectl get tenants -o yaml >> $FILE
echo "--------"  >> $FILE
echo "==namespace-pool==" >> $FILE
kubectl get NamespacePool -o yaml  >> $FILE
echo "--------"  >> $FILE
echo "==pod-pool==" >> $FILE
kubectl get PodPool -o yaml  >> $FILE
echo "--------"  >> $FILE
