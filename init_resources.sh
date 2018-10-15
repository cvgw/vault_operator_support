#!/bin/bash
set -e
echo Creating Resources
kubectl create serviceaccount vault
kubectl create -f example/rbac.yaml
kubectl create -f example/etcd_crds.yaml
kubectl create -f example/etcd-operator-deploy.yaml
kubectl create -f example/vault_crd.yaml
kubectl create -f example/deployment.yaml
