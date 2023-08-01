#!/bin/bash

windows=("Binding of Isaac: Repentance")

windowInList() {
  for i in "${windows[@]}"; do
    [ "\"$i\"" == "$1" ] && return 0
  done
  return 1
}

val() {
  hyprctl activewindow -j | jq "$1"
}

validWin() {
  windowInList "$(val .title)"
}

switch() {
  hyprctl keyword general:cursor_inactive_timeout $1
}

isFullscreen() {
  [ $(val .fullscreen) == "true" ] && return 0 || return 1
}

handle() {
  if [[ ${1:0:10} == "fullscreen" ]]; then
    if validWin && isFullscreen; then
      switch 1
    else
      switch 0
    fi
  fi
  if [[ ${1:0:9} == "workspace" ]]; then
    if validWin && isFullscreen; then
      switch 1
    else
      switch 0
    fi
  fi
}

socat - "UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do handle "$line"; done

