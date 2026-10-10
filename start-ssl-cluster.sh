#!/usr/bin/env bash
#
# start impala cluster with ssl
#
if [ -z "$IMPALA_HOME" ]; then
	echo "IMPALA_HOME not set"
	exit 2;
fi

SERVER_CERT=${IMPALA_HOME}/be/src/testutil/server-cert.pem
SERVER_KEY=${IMPALA_HOME}/be/src/testutil/server-key.pem

SSL_ARGS="--ssl_client_ca_certificate=${SERVER_CERT} \
  --ssl_server_certificate=${SERVER_CERT} \
  --ssl_private_key=${SERVER_KEY} \
  --webserver_certificate_file=${SERVER_CERT} \
  --webserver_private_key_file=${SERVER_KEY} \
  --hostname=localhost \
  --webserver_interface=localhost "

# echo "SSL_SRGS=${SSL_ARGS}"

start-impala-cluster.py --cluster_size=1 --impalad_args="${SSL_ARGS}" \
  --catalogd_args="${SSL_ARGS}" \
  --state_store_args="${SSL_ARGS}" \