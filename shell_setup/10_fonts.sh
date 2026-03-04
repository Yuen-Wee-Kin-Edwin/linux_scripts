#!/usr/bin/env bash
# Install FiraCode Nerd Font if missing

source "$(dirname "$0")/lib.sh"

FONT_NAME="FiraCode Nerd Font"
FONT_VERSION="v3.4.0"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/${FONT_VERSION}/FiraCode.zip"
FONT_DIR="$HOME/.local/share/fonts"
TMP_ZIP="/tmp/FiraCode.zip"

if fc-list | grep -iq "$FONT_NAME"; then
    echo "Font already installed."
    exit 0
fi

mkdir -p "$FONT_DIR"

curl -fsSL "$FONT_URL" -o "$TMP_ZIP"
unzip -o "$TMP_ZIP" -d "$FONT_DIR"
rm -f "$TMP_ZIP"

fc-cache -fv

echo "Font installation complete."