#!/bin/bash

# file: url.sh

# Extract original filename from URL
get_filename_from_url() {
    local url="$1"
    local filename

    # Try to get filename from Content-Disposition header
    filename=$(wget --spider --server-response "$url" 2>&1 \
        | grep -i "Content-Disposition:" \
        | sed -n 's/.*filename=["'\'']\?\([^"'\'';]*\).*/\1/p')

    # If no Content-Disposition, fall back to basename of URL
    if [[ -z "$filename" ]]; then
        filename=$(basename "$url")
    fi

    # Return filename via echo, not return
    echo "$filename"
}

# Check a URL and extract file info without downloading
url_spider() {
    local url="$1"

    # Use wget with --spider and --server-response to get headers
    local headers
    headers=$(wget --spider --server-response "$url" 2>&1) # Get headers

    # Extract HTTP status code
    local status
    status=$(echo "$headers" | grep "HTTP/" | tail -n1 | awk '{print $2}')

    # Extract Content-Length if available
    local size
    size=$(echo "$headers" | grep -i "Content-Length" | awk '{print $2}' | tr -d '\r')

    # Convert in human redable
    local size_hr
    if [[ -n "$size" ]]; then
        size_hr=$(numfmt --to=iec --suffix=B "$size")
    else
        size_hr="unknown"
    fi

    # Extract filename from URL
    local filename
    filename=$(get_filename_from_url "$url")

    # Log based on status
    if [[ "$status" == "200" ]]; then
        LogInfo "Code: (200 OK) - URL reachable: $url"
        LogInfo "File: $filename, Size: ${size_hr:-unknown} bytes"
        return 0
    else
        LogWarn "HTTP status: ${status:-unknown} - URL not reachable: $url"
        return 1
    fi
}

# Download a file from a URL
download_file() {
    local url="$1"
    local output="$2"

    # Extract filename from URL
    local filename
    filename=$(get_filename_from_url "$url")

    # Perform download
    if wget -O "$output" "$url"; then
        # Get file size
        local size
        size=$(stat -c%s "$output" 2>/dev/null || echo "unknown")
        return 0
    else
        return 1
    fi
}