#!/bin/bash

# Move to /tmp directory
cd /tmp

# Install the SSM Agent
sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm

# Enable and start the SSM Agent
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent

# Install Nginx
sudo yum install -y nginx

# # Create a simple HTML file

# echo "<html><body> <h1> Welcome to Instance 1  </h1></body></html>" | sudo tee /usr/share/nginx/html/index.html
# cat <<EOL | sudo tee /etc/nginx/conf.d/proxy.conf
# server {
#     listen 80;
#     server_name _;  # Your EC2 instance's public IP address

#     location / {
#         proxy_pass http://public-lb-655308110.eu-north-1.elb.amazonaws.com;  # Your load balancer's DNS name
#         proxy_set_header Host $host;
#         proxy_set_header X-Real-IP $remote_addr;
#         proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
#         proxy_set_header X-Forwarded-Proto $scheme;
#     }
# }
# EOL

# Start Nginx service
sudo systemctl start nginx