# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=/home/laprise/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

#sonicradish.zsh-theme
#sorin.zsh-theme
#humza.zsh-theme
#adben.zsh-theme
#

ZSH_THEME="muse"

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
DISABLE_UPDATE_PROMPT="true"

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
)

source $ZSH/oh-my-zsh.sh

TERM=xterm

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

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
export PATH=$HOME/local/bin:$PATH

export GOROOT=/usr/lib/golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

export PATH="~/bin/geckodriver:$PATH" 

function loadenv() {
	export $(cat ${1:-.env} | xargs)
}

alias crawl='wget -mkE -l 10 -t 6 -w 1'
#zsh
alias meow='cat ~/scripts/draw_a_cat.sh'
alias ozsh='vim ~/.zshrc'
alias szsh='source ~/.zshrc'
alias dnfi='sudo dnf install'
alias dnfr='sudo dnf remove'
alias dnfs='dnf search'
alias dnfu='sudo dnf upgrade'
alias clear='clear && meow'
alias volu='amixer sset -q Master +2%'
alias vold='amixer sset -q Master -2%'
alias chmux='chmod u+x'

meow

#i3
alias i3conf='vim ~/.config/i3/config'

#Django
source /usr/bin/virtualenvwrapper.sh

alias pym='python manage.py'
alias dapy='django-admin.py'
alias pymt='python manage.py test'

function pvva() {
	if [ $# -eq 0 ]
	then
		source venv/bin/activate
	else
		source env/bin/activate
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

#LastPass
function lpp() {
       if [ $# -eq 0 ]
        then
		url=$(xclip -o)
		url=$(~/scripts/parseURL.sh $url)
		lpass show -c --password  $url
	elif  [ $# -eq 1 ]
	then
		url=$(~/scripts/parseURL.sh $1)
		lpass show -c --password  $url
	else
		echo Nop
        fi
}


function lpu() {
        if [ $# -eq 0 ]
        then
		url=$(xclip -o)
		url=$(~/scripts/parseURL.sh $url)
		lpass show -c --username $url
	elif [ $# -eq 1 ]
        then
		url=$(~/scripts/parseURL.sh $1)
		lpass show -c --username $url
        else
		echo Nop
        fi
}

#extensions
alias j=jump

NPM_PACKAGES="${HOME}/.npm-packages"

PATH="$NPM_PACKAGES/bin:$PATH"

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

if [ -f ~/zsh.command-not-found ]; then
    . ~/zsh.command-not-found
fi

eval $(thefuck --alias)

#Docker
alias dck='docker'
alias dckc='docker-compose'
