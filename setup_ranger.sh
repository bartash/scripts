# based on https://cwiki.apache.org/confluence/display/IMPALA/How+to+start+a+Ranger-enabled+Impala+minicluster
# using latest code from  testdata/bin/create-load-data.sh 


RANGER_SETUP_DIR="${IMPALA_HOME}/testdata/cluster/ranger/setup"

perl -wpl -e 's/\$\{([^}]+)\}/defined $ENV{$1} ? $ENV{$1} : $&/eg' \
"${RANGER_SETUP_DIR}/impala_group_owner.json.template" > \
"${RANGER_SETUP_DIR}/impala_group_owner.json"

GROUP_ID_OWNER=$(wget -qO - --auth-no-challenge --user=admin --password=admin \
--post-file="${RANGER_SETUP_DIR}/impala_group_owner.json" \
--header="accept:application/json" \
--header="Content-Type:application/json" \
http://localhost:6080/service/xusers/secure/groups |
python -c "import sys, json; print json.load(sys.stdin)['id']")
export GROUP_ID_OWNER

GROUP_ID_NON_OWNER=$(wget -qO - --auth-no-challenge --user=admin \
--password=admin --post-file="${RANGER_SETUP_DIR}/impala_group_non_owner.json" \
--header="accept:application/json" \
--header="Content-Type:application/json" \
http://localhost:6080/service/xusers/secure/groups |
python -c "import sys, json; print json.load(sys.stdin)['id']")
export GROUP_ID_NON_OWNER

perl -wpl -e 's/\$\{([^}]+)\}/defined $ENV{$1} ? $ENV{$1} : $&/eg' \
"${RANGER_SETUP_DIR}/impala_user_owner.json.template" > \
"${RANGER_SETUP_DIR}/impala_user_owner.json"

perl -wpl -e 's/\$\{([^}]+)\}/defined $ENV{$1} ? $ENV{$1} : $&/eg' \
"${RANGER_SETUP_DIR}/impala_user_non_owner.json.template" > \
"${RANGER_SETUP_DIR}/impala_user_non_owner.json"

if grep "\${[A-Z_]*}" "${RANGER_SETUP_DIR}/impala_user_owner.json"; then
echo "Found undefined variables in ${RANGER_SETUP_DIR}/impala_user_owner.json."
exit 1
fi

if grep "\${[A-Z_]*}" "${RANGER_SETUP_DIR}/impala_user_non_owner.json"; then
echo "Found undefined variables in ${RANGER_SETUP_DIR}/impala_user_non_owner.json."
exit 1
fi

wget -O /dev/null --auth-no-challenge --user=admin --password=admin \
--post-file="${RANGER_SETUP_DIR}/impala_user_owner.json" \
--header="Content-Type:application/json" \
http://localhost:6080/service/xusers/secure/users

wget -O /dev/null --auth-no-challenge --user=admin --password=admin \
--post-file="${RANGER_SETUP_DIR}/impala_user_non_owner.json" \
--header="Content-Type:application/json" \
http://localhost:6080/service/xusers/secure/users

wget -O /dev/null --auth-no-challenge --user=admin --password=admin \
--post-file="${RANGER_SETUP_DIR}/impala_service.json" \
--header="Content-Type:application/json" \
http://localhost:6080/service/public/v2/api/service

curl -f -u admin:admin -H "Accept: application/json" \
-H "Content-Type: application/json" \
-X PUT http://localhost:6080/service/public/v2/api/policy/5 \
-d @"${RANGER_SETUP_DIR}/policy_5_revised.json"
