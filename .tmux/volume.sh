vol=$(amixer -D pulse | grep -E -o '[0-9]?[0-9][0-9]?%' | head -1)
echo ${vol}

