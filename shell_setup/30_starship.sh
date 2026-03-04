#!/usr/bin/env bash
# Install and configure Starship

set -euo pipefail

curl -sS https://starship.rs/install.sh | sh -s -- -y

ZSHRC="$HOME/.zshrc"

if ! grep -q 'starship init zsh' "$ZSHRC"; then
    {
        echo ""
        echo "# Initialise Starship prompt"
        echo 'eval "$(starship init zsh)"'
    } >> "$ZSHRC"
fi