#!/usr/bin/env zsh

# Exit immediately if any command fails.
set -e

# Check whether snap is installed and accessible.
# 'command -v' returns the path if the command exists, otherwise nothing.
if ! command -v snap >/dev/null 2>&1; then
    echo "Error: snap is not installed or not available in PATH."
    echo "Nothing to update. Exiting."
    exit 1
fi

# Inform the user that snap was detected.
echo "Snap detected. Updating all installed Snap packages..."

# Run the Snap refresh command with elevated privileges.
# This updates every installed Snap package to the latest available version.
sudo snap refresh

# Confirm completion.
echo "Snap package update completed successfully."