#!/bin/zsh

# ─────────────────────────────────────────────────────────────
# Script: system_update.zsh
# Purpose: Update and upgrade system packages on a Debian/Ubuntu system
# Author: Yuen Wee Kin, Edwin
# Usage: Make executable with chmod +x system_update.zsh, then run with ./system_update.zsh
# ─────────────────────────────────────────────────────────────

# Print header.
echo "🔄 Starting system update and upgrade..."

# Refresh the package list.
echo "📦 Updating package list..."
sudo apt update

# Upgrade distribution.
echo "⬆️  Performing full distribution upgrade..."
sudo apt dist-upgrade -y

# Optional: Upgrade to new release (comment out if not required)
# echo "⬆️  Upgrading to new release (Ubuntu)"
# sudo do-release-upgrade

# Optional: Remove unused packages
echo "🧹 Removing unnecessary packages..."
sudo apt autoremove -y
sudo apt autoclean

# Print footer
echo "✅ System update and upgrade complete."

