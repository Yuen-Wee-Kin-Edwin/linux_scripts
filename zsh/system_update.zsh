#!/bin/zsh

# ─────────────────────────────────────────────────────────────
# Script: system_update.zsh
# Purpose: Update and upgrade system packages on a Debian/Ubuntu system
# Author: Edwin (modify as needed)
# Usage: Make executable with chmod +x system_update.zsh, then run with ./system_update.zsh
# ─────────────────────────────────────────────────────────────

# Print header
echo "🔄 Starting system update and upgrade..."

# Refresh the package list
echo "📦 Updating package list..."
sudo apt update

# Upgrade all upgradable packages
echo "⬆️  Upgrading packages..."
sudo apt upgrade -y

# Optional: Upgrade distribution (comment out if not required)
# echo "⬆️  Performing full distribution upgrade..."
# sudo apt dist-upgrade -y

# Optional: Remove unused packages
echo "🧹 Removing unnecessary packages..."
sudo apt autoremove -y
sudo apt autoclean

# Print footer
echo "✅ System update and upgrade complete."

