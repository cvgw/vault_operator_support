#!/bin/bash
set -e -x
wget https://releases.hashicorp.com/vault/1.0.1/vault_1.0.1_linux_amd64.zip
sudo unzip vault_1.0.1_linux_amd64.zip -d /usr/local/bin
