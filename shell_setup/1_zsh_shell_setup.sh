#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to check command existence
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# -----------------------------------------
# Install all required dependencies.
# -----------------------------------------
install_dependencies() {
    if command_exists apt; then
        sudo apt update
        sudo apt install -y curl unzip fontconfig
    elif command_exists dnf; then
        sudo dnf install -y curl unzip fontconfig
    elif command_exists pacman; then
        sudo pacman -Sy --noconfirm curl unzip fontconfig
    else
        echo "Unsupported package manager. Install curl, unzip, and fontconfig manually."
        exit 1
    fi
}
install_firacode() {
    install_dependencies

    mkdir -p "$FONT_DIR"
    # Download the FiraCode Nerd Font zip
    curl -fsSL "$FONT_URL" -o "$TMP_ZIP"
    # Extract font files into font directory
    unzip -o "$TMP_ZIP" -d "$FONT_DIR"
    # Rebuild font cache
    fc-cache -fv
}

# -----------------------------------------
# Install FiraCode Nerd Font if missing
# -----------------------------------------
FONT_CHECK=$(fc-list | grep -i "FiraCode Nerd Font" || true)

FONT_NAME="FiraCode Nerd Font"
FONT_VERSION="v3.4.0"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/${FONT_VERSION}/FiraCode.zip"
FONT_DIR="$HOME/.local/share/fonts"
TMP_ZIP="/tmp/FiraCode.zip"

if [ -n "$FONT_CHECK" ]; then
    echo "FiraCode Nerd Font is already installed."
else
    echo "Installing FiraCode Nerd Font v3.4.0..."
    install_firacode
    echo "FiraCode Nerd Font v3.4.0 installed successfully."
fi

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

# -----------------------------
# Install or update Starship
# -----------------------------
if command_exists starship; then
    echo "Starship is already installed. Updating to latest..."
else
    echo "Installing Starship..."
fi

curl -sS https://starship.rs/install.sh | sh -s -- -y > /dev/null

# -----------------------------------------
# Configure Starship for Zsh
# -----------------------------------------
ZSHRC="$HOME/.zshrc"

if grep -q 'starship init zsh' "$ZSHRC"; then
    echo "Starship is already configured in ~/.zshrc."
else
    echo "Configuring Starship in ~/.zshrc..."
    {
        echo ""
        echo "# Initialise Starship prompt"
        echo 'eval "$(starship init zsh)"'
    } >> "$ZSHRC"
fi

echo "Zsh shell setup complete. Restart your terminal or log out and back in to apply changes."
