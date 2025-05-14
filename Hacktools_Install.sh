#!/bin/bash

# Ethical Hacking Tools Install Script for Ubuntu
# Requires Ubuntu 20.04/22.04 LTS
# Run with sudo privileges

# Check for root privileges
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# System Update
echo -e "\n\033[1;32mUpdating System\033[0m"
apt update && apt upgrade -y
apt install -y software-properties-common

# Install Basic Dependencies
echo -e "\n\033[1;32mInstalling Dependencies\033[0m"
apt install -y \
    git curl wget nmap zip unzip \
    build-essential python3 python3-pip python3-venv \
    ruby ruby-dev libssl-dev zlib1g-dev

# Security Toolkit
echo -e "\n\033[1;32mInstalling Core Security Tools\033[0m"
apt install -y \
    nmap wireshark john hydra \
    aircrack-ng tcpdump netcat \
    sqlmap dirb nikto ettercap-text-only \
    openssl net-tools dsniff macchanger \
    hashcat binwalk exiftool fcrackzip \
    steghide libimage-exiftool-perl

# Network Analysis
echo -e "\n\033[1;32mInstalling Network Analysis Tools\033[0m"
apt install -y \
    tshark driftnet dnsutils netdiscover \
    masscan ngrep tcpflow proxychains4

# Web Application Tools
echo -e "\n\033[1;32mInstalling Web Application Tools\033[0m"
apt install -y \
    gobuster whatweb wafw00f \
    davtest commix webshells

# Password Cracking
echo -e "\n\033[1;32mInstalling Password Cracking Tools\033[0m"
apt install -y \
    hashid crunch cewl patator

# Forensic Tools
echo -e "\n\033[1;32mInstalling Forensic Tools\033[0m"
apt install -y \
    foremost scalpel autopsy sleuthkit \
    guymager regripper

# Install Metasploit Framework
echo -e "\n\033[1;32mInstalling Metasploit Framework\033[0m"
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
chmod +x msfinstall
./msfinstall

# Install Burp Suite Community Edition
echo -e "\n\033[1;32mInstalling Burp Suite Community Edition\033[0m"
wget -q "https://portswigger.net/burp/releases/download?product=community&version=2023.9.4&type=Jar" -O burpsuite_community.jar
mkdir -p /opt/burpsuite
mv burpsuite_community.jar /opt/burpsuite/
echo -e '#!/bin/sh\njava -jar /opt/burpsuite/burpsuite_community.jar' > /usr/local/bin/burpsuite
chmod +x /usr/local/bin/burpsuite

# Install WPScan
echo -e "\n\033[1;32mInstalling WPScan\033[0m"
gem install wpscan

# Install Recon-ng
echo -e "\n\033[1;32mInstalling Recon-ng\033[0m"
git clone https://github.com/lanmaster53/recon-ng.git /opt/recon-ng
pip3 install -r /opt/recon-ng/REQUIREMENTS

# Install Social Engineering Toolkit (SET)
echo -e "\n\033[1;32mInstalling Social Engineering Toolkit\033[0m"
git clone https://github.com/trustedsec/social-engineer-toolkit/ /opt/setoolkit/
pip3 install -r /opt/setoolkit/requirements.txt
ln -s /opt/setoolkit/setoolkit /usr/local/bin/setoolkit

# Install Impacket
echo -e "\n\033[1;32mInstalling Impacket\033[0m"
pip3 install impacket

# Cleanup
echo -e "\n\033[1;32mCleaning Up\033[0m"
apt autoremove -y
apt clean

echo -e "\n\033[1;32mInstallation Complete!\033[0m"
echo -e "Some tools may require additional configuration:"
echo -e "- Burp Suite: Run with 'burpsuite'"
echo -e "- Metasploit: Run with 'msfconsole'"
echo -e "- Wireshark: Configure user permissions for packet capture"
echo -e "- Social Engineering Toolkit: Run with 'setoolkit'"
