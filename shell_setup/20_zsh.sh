#!/usr/bin/env bash
# Install Zsh and Oh My Zsh

source "$(dirname "$0")/lib.sh"

set -e

PM=$(detect_package_manager)

if ! command_exists zsh; then
    case "$PM" in
        apt) sudo apt install -y zsh ;;
        dnf) sudo dnf install -y zsh ;;
        pacman) sudo pacman -Sy --noconfirm zsh ;;
        *) echo "Unsupported package manager"; exit 1 ;;
    esac
fi

# Install zsh-syntax-highlighting package
if ! command_exists zsh-syntax-highlighting; then
    case "$PM" in
        apt)
            sudo apt install -y zsh-syntax-highlighting
            ;;
        dnf)
            sudo dnf install -y zsh-syntax-highlighting
            ;;
        pacman)
            sudo pacman -Sy --noconfirm zsh-syntax-highlighting
            ;;
    esac
fi

# Change default shell to Zsh if not already set
ZSH_PATH="$(command -v zsh)"
if [ "$SHELL" != "$ZSH_PATH" ]; then
    chsh -s "$ZSH_PATH"
fi

# Install Oh My Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

ZSHRC="$HOME/.zshrc"

# Ensure zsh-syntax-highlighting is sourced
HIGHLIGHT_LINE="source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

if ! grep -Fxq "$HIGHLIGHT_LINE" "$ZSHRC"; then
    echo "" >> "$ZSHRC"
    echo "# Enable zsh syntax highlighting" >> "$ZSHRC"
    echo "$HIGHLIGHT_LINE" >> "$ZSHRC"
fi

echo "Zsh setup complete."
echo "Restart the terminal or run: exec zsh"