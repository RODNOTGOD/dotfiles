source ~/.tmux/text_roll.sh
metadata=$(playerctl metadata)

if [[ "$?" -eq 0 && -n "$metadata" ]]; then
	state=$(playerctl status)
	if [[ $state == "Playing" ]]; then
		artist=$(playerctl metadata artist)
		track=$(playerctl metadata title)
		np=$(echo "${artist} - ${track}")
		# echo "♫ $np"
		roll_text "$np" 75 15
	fi
fi
