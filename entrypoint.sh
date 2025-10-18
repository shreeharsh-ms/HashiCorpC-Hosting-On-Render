#!/bin/bash
set -e

export PGPASSWORD="ZEtRmToZ5qmKpHzrjRbDsBuMQy2CjCzG"

# Wait for PostgreSQL to be ready
until pg_isready -h dpg-d3piv8jipnbc739v0d60-a.oregon-postgres.render.com -p 5432 -U vault_db_m7gc_user; do
  echo "Waiting for PostgreSQL..."
  sleep 2
done

echo "PostgreSQL ready. Starting Vault..."

# Start Vault
vault server -config=/vault/config/vault-config.hcl &
VAULT_PID=$!

# Wait until Vault is ready
until vault status >/dev/null 2>&1; do
  sleep 2
done

# Initialize Vault if not initialized
if ! vault status -format=json | jq -e '.initialized' >/dev/null; then
    vault operator init -key-shares=1 -key-threshold=1 -format=json > /vault/init.json
    echo "Vault initialized. Keys and token saved in /vault/init.json"
fi

wait $VAULT_PID
