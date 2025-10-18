ui = true

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1   # For production, replace with TLS-enabled configuration
}

storage "postgresql" {
  connection_url = "postgresql://vault_db_m7gc_user:ZEtRmToZ5qmKpHzrjRbDsBuMQy2CjCzG@dpg-d3piv8jipnbc739v0d60-a:5432/vault_db_m7gc?sslmode=require"
  table          = "vault_kv_store"
}

disable_mlock = true  # Required on unprivileged containers like Render
