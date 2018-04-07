BOLD_WHITE='\033[1;37m'
BOLD_CYAN='\033[1;36m'
LIGHT_GREEN='\[\e[1;32m\]'
LIGHT_RED='\[\e[1;31m\]'
DARK_GARY='\[\e[1;30m\]'
RESET='\[\e[m\]'

get_prompt_colors() {
	if [ "$EUID" -eq 0 ]; then
		echo $LIGHT_RED
	else
		echo $LIGHT_GREEN
	fi
}

GIT_PS1_SHOWDIRTYSTATE="true"
GIT_PS1_SHOWUNTRACKEDFILES="true"

source $SCRIPT_DIR/git-prompt.sh

set_bash_prompt() {
	ERR_CODE=$?

	if [ "$ERR_CODE" -ne "0" ]; then
		ERR_CODE="$LIGHT_RED$ERR_CODE$RESET"
	else
		ERR_CODE=
	fi

	PROMPT_DIRTRIM=2
	PS1="$LIGHT_GREEN┌─[\u@\h] - [$BOLD_WHITE\w$BOLD_CYAN`__git_ps1 \" (%s)\"`$LIGHT_GREEN] $ERR_CODE \n$RESET$LIGHT_GREEN└─[$DARK_GARY\$$LIGHT_GREEN]$RESET "
}

PROMPT_COMMAND=set_bash_prompt
