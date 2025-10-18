# Enable Vault UI
ui = true

# TCP listener
listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}

# Storage backend (file for dev/testing)
storage "file" {
  path = "/vault/file"
}

# Disable mlock (needed for Render)
disable_mlock = true
