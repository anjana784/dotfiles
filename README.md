# Dotfiles — anjana784

My macOS development environment, managed as a [bare git repository](https://www.atlassian.com/git/tutorials/dotfiles).

## 🛠 Stack

| Category | Tool |
|---|---|
| Shell | [zsh](https://www.zsh.org/) + [zsh-autocomplete](https://github.com/marlonrichert/zsh-autocomplete) + [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) |
| Prompt | [Starship](https://starship.rs/) (Catppuccin Mocha) |
| Terminal | [Ghostty](https://ghostty.org/) |
| Multiplexer | [tmux](https://github.com/tmux/tmux) + [TPM](https://github.com/tmux-plugins/tpm) + [Catppuccin](https://github.com/catppuccin/tmux) |
| Editor | [Neovim](https://neovim.io/) + [lazy.nvim](https://github.com/folke/lazy.nvim) |
| Git TUI | [Lazygit](https://github.com/jesseduffield/lazygit) |
| Keyboard | [Karabiner-Elements](https://karabiner-elements.pqrs.org/) |
| Package Manager | [Homebrew](https://brew.sh/) |
| Node.js | [nvm](https://github.com/nvm-sh/nvm) + [pnpm](https://pnpm.io/) |

## 📁 Structure

```
~/
├── .zshrc                       # Shell config
├── .zprofile                    # Login shell (brew shellenv)
├── .gitconfig                   # Git user + settings
├── .tmux.conf                   # Tmux config (Catppuccin, keybinds)
├── .secrets                     # API keys (NOT tracked — see below)
├── .gitignore                   # Dotfiles ignore rules (whitelist approach)
└── .config/
    ├── starship.toml            # Prompt theme
    ├── ghostty/config           # Terminal settings
    ├── karabiner/karabiner.json # Keyboard customizations
    ├── lazygit/config.yml       # Lazygit UI + keybinds
    ├── git/ignore               # Global gitignore
    └── nvim/                    # Neovim (lazy.nvim)
        ├── init.lua
        ├── lazy-lock.json
        └── lua/config/
            ├── core/            # Options, keymaps, autocmds
            └── plugins/         # Per-plugin configs
```

## 🚀 Bootstrapping a new Mac

### 1. Install essentials

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install git (if not already)
brew install git
```

### 2. Clone dotfiles

```bash
# Clone as a bare repo
git clone --bare https://github.com/anjana784/dotfiles.git $HOME/.dotfiles

# Define the alias (add this to your .zshrc manually, or temporarily):
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# Checkout the files
dotfiles checkout
```

If you get errors about existing files, move them out of the way first:

```bash
mkdir ~/.dotfiles-backup
dotfiles checkout 2>&1 | grep -E '^\s+' | awk '{print $1}' | while read f; do
  mkdir -p "$(dirname "$HOME/.dotfiles-backup/$f")"
  mv "$HOME/$f" "$HOME/.dotfiles-backup/$f"
done
dotfiles checkout
```

### 3. Set up secrets

```bash
cp .secrets.template .secrets
chmod 600 .secrets
# Edit .secrets with your actual API keys
```

### 4. Install tools

```bash
# Shell plugins
brew install zsh-autocomplete zsh-autosuggestions

# Starship prompt
brew install starship

# Neovim
brew install neovim

# Lazygit
brew install lazygit

# Tmux + TPM
brew install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Karabiner
brew install --cask karabiner-elements

# Ghostty
brew install --cask ghostty

# Node.js
brew install nvm pnpm

# Reload shell
exec zsh
```

### 5. Install Neovim plugins

Open Neovim — lazy.nvim will bootstrap itself and install all plugins automatically:

```bash
nvim
```

### 6. Install Tmux plugins

Start tmux and press `prefix + I` (capital i) to install plugins via TPM:

```bash
tmux
# Then: Ctrl+b Shift+I
```

## 🔐 Secrets management

Secrets are stored in `~/.secrets` (permissions `0600`) and sourced by `.zshrc`. This file is **never** committed. See `.secrets.template` for the expected format. Copy and fill in your own keys:

```bash
cp .secrets.template .secrets
chmod 600 .secrets
```

## 📝 Day-to-day usage

```bash
dotfiles status          # See what changed
dotfiles add ~/.zshrc    # Stage a file
dotfiles add -u          # Stage all changed tracked files
dotfiles commit -m "..." # Commit
dotfiles push            # Push to GitHub
dotfiles log             # View history
```

### Adding a new file to track

```bash
# 1. Add the file
dotfiles add ~/.config/some-new-app/config.yml

# 2. Update .gitignore to whitelist it
dotfiles add ~/.gitignore

# 3. Commit both
dotfiles commit -m "Add some-new-app config"
```

## 🙏 Inspiration

- [Atlassian — The best way to store your dotfiles](https://www.atlassian.com/git/tutorials/dotfiles)
- [StreakyCobra's HN comment](https://news.ycombinator.com/item?id=11070797) that popularized the bare-repo approach
