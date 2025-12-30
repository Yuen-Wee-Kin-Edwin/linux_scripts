#!/usr/bin/env zsh

set -e  # Exit immediately if any command fails

# Ensure curl is available
if ! command -v curl >/dev/null 2>&1; then
    echo "Error: curl is not installed. Install curl first."
    exit 1
fi

# Check whether Rust is already installed
if command -v rustc >/dev/null 2>&1; then
    echo "Rust detected. Updating Rust toolchains..."
    rustup update
else
    echo "Rust not detected. Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

# Load Cargo environment for the current shell
if [[ -f "$HOME/.cargo/env" ]]; then
    source "$HOME/.cargo/env"
else
    echo "Warning: Cargo environment file not found."
fi

# Verify installation
if command -v rustc >/dev/null 2>&1; then
    echo "Rust is ready."
    rustc --version
    cargo --version
else
    echo "Rust setup failed."
    exit 1
fi
