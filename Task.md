# Terraform EC2 and Load Balancer Deployment
This document serves as a comprehensive guide for anyone want to creat and deploy this project. Whether you are a seasoned Devops eng or just starting your journey in cloud infrastructure, this project is designed to enhance your understanding of AWS and Terraform. 
## Project Overview
| Description           | Details                                    |
|-----------------------|--------------------------------------------|
| Purpose               | Deploy a scalable and secure infrastructure on AWS using Terraform.         |
| Main Features         | Architecture includes four EC2 instances and two load balancers in public and private subnets in two different availability zone. |

### Main Features
| Feature                | Description                             |
|------------------------|-----------------------------------------|
| Public EC2 Instances    | Two instances in public subnets,in two different availability zone,accessible via the internet. |
| Private EC2 Instances   | Two instances in private subnets,in two different availability zone, isolated from direct internet access. |
| Load Balancers          | Public-facing load balancer for public instances; private load balancer for private instances. |
| Custom Terraform Modules | Deployed using custom-built modules for scalability. |
| State Management        | Terraform state stored securely in an S3 bucket. |
| Remote Provisioning     | nginx or Apache server installed automatically on EC2 instances. |
| Output Logging          | Public and private IP addresses saved in `all-ips.txt`. |
| Traffic Flow           | Public load balancer forwards traffic to public instances, which then direct requests to private load balancer then to private instances. |

## Implementation Steps
| Step | Action                               | Details                |
|------|--------------------------------------|------------------------|
| 1    | Using Custom Modules                 | Implement the infrastructure using custom, not public, Terraform modules based on the architecture diagram included in the README. |
| 2    | State File Management                | Store the Terraform state file in a remote S3 bucket for secure management. |
| 3    | Provisioning                         | Use a remote provisioner to install nginx or Apache on the EC2 instances. Then, utilize `local-exec` to print all IPs to a file named `all-ips.txt` in the format: `public-ip1 1.1.1.1 public-ip2 2.2.2.2`. |
| 4    | Load Balancer Configuration          | The first load balancer must be public, while the second load balancer will send traffic to the private EC2 instances. |
| 5    | Documentation                        | Take a screenshot of the proxy configuration. |
| 6    | DNS Verification                     | Capture a screenshot of the public DNS of the load balancer when traffic is sent from a browser, showing it returns content from the private EC2 instances. |
| 7    | State File Verification              | Screenshot the S3 bucket that contains the Terraform state file to demonstrate proper state management. |

### Additional Insights
- 
