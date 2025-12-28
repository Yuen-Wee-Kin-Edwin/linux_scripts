#!/usr/bin/env zsh
# snap_setup.zsh
# This script ensures snap is installed and /snap/bin is present in the PATH.
# If snap is missing, it will attempt to install snapd.

ZSHRC="$HOME/.zshrc"
SNAP_BIN="/snap/bin"
PATH_EXPORT='export PATH="$PATH:/snap/bin"'

# Check if snap is installed
if ! command -v snap >/dev/null 2>&1; then
    echo "snap is not installed. Installing snapd..."

    # Requires sudo privileges
    if command -v apt >/dev/null 2>&1; then
        sudo apt update && sudo apt install -y snapd
    else
        echo "Automatic installation not supported on this system."
        return 1 2>/dev/null || exit 1
    fi

    # Verify installation
    if ! command -v snap >/dev/null 2>&1; then
        echo "snap installation failed. Aborting."
        return 1 2>/dev/null || exit 1
    fi
fi

# Ensure /snap/bin exists
if [[ ! -d "$SNAP_BIN" ]]; then
  echo "/snap/bin does not exist even after installation. Aborting."
  return 1 2>/dev/null || exit 1
fi

# Add /snap/bin to PATH if missing
if ! echo "$PATH" | tr ':' '\n' | grep -qx "$SNAP_BIN"; then
    # Add to ~/.zshrc if not already present
    if [[ ! -f "$ZSHRC" ]] || ! grep -Fqx "$PATH_EXPORT" "$ZSHRC"; then
        echo "$PATH_EXPORT" >> "$ZSHRC"
        echo "Added /snap/bin to PATH in ~/.zshrc."
    fi
    export PATH="$PATH:$SNAP_BIN"
else
    echo "/snap/bin is already in PATH."
fi

# Reload zsh configuration
source "$ZSHRC"
echo "Reloaded ~/.zshrc successfully."

