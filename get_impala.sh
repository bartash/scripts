#!/usr/bin/env bash
# dump json from impalas

TMP=/tmp/jxon$$
echo "select json from edws_impala where id = 'impala-1639531395-6hs7'" |\
  psql -t -q -U postgres --output=$TMP
python -m json.tool < $TMP 

