# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

#sonicradish.zsh-theme
#adben.zsh-theme
#garyblessington

ZSH_THEME="lambda"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT="false"

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
# HIST_STAMPS="mm/dd/yyyy/"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  jump
  docker
  sudo
)

source $ZSH/oh-my-zsh.sh

TERM=xterm

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_CA.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

## Custom entries
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH:/bin
export PATH=$HOME/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH="~/bin/geckodriver:$PATH" 
export CC=gcc-7

function loadenv() {
	export $(cat ${1:-.env} | xargs)
}

function ezsh() {
    if [ $# -eq 0 ]; then
	vim ~/.zshrc
    else
	vim ~/.config/zsh/$1
    fi
}

alias szsh='source ~/.zshrc'
alias volu='amixer sset -q Master +2%'
alias vold='amixer sset -q Master -2%'
alias chmux='chmod u+x'
alias less='less -Q'
alias man 'man -P "less -Q"'
alias iclip='xclip -selection clipboard'
alias oclip='xclip -selection clipboard -o'
alias l='la'
alias mux='tmuxinator'
alias dir_name='pwd | rev | cut -f1 -d '/' | rev'

function getDate() {
    if [ $# -eq 0 ]; then
        date="20$(date +%y-%m-%d)"
    elif [ $# -eq 1 ]; then
        month=$(date +%m)
        day=$(date +%d)
        ((day = day + $1))
        day=$(printf "%02d\n" $day)
        date="20$year-$month-$day"
    else
        if [[ -z "$3" ]]; then
             year=$(date +%y)
        fi
        date="20$year-$1-$2"
    fi

    echo $date
}

function hist() {
    date=$(getDate $@) 
    fc -li 1000 | grep $date | less
}

function untrash() {
    dest='.'
    if [[ -z '$2' ]]; then
        dest=$2
    fi

    mv ~/.local/share/Trash/files/$1 $dest
}

export EDITOR=$(which vim)

for file in ~/.config/zsh/*; do
    source "$file"
done

#extensions
alias j=jump

# Ruby 2.7.0
RUBY_PACKAGES="${HOME}/.gem/ruby/2.7.0"
# PATH="$RUBY_PACKAGES/bin:$PATH"

# GO
export GOCACHE="${HOME}/.gocache"

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 

#NPM
NPM_PACKAGES="${HOME}/.npm-packages"

PATH="$NPM_PACKAGES/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

if [ -f ~/zsh.command-not-found ]; then
    . ~/zsh.command-not-found
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
