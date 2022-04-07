OPENSHIFT_KUBECONFIG=~/.kube/shared-os-dev-01
CP_PLATFORM_TYPE=private
CP_PLATFORM_NAME=openshift

# The database names provided during env activation and DBC creation will be automatically created. Works only with postgres.
CREATE_WAREHOUSE_DATABASES=true

# Shared Docker info
# deleted

# Settings to enable dev & low-cost mode, which reduces resources
# allocated to virtual warehouses significantly. Please enable
# this if possible.
ENABLE_DEV_MODE=true
ENABLE_LOW_COST_MODE=true

# Settings related to getting dwxVersion to work, see DWX-4513 for details
IMAGE_PULL_POLICY=Always
IMAGE_VERSION_PREFIX=2021.0
DWX_IMAGE_VERSION_PREFIX=1.1.8-b44
DWX_IMAGE_NAMESPACE=dwx-1.1.8-b44
SDX_IMAGE_VERSION=1.4.0-b856
USE_CHARTMAP=false
CHART_MAP_LOCAL_MODE=true
LOCAL_FOLDER_FOR_MAPS=./resources/dwx2cdhmaps_private_cloud/
USE_AVAILABLE_VERSION_CONTROL=false


# Settings specific to OpenShift clusters. For values to use, see shared dev instances.

# Settings to connect with CDP Private control plane and base
# cluster. These need to be retrieved from a running CDP private cloud instance - see Setting up a CDP control plane.
SDX_CDP_CONSOLE_HOST_URL=
PRIVATE_CLOUD_ENV_CRN=

# DWX installation namespace, used to get the postgres 
# db root cert from
CSI_NAMESPACE=

# Workload database configurations
OPENSHIFT_DB_DRIVER=postgresql
OPENSHIFT_DB_HOST=cdp-embedded-db.$CSI_NAMESPACE.svc.cluster.local
OPENSHIFT_DB_NAME=sampledb
OPENSHIFT_DB_USER=userRUG
OPENSHIFT_DB_PORT=5432
OPENSHIFT_DB_SSL_MODE=disable
# Password is coming from the secret cdp-release-cdp-embedded-db-secret in $CSI_NAMESPACE
OPENSHIFT_DB_PASSWORD=QnBMbmZnRHNjMldEOEYy



# Used for finding the $OPENSHIFT_NAMESPACE_PREFIX-monitoring-platform
# namespace which is created during environment registration in
# the CDP control plane
OPENSHIFT_NAMESPACE_PREFIX=

# User Management Service related settings
# See this section on how to get the CRN or copy from here if
# you are using a shared instance
DEBUG_ACTOR_CRN=
UMS_ENABLED=true
UMS_SERVER=localhost
UMS_PORT=8078

