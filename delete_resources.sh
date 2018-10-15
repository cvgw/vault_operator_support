#!/bin/bash
set -e
echo Deleting Resources
kubectl delete deployment.extensions/vault-operator
kubectl delete customresourcedefinition.apiextensions.k8s.io/vaultservices.vault.security.coreos.com
kubectl delete deployment.extensions/etcd-operator
kubectl delete customresourcedefinition.apiextensions.k8s.io/etcdrestores.etcd.database.coreos.com
kubectl delete customresourcedefinition.apiextensions.k8s.io/etcdbackups.etcd.database.coreos.com
kubectl delete customresourcedefinition.apiextensions.k8s.io/etcdclusters.etcd.database.coreos.com
kubectl delete rolebinding.rbac.authorization.k8s.io/vault-operator-rolebinding
kubectl delete role.rbac.authorization.k8s.io/vault-operator-role
kubectl delete serviceaccount/vault
