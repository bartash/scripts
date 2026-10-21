#
# Search for log4j files in all containers of all pods
#
# Note that 'kubectl get pods -o wide -A' does a lot of this....
#
export KUBECONFIG=~/.kube/dwx-rzs556
export NS=compute-1639142720-gvtw  
# export NS=impala-1639153773-6bfg
for pod in $(kubectl  get pods -n $NS |  grep -v NAME | awk '{print $1}')
do 
	for container in $(kubectl -n $NS get pods $pod -o jsonpath={.spec.containers[*].name})
	do 
		echo "$pod $container"
		TMP=/tmp/xx-$pod-$container
		kubectl -n $NS exec -it $pod -c $container  -- ls -R /  > $TMP
		grep -i log4j $TMP
	done
	# init containers
	for init_container in $(kubectl -n $NS get pods $pod -o jsonpath={.spec.initContainers[*].name})
	do 
		echo "ignoring $pod $init_container (init container)"
	done
done

