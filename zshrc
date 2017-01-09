# Path to your oh-my-zsh installation.
  export ZSH=/home/kragenarch/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bullet-train"

POWERLINE_RIGHT_A="exit-status-on-fail"
POWERLINE_HIDE_HOST_NAME="true"
POWERLINE_HIDE_USER_NAME="true"
POWERLINE_PATH="short"
POWERLINE_SHOW_GIT_ON_RIGHT="true"

POWERLINE_RIGHT_A_COLOR_FRONT="white"
POWERLINE_RIGHT_A_COLOR_BACK="red"

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
plugins=(git)

# User configuration

export PATH="/home/kragenarch/.gem/ruby/2.3.0/bin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh
source ~/.bin/*

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
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

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

zle -N fancy-ctrl-z
bindkey '' fancy-ctrl-z

export EDITOR=vim
export TERM=xterm-256color
export NOTES_DIR="/home/kragenarch/notes"

stty -ixon

# User defined alias

# VIM KEKS
alias :q="echo \"You're not in vim, dummy\""

# UPDATING
alias sysupdate="pacaur -Syu"
alias pi="sudo pacman -S"
alias pr="sudo pacman -R"
alias pr-full="sudo pacman -Rns"

#LISTING
alias la="ls -A"
alias lah="ls -lAhr"

alias godmode="sudo su"

# USEFUL COMMANDS
alias xc="xclip -sel clipboard"
alias neofetch="clear;neofetch --ascii"
alias vi="vim"
alias emacs="emacs -nw"
alias py="python3"

# TMUX ALIAS
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
