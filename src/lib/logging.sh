#!/usr/bin/env bash

# Force lib file reload
FORCE_RELOAD=0
if [[ "$1" == "-f" ]]; then
    FORCE_RELOAD=1
fi

# Load lib file
if [[ -n "$LOGGINGLIB_LOADED" && $FORCE_RELOAD -eq 0 ]]; then
    return 0
fi
LOGGINGLIB_LOADED=1

# color
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'



# Lib Function
LogMessage() {
    local level="$1"
    local msg="$2"
    local file="$3"
    local timestamp
    timestamp=$(date '+%H:%M:%S')
    echo "[$timestamp] [$level] - $msg" >> "$file"
}

LogInfo() {
    local msg="$1"
    local file="$2"
    LogMessage "INFO" "$msg" "$file"
}

LogWarn() {
    local msg="$1"
    local file="$2"
    LogMessage "WARN" "$msg" "$file"
}

LogError() {
    local msg="$1"
    local file="$2"
    LogMessage "ERROR" "$msg" "$file"
}

LogInfoCls() {
    local msg="$1"
    local file="$2"
    echo -e "[${BLUE}INFO${NC}] - $msg"
    LogMessage "INFO" "$msg" "$file"
}

LogWarnCls() {
    local msg="$1"
    local file="$2"
    echo -e "[${YELLOW}WARN${NC}] - $msg"
    LogMessage "WARN" "$msg" "$file"
}

LogErrorCls() {
    local msg="$1"
    local file="$2"
    echo -e "[${RED}ERROR${NC}] - $msg"
    LogMessage "ERROR" "$msg" "$file"
}