# show all the ids  from edws_cluster in the db
echo 'select id, environment_id, account_id, cloud_platform, created_by from edws_cluster' | psql -t -q -U postgres
