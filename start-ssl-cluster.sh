#!/usr/bin/env bash
#
# start impala cluster with ssl
#
if [ -z "$IMPALA_HOME" ]; then
	echo "IMPALA_HOME not set"
	exit 2;
fi

SSL_ARGS="--ssl_client_ca_certificate=${IMPALA_HOME}/be/src/testutil/server-cert.pem --ssl_server_certificate=${IMPALA_HOME}/be/src/testutil/server-cert.pem --ssl_private_key=${IMPALA_HOME}/be/src/testutil/server-key.pem --hostname=localhost"
# echo "SSL_SRGS=${SSL_ARGS}"

start-impala-cluster.py --cluster_size=1 --impalad_args="${SSL_ARGS}" --catalogd_args="${SSL_ARGS}" --state_store_args="${SSL_ARGS}"
