<p align="center">
  <img src="assets/images/smartmur-favicon.png" alt="SmartMur" width="84" />
</p>

# SmartMur Dotfiles (macOS Terminal)

[![macOS](https://img.shields.io/badge/macOS-13%2B-000000?logo=apple)](https://www.apple.com/macos/)
[![Shell](https://img.shields.io/badge/Shell-Zsh-89e051)](https://www.zsh.org/)
[![Repo](https://img.shields.io/badge/GitHub-SmartMur%2Fdotfiles-181717?logo=github)](https://github.com/SmartMur/dotfiles)

Production-ready macOS terminal dotfiles with a reproducible install script, safe backups, and iTerm2 profile/theme setup.

## Overview

This repo captures your terminal personalization so it can be reapplied on any fresh Mac quickly and consistently.

- Uses symlink-based dotfile management
- Backs up existing local config before changes
- Installs required CLI tooling via Homebrew (`Brewfile`)
- Configures Starship prompt and iTerm2 profile/theme
- Keeps secrets out of version control

## Repo Structure

```text
.
├── Brewfile
├── install.sh
├── assets/images/
├── config/.config/
│   ├── iterm2/
│   └── starship.christianlempa.toml
└── zsh/
    ├── .zshrc
    └── .zsh/
        ├── aliases.christianlempa.zsh
        ├── functions.christianlempa.zsh
        ├── nvm.christianlempa.zsh
        └── starship.christianlempa.zsh
```

## Requirements

- macOS 13+
- `zsh` (default on macOS)
- Xcode Command Line Tools
- Homebrew

## Quick Start

```bash
git clone https://github.com/SmartMur/dotfiles.git mac-terminal-dotfiles
cd mac-terminal-dotfiles
./install.sh
exec zsh
```

## Fresh macOS Bootstrap

1. Install Xcode Command Line Tools:
```bash
xcode-select --install
```
2. Install Homebrew:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
3. Clone and install:
```bash
git clone https://github.com/SmartMur/dotfiles.git mac-terminal-dotfiles
cd mac-terminal-dotfiles
./install.sh
```
4. Reload shell:
```bash
exec zsh
```

## What `install.sh` does

- Creates timestamped backups in `~/.terminal_backups/mac-terminal-dotfiles-<timestamp>/`
- Symlinks repo-managed files into `~/.zsh*`, `~/.config/*`, and iTerm2 Dynamic Profiles
- Sets the iTerm2 default profile GUID to the SmartMur profile
- Runs `brew bundle --file Brewfile` (unless `--skip-brew` is set)

## iTerm2 and Branding

- Dynamic profile installed at:
  - `~/Library/Application Support/iTerm2/DynamicProfiles/christianlempa.dynamic.json`
- Additional profile assets:
  - `~/.config/iterm2/christianlempa.itermcolors`
  - `~/.config/iterm2/christianlempa-profile.json`

Brand assets copied from `https://smartmur.ca` on February 18, 2026:

- `assets/images/smartmur-white.png`
- `assets/images/smartmur-favicon.png`

## Customization

- Main shell behavior: `zsh/.zshrc`
- Aliases/functions modules: `zsh/.zsh/*`
- Prompt design: `config/.config/starship.christianlempa.toml`
- Package list: `Brewfile`

After changing repo files, re-run:

```bash
./install.sh --skip-brew
exec zsh
```

## Secrets and Security

Never commit API keys/tokens.

Use local-only file:

- `~/.zsh/secrets.zsh`

Example:

```bash
export OPENAI_API_KEY="..."
```

## Troubleshooting

- If prompt/theme does not update: run `exec zsh`
- If iTerm2 profile does not switch: restart iTerm2 and open a new window
- If brew packages are missing: run `brew bundle --file Brewfile`
- If you need to rollback: restore files from `~/.terminal_backups/...`

## Maintenance Workflow

```bash
git pull
./install.sh --skip-brew
exec zsh
```

## Contributing

Issues and pull requests are welcome.

For config changes, include:

- what changed
- why it changed
- how it was tested on macOS

## Roadmap

- Add optional WezTerm profile support
- Add non-interactive CI checks for shell/script syntax
- Add screenshot previews for prompt/theme states

## License

No license file is currently defined. Add a `LICENSE` file before broad reuse outside your personal/team workflow.
