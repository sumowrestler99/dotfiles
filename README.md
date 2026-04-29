# Dotfiles

Personal configuration files for macOS, managed with git and symlinks.

## Contents

| Directory | Files | Target |
|-----------|-------|--------|
| `shell/` | `.zshrc`, `.zprofile`, `.bashrc`, `.bash_profile` | `~/` |
| `git/` | `.gitconfig` | `~/` |
| `terminal/` | `.tmux.conf`, `.fzf.zsh`, `iterm2_shell_integration.zsh` | `~/` |
| `iterm2/` | `com.googlecode.iterm2.plist` | loaded manually in iTerm2 prefs |
| `wezterm/` | `wezterm.lua` | `~/.config/wezterm/` |
| `zellij/` | `config.kdl` | `~/.config/zellij/` |
| `starship/` | `starship.toml` | `~/.config/` |
| `lsd/` | `colors.yaml` | `~/.config/lsd/` |

Neovim config is maintained separately at [nvim-config](https://github.com/sumowrestler99/nvim-config).

## Installation

```bash
git clone git@github.com:sumowrestler99/dotfiles.git ~/dotfiles
bash ~/dotfiles/install.sh
```

The install script:
- Creates symlinks from `$HOME` to files in `~/dotfiles/`
- Backs up any existing files as `.bak` before replacing
- Skips files that are already symlinked

## iTerm2

The plist must be loaded manually:

1. Open iTerm2 → **Preferences** → **General** → **Preferences**
2. Enable **Load preferences from a custom folder**
3. Set path to `~/dotfiles/iterm2/`

## Requirements

- macOS
- [Homebrew](https://brew.sh)
- A [Nerd Font](https://www.nerdfonts.com/) (used by starship, zellij, wezterm, nvim)
- [Zellij](https://zellij.dev), [Starship](https://starship.rs), [tmux](https://github.com/tmux/tmux), [fzf](https://github.com/junegunn/fzf), [lsd](https://github.com/lsd-rs/lsd)
