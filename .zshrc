# ----------------------------
# POWERLEVEL10K INSTANT PROMPT
# ----------------------------
# Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ----------------------------
# EDITOR CONFIGURATION
# ----------------------------
export EDITOR="vim" # Change to your preferred editor
export KEYTIMEOUT=1

# ----------------------------
# HISTORY CONFIGURATION
# ----------------------------
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY

# History search
bindkey '^R' history-incremental-search-backward
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

# ----------------------------
# OH-MY-ZSH CONFIG
# ----------------------------
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

if [[ -n $CURSOR_TRACE_ID ]]; then
  ZSH_THEME="robbyrussell"  # Use a simpler theme in Cursor
else
  ZSH_THEME="powerlevel10k/powerlevel10k"
fi


# Plugins
plugins=(
  colored-man-pages
  kubectl
  git
  vi-mode
  z
  zsh-navigation-tools
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Load Oh My Zsh configuration
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
if [[ ! -n $CURSOR_TRACE_ID ]]; then
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi

# ----------------------------
# PATH
# ----------------------------
# The next line updates PATH for the Google Cloud SDK (installed via `brew install --cask gcloud-cli`).
if [ -f "${HOMEBREW_PREFIX:-/opt/homebrew}/share/google-cloud-sdk/path.zsh.inc" ]; then . "${HOMEBREW_PREFIX:-/opt/homebrew}/share/google-cloud-sdk/path.zsh.inc"; fi

export PATH="$HOME/.local/bin:$PATH"

# ----------------------------
# SHELL COMPLETIONS
# ----------------------------
case "$(uname)" in
  Darwin)
    # Set up homebrew shell completion
    eval "$(/opt/homebrew/bin/brew shellenv)"
    ;;
  Linux)
    ;;
  *)
    echo "Unknown OS: $(uname)"
    ;;
esac

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Set up shell command completion for gcloud.
if [ -f "${HOMEBREW_PREFIX:-/opt/homebrew}/share/google-cloud-sdk/completion.zsh.inc" ]; then . "${HOMEBREW_PREFIX:-/opt/homebrew}/share/google-cloud-sdk/completion.zsh.inc"; fi

# ----------------------------
# ALIASES
# ----------------------------
alias vi="vim"
alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.vimrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias python="python3"
alias pip="pip3"
alias c="clear"
alias k="kubectl"
alias j="just"
alias g="git"

