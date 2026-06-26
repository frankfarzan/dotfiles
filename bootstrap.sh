#!/usr/bin/env bash
#
# Idempotent bootstrap for a fresh macOS machine.
# Safe to re-run: every step checks before acting, so nothing is done twice.
#
#   ./bootstrap.sh
#
# Steps:
#   1. Install Homebrew (if missing)
#   2. Install everything in ./Brewfile
#   3. Install oh-my-zsh + the plugins/theme that .zshrc expects
#   4. Print how to deploy the dotfiles into $HOME

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

step() { printf '\n==> %s\n' "$1"; }

# --- 1. Homebrew ---------------------------------------------------------------
step "Homebrew"
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "already installed"
fi

# Put brew on PATH for the rest of this script (Apple Silicon vs Intel).
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# --- 2. Brewfile ---------------------------------------------------------------
step "Brewfile (brew bundle)"
brew bundle --file="$REPO_DIR/Brewfile"

# --- 3. oh-my-zsh + plugins/theme ---------------------------------------------
step "oh-my-zsh"
export ZSH="${ZSH:-$HOME/.oh-my-zsh}"
if [ ! -d "$ZSH" ]; then
  # KEEP_ZSHRC: don't clobber the .zshrc from this repo. RUNZSH/CHSH: don't switch
  # shells or drop into zsh mid-script.
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "already installed"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH/custom}"
clone_if_missing() {  # url, dest
  if [ -d "$2" ]; then
    echo "have $(basename "$2")"
  else
    git clone --depth 1 "$1" "$2"
  fi
}
clone_if_missing https://github.com/zsh-users/zsh-autosuggestions      "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_if_missing https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
clone_if_missing https://github.com/romkatv/powerlevel10k.git         "$ZSH_CUSTOM/themes/powerlevel10k"

# --- 4. Dotfiles ---------------------------------------------------------------
step "Done"
if [ ! -d "$HOME/.dotfiles" ]; then
  cat <<'EOF'
Tooling is installed. To deploy the dotfiles into $HOME, follow the bare-repo
checkout in .README.md (it backs up any conflicting files first). After that,
restart your shell.
EOF
else
  echo "dotfiles already deployed (~/.dotfiles exists). Restart your shell to pick up changes."
fi
