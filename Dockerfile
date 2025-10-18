# Base image
FROM ubuntu:22.04

# Install required packages
RUN apt-get update && \
    apt-get install -y curl unzip && \
    apt-get clean

# Download and install Vault
RUN curl -O https://releases.hashicorp.com/vault/1.14.1/vault_1.14.1_linux_amd64.zip \
    && unzip vault_1.14.1_linux_amd64.zip \
    && mv vault /usr/local/bin/ \
    && rm vault_1.14.1_linux_amd64.zip

# Create directories
RUN mkdir -p /vault/config /vault/data

# Add a non-root user
RUN useradd -m vaultuser && chown -R vaultuser:vaultuser /vault

# Copy Vault configuration
COPY vault-config.hcl /vault/config/vault-config.hcl

# Set working directory
WORKDIR /vault

# Expose Vault port
EXPOSE 8200

# Switch to non-root user
USER vaultuser

# Start Vault server in normal mode
CMD ["vault", "server", "-config=/vault/config/vault-config.hcl"]
