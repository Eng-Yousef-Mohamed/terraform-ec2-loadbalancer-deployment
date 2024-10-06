# AWS EC2 and Load Balancer Infrastructure Deployment using Terraform

## Project Overview
This project involves deploying a scalable and secure infrastructure on AWS using Terraform. The architecture consists of four EC2 instances and two load balancers, distributed between public and private subnets. 

### Key Components:
- **Public EC2 Instances:** Two EC2 instances deployed in public subnets, accessible via the internet.
- **Private EC2 Instances:** Two additional EC2 instances deployed in private subnets, isolated from direct internet access.
- **Load Balancers:** A public-facing load balancer distributes traffic to the public EC2 instances, while a second private load balancer manages traffic directed to the private EC2 instances.
- **Custom Terraform Modules:** The infrastructure is deployed using custom-built modules (you made), ensuring modularity and scalability for future use cases.
- **State Management:** The Terraform state file is stored securely in an S3 bucket, enabling collaboration and version control of the infrastructure state.
- **Remote Provisioning:** nginx server is installed on the EC2 instances ensuring the application stack is set up automatically upon instance creation.
- **Output Logging:** After deployment, the public and private IP addresses of the instances are captured and stored in a text file (`all-ips.txt`) using a local-exec provisioner. This file contains a structured list of IP addresses, formatted for easy reference.
- **Traffic Flow:** The public load balancer manages incoming traffic, forwarding it to publice instance then forwarding it to the private load balancer, which then directs requests to the private EC2 instances, ensuring a secure and efficient traffic distribution.

## Instructions
1. **Custom Modules:** Use custom-built modules (not public ones) to implement the infrastructure as per the architecture.
2. **State File:** Store the Terraform state file in a remote S3 bucket for secure and reliable state management.
3. **Provisioning:** Use the remote provisioner to install either Apache or a proxy on the EC2 instances. After setup, use the `local-exec` provisioner to print the IP addresses of all EC2 instances to a file called `all-ips.txt`.
4. **Load Balancers:** The first load balancer must be public-facing, while the second should handle internal traffic and direct it to the private EC2 instances.
5. **Proxy Configuration Screenshot:** Take a screenshot of the proxy configuration for documentation.
6. **DNS Screenshot:** After setting up the public load balancer, capture a screenshot of its DNS responding to traffic when accessed through a browser, showing that it successfully returns content from the private EC2 instances.
7. **State File Screenshot:** Capture a screenshot of the S3 bucket that contains the Terraform state file, demonstrating proper state management.

---


