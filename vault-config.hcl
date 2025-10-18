ui = true

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1   # For production, replace with proper TLS
}

storage "file" {
  path = "/vault/data"
}

disable_mlock = true   # Required on unprivileged containers like Render
