#!/usr/bin/env bash

# alias / abbreviation
alias -- :q=exit
alias -- ln="ln -s -v"
alias -- cp="cp -i"
alias -- mv="mv -i"
alias -- rm="trash put"
alias -- mkdir="mkdir -p"
alias -- e="edit"
alias -- n="nvim"
alias -- h="hx"
alias -- tl="tldr"
alias -- gstatus="git status -s -b"

# eza / ls
alias -- ls='eza --icons auto --git --group-directories-first --sort Filename --group --time-style long-iso'
alias -- la='eza --icons auto --git --group-directories-first --sort Filename --group --time-style long-iso -a'
alias -- ll='eza --icons auto --git --group-directories-first --sort Filename --group --time-style long-iso -l'
alias -- lla='eza --icons auto --git --group-directories-first --sort Filename --group --time-style long-iso -la'
alias -- lt='eza --icons auto --git --group-directories-first --sort Filename --group --time-style long-iso --tree'

# image
case $TERM in
  kitty|xterm-ghostty|xterm-rio)
    alias -- img="kitten icat";;
  wezterm)
    alias -- img="wezterm imgcat";;
esac

# key-bind
bind -x '"\C-y": cd ../'

# Long command notifier
# Notify when command takes longer than N seconds
LONG_CMD_THRESHOLD=10
__cmd_start=$SECONDS
__cmd_running=0

# Called before each command runs (receives actual command as $1)
__notify_preexec() {
    __cmd_start=$SECONDS
    __cmd_running=1
}

# Called before each prompt is displayed
__notify_precmd() {
    if [[ $__cmd_running -eq 1 ]]; then
        local elapsed=$(( SECONDS - __cmd_start ))
        if (( elapsed >= LONG_CMD_THRESHOLD )); then
            notify-send "Terminal" "Command finished (${elapsed}s)" \
                --icon=utilities-terminal
        fi
    fi
    __cmd_running=0
}

preexec_functions+=(__notify_preexec)
precmd_functions+=(__notify_precmd)
