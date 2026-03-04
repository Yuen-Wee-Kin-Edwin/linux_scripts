#!/usr/bin/env bash
# Install required dependencies

source "$(dirname "$0")/lib.sh"

PM=$(detect_package_manager)

case "$PM" in
    apt)
        sudo apt update
        sudo apt install -y curl unzip fontconfig
        ;;
    dnf)
        sudo dnf install -y curl unzip fontconfig
        ;;
    pacman)
        sudo pacman -Sy --noconfirm curl unzip fontconfig
        ;;
    *)
        echo "Unsupported package manager."
        exit 1
        ;;
esac