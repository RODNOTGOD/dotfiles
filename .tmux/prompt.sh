#!/usr/bin/env bash

export TMUX_POWERLINE_DIR_HOME="$(dirname $0)"
export DEBUG_MODE=0 # enable this to test all segments
export DEBUG_VCS=0 # enable this to also show the vcs segments
source "${TMUX_POWERLINE_DIR_HOME}/config.sh"
get_pane_width

print_powerline() {
  # The format of the segments is:

  # segment "segment_file_name" foreground background min_pane_width
  # double_segment "label" fg bg "segment_filename" fg bg min_pane_width

  # If the required PANE_WIDTH isn't met then the segment will be
  # hidden
  if [ $DEBUG_MODE -ne 1 ]; then
    double_segment "♫" brightgreen blue "s_now_playing" blue black 143
    double_segment "♫" brightgreen blue "m_now_playing" blue black 143
    double_segment "♫" brightgreen blue "volume" blue black 143
    double_segment "Host" brightgreen blue "hostname" blue black 143
    double_segment "Time" brightgreen blue "wakatime_today" blue black 144
    double_segment "js" brightgreen yellow "node" yellow brightgreen 114
    double_segment "rb" brightgreen red "ruby" red brightgreen 113
    double_segment "⎇" brightgreen brightred "vcs_branch" brightred brightgreen
    segment "vcs_compare" black black #this is kind of a hack need to refactor
    double_segment "⊕" brightgreen green "vcs_staged" green brightgreen
    double_segment "+" brightgreen yellow "vcs_modified" yellow brightgreen
    double_segment "○" brightgreen white "vcs_others" white brightgreen
  else
    source "${TMUX_POWERLINE_DIR_HOME}/debug_prompt.sh"
  fi

  exit 0
}

print_powerline "$1"
