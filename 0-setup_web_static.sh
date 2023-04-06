#!/usr/bin/env bash

# Update and install nginx
sudo apt-get update
sudo apt-get -y install nginx

# Allow Nginx HTTP traffic
sudo ufw allow 'Nginx HTTP'

# Create directory structure for web_static
sudo mkdir -p /data/web_static/releases/test
sudo mkdir -p /data/web_static/shared

# Create an index.html file in the test directory
sudo echo "<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" | sudo tee /data/web_static/releases/test/index.html

# Create a symbolic link from /data/web_static/current to /data/web_static/releases/test/
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

# Set ownership of the /data/ directory to ubuntu
sudo chown -R ubuntu:ubuntu /data/

# Update Nginx configuration to serve web_static
sudo sed -i '/^\s*server\s*{/a location /hbnb_static/ {\n\talias /data/web_static/current/;\n}\n' /etc/nginx/sites-available/default

# Restart Nginx service
sudo service nginx restart
