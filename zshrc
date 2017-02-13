# Path to your oh-my-zsh installation.
export ZSH=/home/kragentu/.oh-my-zsh

# Zsh theme settings
ZSH_THEME="bullet-train"

# Bullet train format
if [ ! -n "${BULLETTRAIN_PROMPT_ORDER+1}" ]; then
  BULLETTRAIN_PROMPT_ORDER=(
    status
    custom
    context
    dir
    perl
    ruby
    virtualenv
    nvm
    go
    git
    hg
    cmd_exec_time
  )
fi
BULLETTRAIN_PROMPT_CHAR="»"
BULLETTRAIN_GIT_BG=green
BULLETTRAIN_GIT_CLEAN=" %F{black}✔%F{black}"

# Oh my zsh options
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="mm/dd/yyyy"
plugins=(git sudo ubuntu zsh-autosuggestions)

# User configuration
source $ZSH/oh-my-zsh.sh

# Vim Functions
fancy-ctrl-z() {
	if [[ $#BUFFER -eq  0 ]]; then
		BUFFER="fg"
		zle accept-line
	else
		zle push-input
		zle clear-screen
	fi
}

# Key bindings
zle -N fancy-ctrl-z
bindkey '' fancy-ctrl-z
bindkey '^N' autosuggest-accept
bindkey '^P' up-line-or-search

export EDITOR=nvim
export TERM=xterm-256color
export NOTES_DIRECTORY="/home/kragentu/.notes"

# Disable tty scroll lock
stty -ixon

# User defined alias
alias notes\ open="cd $NOTES_DIRECTORY"

# VIM KEKS
alias :q="echo \"You're not in vim, dummy\""

# UPDATING
alias update="sudo apt update"
alias upgrade="sudo apt update; sudo apt upgrade"
alias ai="sudo apt install"
alias ar="sudo apt remove"
alias ar-full="sudo apt remove --purge"

#LISTING
alias la="ls -A"
alias lah="ls -lAhr"

alias godmode="sudo su"

# USEFUL COMMANDS
alias xc="xclip -sel clipboard"
alias neofetch="clear;neofetch --ascii"
alias vi="vim"
alias vim="nvim"
alias emacs="emacs -nw"
alias py="python3"

# TMUX ALIAS
alias tm="tmux-menu"
alias tmux="tmux -2"
alias ta="tmux attach"
alias tat="tmux attach -t"
alias tl="tmux list-sessions"

alias tk="tmux kill-session -t"
alias tks="tmux kill-server"

alias ts="tmuxinator start"
alias tn="tmuxinator new"

# GIT ALIAS
alias gla="git log --oneline --all --decorate --graph"
alias glas="git --no-pager log --oneline --all --decorate --graph -40"
alias glass="git --no-pager log --oneline --all --decorate --graph -10"

alias glb="git log --oneline --decorate --graph"
alias glbs="git --no-pager log --oneline --decorate --graph -40"
alias glbss="git --no-pager log --oneline --decorate --graph -10"
