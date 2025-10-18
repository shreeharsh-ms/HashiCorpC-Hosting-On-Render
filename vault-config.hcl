ui = true

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1   # Only for testing. For production, enable TLS
}

storage "postgresql" {
  connection_url = "postgresql://postgres.ctsgvdupihtowsceuvhv:puxre8-cucqar-Xunryd@aws-1-us-east-1.pooler.supabase.com:6543/postgres"
  table          = "vault_kv_store"  # Vault will create this table if it doesn't exist
}

disable_mlock = true   # Required on unprivileged containers like Render
