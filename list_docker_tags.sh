#
DWX=cloudera/dwx
IMPALA=cloudera/impalad_coordinator
curl -i -u${UNIFIED_REGISTRY_DOCKER_USERNAME}:"${UNIFIED_REGISTRY_DOCKER_PASSWORD}" ${UNIFIED_REGISTRY_DOCKER_SERVER}v2/${DWX}/tags/list

