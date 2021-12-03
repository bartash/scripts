# show all the ids  from edws_cluster in the db
echo 'select id, environment_id from edws_cluster' | psql -t -q -U postgres
