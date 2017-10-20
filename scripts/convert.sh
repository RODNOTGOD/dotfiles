#!/usr/bin/env bash

if [[ -z $(command -v ffmpeg) ]]; then
	echo "Missing dependency ffmpeg"
	exit 1
fi

__ScriptVersion="version"

#===  FUNCTION  ================================================================
#         NAME:  usage
#  DESCRIPTION:  Display usage information.
#===============================================================================
function usage ()
{
	if [[ ! -z $1 ]]; then
		echo "Error: $(tput setaf 1)$1$(tput sgr 0)"
	fi
	echo "Usage :  $0 [options] [--]

    Options:
    -h|help       Display this message
    -v|version    Display script version
    -c|codec      What codec to use for convert (ffmpeg help | grep {your codec})
    -e|extension  Extension to append to the end of the file
    -b|bitrate    (default 320k) optional setting to set bitrate"

}    # ----------  end of function usage  ----------

#-----------------------------------------------------------------------
#  Handle command line arguments
#-----------------------------------------------------------------------

ext=""
codec=""

while getopts "c:e:hvb:" opt
do
  case $opt in

	e|extension)
		ext=$OPTARG
		;;

	c|codec)
		codec=$OPTARG
		;;

	b|bitrate)
		bitrate=$OPTARG
		;;

	h|help)
		usage
		exit 0
		;;

	v|version)
		echo "$0 -- Version $__ScriptVersion"
		exit 0
		;;

	* )
		echo -e "\n  Option does not exist : $OPTARG\n"
		usage
		exit 1
		;;

  esac    # --- end of case ---
done
shift $(($OPTIND-1))

if [[ -z $codec ]]; then
	usage "Missing codec"
	exit -1
fi

if [[ -z $ext ]]; then
	usage "Missing extension"
	exit -1
fi


if [[ $# -lt 1 ]]; then
	usage "Missing convert files"
	exit 99
fi

IFS=""
for file in $@; do
	if [[ -e $file ]]; then
		printf "\xE2\x86\x92 Converting $(tput smul)$file$(tput rmul)\n"
		$(ffmpeg -i "$file" -acodec "$codec" -ab $bitrate "${file%.*}.$ext" &> /dev/null)
		if [[ $? -eq 0 ]]; then
			printf "$(tput setaf 2)\xE2\x9C\x93 Created ${file%.*}.$ext $(tput sgr 0)\n"
		else
			printf "$(tput setaf 1)\xE2\x9D\x8C Failed to convert $file $(tput sgr 0)\n"
		fi
	fi
done
