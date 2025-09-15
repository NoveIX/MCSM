#!/bin/bash

# Default library folder
lib_dir="${LIB_DIR:-lib}"

declare -A LIBS_LOADED

# Load a single library
# $1 = library name (es. directory.sh)
# $2 = force_reload (optional, default 0)
load_lib() {
    local lib_name="$1"
    local force_reload="${2:-0}"

    # Salta se già caricata
    if [[ "${LIBS_LOADED[$lib_name]}" == "1" && $force_reload -eq 0 ]]; then
        return 0
    fi

    # Controlla che la libreria esista
    local lib_path="$lib_dir/$lib_name"
    if [[ ! -f "$lib_path" ]]; then
        echo "Errore: libreria '$lib_name' non trovata in '$lib_dir'"
        return 1
    fi

    # Carica la libreria
    source "$lib_path"
    LIBS_LOADED[$lib_name]=1
    echo "$lib_name caricata!"
}

# Carica tutte le librerie nella cartella lib_dir
# $1 = force_reload (opzionale, default 0)
load_all_libs() {
    local force_reload="${1:-0}"

    if [[ ! -d "$lib_dir" ]]; then
        echo "Errore: cartella librerie '$lib_dir' non trovata"
        return 1
    fi

    for lib_file in "$lib_dir"/*.sh; do
        [[ -f "$lib_file" ]] || continue
        local lib_name
        lib_name=$(basename "$lib_file")
        load_lib "$lib_name" "$force_reload"
    done
}
