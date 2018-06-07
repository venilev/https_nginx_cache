#!/bin/bash

# Install NGINX on Centos 7

# Install EPEL repo
sudo yum -y install epel-release

# Install NGINX
sudo yum -y install nginx

# Configure NGINX to run after system reboot
sudo chkconfig nginx on
sudo systemctl enable nginx
sudo systemctl start nginx

# Generate SSl key and cert for HTTPS servers
sudo mkdir -p /etc/pki/nginx/private
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/pki/nginx/private/server.key -out /etc/pki/nginx/server.crt

# Create nginx caching folder
sudo mkdir -p /tmp/nginx/cache
sudo chown -R nginx:nginx /tmp/nginx

# Check nginx config syntax
sudo nginx -t

# Logging nginx
sudo chown nginx:nginx /var/log/nginx/access.log
sudo chown nginx:nginx /var/log/nginx/error.log

# Debugging commands
# Verify NGINX is running on expected ports
netstat -tapnl

# Verify NGINX status
sudo systemctl status nginx

# Check NGINX errors
journalctl -xe

# Check NGINX logs
tail -f /var/log/nginx/error.log /var/log/nginx/access.log
