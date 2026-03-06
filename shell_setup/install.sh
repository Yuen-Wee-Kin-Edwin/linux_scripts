#!/usr/bin/env bash
# Master installer

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

run_bash() {
    local script="$1"

    if [[ ! -f "$DIR/$script" ]]; then
        echo "Missing script: $script"
        exit 1
    fi

    echo "Running $script..."
    bash "$DIR/$script"
}

run_zsh() {
    local script="$1"

    if [[ ! -f "$DIR/$script" ]]; then
        echo "Missing script: $script"
        exit 1
    fi

    echo "Running $script..."
    zsh "$DIR/$script"
}

# Core setup
run_bash "00_deps.sh"
run_bash "10_fonts.sh"
run_bash "20_zsh.sh"
run_bash "30_starship.sh"

# Shell-level tooling
run_zsh "40_snap.zsh"
run_zsh "50_rust.zsh"
run_zsh "60_docker.zsh"

echo "Setup complete."