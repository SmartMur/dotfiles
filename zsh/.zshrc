# mac-terminal-dotfiles: macOS-focused zsh setup
# Keep personal secrets in ~/.zsh/secrets.zsh (not tracked in git).

[[ -f ~/.zsh/secrets.zsh ]] && source ~/.zsh/secrets.zsh

export EDITOR="${EDITOR:-nvim}"
export NVM_DIR="$HOME/.nvm"

# History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY

# Completion
autoload -U compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Common aliases
alias reload-zsh='exec zsh'
alias edit-zsh='$EDITOR ~/.zshrc'
alias python='python3'

# ChristianLempa-inspired modular files
[[ -f ~/.zsh/aliases.christianlempa.zsh ]] && source ~/.zsh/aliases.christianlempa.zsh
[[ -f ~/.zsh/functions.christianlempa.zsh ]] && source ~/.zsh/functions.christianlempa.zsh
[[ -f ~/.zsh/nvm.christianlempa.zsh ]] && source ~/.zsh/nvm.christianlempa.zsh
[[ -f ~/.zsh/starship.christianlempa.zsh ]] && source ~/.zsh/starship.christianlempa.zsh

# Optional PATH additions used by this setup
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

# Tool hooks
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
  alias cd='z'
fi

if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --zsh)"
fi

# Homebrew plugins
if command -v brew >/dev/null 2>&1; then
  BREW_PREFIX="$(brew --prefix)"
  [[ -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  [[ -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Prompt
if [[ -o interactive ]] && [[ "$TERM" != "dumb" ]] && command -v starship >/dev/null 2>&1; then
  export STARSHIP_CONFIG="$HOME/.config/starship.christianlempa.toml"
  eval "$(starship init zsh)"
fi

# Optional system summary at shell startup
if [[ -o interactive ]] && command -v fastfetch >/dev/null 2>&1; then
  fastfetch
fi
