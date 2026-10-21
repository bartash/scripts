#!/usr/bin/env bash
# dump json from shared cluster

TMP=/tmp/json$$
export PGPASSWORD=pvc
echo "select json from edws_cluster where cloud_platform='OPENSHIFT'" |\
  psql -t -q -U pvc --output=$TMP
python -m json.tool < $TMP 

