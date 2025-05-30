#/bin/bash

# Update System
sudo apt update
sudo apt upgrade -y

# Firewall
ufw allow shh
ufw allow http
ufw allow https
ufw enable

# Disable Password Login
sed -i -e '/^\(#\|\)PasswordAuthentication/s/^.*$/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i -e '/^\(#\|\)PubkeyAuthentication/s/^.*$/PubkeyAuthentication yes/' /etc/ssh/sshd_config
sed -i -e '/^\(#\|\)PermitEmptyPasswords/s/^.*$/PermitEmptyPasswords no/' /etc/ssh/sshd_config
if ! grep -q "^ChallengeResponseAuthentication" /etc/ssh/sshd_config; then
    echo 'ChallengeResponseAuthentication no' >> /etc/ssh/sshd_config
else 
    sed -i -e '/^\(#\|\)ChallengeResponseAuthentication/s/^.*$/ChallengeResponseAuthentication no/' /etc/ssh/sshd_config
fi
sudo systemctl reload ssh

# Install fail2ban
sudo apt install fail2ban

# Install Postgres
sudo apt -y install postgresql postgresql-contrib
sudo systemctl status postgresql

# Install .Net
sudo apt install -y dotnet-runtime-8.0

# Install nginx
sudo apt install -y nginx
