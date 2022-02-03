#!/usr/bin/env bash
# dump json from shared cluster

TMP=/tmp/json$$
echo "select json from edws_cluster" |\
  psql -t -q -U postgres --output=$TMP
python -m json.tool < $TMP

