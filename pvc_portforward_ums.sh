#!/usr/bin/env bash
# Run the following script to use the UMS from the Control Plane
#
# https://docs.google.com/document/d/16ySv2fdWdXIABpj5VIgbjD0preIO9CY-pgk0qUr7p0c/edit#
#
# Set CSI_NAMESPACE in advance to DWX installation NS
if [[ ! -v KUBECONFIG ]]; then
    echo "KUBECONFIG not set"
    exit 1
fi
if [[ ! -v CSI_NAMESPACE ]]; then
    echo "CSI_NAMESPACE not set"
    exit 1
fi
# Get UMS service name
export UMS_POD_NAME=$(kubectl get pods -l app=thunderhead-usermanagement-private  -o jsonpath="{.items[0].metadata.name}" -n $CSI_NAMESPACE)

# Start port forwarding
while :
do
  kubectl -n $CSI_NAMESPACE port-forward pod/$UMS_POD_NAME 8078:8982
  sleep 0.1
done
