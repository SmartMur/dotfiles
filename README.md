# mac-terminal-dotfiles

[![macOS](https://img.shields.io/badge/macOS-13%2B-000000?logo=apple)](https://www.apple.com/macos/)
[![Shell](https://img.shields.io/badge/Shell-Zsh-89e051)](https://www.zsh.org/)
[![Repo](https://img.shields.io/badge/GitHub-SmartMur%2Fdotfiles-181717?logo=github)](https://github.com/SmartMur/dotfiles)

Personal macOS terminal dotfiles setup inspired by ChristianLempa-style workflow, packaged for fast reuse on fresh machines.

## Quick Install

```bash
git clone https://github.com/SmartMur/dotfiles.git mac-terminal-dotfiles
cd mac-terminal-dotfiles
./install.sh
exec zsh
```

## Fresh macOS Setup

1. Install Xcode Command Line Tools:
```bash
xcode-select --install
```
2. Install Homebrew:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
3. Install and apply dotfiles:
```bash
git clone https://github.com/SmartMur/dotfiles.git mac-terminal-dotfiles
cd mac-terminal-dotfiles
./install.sh
exec zsh
```

## What This Includes

- `zsh/.zshrc`: main zsh config (modular, macOS-safe, no secrets)
- `zsh/.zsh/*.christianlempa.zsh`: aliases, helpers, nvm lazy-load, starship env vars
- `config/.config/starship.christianlempa.toml`: prompt theme
- `config/.config/iterm2/*`: iTerm2 color/profile files
- `install.sh`: backup + symlink install script
- `Brewfile`: required/optional packages used by this setup

## iTerm2 Setup

`install.sh` installs a Dynamic Profile and sets it as iTerm2 default.

- Dynamic profile path: `~/Library/Application Support/iTerm2/DynamicProfiles/christianlempa.dynamic.json`
- Additional profile assets: `~/.config/iterm2/christianlempa.itermcolors`
- Additional profile assets: `~/.config/iterm2/christianlempa-profile.json`

If you use Terminal.app instead of iTerm2, zsh prompt/aliases still work. iTerm profile theming is iTerm2-specific.

## Fonts

This setup expects Nerd Fonts for icons. `Brewfile` installs `font-hack-nerd-font`.

Set your terminal font to **Hack Nerd Font Mono**.

## Secrets

Never commit API keys/tokens.

Put local secrets in `~/.zsh/secrets.zsh`.

Example:
```bash
export OPENAI_API_KEY="..."
```

## Restore

Each install creates a backup in:

- `~/.terminal_backups/mac-terminal-dotfiles-<timestamp>/`

You can move backed-up files back manually if needed.
