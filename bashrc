# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

[ -z "$PS1" ] && return
export HISTCONTROL=ignoredups

export SCRIPT_DIR=~/.scripts

source $SCRIPT_DIR/custom-bash-prompt.sh

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

mkd() {
	mkdir -p "$@"; cd "$@" || exit
}

utsa() {
	ssh "euw112@fox0$@.cs.utsa.edu"
}

fork() {
	(setsid "$@" &);
}

tvim() {
	nvim -q <(taskfinder $@)
}

vgrep() {
	nvim -q <(grep -nHIs $@)
}


export EDITOR="nvim"
export NOTES_DIRECTORY=".notes"

alias md="mkdir -p"

alias gst="git status"
alias gcl="git clone --recursive"
alias gp="git push"
alias gc="git commit -v"

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

alias la="ls -A"
alias lah="ls -lAhr"
alias sl="ls"
alias l="ls"
alias s="ls"

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

EDITOR=nvim
BROWSER=firefox

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
