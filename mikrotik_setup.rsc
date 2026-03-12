# --- NCAE Cyber Games 2025: MikroTik Master Setup ---
# Instructions: Update the 'TEAM' variable below, then copy/paste into terminal.

:local TEAM "12"
:local EXT_IP ("172.20." . $TEAM . ".1/16")
:local INT_IP ("192.168." . $TEAM . ".1/24")
:local WEB_SERVER ("192.168." . $TEAM . ".2")

# 1. IP Address Configuration
/ip address add address=$EXT_IP interface=ether5 comment="External"
/ip address add address=$INT_IP interface=ether6 comment="Internal"

# 2. DNS Configuration (Allows resolution of team website)
/ip dns set allow-remote-requests=yes servers=8.8.8.8
/ip dns static add name=("www.team" . $TEAM . ".ncaecybergames.org") address=$WEB_SERVER

# 3. NAT & Port Forwarding (The "Green Light" Fix)
/ip firewall nat add chain=srcnat out-interface=ether5 action=masquerade comment="Outbound Internet"
/ip firewall nat add chain=dstnat dst-address=[:pick $EXT_IP 0 [:find $EXT_IP "/"]] protocol=tcp dst-port=80 action=dst-nat to-addresses=$WEB_SERVER to-ports=80 comment="Web Traffic Forwarding"

# 4. Basic Hardening (Security)
/user set admin password="YourStrongPassword123!"
/ip service disable telnet,ftp,api,api-ssl,www
/ip service set ssh port=22

# 5. Logging (Keep track of attempts)
/system logging add topics=firewall action=memory
/log info "Master Setup Script Completed for Team $TEAM"
