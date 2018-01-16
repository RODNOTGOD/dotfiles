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

	PS1="$LIGHT_GREEN\u@\h[\w`__git_ps1 \" (%s)\"`] $ERR_CODE \n$RESET$DARK_GARY\$$RESET "
}

PROMPT_COMMAND=set_bash_prompt
