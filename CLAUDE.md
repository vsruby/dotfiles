# CLAUDE.md

Personal dotfiles managed with [Chezmoi](https://www.chezmoi.io/) for macOS and Linux.

Repository: https://github.com/vsruby/dotfiles

## Directory Structure

```
dot_config/              # ~/.config
├── alacritty/          # Alacritty terminal
├── ghostty/            # Ghostty terminal
├── git/                # Git config (templated with user email)
├── gh/                 # GitHub CLI
├── lazydocker/         # Docker UI
├── lazygit/            # Git UI
├── tmux/               # Tmux (Ctrl-A prefix)
└── starship.toml       # Shell prompt

dot_zshrc.tmpl          # Main shell RC (templated)
dot_zshenv              # Shell environment variables
dot_zsh_plugins.txt     # Antidote plugin definitions

.chezmoiscripts/        # Setup automation scripts
```

## Key Details

- **Theme:** Catppuccin Mocha everywhere (starship, tmux, alacritty, ghostty). Variants available: latte, frappe, macchiato
- **Template data:** Custom variables in `~/.config/chezmoi/chezmoi.jsonc` (see `chezmoi.example.jsonc`). Currently defines `customGit.email`
- **Machine profiles:** General (default) and `zylo-vince-ruby` (work machine). Templates branch on `.chezmoi.os` and `.chezmoi.hostname`
- **1Password CLI required:** Work machine uses `onepasswordRead` for secrets (NPM_TOKEN, etc.)
- **Shell aliases:** `cm`=chezmoi, `lg`=lazygit, `ld`=lazydocker, `dc`=docker-compose, `vim`/`vi`=nvim
