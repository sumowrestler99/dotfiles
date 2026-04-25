#!/usr/bin/env bash
# Dotfiles install script — creates symlinks from $HOME to ~/dotfiles/
# Run: bash ~/dotfiles/install.sh

set -e

DOTFILES="$HOME/dotfiles"

# Colour output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

link() {
    local src="$DOTFILES/$1"
    local dst="$HOME/$2"

    # Create parent directory if needed
    mkdir -p "$(dirname "$dst")"

    if [ -L "$dst" ]; then
        echo -e "${YELLOW}skip${NC}  $dst (already symlinked)"
    elif [ -e "$dst" ]; then
        echo -e "${YELLOW}backup${NC} $dst → $dst.bak"
        mv "$dst" "$dst.bak"
        ln -s "$src" "$dst"
        echo -e "${GREEN}link${NC}   $dst"
    else
        ln -s "$src" "$dst"
        echo -e "${GREEN}link${NC}   $dst"
    fi
}

echo "Installing dotfiles from $DOTFILES..."
echo ""

# Shell
link shell/zshrc          .zshrc
link shell/zprofile        .zprofile
link shell/bashrc          .bashrc
link shell/bash_profile    .bash_profile

# Git
link git/gitconfig         .gitconfig

# Terminal
link terminal/tmux.conf                    .tmux.conf
link terminal/iterm2_shell_integration.zsh .iterm2_shell_integration.zsh
link terminal/fzf.zsh                      .fzf.zsh

# Wezterm
link wezterm/wezterm.lua   .config/wezterm/wezterm.lua

# Zellij
link zellij/config.kdl     .config/zellij/config.kdl

# Starship
link starship/starship.toml .config/starship.toml

echo ""
echo "Done. iTerm2 plist must be loaded manually via:"
echo "  iTerm2 → Preferences → General → Preferences → Load from: ~/dotfiles/iterm2/"
