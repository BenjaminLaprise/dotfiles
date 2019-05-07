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
  fedora
  nyan
  dircycle
  copydir
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

eval "$(direnv hook zsh)"

function loadenv() {
	export $(cat ${1:-.env} | xargs)
}

alias crawl='wget -mkE -l 10 -t 6 -w 1'

#Neofetch
neofetch

#zsh
alias ezsh='vim ~/.zshrc'
alias szsh='source ~/.zshrc'
alias volu='amixer sset -q Master +2%'
alias vold='amixer sset -q Master -2%'
alias chmux='chmod u+x'
alias less='less -Q'
alias man 'man -P "less -Q"'
alias iclip='xclip -selection clipboard'
alias oclip='xclip -selection clipboard -o'
alias l='la'

function hist() {
    if [[ -z "$3" ]]; then
         year=$(date +%y)
    fi
    date="20$year-$1-$2"
    fc -li 1000 | grep $date | less
}

function untrash() {
    if [[ -z '$2' ]]; then
        dest=$2
    else
        dest='.'
    fi

    mv ~/.local/share/Trash/files/$1 $dest
}

#Git
alias oups='git reset HEAD~'

function gog() {
    if [[ -z "$3" ]]; then
        year=$(date +%y)
    fi
    start_date="20$year-$1-$2 00:00:00"
    end_date="20$year-$1-$2 23:59:59"

    git log --after=$start_date --before=$end_date --reverse
}

#Arch
alias pacu='sudo pacman -Syu'
alias paci='sudo pacman -S'
alias pacr='sudo pacman -R'
alias pacs='sudo pacman -Ss'

#i3
alias i3conf='vim ~/.config/i3/config'

#Brew
PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

#Django
#source /usr/bin/virtualenvwrapper.sh
export PYTHONSTARTUP=~/.pythonrc
alias pym='python manage.py'
alias dapy='django-admin.py'
alias pymt='python manage.py test'

alias depym='docker-compose exec django python manage.py'


alias drpym="docker-compose run --rm django python manage.py"

function pvva() {
	if [ $# -eq 1 ]
	then
		source $1/bin/activate
	else
		source venv/bin/activate
	fi
}

function pymm() {
	python manage.py makemigrations
	python manage.py migrate
}

function pymr() {
	if [ $# -eq 0 ]
	then
		pym runserver
	else
		loadenv .env.docker-mysql 
		systemctl start docker
		python manage.py runserver
	fi
}

export EDITOR=$(which vim)

#extensions
alias j=jump

#Wal
(cat ~/.cache/wal/sequences &)

#Docker
alias dck='docker'
alias dckc='docker-compose'

function  dckid() {
    container_name=$1
    container_infos=`docker ps -a | grep $container_name`
    echo $container_infos | awk '{print $1}'
}

#venv
. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source $HOME/.local/bin/virtualenvwrapper.sh

#NPM
NPM_PACKAGES="${HOME}/.npm-packages"

PATH="$NPM_PACKAGES/bin:$PATH"

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

if [ -f ~/zsh.command-not-found ]; then
    . ~/zsh.command-not-found
fi

eval $(thefuck --alias)
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
source $HOME/.bin/tmuxinator.zsh
