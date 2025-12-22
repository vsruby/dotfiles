# Dotfiles

Personal dotfiles managed with [Chezmoi](https://www.chezmoi.io/).

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)

## Prerequisites

- [Chezmoi](https://www.chezmoi.io/)
- [1Password CLI](https://developer.1password.com/docs/cli/) (required for work machine configurations that use secrets)

**Note:** Development tools (Volta, pyenv, jabba, lazygit, etc.) should be installed separately. Chezmoi only manages configuration files, following [best practices](https://www.chezmoi.io/user-guide/frequently-asked-questions/usage/) to avoid system management issues.

## Installation

1. **Initialize and apply dotfiles**
   ```bash
   chezmoi init --apply vsruby
   ```

2. **Configure personal settings**

   Copy the example configuration:
   ```bash
   cp ~/.config/chezmoi/chezmoi.example.jsonc ~/.config/chezmoi/chezmoi.jsonc
   ```

   Edit `~/.config/chezmoi/chezmoi.jsonc` with your values (e.g., git email)
