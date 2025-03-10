#!/usr/bin/env bash
#
# start impala cluster with admission controller pools
#
if [ -z "$IMPALA_HOME" ]; then
	echo "IMPALA_HOME not set"
	exit 2;
fi

FAIR="mem-limit-test-fair-scheduler.xml"
LLAMA="mem-limit-test-llama-site.xml"

${IMPALA_HOME}/bin/start-impala-cluster.py \
 --cluster_size=3 --num_coordinators=3 --log_dir=/tmp/ --log_level=1 \
 --impalad_args="-fair_scheduler_allocation_path ${IMPALA_HOME}/fe/src/test/resources/${FAIR} \
    -llama_site_path ${IMPALA_HOME}/fe/src/test/resources/${LLAMA}" \
 --state_store_args="--statestore_update_frequency_ms=50   --statestore_priority_update_frequency_ms=50 \
    --statestore_heartbeat_frequency_ms=50"

# impala-shell -q 'set request_pool=root.memLimitCoordExecClamp; select * from foo'

