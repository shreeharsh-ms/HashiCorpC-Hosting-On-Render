ui = true

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1  # Only for testing. Enable TLS in production
}

storage "postgresql" {
  connection_url = "postgresql://vault_user:puxre8-cucqar-Xunryd@aws-1-us-east-1.pooler.supabase.com:6543/postgres?sslmode=require"
  table          = "vault_kv_store"  # Vault will create this table if it doesn't exist
}

disable_mlock = true  # Required on unprivileged containers like Render
