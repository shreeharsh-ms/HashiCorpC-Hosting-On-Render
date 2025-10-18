# Use the official Vault image
FROM hashicorp/vault:1.14.1

# Expose Vault default port
EXPOSE 8200

# Run Vault in dev mode (root token: root)
CMD ["vault", "server", "-dev", "-dev-root-token-id=root"]
