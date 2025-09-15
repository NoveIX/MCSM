#!/bin/bash

# =================================== Global parameter ===================================== #

CURRENT_DATE=$(date '+%Y-%m-%d')
LOG_FILE="$HOME/MCServerManager/logs/${CURRENT_DATE}.log"

LIB_DIR="lib/"

# Carica il loader
source loader.sh

# Carica tutte le librerie automaticamente
load_all_libs       # senza reload
# oppure per forzare il reload
# load_all_libs 1
