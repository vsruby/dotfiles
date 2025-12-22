# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository managed with [Chezmoi](https://www.chezmoi.io/). It maintains consistent development environment configuration across multiple machines (macOS and Linux).

Repository: https://github.com/vsruby/dotfiles

## Chezmoi Commands

### Core Workflow
```bash
# Apply all changes from the source directory to home directory
chezmoi apply

# Apply with verbose output
chezmoi apply -v

# See what changes would be made without applying
chezmoi diff

# Edit a file in the source directory
chezmoi edit ~/.zshrc

# Re-add a file after manual changes
chezmoi re-add ~/.config/git/config

# Pull latest changes from git and apply
chezmoi update

# Check for common problems
chezmoi doctor
```

### Development Workflow
```bash
# Add a new dotfile to chezmoi management
chezmoi add ~/.newconfig

# Add a file as a template (for conditional logic)
chezmoi add --template ~/.config/newapp/config

# Run scripts manually
chezmoi execute-template < dot_zshrc.tmpl

# View the target path for a source file
chezmoi target-path dot_zshrc.tmpl
```

## Architecture and Key Concepts

### Chezmoi File Naming Convention

Chezmoi uses special prefixes in source filenames that determine how they're applied:

- `dot_` → `.` (dotfile prefix)
- `.tmpl` → template file (Go templating enabled)
- `run_once_before_` → one-time setup script that runs before applying
- `private_` → file with 0600 permissions
- `executable_` → file with executable permissions

Examples:
- `dot_zshrc` → `~/.zshrc`
- `dot_config/git/config.tmpl` → `~/.config/git/config` (templated)
- `run_once_before_install_volta.sh` → runs once before applying changes

### Template System

Files with `.tmpl` extension use Go's `text/template` syntax for conditional configuration:

```go
{{ if eq .chezmoi.os "darwin" }}
# macOS-specific config
{{ end }}

{{ if eq .chezmoi.os "linux" }}
# Linux-specific config
{{ end }}

{{ if eq .chezmoi.hostname "zylo-vince-ruby" }}
# Machine-specific config
{{ end }}

# Custom variables from chezmoi.jsonc
{{ .customGit.email }}
```

### Configuration Data

Custom template variables are stored in `~/.config/chezmoi/chezmoi.jsonc`:
- See `chezmoi.example.jsonc` for the structure
- Currently defines: `customGit.email` for git user email

### Directory Structure

```
dot_config/              # Maps to ~/.config
├── alacritty/          # Alacritty terminal (4 Catppuccin themes)
├── ghostty/            # Ghostty terminal (4 Catppuccin themes)
├── git/                # Git configuration (templated with user email)
├── gh/                 # GitHub CLI configuration
├── lazydocker/         # Docker UI tool
├── lazygit/            # Git UI tool
├── tmux/               # Terminal multiplexer (Ctrl-A prefix)
└── starship.toml       # Shell prompt (Catppuccin mocha theme)

dot_zshrc.tmpl          # Main shell RC file (templated)
dot_zshenv              # Shell environment variables
dot_zsh_plugins.txt     # Antidote plugin definitions

.chezmoiscripts/        # Automation scripts
└── run_once_before_install_volta.sh
```

### Tool Stack

**Shell Environment:**
- Shell: Zsh with Antidote plugin manager
- Prompt: Starship (Catppuccin mocha theme)
- Plugins: zsh-autosuggestions, zsh-completions, oh-my-zsh modules

**Development Tools:**
- Node.js: Volta (VOLTA_FEATURE_PNPM=1 enabled)
- Python: pyenv
- Java: Jabba
- Git: Lazygit UI
- Docker: Lazydocker UI
- Navigation: zoxide

**Terminal Emulators:**
- Alacritty (Catppuccin mocha theme active, 4 variants available)
- Ghostty (Catppuccin mocha theme active, 4 variants available)

**Terminal Multiplexer:**
- Tmux with custom prefix `Ctrl-A` (not default Ctrl-B)
- Plugins: TPM, tmux-sensible, Catppuccin

### Theme Consistency

The entire environment uses **Catppuccin Mocha** theme:
- Starship prompt
- Tmux status bar
- Alacritty terminal
- Ghostty terminal

Alternative Catppuccin variants available: latte, frappe, macchiato

### Machine-Specific Configuration

The repository supports two machine profiles:
1. General (default macOS/Linux)
2. `zylo-vince-ruby` hostname (work machine with additional tooling)

Conditional blocks in `.tmpl` files handle:
- OS-specific paths (macOS vs Linux Homebrew)
- Machine-specific exports and PATH modifications
- Private tokens and credentials (via chezmoi.jsonc data)

## Shell Aliases

Key aliases defined in `dot_zshrc.tmpl`:
- `cm` → chezmoi
- `lg` → lazygit
- `ld` → lazydocker
- `dc` → docker-compose
- `vim` / `vi` → nvim

## Common Patterns

### Adding a New Tool Configuration

1. Add config files to appropriate directory:
   ```bash
   chezmoi add ~/.config/newtool/config.toml
   ```

2. If it needs templating (OS/machine-specific):
   ```bash
   chezmoi add --template ~/.config/newtool/config.toml
   ```

3. Edit the file with Chezmoi-aware templating:
   ```bash
   chezmoi edit ~/.config/newtool/config.toml
   ```

### Adding a Setup Script

1. Create script in `.chezmoiscripts/`:
   - `run_once_before_*` → runs once before applying
   - `run_onchange_*` → runs when script content changes
   - `run_after_*` → runs after applying changes

2. Make it executable:
   ```bash
   chmod +x .chezmoiscripts/run_once_before_install_tool.sh
   ```

### Testing Configuration Changes

Always test before committing:
```bash
# See what would change
chezmoi diff

# Apply to test
chezmoi apply -v

# If something breaks, revert
git restore .
chezmoi apply
```

## Git Workflow

Standard git workflow in the Chezmoi source directory:
```bash
cd ~/.local/share/chezmoi
git status
git add .
git commit -m "description"
git push
```

On new machine:
```bash
chezmoi init --apply vsruby
```

## Important Notes

- **Never commit sensitive data**: Use `chezmoi.jsonc` data variables for tokens/emails
- **1Password CLI required**: Work machine configurations use `onepasswordRead` function for secrets (NPM_TOKEN, etc.). Ensure [1Password CLI](https://developer.1password.com/docs/cli/) is installed and authenticated
- **Template syntax**: Use `{{ }}` for Go template expressions, not shell variables
- **File permissions**: Use `private_` prefix for sensitive files (SSH keys, tokens)
- **OS detection**: Check `.chezmoi.os` for "darwin" or "linux"
- **Test templates**: Use `chezmoi execute-template < file.tmpl` to debug template rendering
