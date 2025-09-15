#!/usr/bin/env bash

# Force lib file reload
FORCE_RELOAD=0
if [[ "$1" == "-f" ]]; then
    FORCE_RELOAD=1
fi

# Load lib file
if [[ -n "$SOFTWARELIB_LOADED" && $FORCE_RELOAD -eq 0 ]]; then
    return 0
fi
SOFTWARELIB_LOADED=1



# Lib function
JavaInstalled() {
    local file="$1"
    if ! command -v java &>/dev/null; then
        LogFatal "Java is not installed. Install Java 17 or higher." "$file"
        exit 1
    fi
}

JavaVersion() {
    local file="$1"
    JAVA_VERSION=$(java -version 2>&1 | awk -F[\".] '/version/ {print $2}')
    if (( JAVA_VERSION < 17 )); then
        LogFatal "Java version too old: $JAVA_VERSION. Java 17 or higher is required." "$file"
        exit 1
    fi
}

UnzipInstalled() {
    local file="$1"
    if ! command -v unzip &>/dev/null; then
        LogFatal "unzip is not installed" "$file"
        exit 1
    fi
}