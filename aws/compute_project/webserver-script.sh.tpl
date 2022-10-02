#!/bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo touch /var/www/html/index.html
sudo chmod 777 /var/www/html/index.html
sudo echo "<h2>Web Server</h2>" >> /var/www/html/index.html
sudo systemctl start httpd 
