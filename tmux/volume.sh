#!/usr/bin/env bash

vol=$(amixer -D pulse | grep -P -o '\d{1,3}' | head -1)
echo $vol
