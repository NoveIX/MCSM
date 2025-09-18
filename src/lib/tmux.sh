#!/usr/bin/env bash

# ======================================[ Lib function ]====================================== #

test_session_exist() {
        local session="$1"
    tmux has-session -t "$session" 2>/dev/null
}


tmux_attach_session() {
    local session="$1"
    tmux attach -t "$session"
}

tmux_new_session() {
    local session="$1"
    local dir="$2"
    local cmd="$3"
    tmux new-session -d -s "$session" -c "$dir" "$cmd"
}