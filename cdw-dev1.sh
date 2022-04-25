# Start a new script for restart

# values from https://docs.google.com/document/d/16ySv2fdWdXIABpj5VIgbjD0preIO9CY-pgk0qUr7p0c/edit#
export OPENSHIFT_KUBECONFIG=/home/asherman/.kube/shared-os-dev-01
export CP_PLATFORM_TYPE=private
export CP_PLATFORM_NAME=openshift

# The database names provided during env activation and DBC creation will be automatically created. Works only with postgres.
export CREATE_WAREHOUSE_DATABASES=true


# Settings to enable dev & low-cost mode, which reduces resources
# allocated to virtual warehouses significantly. Please enable
# this if possible.
export ENABLE_DEV_MODE=true
export ENABLE_LOW_COST_MODE=true

# Settings related to getting dwxVersion to work, see DWX-4513 for details
export IMAGE_PULL_POLICY=Always



export IMAGE_VERSION_PREFIX="2022.0.7"
export DWX_IMAGE_VERSION_PREFIX="1.3.0"
export SDX_IMAGE_VERSION="1.4.0-b856"
export USE_CHARTMAP=false
export CHART_MAP_LOCAL_MODE=true
export USE_AVAILABLE_VERSION_CONTROL=false


# Settings specific to OpenShift clusters. For values to use, see shared dev instances.

# Settings to connect with CDP Private control plane and base
# cluster. These need to be retrieved from a running CDP private cloud instance - see Setting up a CDP control plane.
export SDX_CDP_CONSOLE_HOST_URL=https://luksan-psql-1.luksan-psql.root.hwx.site:7183/cmf/home




export PRIVATE_CLOUD_ENV_CRN="crn:altus:environments:us-west-1:4f00cc61-cb71-4059-94f5-2f1e2db3e6cc:environment:asherman3-env-1/3df03a7d-6d69-4746-87e1-fb0caf41f35c"

# DWX installation namespace, used to get the postgres 
# db root cert from
export CSI_NAMESPACE=asherman3

# Workload database configurations
export OPENSHIFT_DB_DRIVER=postgresql
export OPENSHIFT_DB_HOST=cdp-embedded-db.asherman3.svc.cluster.local
export OPENSHIFT_DB_NAME=pvc
export OPENSHIFT_DB_USER=pvc
export OPENSHIFT_DB_PORT=5432
export OPENSHIFT_DB_SSL_MODE=disable
# Password is coming from the secret cdp-release-cdp-embedded-db-secret in $CSI_NAMESPACE
export OPENSHIFT_DB_PASSWORD=pvc



# Used for finding the $OPENSHIFT_NAMESPACE_PREFIX-monitoring-platform
# namespace which is created during environment registration in
# the CDP control plane
export OPENSHIFT_NAMESPACE_PREFIX=asherman3-env-1-3df03a7d

# User Management Service related settings
# See this section on how to get the CRN or copy from here if
# you are using a shared instance
export DEBUG_ACTOR_CRN="crn:altus:iam:us-west-1:4f00cc61-cb71-4059-94f5-2f1e2db3e6cc:user:b3ac0618-f569-4745-a0ef-8391a93b06a5"
export UMS_ENABLED=true
export UMS_SERVER=localhost
export UMS_PORT=8078

