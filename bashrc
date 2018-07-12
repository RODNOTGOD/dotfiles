# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

[ -z "$PS1" ] && return

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

export HISTCONTROL=ignoreboth

export SCRIPT_DIR=~/.scripts

source $SCRIPT_DIR/custom-bash-prompt.sh

shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Purpose: Display pause prompt
# $1-> Message (optional)
function pause(){
	local message="$@"
	[ -z $message ] && message="Press [Enter] key to continue..."
	read -p "$message" readEnterKey
}

# Purpose - Display header message
# $1 - message
function write_header(){
	local h="$@"
	echo "---------------------------------------------------------------"
	echo "     ${h}"
	echo "---------------------------------------------------------------"
}

# Purpose - Network inferface and routing info
function netinfo(){
	devices=$(netstat -i | cut -d" " -f1 | egrep -v "^Kernel|Iface|lo")
	write_header " Network information "
	echo "Total network interfaces found : $(wc -w <<<${devices})"

	echo "*** IP Addresses Information ***"
	ip -4 address show | awk '/inet/ {print $2;}'
	wget -qO- ipinfo.io/ip || curl ipinfo.io/ip || echo "Not connected to internet"

	echo "***********************"
	echo "*** Network routing ***"
	echo "***********************"
	netstat -nr

	echo "**************************************"
	echo "*** Interface traffic information ***"
	echo "**************************************"
	netstat -i

	pause
}

extract () {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)   tar xvjf $1    ;;
			*.tar.gz)    tar xvzf $1    ;;
			*.bz2)       bunzip2 $1     ;;
			*.rar)       unrar x $1     ;;
			*.gz)        gunzip $1      ;;
			*.tar)       tar xvf $1     ;;
			*.tbz2)      tar xvjf $1    ;;
			*.tgz)       tar xvzf $1    ;;
			*.zip)       unzip $1       ;;
			*.Z)         uncompress $1  ;;
			*.7z)        7z x $1        ;;
			*)           echo "don't know how to extract '$1'..." ;;
		esac
	else
		echo "'$1' is not a valid file!"
	fi
}

compress () {
	case $1 in
		*.tar.bz2)   tar cvjf $1 ${@:2} ;;
		*.tar.gz)    tar cvzf $1 ${@:2} ;;
		*.tar)       tar cvf  $1 ${@:2} ;;
		*.tbz2)      tar cvjf $1 ${@:2} ;;
		*.tgz)       tar cvzf $1 ${@:2} ;;
		*)           echo "don't know how to compress '$1'..." ;;
	esac
}

md() {
	mkdir -p "$@"; cd "$@" || exit
}

utsa() {
	ssh "euw112@fox0$@.cs.utsa.edu"
}

fork() {
	(setsid "$@" &);
}

tvim() {
	vim -q <(taskfinder $@)
}

vgrep() {
	vim -q <(grep -nHIs $@)
}


export EDITOR="vim"
export NOTES_DIRECTORY=".notes"

alias mkd="mkdir -p"

alias rm="rm -I --preserve-root"

# confirmation #
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# Parenting changing perms on / #
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

alias tm="tmux-menu"
alias tl="tmux list-sessions"
alias ta="tmux attach"
alias tat="tmux attach -t"
alias tk="tmux kill-session"
alias tks="tmux kill-server"
alias tkt="tmux kill-session -t"

alias gst="git status -sb"
alias gcl="git clone --recursive"
alias gp="git push"
alias gc="git commit -v"

# GIT ALIAS
alias gl="git log --oneline --all --decorate --graph"
alias gls="git --no-pager log --oneline --all --decorate --graph -40"
alias glss="git --no-pager log --oneline --all --decorate --graph -10"

alias glb="git log --oneline --decorate --graph"
alias glbs="git --no-pager log --oneline --decorate --graph -40"
alias glbss="git --no-pager log --oneline --decorate --graph -10"

alias d="dirs -v"
alias 1="cd ~1"
alias 2="cd ~2"
alias 3="cd ~3"
alias 4="cd ~4"
alias 5="cd ~5"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias ll="ls -alF"
alias la="ls -A"
alias lah="ls -lAhr"
alias sl="ls"
alias l="ls"
alias s="ls"

alias yt-music="youtube-dl -o \"~/Music/%(title)s.%(ext)s\" -x --audio-format opus --audio-quality 0"

stty werase undef
bind '\C-w:unix-filename-rubout'

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

export EDITOR=vim
export BROWSER=firefox
export XKB_DEFAULT_OPTIONS=ctrl:nocaps
export LESS="--RAW-CONTROL-CHARS"

export PATH="$PATH:~/.scripts/"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.LESS_TERMCAP ] && source ~/.LESS_TERMCAP

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
