#!/bin/bash

# Security Tools Installation Script
# Part 2: Tool installation with verification

# Initialize logging
LOG_FILE="security_tools_install.log"
exec > >(tee -a "$LOG_FILE") 2>&1

# Error handling with continuation
handle_install_error() {
    echo -e "\033[1;31mInstall Error: $1\033[0m"
    echo "Skipping this tool, continuing installation..."
}

# Check if setup was completed
if [ ! -f "$LOG_FILE" ]; then
    echo -e "\033[1;31mRun security_tools_setup.sh first!\033[0m"
    exit 1
fi

# Installation groups with verification
install_apt_tools() {
    local tool_groups=(
        "nmap wireshark john hydra"
        "aircrack-ng tcpdump netcat"
        "sqlmap dirb nikto ettercap-text-only"
        "hashcat binwalk exiftool steghide"
    )

    for group in "${tool_groups[@]}"; do
        echo -e "\n\033[1;32mInstalling package group: $group\033[0m"
        if ! apt install -y $group; then
            handle_install_error "Failed to install $group"
        fi
        
        # Verify key tools in group
        for tool in $group; do
            if ! command -v "$tool" &> /dev/null; then
                handle_install_error "$tool not found after installation"
            fi
        done
    done
}

install_external_tools() {
    # Metasploit Framework
    echo -e "\n\033[1;32mInstalling Metasploit\033[0m"
    if [ ! -f "/opt/metasploit-framework/bin/msfconsole" ]; then
        curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
        chmod +x msfinstall && ./msfinstall || handle_install_error "Metasploit install failed"
    fi

    # Burp Suite
    echo -e "\n\033[1;32mInstalling Burp Suite\033[0m"
    burp_path="/opt/burpsuite/burpsuite_community.jar"
    if [ ! -f "$burp_path" ]; then
        mkdir -p /opt/burpsuite
        wget -q "https://portswigger.net/burp/releases/download?product=community&version=2023.9.4&type=Jar" -O "$burp_path" || handle_install_error "Burp download failed"
        echo -e '#!/bin/sh\njava -jar '"$burp_path"'' > /usr/local/bin/burpsuite
        chmod +x /usr/local/bin/burpsuite
    fi

    # Validate installations
    required_commands=(
        "msfconsole" "burpsuite" "wpscan" "setoolkit"
    )

    for cmd in "${required_commands[@]}"; do
        if ! command -v "$cmd" &> /dev/null; then
            handle_install_error "$cmd not found in PATH"
        fi
    done
}

# Main installation flow
echo -e "\n\033[1;32m[1/3] Installing APT Packages\033[0m"
install_apt_tools

echo -e "\n\033[1;32m[2/3] Installing External Tools\033[0m"
install_external_tools

echo -e "\n\033[1;32m[3/3] Finalizing Installation\033[0m"
apt autoremove -y
apt clean

echo -e "\n\033[1;32mInstallation Complete!\033[0m"
echo "Detailed log saved to $LOG_FILE"
