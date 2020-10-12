#!/usr/bin/env bash

#
# Script to install https://github.com/adnanh/webhook
#

# Get Absolute Path of the base repo
repo_root="$(git rev-parse --show-toplevel)"

# Webhook version
webhook_version="2.7.0"

# Get Arch
arch="amd64"
case "$(dpkg --print-architecture)" in
  'arm32v7') arch="arm" ;;
  'arm64v8') arch="arm64" ;;
esac

# Download binary
curl -Lso \
  /tmp/webhook.tar.gz \
  "https://github.com/adnanh/webhook/releases/download/${webhook_version}/webhook-linux-${arch}.tar.gz"

# Extract binary
tar ixzf /tmp/webhook.tar.gz -C /usr/local/bin --strip-components 1

# Remove compressed file
rm -rf /tmp/webhook.tar.gz

# Set as executable
chmod +x /usr/local/bin/webhook

# Create service
cp "${repo_root}/power-outage/webhook.service" /etc/systemd/system/webhook.service

# Enable service
systemctl enable webhook.service

# Start service
systemctl start webhook.service
