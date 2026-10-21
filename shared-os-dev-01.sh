export VAULT_ADDR="https://vault-shared-os-dev-01-control-plane-vault.apps.shared-os-dev-01.kcloud.cloudera.com"
export VAULT_SKIP_VERIFY="True"
vault login -method=ldap username=asherman@cloudera.com
