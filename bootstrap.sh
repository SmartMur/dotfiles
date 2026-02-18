#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${REPO_URL:-https://github.com/SmartMur/dotfiles.git}"
TARGET_DIR="${1:-$HOME/.smartmur-dotfiles}"

log() {
  printf '[bootstrap] %s\n' "$*"
}

if ! xcode-select -p >/dev/null 2>&1; then
  log "Xcode Command Line Tools are required."
  xcode-select --install || true
  log "Install CLT, then rerun this script."
  exit 1
fi

if ! command -v git >/dev/null 2>&1; then
  log "git is required but not found."
  exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
  log "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ -d "$TARGET_DIR/.git" ]]; then
  log "Updating existing repo in $TARGET_DIR"
  git -C "$TARGET_DIR" pull --ff-only
else
  log "Cloning dotfiles into $TARGET_DIR"
  git clone "$REPO_URL" "$TARGET_DIR"
fi

cd "$TARGET_DIR"
chmod +x install.sh
./install.sh

log "Done. Run: exec zsh"
