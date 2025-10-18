# Vault configuration using environment variables for PostgreSQL backend

storage "postgresql" {
  connection_url = "postgresql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}?sslmode=disable"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1   # Change to 0 for production TLS
}

ui = true
