# mac-terminal-dotfiles

Personal macOS terminal dotfiles, based on your ChristianLempa-style setup and adapted for safe reuse on fresh machines.

## What this includes

- `zsh/.zshrc`: main zsh config (modular, macOS-safe, no secrets)
- `zsh/.zsh/*.christianlempa.zsh`: aliases, helpers, nvm lazy-load, starship env vars
- `config/.config/starship.christianlempa.toml`: prompt theme
- `config/.config/iterm2/*`: iTerm2 color/profile files
- `install.sh`: backup + symlink install script
- `Brewfile`: required/optional packages used by this setup

## Fresh macOS setup (default terminal)

1. Install Xcode Command Line Tools:
```bash
xcode-select --install
```
2. Install Homebrew:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
3. Clone this repo and install:
```bash
git clone <YOUR_REPO_URL> mac-terminal-dotfiles
cd mac-terminal-dotfiles
./install.sh
```
4. Reload shell:
```bash
exec zsh
```

## iTerm2 setup

`install.sh` installs a Dynamic Profile and sets it as iTerm2 default.

- Dynamic profile path:
  - `~/Library/Application Support/iTerm2/DynamicProfiles/christianlempa.dynamic.json`
- Additional profile assets:
  - `~/.config/iterm2/christianlempa.itermcolors`
  - `~/.config/iterm2/christianlempa-profile.json`

If you use Terminal.app instead of iTerm2, zsh prompt/aliases still work; only iTerm2 profile theming is iTerm-specific.

## Fonts

This setup expects Nerd Fonts for icons. `Brewfile` installs:

- `font-hack-nerd-font`

Set your terminal font to **Hack Nerd Font Mono**.

## Secrets

Never commit API keys/tokens.

Put local secrets in:

- `~/.zsh/secrets.zsh`

Example:
```bash
export OPENAI_API_KEY="..."
```

## Restore

Each install creates a backup in:

- `~/.terminal_backups/mac-terminal-dotfiles-<timestamp>/`

You can move backed-up files back manually if needed.

## Publish to GitHub

```bash
git init
git add .
git commit -m "Initial mac terminal dotfiles"
gh repo create <repo-name> --public --source=. --remote=origin --push
```
