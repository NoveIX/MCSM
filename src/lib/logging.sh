#!/usr/bin/env bash

# Get current date in YYYY-MM-DD_HH-MM-SS format
log_file_current_date=$(date '+%Y-%m-%d')

# Log files with fallback
log_file="${LOG_FILE:-$HOME/mcsm/log/${log_file_current_date}.log}"

# color
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# ====================================== Lib function ====================================== #

# Core log function
LogMessage() {
    local level="$1"
    local msg="$2"
    local timestamp
    timestamp=$(date '+%H:%M:%S')
    echo "[$timestamp] [$level] - $msg" >> "$log_file"
}

# Simple wrappers
LogInfo()  { LogMessage "INFO" "$1"; }
LogWarn()  { LogMessage "WARN" "$1"; }
LogError() { LogMessage "ERROR" "$1"; }
LogFatal() { LogMessage "FATAL" "$1"; }

# Console + file
LogInfoCls()  { echo -e "[${BLUE}INFO${NC}]  - $1"; LogMessage "INFO" "$1"; }
LogWarnCls()  { echo -e "[${YELLOW}WARN${NC}]  - $1"; LogMessage "WARN" "$1"; }
LogErrorCls() { echo -e "[${RED}ERROR${NC}] - $1"; LogMessage "ERROR" "$1"; }