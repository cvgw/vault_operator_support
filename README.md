# Description
Some useful tools for working with the coreos vault operator
# Prerequisites
* Locally running Kubernetes Cluster
* The Vault CLI
# Getting started
Clone the repo for the [coreos vault operator](https://github.com/coreos/vault-operator)
```
git clone git@github.com:coreos/vault-operator
```
Clone this repo
```
git clone git@github.com:cvgw/vault_operator_support
```
Navigate to the root of the coreos/vault-operator
```
cd ~/src/github.com/coreos/vault-operator
```
With your K8s cluster accessable via `kubectl` create the operator resources using the script in vault_operator_support
```
$ ~/src/github.com/cvgw/vault_operator_support/init_resources.sh
```
Create the example vault cluster
```
$ kubectl create -f ./example/example_vault.yaml
```
Wait until the pods have been created

Navigate to the root of vault_operator_support
```
$ cd ~/src/github.com/cvgw/vault_operator_support
```
Initialize and unseal the vault instance
```
$ ./init_vault.sh
```
# Using the Vault cluster
Setup port forwarding to the active vault instance
```
$ kubectl -n default get vault example -o jsonpath='{.status.vaultStatus.active}' | xargs -0 -I {} kubectl -n default port-forward {} 8200
```
```
export VAULT_ADDR=https://localhost:8200
export VAULT_SKIP_VERIFY=true
```
## Example usage
```
$ vault login ${ROOT_TOKEN}
```
```
$ vault policy write k8s-policy vault_policy.hcl
```
```
$ vault token create --policy k8s-policy
```
collect the token from the output
```
$ vault write secret/foo bar=baz
```
