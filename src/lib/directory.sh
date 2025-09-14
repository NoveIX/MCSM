#!/usr/bin/env bash

# Force lib file reload
FORCE_RELOAD=0
if [[ "$1" == "-f" ]]; then
    FORCE_RELOAD=1
fi

# Load lib file
if [[ -n "$DIRECTORYLIB_LOADED" && $FORCE_RELOAD -eq 0 ]]; then
    return 0
fi
DIRECTORYLIB_LOADED=1



# Lib Function
EnsureDir() {
    local dir="$1"
    if [[ ! "$dir" ]]; then
        mkdir -p "$dir"
    fi
}

DirExists() {
    local dir="$1"
    [[ -d "$dir" ]]
}