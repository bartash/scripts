#!/usr/bin/env bash
#
# start impala cluster with admission controller pools
#
if [ -z "$IMPALA_HOME" ]; then
	echo "IMPALA_HOME not set"
	exit 2;
fi

FAIR=fair-scheduler-test2.xml
LLAMA=llama-site-test2.xml

# need --admission_control_slots
${IMPALA_HOME}/bin/start-impala-cluster.py \
 --cluster_size=3 --num_coordinators=3  --log_level=1 \
    --catalogd_args="--enable_workload_mgmt=true" \
 --impalad_args="-fair_scheduler_allocation_path ${IMPALA_HOME}/fe/src/test/resources/${FAIR} \
    --enable_workload_mgmt=true \
    -llama_site_path ${IMPALA_HOME}/fe/src/test/resources/${LLAMA}" \
 --state_store_args="--statestore_update_frequency_ms=50   --statestore_priority_update_frequency_ms=50 \
    --statestore_heartbeat_frequency_ms=50"

# impala-shell -q 'set request_pool=root.queueF; select * from foo'
# impala-shell -q 'set request_pool=root.queueF; set mt_dop=8 ;select * from foo'
