# setup for pvc

if [ -z "$AAPVC" ]; then
    echo "Need to set AAPVC"
    return 1
fi
if [ -z "$KUBECONFIG" ]; then
    echo "Need to set KUBECONFIG"
    return 1
fi

# settings from https://docs.google.com/document/d/16ySv2fdWdXIABpj5VIgbjD0preIO9CY-pgk0qUr7p0c

export OPENSHIFT_KUBECONFIG=${KUBECONFIG}

export CP_PLATFORM_TYPE=private
export CP_PLATFORM_NAME=openshift

export OPENSHIFT_DB_DRIVER=postgresql
export OPENSHIFT_DB_HOST=postgres-service.cdw-tiller.svc.cluster.local
export OPENSHIFT_DB_NAME=sampledb
export OPENSHIFT_DB_USER=userRUG
export OPENSHIFT_DB_PORT=5432
export OPENSHIFT_DB_SSL_MODE=disable
export OPENSHIFT_DB_PASSWORD=UN2oIscgNirolDeG

# The database names provided during env activation and DBC creation will be automatically created. Works only with postgres.
export CREATE_WAREHOUSE_DATABASES=true

# Shared Docker info: DOCKER_PASSWORD DOCKER_USERNAME DOCKER_SERVER
.  ~/Dropbox/work/cloudera/docker-private.sh

# Settings to enable dev & low-cost mode, which reduces resources
# allocated to virtual warehouses significantly. Please enable
# this if possible.
export ENABLE_DEV_MODE=true
export ENABLE_LOW_COST_MODE=true

# Settings related to getting dwxVersion to work, see DWX-4513 for details
export IMAGE_PULL_POLICY=Always
export IMAGE_VERSION_PREFIX=7.2
export DWX_IMAGE_VERSION_PREFIX=1.1.6
export DWX_IMAGE_NAMESPACE=dwx-1.1.6
export USE_CHARTMAP=false
export CHART_MAP_LOCAL_MODE=true
export LOCAL_FOLDER_FOR_MAPS=./resources/dwx2cdhmaps_private_cloud/
export USE_AVAILABLE_VERSION_CONTROL=false

# Settings specific to OpenShift clusters. For values to use, see shared dev instances.

## Use check_pvc to see if these are set

# Settings to connect with CDP Private control plane and base
# cluster. These need to be retrieved from a running CDP private cloud instance - see Setting up a CDP control plane.
## SDX_CDP_CONSOLE_HOST_URL=
## PRIVATE_CLOUD_ENV_CRN=

# DWX installation namespace, used to get the postgres 
# db root cert from
## CSI_NAMESPACE=

# Used for finding the $OPENSHIFT_NAMESPACE_PREFIX-monitoring-platform
# namespace which is created during environment registration in
# the CDP control plane
## OPENSHIFT_NAMESPACE_PREFIX=

# User Management Service related settings
# See this section on how to get the CRN or copy from here if
# you are using a shared instance
## DEBUG_ACTOR_CRN=

export UMS_ENABLED=true
export UMS_SERVER=localhost
export UMS_PORT=8078

