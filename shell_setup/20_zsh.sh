#!/usr/bin/env bash
# Install Zsh and Oh My Zsh

source "$(dirname "$0")/lib.sh"

if ! command_exists zsh; then
    PM=$(detect_package_manager)
    case "$PM" in
        apt) sudo apt install -y zsh ;;
        dnf) sudo dnf install -y zsh ;;
        pacman) sudo pacman -Sy --noconfirm zsh ;;
        *) echo "Unsupported package manager"; exit 1 ;;
    esac
fi

if [ "$SHELL" != "$(command -v zsh)" ]; then
    chsh -s "$(command -v zsh)"
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no CHSH=no \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi