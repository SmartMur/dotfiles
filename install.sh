#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_ROOT="$HOME/.terminal_backups"
BACKUP_DIR="$BACKUP_ROOT/mac-terminal-dotfiles-$(date +%Y%m%d-%H%M%S)"
SKIP_BREW=0

log() {
  printf '[mac-terminal-dotfiles] %s\n' "$*"
}

usage() {
  cat <<USAGE
Usage: ./install.sh [--skip-brew]

  --skip-brew   Skip Homebrew dependency installation.
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --skip-brew)
      SKIP_BREW=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage
      exit 1
      ;;
  esac
done

mkdir -p "$BACKUP_DIR" "$HOME/.zsh" "$HOME/.config/iterm2" "$HOME/Library/Application Support/iTerm2/DynamicProfiles"

backup_and_link() {
  local src="$1"
  local dst="$2"

  mkdir -p "$(dirname "$dst")"

  if [[ -L "$dst" ]] && [[ "$(readlink "$dst")" == "$src" ]]; then
    log "already linked: $dst"
    return
  fi

  if [[ -e "$dst" || -L "$dst" ]]; then
    local rel="${dst#$HOME/}"
    mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
    mv "$dst" "$BACKUP_DIR/$rel"
    log "backup: $dst -> $BACKUP_DIR/$rel"
  fi

  ln -s "$src" "$dst"
  log "linked: $dst -> $src"
}

# Dotfiles
backup_and_link "$REPO_ROOT/zsh/.zshrc" "$HOME/.zshrc"
backup_and_link "$REPO_ROOT/zsh/.zsh/aliases.smartmur.zsh" "$HOME/.zsh/aliases.smartmur.zsh"
backup_and_link "$REPO_ROOT/zsh/.zsh/functions.smartmur.zsh" "$HOME/.zsh/functions.smartmur.zsh"
backup_and_link "$REPO_ROOT/zsh/.zsh/nvm.smartmur.zsh" "$HOME/.zsh/nvm.smartmur.zsh"
backup_and_link "$REPO_ROOT/zsh/.zsh/starship.smartmur.zsh" "$HOME/.zsh/starship.smartmur.zsh"
backup_and_link "$REPO_ROOT/config/.config/starship.smartmur.toml" "$HOME/.config/starship.smartmur.toml"
backup_and_link "$REPO_ROOT/config/.config/iterm2/smartmur.itermcolors" "$HOME/.config/iterm2/smartmur.itermcolors"
backup_and_link "$REPO_ROOT/config/.config/iterm2/smartmur-profile.json" "$HOME/.config/iterm2/smartmur-profile.json"
backup_and_link "$REPO_ROOT/config/.config/iterm2/smartmur.dynamic.json" "$HOME/Library/Application Support/iTerm2/DynamicProfiles/smartmur.dynamic.json"

# iTerm2 default profile
DYN_PROFILE="$HOME/Library/Application Support/iTerm2/DynamicProfiles/smartmur.dynamic.json"
if [[ -f "$DYN_PROFILE" ]]; then
  PROFILE_GUID="$(plutil -extract Profiles.0.Guid raw -o - "$DYN_PROFILE" 2>/dev/null || true)"
  if [[ -n "$PROFILE_GUID" ]]; then
    defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "$PROFILE_GUID" || true
    log "iTerm2 default profile GUID set to: $PROFILE_GUID"
  fi
fi

if [[ "$SKIP_BREW" -eq 0 ]]; then
  if command -v brew >/dev/null 2>&1; then
    log "installing/updating Homebrew dependencies"
    brew bundle --file "$REPO_ROOT/Brewfile"
  else
    log "Homebrew not found. Install Homebrew, then run: brew bundle --file $REPO_ROOT/Brewfile"
  fi
fi

log "install complete"
log "backup directory: $BACKUP_DIR"
log "apply now: exec zsh"
