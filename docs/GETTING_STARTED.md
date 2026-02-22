# Getting Started (macOS)

## Prerequisites

- macOS 13+
- Xcode Command Line Tools
- Git
- Homebrew
- Zsh

## Fast Path

```bash
git clone https://github.com/SmartMur/dotfiles.git
cd dotfiles
./install.sh
exec zsh
```

## Fresh Machine Bootstrap

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/SmartMur/dotfiles/main/bootstrap.sh)"
```

This will:
- Ensure prerequisites
- Clone repo to `~/.smartmur-dotfiles`
- Run installer

## Safe Re-apply After Changes

```bash
./install.sh --skip-brew
exec zsh
```

## Validation

```bash
bash -n bootstrap.sh
bash -n install.sh
python3 scripts/security_scrub.py --no-history
```

For a full history scan before release:

```bash
python3 scripts/security_scrub.py
```

If any secret finding appears, follow `docs/SECURITY_RULEBOOK.md`.
