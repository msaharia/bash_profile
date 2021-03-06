### PATHS~

### Aliases

# Text editors
alias s='open -a "Sublime Text"'
alias vi='vim'
export TERM=xterm-256color #Set colors to match iTerm2 Terminal Colors
export CLICOLOR=1i #Set CLICOLOR if you want Ansi Colors in iTerm2

# SERVERS
alias hydro='ssh -X manab@hydro-c1.rap.ucar.edu'
alias yellow='ssh -X manab@yellowstone.ucar.edu'
alias cheyenne='ssh -X manab@cheyenne.ucar.edu'
alias flash252='ssh -X -l manab 10.197.10.252'
alias flash249='ssh -X -l manab 10.197.10.249'

# SERVER SHORTCUTS
alias hwork='cd /d3/msaharia' #hydro-c1
alias cwork='cd /glade/p/work/manab' #cheyenne
alias chome='cd /glade/u/home/manab' #cheyenne

# Color LS
colorflag="-G"
alias ls="command ls ${colorflag}"
alias l="ls -lF ${colorflag}" # all files, in long format
alias la="ls -laF ${colorflag}" # all files inc dotfiles, in long format
alias lsd='ls -lF ${colorflag} | grep "^d"' # only directories
alias ds='du -sh' #size of directory

# Quicker navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

#Full location of a link
alias rl="readlink -f"

#netCDF shortcuts
alias ncd="ncdump -h"
alias ncv="ncdump -v"

# Enable aliases to be sudo’ed
alias sudo='sudo '

# grep
alias grep='grep --color' 

# History
HISTCONTROL=ignoreboth #Ignores duplicate and leading whitespace commands
alias h="history"
HISTSIZE=100000
HISTFILESIZE=200000
shopt -s histappend

# Colored up cat!
# You must install Pygments first - "sudo easy_install Pygments"
alias c='pygmentize -O style=monokai -f console256 -g'

# Git
alias gst='git status'
alias ga='git add .'
alias gco='git commit -m' # requires you to type a commit message
alias gpush='git push'
alias gpull='git pull'
alias grm='git rm $(git ls-files --deleted)'
alias gch='git checkout'
alias gl='git log'
alias gd='git diff'
alias gm='git merge'
alias gf='git fetch'

# Automatically enter a dir and list
function cs () {
    cd $1
    ls -htr --color -h --group-directories-first
}

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

### Prompt Colors
# Modified version of @gf3’s Sexy Bash Prompt
# (https://github.com/gf3/dotfiles)
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM=xterm-256color
fi

if tput setaf 1 &> /dev/null; then
	tput sgr0
	if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
		MAGENTA=$(tput setaf 9)
		ORANGE=$(tput setaf 172)
		GREEN=$(tput setaf 190)
		PURPLE=$(tput setaf 141)
	else
		MAGENTA=$(tput setaf 5)
		ORANGE=$(tput setaf 4)
		GREEN=$(tput setaf 2)
		PURPLE=$(tput setaf 1)
	fi
	BOLD=$(tput bold)
	RESET=$(tput sgr0)
else
	MAGENTA="\033[1;31m"
	ORANGE="\033[1;33m"
	GREEN="\033[1;32m"
	PURPLE="\033[1;35m"
	BOLD=""
	RESET="\033[m"
fi

export MAGENTA
export ORANGE
export GREEN
export PURPLE
export BOLD
export RESET

# Git branch details
function parse_git_dirty() {
	[[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}
function parse_git_branch() {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

# (http://en.wikipedia.org/wiki/Unicode_symbols)
symbol="⚡  "

export PS1="\[${MAGENTA}\]\u \[$RESET\]in \[$GREEN\]\w\[$RESET\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$PURPLE\]\$(parse_git_branch)\[$RESET\]\n$symbol\[$RESET\]"
export PS2="\[$ORANGE\]→ \[$RESET\]"


### Misc

# Only show the current directory's name in the tab
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'
