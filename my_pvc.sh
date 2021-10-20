# setup for pvc

if [ -z "$AAPVC" ]; then
    echo "Need to set AAPVC"
    return 1
fi
if [ -z "$KUBECONFIG" ]; then
    echo "Need to set KUBECONFIG"
    return 1
fi

