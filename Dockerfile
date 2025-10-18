# Use official Vault image
FROM hashicorp/vault:1.14.3

# Create Vault config directory
RUN mkdir -p /vault/config /vault/file

# Copy config
COPY vault-config.hcl /vault/config/vault-config.hcl

# Set working directory
WORKDIR /vault

# Expose Vault port
EXPOSE 8200

# Run Vault server in dev mode with root token
CMD ["vault", "server", "-dev", "-dev-root-token-id=root"]
