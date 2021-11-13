# Some values from a recent env
export KUBECONFIG=~/.kube/cdw-dev-kubeconfig
export SDX_CDP_CONSOLE_HOST_URL="https://console-asherman2.apps.cdw-dev.kcloud.cloudera.com/"
export CSI_NAMESPACE="asherman2"
export OPENSHIFT_NAMESPACE_PREFIX="asherman2-env-1-f85e7a62"
# DEBUG_ACTOR_CRN comes from the cdp-pvt-session-token cookie
# chrome browser tools->Application->Cookies
# Paste it to https://jwt.io/ to decode
export DEBUG_ACTOR_CRN="crn:altus:iam:us-west-1:5f7b4303-cbfe-44e0-86c7-43e074868122:user:8b7c8609-6dc1-4b2d-bd71-d287e3bf1bc9"

# Values from Norbert's note https://cloudera.slack.com/archives/C010JDW7RRR/p1636564517010900
export DWX_IMAGE_NAMESPACE="1.1.7-b19"
export DWX_IMAGE_VERSION_PREFIX="1.1.7-b19"
export IMAGE_VERSION_PREFIX="7.2"
export SDX_IMAGE_VERSION="1.4.0-b248"
