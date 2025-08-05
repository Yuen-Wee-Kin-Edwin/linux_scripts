#!/bin/zsh

# ─────────────────────────────────────────────────────────────
# Script: rust_update.zsh
# Purpose: Update and upgrade rust
# Author: Edwin (modify as needed)
# Usage: Make executable with chmod +x system_update.zsh, then run with ./system_update.zsh
# ─────────────────────────────────────────────────────────────

# Print header
echo "🔄 Starting rust update..."

# Upgrade rust
echo "⬆️  Updating rust"
rustup update

# Print footer
echo "✅ rust update complete."

