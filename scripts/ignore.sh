#!/bin/bash

sed '
/[#!]\|^$/d
s|^|\*/|
s|$|/\*|
s_//\|/\*/_/_g
s_\(\*/\([^/\.]\|.\)\+\..*\)\(/\*\)_\1_
s|^|set wildignore+=|
' "$@"
