#!/usr/bin/env bash
# Run queries in impala-shell with many different users

# Start cluster with
# start-impala-cluster.py --impalad_args="-fair_scheduler_allocation_path=fe/src/test/resources/fair-scheduler-test2.xml
# -llama_site_path=fe/src/test/resources/llama-site-test2.xml"

# Number of concurrent users
TOTAL_USERS=4
if [ "$#" -eq 1 ]
then
	TOTAL_USERS=$1
fi

QUERY='set REQUEST_POOL=queueE; select * from hoo where a <  sleep (60000);'

for user_number in $(seq 1 ${TOTAL_USERS})
do
  IMPALA_USER="user-${user_number}"
  echo "user is ${IMPALA_USER}"
  impala-shell.sh -u ${IMPALA_USER}  -i localhost:21050 -q "${QUERY}" &
  sleep 0.1
done
