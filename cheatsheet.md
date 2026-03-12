# 🛡️ NCAE Cyber Games Quick Reference

## 📟 MikroTik (Router)
- **Check Interfaces:** `/interface print`
- **Check IP Addresses:** `/ip address print`
- **Check NAT Rules:** `/ip firewall nat print`
- **Reset to Blank:** `/system reset-configuration no-defaults=yes`
- **View Logs:** `/log print follow`
- **DNS Lookup Test:** `/put [:resolve www.google.com]`

## 🐧 Ubuntu (Web Server)
- **Check IP Address:** `ip addr`
- **Check Service Status:** `systemctl status apache2`
- **Edit Netplan (Network):** `sudo nano /etc/netplan/01-network-manager-all.yaml`
- **Apply Network Changes:** `sudo netplan apply`
- **View Web Logs (Live):** `tail -f /var/log/apache2/access.log`
- **Check Listening Ports:** `sudo ss -tulpn`

## 🏁 Scoring Verification
- **Internal Test:** `curl http://localhost`
- **Router NAT Test (From External):** `curl http://172.20.X.1`
