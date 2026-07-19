# --- HOMEbrew prefix (Apple Silicon + Intel) ---
if [ -d "/opt/homebrew" ]; then
  HOMEBREW_PREFIX="/opt/homebrew"
elif [ -d "/usr/local" ]; then
  HOMEBREW_PREFIX="/usr/local"
fi

# export for plugins
export HOMEBREW_PREFIX

# --- Load zsh-autocomplete early ---
# This takes over completion — don’t call compinit manually.
source "${HOMEBREW_PREFIX}/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh"

# --- ENVIRONMENT & PATHS ---
export NVM_DIR="$HOME/.nvm"

if [ -n "${HOMEBREW_PREFIX:-}" ]; then
  # Load nvm if available
  [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && . "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
  [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && . "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"
fi

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

#php
export PATH="/opt/homebrew/opt/php@8.2/bin:$PATH"
export PATH="/opt/homebrew/opt/php@8.2/sbin:$PATH"

#mysql
export PATH="/opt/homebrew/opt/mysql@8.4/bin:$PATH"

# --- zsh-autosuggestions Plugin ---

ZSH_AUTOSUGGEST_STRATEGY=(history completion) # Autosuggestions strategy: try history, then completion

if [ -n "${HOMEBREW_PREFIX:-}" ]; then
  [ -f "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ] \
    && source "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'  # lighter/dimmer text

# --- PROMPT ---
eval "$(starship init zsh)"

# Added by Antigravity
export PATH="/Users/anjana784/.antigravity/antigravity/bin:$PATH"

# Secrets (API keys, tokens) are in ~/.secrets — sourced below

# pnpm
export PNPM_HOME="/Users/anjana784/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
export PATH="$HOME/.local/bin:$HOME/Library/Python/3.9/bin:$PATH"

# Source secrets file if it exists
[ -f ~/.secrets ] && source ~/.secrets

# --- ALIASES ---
#alias cat=bat
#alias ls=lsd

# Dotfiles bare repo management
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'


export PATH="$PATH:$HOME/go/bin"
