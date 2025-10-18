FROM ubuntu:22.04

RUN apt-get update && apt-get install -y curl unzip

# Download Vault binary
RUN curl -O https://releases.hashicorp.com/vault/1.14.1/vault_1.14.1_linux_amd64.zip \
    && unzip vault_1.14.1_linux_amd64.zip \
    && mv vault /usr/local/bin/ \
    && rm vault_1.14.1_linux_amd64.zip

# Set Vault config directory
RUN mkdir -p /vault/config
COPY vault-config.hcl /vault/config/vault-config.hcl

EXPOSE $PORT

CMD ["vault", "server", "-config=/vault/config/vault-config.hcl"]
