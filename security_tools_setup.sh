#!/bin/bash

# Security Tools Setup Script
# Part 1: Dependency checks and system preparation

# Initialize logging
LOG_FILE="security_tools_install.log"
exec > >(tee -a "$LOG_FILE") 2>&1

# Error handling function
handle_error() {
    echo -e "\033[1;31mError: $1\033[0m"
    echo "Last command failed. Check $LOG_FILE for details."
    exit 1
}

# Check root privileges
if [ "$EUID" -ne 0 ]; then
    handle_error "Please run as root"
fi

# System compatibility check
source /etc/os-release
if [[ "$ID" != "ubuntu" || ("$VERSION_ID" != "20.04" && "$VERSION_ID" != "22.04") ]]; then
    handle_error "Unsupported OS. Only Ubuntu 20.04/22.04 supported."
fi

# Verify internet connection
if ! curl -Is https://github.com | head -n 1 | grep -q 200; then
    handle_error "No internet connection or GitHub unreachable"
fi

# System update with error checking
echo -e "\n\033[1;32m[1/3] Updating System\033[0m"
if ! apt update && apt upgrade -y; then
    handle_error "System update failed"
fi

# Install core dependencies with verification
echo -e "\n\033[1;32m[2/3] Installing Core Dependencies\033[0m"
required_deps=(
    software-properties-common git curl wget nmap
    build-essential python3 python3-pip python3-venv
    ruby ruby-dev libssl-dev zlib1g-dev openjdk-17-jdk
)

if ! apt install -y "${required_deps[@]}"; then
    handle_error "Core dependency installation failed"
fi

# Verify critical components
declare -A binary_checks=(
    ["git"]="git version"
    ["python3"]="python3 --version"
    ["pip3"]="pip3 --version"
    ["java"]="java --version"
)

for cmd in "${!binary_checks[@]}"; do
    if ! command -v "$cmd" &> /dev/null; then
        handle_error "$cmd not installed properly"
    fi
done

echo -e "\n\033[1;32m[3/3] System Prepared Successfully\033[0m"
echo "Proceed with installation script"
