#!/bin/bash
set -e

# Wait for PostgreSQL
until pg_isready -h "$VAULT_DB_HOST" -p "$VAULT_DB_PORT" -U "$VAULT_DB_USER"; do
  echo "Waiting for PostgreSQL..."
  sleep 2
done

echo "PostgreSQL ready. Starting Vault..."

# Start Vault in background
vault server -config=/vault/config/vault-config.hcl &
VAULT_PID=$!

# Wait for Vault to start listening
echo "Waiting for Vault to become ready..."
export VAULT_ADDR="http://127.0.0.1:${PORT}"
until vault status >/dev/null 2>&1; do
  echo "Vault not ready yet..."
  sleep 2
done

# Initialize if needed
if ! vault status -format=json | jq -e '.initialized' >/dev/null; then
  echo "Initializing Vault..."
  vault operator init -key-shares=1 -key-threshold=1 -format=json > /vault/init.json
  echo "Vault initialized. Keys and token saved in /vault/init.json"
fi

# Keep Vault running
wait $VAULT_PID
