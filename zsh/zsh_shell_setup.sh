#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to check command existence
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install Zsh if not already installed
if command_exists zsh; then
    echo "Zsh is already installed."
else
    echo "Installing Zsh..."
    if command_exists apt; then
        sudo apt update
        sudo apt install -y zsh
    elif command_exists dnf; then
        sudo dnf install -y zsh
    elif command_exists pacman; then
        sudo pacman -Sy --noconfirm zsh
    else
        echo "Unsupported package manager. Install Zsh manually."
        exit 1
    fi
fi

# Set Zsh as the default shell for the current user
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Setting Zsh as default shell..."
    chsh -s "$(which zsh)"
else
    echo "Zsh is already the default shell."
fi

# Install Oh My Zsh if not already installed
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh is already installed."
else
    echo "Installing Oh My Zsh..."
    # Auto-confirm install script
    export RUNZSH=no
    export CHSH=no
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "Zsh setup complete. Restart your terminal or log out and back in to apply changes."
