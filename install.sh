#/bin/bash

# Update System
sudo apt update
sudo apt upgrade

# Install Postgres
sudo apt -y install postgresql postgresql-contrib
sudo systemctl status postgresql


# Install .Net
sudo apt install -y dotnet-runtime-8.0

# Install nginx
sudo apt install -y nginx

# Firewall
sudo ufw allow 80
sudo ufw allow 443


