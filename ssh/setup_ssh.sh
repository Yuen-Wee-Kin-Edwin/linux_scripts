#!/bin/bash
# Script to install and configure OpenSSH client and server on Ubuntu/Debian systems.

# Exit immediately if a command exists with a non-zero status.
set -e

echo "=== Installing OpenSSH client ==="
sudo apt update
sudo apt install -y openssh-client

echo "=== Installing OpenSSH server ==="
sudo apt install -y openssh-server

echo "=== Checking SSH service status ==="
sudo systemctl status ssh --no-pager

echo "=== Enabling SSH service to start on boot ==="
sudo systemctl enable ssh

echo "=== Starting SSH service now ==="
sudo systemctl start ssh

echo "=== Adding firewall rule to allow SSH (port 22/tcp) ==="
sudo ufw allow ssh

echo "=== SSH setup complete ==="