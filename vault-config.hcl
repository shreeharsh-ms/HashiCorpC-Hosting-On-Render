storage "postgresql" {
  connection_url = "postgresql://vault_db_m7gc_user:ZEtRmToZ5qmKpHzrjRbDsBuMQy2CjCzG@dpg-d3piv8jipnbc739v0d60-a:5432/vault_db_m7gc?sslmode=disable"
}

listener "tcp" {
  address     = "0.0.0.0:${PORT}"
  tls_disable = 1
}

ui = true
