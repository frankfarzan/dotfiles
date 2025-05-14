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

# Set the theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
  vi-mode
  git
  colored-man-pages
  z
  zsh-navigation-tools
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Load Oh My Zsh configuration
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ----------------------------
# OPERATING SYSTEM SPECIFIC SETTINGS
# ----------------------------
case "$(uname)" in
  Darwin)
    # macOS-specific settings
    eval "$(/opt/homebrew/bin/brew shellenv)"
    ;;
  Linux)
    # Linux-specific settings (currently empty)
    ;;
  *)
    echo "Unknown OS: $(uname)"
    ;;
esac

# ----------------------------
# ALIASES
# ----------------------------
alias vi="vim"
alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.vimrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
