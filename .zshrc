# Path to your oh-my-zsh installation.
export ZSH=/Users/frankfarzan/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker python colored-man)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$PATH:/usr/local/go/bin"
# export MANPATH="/usr/local/man:$MANPATH"
export GOPATH=/Users/frankfarzan/code/go

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# vim mode
bindkey -v
export KEYTIMEOUT=1

bindkey '^R' history-incremental-search-backward
autoload -U history-search-end

# escape-v edits in vim
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey "\e[A" history-beginning-search-backward-end
bindkey "\e[B" history-beginning-search-forward-end

# The next line updates PATH for the Google Cloud SDK.
source '/Users/frankfarzan/tools/google-cloud-sdk/path.zsh.inc'

# The next line enables shell command completion for gcloud.
source '/Users/frankfarzan/tools/google-cloud-sdk/completion.zsh.inc'

###-begin-ng-completion### 
ng_opts='new init build serve generate autocomplete e2e lint test version'
init_opts='--dry-run --verbose --blueprint --skip-npm --skip-bower --name'
new_opts='--dry-run --verbose --blueprint --skip-npm --skip-bower --skip-git --directory'
build_opts='--environment --output-path --watch --watcher'
serve_opts='--port --host --proxy --insecure-proxy --watcher --live-reload --live-reload-host
            --live-reload-port --environment --output-path --ssl --ssl-key --ssl-cert'
generate_opts='component directive pipe route service'
test_opts='--watch --browsers --colors --log-level --port --reporters'

if type complete &>/dev/null; then
  _ng_completion() {
    local cword pword opts

    COMPREPLY=()
    cword=${COMP_WORDS[COMP_CWORD]}
    pword=${COMP_WORDS[COMP_CWORD - 1]}

    case ${pword} in
      ng) opts=$ng_opts ;;
      i|init) opts=$init_opts ;;
      new) opts=$new_opts ;;
      b|build) opts=$build_opts ;;
      s|serve|server) opts=$serve_opts ;;
      g|generate) opts=$generate_opts ;;
      test) opts=$test_opts ;;
    esac

    COMPREPLY=( $(compgen -W '${opts}' -- $cword) )

    return 0
  }
  complete -o default -F _ng_completion ng
elif type compctl &>/dev/null; then
  _ng_completion () {
    local words cword opts
    read -Ac words
    read -cn cword
    let cword-=1

    case $words[cword] in
      ng) opts=$ng_opts ;;
      i|init) opts=$init_opts ;;
      new) opts=$new_opts ;;
      b|build) opts=$build_opts ;;
      s|serve|server) opts=$serve_opts ;;
      g|generate) opts=$generate_opts ;;
      test) opts=$test_opts ;;
    esac
    
    setopt shwordsplit
    reply=($opts)
    unset shwordsplit
  }
  compctl -K _ng_completion ng
fi
###-end-ng-completion###
