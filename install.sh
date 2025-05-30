#/bin/bash

# Update System
echo "Update System"
sudo apt update
sudo apt upgrade -y

# Firewall
echo "Configuring Firewall"
ufw allow ssh
ufw allow http
ufw allow https
ufw enable

# Disable Password Login
echo "Disabling Password Login"
sed -i -e '/^\(#\|\)PasswordAuthentication/s/^.*$/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i -e '/^\(#\|\)PubkeyAuthentication/s/^.*$/PubkeyAuthentication yes/' /etc/ssh/sshd_config
sed -i -e '/^\(#\|\)PermitEmptyPasswords/s/^.*$/PermitEmptyPasswords no/' /etc/ssh/sshd_config
if ! grep -q "^ChallengeResponseAuthentication" /etc/ssh/sshd_config; then
    echo 'ChallengeResponseAuthentication no' >> /etc/ssh/sshd_config
else 
    sed -i -e '/^\(#\|\)ChallengeResponseAuthentication/s/^.*$/ChallengeResponseAuthentication no/' /etc/ssh/sshd_config
fi

# Install fail2ban
echo "Installing fail2ban"
sudo apt -y install fail2ban

# Install Postgres
echo "Installing Postgres"
sudo apt -y install postgresql postgresql-contrib
sudo systemctl status postgresql

# Install .Net
echo ".net runtime"
sudo apt install -y dotnet-runtime-8.0

# Install nginx
echo "nginx"
sudo apt install -y nginx

echo "rebooting"
sudo reboot