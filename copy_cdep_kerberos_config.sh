#!/usr/bin/env bash
#
# copy the kerberos config from a cdep cluster
# See https://docs.google.com/document/d/1VjZ-U2HBGX4AFozWAHDk3qUh0NPhue4xersUSGK3pns for gory details
#

if [ "$#" -ne 1 ]
then
  echo "usage $0 hostname"
  exit 1
fi

HOST=$1
CONFIG=~/tmp/cdep_kerberos_$$
mkdir ${CONFIG}
cd ${CONFIG}

echo "Copying keytab files to ${CONFIG}"
scp -r -i ~/.ssh/systest_rsa  systest@${HOST}:/cdep .
echo "Copying krb5.conf files to ${CONFIG}"
scp -r -i ~/.ssh/systest_rsa  systest@${HOST}:/etc/krb5.conf .
echo "Overwriting /etc/krb5.conf"
sudo cp krb5.conf /etc/krb5.conf
echo "Copying certificate"
scp -r  -i ~/.ssh/systest_rsa  systest@${HOST}:/var/lib/cloudera-scm-agent/agent-cert/cm-auto-global_cacerts.pem .
echo "Running kinit for systest"
kinit -kt cdep/keytabs/systest.keytab systest

echo "Impala-shell string"
echo "impala-shell -i ${HOST} -d default -k --ssl --ca_cert=${CONFIG}/cm-auto-global_cacerts.pem"



