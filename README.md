# SCRIPTFORTOOLS
BEST LINUX DISTRO FOR TECHNICAL AND NETWORK ENGINEERS AND SECURITY PERSONNEL


### **Ubuntu: The Ultimate Stable Platform for Ethical Hacking**  

While Kali Linux and Parrot OS are specialized for penetration testing, **Ubuntu offers the best balance of stability, software support, and customization** for building a reliable hacking platform.  

✅ **Why Ubuntu?**  
✔ **Wider software compatibility** – More tools, libraries, and documentation work out-of-the-box.  
✔ **Long-term support (LTS)** – Stable updates without breaking changes.  
✔ **Better hardware support** – Fewer driver issues compared to niche distros.  
✔ **Stealthier** – Looks like a normal workstation, avoiding detection in red team ops.  

🔧 **How to Turn Ubuntu into a Hacking Powerhouse**  
This repository provides **tested, dependency-safe scripts** to install all essential security tools without breaking your system:  

1️⃣ **Pre-Installation Setup** – Ensures dependencies and system stability.  
2️⃣ **Tool Installation** – Adds 100+ hacking tools (Metasploit, Burp Suite, Wireshark, etc.) with verification.  

💻 **Usage:**  
```bash
sudo ./setup.sh   # Prepares system  
sudo ./install.sh # Installs tools  
```  

📌 **Perfect For:**  
- **Security researchers** who need a stable base OS  
- **Bug bounty hunters** requiring reliable tools  
- **CTF players** who want a customizable environment  
- **IT professionals** learning ethical hacking  

⚠ **Note:** Use responsibly and only on authorized systems.  

---

This keeps it professional, highlights Ubuntu's advantages, and directs users to your scripts. You can expand details in the full `README.md`.  



# Ubuntu Security Tools Installer

## Features
- Safe, error-checked installation
- Verified dependencies
- System compatibility checks
- Comprehensive logging



## Usage
1. Clone repository:
   ```bash
   git clone git@github.com:swthetnt/SCRIPTFORTOOLS.git
   cd ubuntu-security-tools



  ## INSTALLATION
sudo ./setup.sh

sudo ./install.sh


**Best Practices:**
1. Keep scripts in separate files for easier maintenance
2. Use explicit version pins for critical tools
3. Include SHA256 checksums for downloaded files
4. Add a `--dry-run` option for testing
5. Include uninstallation script for clean removal

This structure ensures reliability while maintaining system integrity. The scripts can be safely run multiple times and will skip already-installed components.
