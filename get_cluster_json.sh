#!/usr/bin/env bash
# dump json from shared cluster

TMP=/tmp/json$$
echo "select json from edws_cluster where cloud_platform='AWS' AND account_id='dev-account'" |\
  psql -t -q -U postgres --output=$TMP
python -m json.tool < $TMP 

