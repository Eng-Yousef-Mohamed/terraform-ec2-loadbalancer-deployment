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


TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/local-ipv4 > /usr/share/nginx/html/index.html



# Start Nginx service
sudo systemctl start nginx