#!/bin/bash
set -e

# Wait for PostgreSQL to be ready
until pg_isready -h dpg-d3piv8jipnbc739v0d60-a -p 5432 -U vault_db_m7gc_user; do
  echo "Waiting for PostgreSQL..."
  sleep 2
done

echo "PostgreSQL ready. Starting Vault..."

# Start Vault in the background
vault server -config=/vault/config/vault-config.hcl &
VAULT_PID=$!

# Wait a few seconds for Vault to be ready to accept requests
sleep 5

# Check if Vault is initialized
if ! vault status | grep -q 'Initialized.*true'; then
    echo "Initializing Vault..."
    vault operator init -key-shares=1 -key-threshold=1 -format=json > /vault/init.json
    echo "Vault initialized. Keys and token saved in /vault/init.json"
fi

# Wait indefinitely (or until Vault exits)
wait $VAULT_PID
