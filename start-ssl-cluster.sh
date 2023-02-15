
#
# start impala cluster with ssl
if [ -z "$IMPALA_HOME" ]; then
	echo "IMPALA_HOME not set"
	exit 2;
fi

SSL_ARGS="--ssl_client_ca_certificate=$IMPALA_HOME/be/src/testutil/server-cert.pem --ssl_server_certificate=$IMPALA_HOME/be/src/testutil/server-cert.pem --ssl_private_key=$IMPALA_HOME/be/src/testutil/server-key.pem --hostname=localhost"
