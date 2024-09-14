# Terraform EC2 and Load Balancer Deployment

This project automates the deployment of a highly available and scalable infrastructure on AWS using Terraform. The architecture includes multiple EC2 instances, both public and private, behind load balancers, with traffic managed via NGINX proxies. A NAT Gateway is used to enable internet access for private EC2 instances. The state of the infrastructure is stored in an S3 bucket for remote state management.

## Table of Contents

1. [Architecture Overview](#architecture-overview)
2. [Features](#features)
3. [Project Structure](#project-structure)
4. [Requirements](#requirements)
5. [Setup Instructions](#setup-instructions)
    - [1. Clone the repository](#1-clone-the-repository)
    - [2. Initialize Terraform](#2-initialize-terraform)
    - [3. Set up Remote State](#3-set-up-remote-state)
    - [4. Deploy the Infrastructure](#4-deploy-the-infrastructure)
    - [5. Access Public Load Balancer](#5-access-public-load-balancer)
    - [6. View All IPs](#6-view-all-ips)
    - [7. Cleanup](#7-cleanup)
6. [Customization](#customization)
7. [Screenshots](#screenshots)
8. [Remote Provisioning](#remote-provisioning)
    - [Sample IP Output](#sample-ip-output)
9. [Contributing](#contributing)
10. [License](#license)

## Architecture Overview

1. **Public Load Balancer**: Receives traffic from the internet and forwards it to the public EC2 instances.
2. **Public EC2 Instances**: Serve as reverse proxies using NGINX to forward traffic to a private load balancer.
3. **Private Load Balancer**: Manages traffic between the public EC2 instances and the private EC2 instances.
4. **Private EC2 Instances**: Return their private IP address when accessed.
5. **Remote State**: Stored in an S3 bucket.
6. **NAT Gateway**: Enables the private EC2 instances to access the internet when needed.

## Features

- **Custom Terraform Modules**: Utilizes custom modules to manage EC2 instances, load balancers, and VPC resources.
- **Remote State Management**: The Terraform state file is stored in an S3 bucket for safe storage and collaboration.
- **Dynamic IP Output**: Public and private IPs of the EC2 instances are stored in a file (`all-ips.txt`).
- **Automated Provisioning**: Apache or NGINX is installed on EC2 instances via remote provisioner.
- **Scalable and Secure**: Combines public and private EC2 instances with NAT Gateway for secure traffic management.

## Project Structure

```bash
terraform-ec2-loadbalancer-deployment/
├── main.tf                        # Main Terraform configuration
├── modules/                       # Custom Terraform modules
│   ├── ec2-instance/              # EC2 module
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── private_user_data.sh   # NGINX config for private instances
│   │   ├── public_user_data.sh    # NGINX config for public instances
│   │   ├── README.md
│   │   ├── templates/             # Additional templates for EC2 config
│   │   └── variables.tf
│   ├── load-balancer/             # Load Balancer module
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── README.md
│   │   └── variables.tf
│   └── vpc/                       # VPC module for networking
│       ├── main.tf
│       ├── outputs.tf
│       ├── README.md
│       └── variables.tf
├── nginx_config.conf              # NGINX configuration file
├── outputs.tf                     # Terraform outputs
├── provider.tf                    # Provider configuration (AWS)
├── README.md                      # Project documentation (this file)
├── remote-state-setup/            # Remote state management setup
│   └── main.tf
├── scripts/                       # Shell scripts for setup and teardown
│   ├── destroyALL.sh              # Script to destroy all resources
│   └── setup.sh                   # Script to initialize resources
└── variables.tf                   # Input variables for the project
