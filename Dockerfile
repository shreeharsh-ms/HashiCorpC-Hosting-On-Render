# Dockerfile
FROM hashicorp/vault:1.14.3

# Optional: Add your custom configuration files
COPY vault-config.hcl /vault/config/vault-config.hcl

# Expose the Vault port
EXPOSE 8200

CMD ["vault", "server", "-config=/vault/config/vault-config.hcl"]
