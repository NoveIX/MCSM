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

# ======================================[ Lib function ]====================================== #

# Core log function
log_message() {
    local level="$1"
    local msg="$2"
    local timestamp
    timestamp=$(date '+%H:%M:%S')
    echo "[$timestamp] [$level] - $msg" >> "$log_file"
}

# Simple wrappers
log_info()  { LogMessage "INFO" "$1"; }
log_warn()  { LogMessage "WARN" "$1"; }
log_error() { LogMessage "ERROR" "$1"; }
log_fatal() { LogMessage "FATAL" "$1"; }

# Console + file
log_info_cli()  { echo -e "[${BLUE}INFO${NC}]  - $1"; LogMessage "INFO" "$1"; }
log_warn_cli()  { echo -e "[${YELLOW}WARN${NC}]  - $1"; LogMessage "WARN" "$1"; }
log_error_cli() { echo -e "[${RED}ERROR${NC}] - $1"; LogMessage "ERROR" "$1"; }