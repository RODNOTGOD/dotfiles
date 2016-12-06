# Print current playing song in your music player of choice.
source "${TMUX_POWERLINE_DIR_LIB}/text_roll.sh"

TMUX_POWERLINE_SEG_NOW_PLAYING_MUSIC_PLAYER="spotify"
TMUX_POWERLINE_SEG_NOW_PLAYING_MAX_LEN="50"
TMUX_POWERLINE_SEG_NOW_PLAYING_TRIM_METHOD="roll"
TMUX_POWERLINE_SEG_NOW_PLAYING_ROLL_SPEED="5"
TMUX_POWERLINE_SEG_NOW_PLAYING_NOTE_CHAR="♫"

run_segment() {
	if [ -z "$TMUX_POWERLINE_SEG_NOW_PLAYING_MUSIC_PLAYER" ]; then
		return 1
	fi

	local np
	case "$TMUX_POWERLINE_SEG_NOW_PLAYING_MUSIC_PLAYER" in
		"spotify")  np=$(__np_spotify) ;;
		"mpd")  np=$(__np_mpd) ;;
		*)
			echo "Unknown music player type [${TMUX_POWERLINE_SEG_NOW_PLAYING_MUSIC_PLAYER}]";
			return 1
	esac
	local exitcode="$?"
	if [ "${exitcode}" -ne 0 ]; then
		return ${exitcode}
	fi
	if [ -n "$np" ]; then
		case "$TMUX_POWERLINE_SEG_NOW_PLAYING_TRIM_METHOD" in
			"roll")
				np=$(roll_text "${np}" ${TMUX_POWERLINE_SEG_NOW_PLAYING_MAX_LEN} ${TMUX_POWERLINE_SEG_NOW_PLAYING_ROLL_SPEED})
				;;
			"trim")
				np=${np:0:TMUX_POWERLINE_SEG_NOW_PLAYING_MAX_LEN}
				;;
		esac
		echo "${np}"
	fi
	return 0
}

__np_spotify() {
    metadata=$(playerctl metadata)

	if [[ "$?" -eq 0 && -n "$metadata" ]]; then
		state=$(playerctl status)
		if [[ $state == "Playing" ]]; then
			artist=$(playerctl metadata artist)
			track=$(playerctl metadata title)
			np=$(echo "${artist} - ${track}")
		fi
	fi
	echo "$np"
}

__np_mpd() {

	state=$(mpc status | grep -E -o '\[[a-z]+\]')
	if [[ $state == "[playing]" ]]; then
		artist=$(mpc current | tr "\-" "\n" | head -1)
		track=$(mpc current | tr "\-" "\n" | tail -1)
		np=$(echo "${artist} - ${track}")
	fi
	echo "$np"
}
