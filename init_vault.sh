#!/bin/bash

export VAULT_FORMAT=json
export VAULT_ADDR=https://localhost:8200
export VAULT_SKIP_VERIFY=true

if ! [ -x "$(command -v vault)" ]; then
  echo 'vault executable must be present'
  exit 1
fi

function connect_to_vault_instance {
  POD_ID=$(kubectl -n default get vault example -o jsonpath='{.status.vaultStatus.sealed[0]}')
  if [ -z "${POD_ID}" ]
  then
    echo "no vault instance found"
    exit 1
  fi
  echo ${POD_ID}
  
  if [ ! -z "${LAST_POD_ID}" ]
  then
    if [ "${POD_ID}" == "${LAST_POD_ID}" ]
    then
      echo "pod id is the same as the last pod"
      exit 1
    fi
  fi
  LAST_POD_ID=$POD_ID

  kubectl -n default port-forward ${POD_ID} 8200 &
  FORWARD_DAEMON_PID=$!
  sleep 5
  echo ${FORWARD_DAEMON_PID}
}

function unseal_instance {
  keys=$unseal_keys
  for i in {0..2}; do
    vault operator unseal $(echo ${keys} | jq -r --argjson v ${i} '.[$v]')
  done
}

echo 'connecting to first vault instance'
connect_to_vault_instance

vault status

creds=$(vault operator init)

echo ${creds} > ./vault_creds.json

unseal_keys=$(echo ${creds} | jq '.unseal_keys_b64')
unseal_instance
kill ${FORWARD_DAEMON_PID}

sleep 10

echo 'connecting to second vault instance'
connect_to_vault_instance
unseal_instance
kill ${FORWARD_DAEMON_PID}

echo 'both instances unsealed'