#!/bin/bash
# NCAE Cyber Games 2025 - Ubuntu Web Server Hardening
# Run with: sudo bash ubuntu_hardening.sh

TEAM_NUM="X" # Change this to your team number

echo "[+] Starting Hardening for Team $TEAM_NUM..."

# 1. Update and Install Basics
apt-get update && apt-get upgrade -y
apt-get install -y ufw apache2 curl

# 2. Create Scoring User (Change 'password123' to your assigned pass)
if ! id "scoring_user" &>/dev/null; then
    useradd -m -s /bin/bash scoring_user
    echo "scoring_user:password123" | chpasswd
    echo "[+] User 'scoring_user' created."
fi

# 3. Secure SSH Configuration
# Disables root login and empty passwords
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/PermitEmptyPasswords yes/PermitEmptyPasswords no/' /etc/ssh/sshd_config
systemctl restart ssh
echo "[+] SSH Hardened."

# 4. Configure Firewall (UFW)
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp    # SSH
ufw allow 80/tcp    # HTTP (The Scoring Port)
ufw --force enable
echo "[+] Firewall (UFW) Enabled: Allowing SSH and HTTP."

# 5. Set the Scoring String
echo "team$TEAM_NUM" > /var/www/html/index.html
systemctl restart apache2
echo "[+] Web Content Set to: team$TEAM_NUM"

echo "[***] HARDENING COMPLETE [***]"
