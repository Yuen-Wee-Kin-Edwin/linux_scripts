#!/usr/bin/env zsh
# Install or update Rust using rustup.

set -euo pipefail

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

require_curl() {
    if ! command_exists curl; then
        echo "curl is required but not installed."
        exit 1
    fi
}

install_rust() {
    echo "Installing Rust via rustup..."

    # Download installer explicitly first (safer than blind pipe)
    TMP_SCRIPT="$(mktemp)"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o "$TMP_SCRIPT"

    sh "$TMP_SCRIPT" -y
    rm -f "$TMP_SCRIPT"
}

update_rust() {
    echo "Updating Rust toolchains..."
    rustup update
}

load_cargo_env() {
    if [[ -f "$HOME/.cargo/env" ]]; then
        # Load Cargo environment into current shell session
        source "$HOME/.cargo/env"
    fi
}

verify_rust() {
    if command_exists rustc && command_exists cargo; then
        echo "Rust installation verified."
        rustc --version
        cargo --version
    else
        echo "Rust setup failed."
        exit 1
    fi
}

# ----------------------------
# Execution Flow
# ----------------------------

require_curl

if command_exists rustc; then
    update_rust
else
    install_rust
fi

load_cargo_env
verify_rust