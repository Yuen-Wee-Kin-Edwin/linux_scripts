#!/usr/bin/env zsh
# snap_setup.zsh
# Ensure snapd is installed, active, and properly configured for Zsh.

set -euo pipefail

ZSHRC="$HOME/.zshrc"
SNAP_BIN="/snap/bin"
PATH_LINE='export PATH="$PATH:/snap/bin"'

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

install_snapd() {
    echo "Installing snapd..."

    if command_exists apt; then
        sudo apt update
        sudo apt install -y snapd
    else
        echo "Unsupported package manager."
        exit 1
    fi
}

ensure_snap_service() {
    # Enable and start snapd service
    sudo systemctl enable --now snapd.socket >/dev/null 2>&1 || true
    sudo systemctl enable --now snapd.service >/dev/null 2>&1 || true

    # Wait briefly for snapd to become available
    sleep 2

    if ! command_exists snap; then
        echo "snapd service is not operational."
        exit 1
    fi
}

ensure_snap_bin_in_path() {
    if [[ ":$PATH:" != *":$SNAP_BIN:"* ]]; then
        echo "Adding $SNAP_BIN to PATH..."

        if [[ ! -f "$ZSHRC" ]]; then
            touch "$ZSHRC"
        fi

        if ! grep -Fqx "$PATH_LINE" "$ZSHRC"; then
            echo "$PATH_LINE" >> "$ZSHRC"
        fi

        export PATH="$PATH:$SNAP_BIN"
    else
        echo "$SNAP_BIN already in PATH."
    fi
}

# ----------------------------
# Execution Flow
# ----------------------------

if ! command_exists snap; then
    install_snapd
fi

ensure_snap_service

if [[ ! -d "$SNAP_BIN" ]]; then
    echo "$SNAP_BIN directory missing. Snap installation likely incomplete."
    exit 1
fi

ensure_snap_bin_in_path

echo "Snap setup complete."
echo "Open a new shell session to ensure full environment consistency."