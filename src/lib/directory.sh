#!/usr/bin/env bash

# ======================================[ Lib function ]====================================== #

ensure_dir() {
    local dir="$1"
    if [[ -n "$dir" && ! -d "$dir" ]]; then
        mkdir -p "$dir"
    fi
}

if_dir_exists() {
    local dir="$1"
    [[ -d "$dir" ]]
}

make_temp_dir() {
    local dir="$1"
    mktemp -d -p "$dir" tmp.XXXXXXXXXXXXXXXXXXXX
}