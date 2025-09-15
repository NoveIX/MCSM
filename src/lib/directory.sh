#!/bin/bash

# ====================================== Lib function ====================================== #

ensure_dir() {
    local dir="$1"
    if [[ -n "$dir" && ! -d "$dir" ]]; then
        mkdir -p "$dir"
    fi
}

dir_exists() {
    local dir="$1"
    [[ -d "$dir" ]]
}