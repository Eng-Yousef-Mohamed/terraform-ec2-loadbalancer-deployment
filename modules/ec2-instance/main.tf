# data "template_file" "nginx_config" {
#   template = file("${path.module}/templates/nginx_config.tpl")

#   vars = {
#     load_balancer_dns = var.load_balancer_dns
#   }
# }

resource "aws_instance" "public_ec2"{
    count =length(var.public_subnet_id) 
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.public_subnet_id[count.index]
    vpc_security_group_ids = [aws_security_group.public_security-group.id]
    key_name = aws_key_pair.kp.key_name #key pair attach
    associate_public_ip_address = "true"
    user_data =file("./modules/ec2-instance/public_user_data.sh")
 
    tags = {
        Name = "${var.Name}_public_ec2_${count.index + 1}",
        created-by="Yousef"
    }
    
    provisioner "file" {
        source      = "/home/youasf/partionA/terraform-ec2-loadbalancer-deployment/nginx_config.conf" # Local config file
        #source       = data.template_file.nginx_config.rendered  
        destination = "/tmp/nginx_config.conf" # Remote path on EC2

        # Connection details
        connection {
        type        = "ssh"
        user        = "ec2-user"
        private_key = tls_private_key.pk.private_key_pem
        host        = self.public_ip
        }
    }

    
    # Use remote-exec to apply the config
    provisioner "remote-exec" {
        inline = [
        "sudo yum install -y nginx"  , 
        "sudo cp /tmp/nginx_config.conf  /etc/nginx/conf.d/"
        ]

        # Connection details
        connection {
        type        = "ssh"
        user        = "ec2-user"
        private_key = tls_private_key.pk.private_key_pem
        host        = self.public_ip
        }
    }

  
}


resource "aws_instance" "private_ec2"{
    count = length(var.private_subnet_id)
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.private_subnet_id[count.index]
    vpc_security_group_ids = [aws_security_group.private_security-group.id]
    key_name = aws_key_pair.kp.key_name #key pair attach
    associate_public_ip_address = "false"
    user_data =file("./modules/ec2-instance/private_user_data.sh")
    tags = {
        Name = "${var.Name}_private_ec2_${count.index + 1}",
        created-by="Yousef"
    }
    
}


resource "aws_security_group" "public_security-group" {
    name = "public-security-group"
    vpc_id = var.vpc_id

    ingress {
        from_port   = var.ssh_port
        to_port     = var.ssh_port
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    

    ingress {
        from_port   = var.HTTP_port
        to_port     = var.HTTP_port
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_security_group" "private_security-group" {
    name = "private-security-group"
    vpc_id = var.vpc_id

    ingress {
        from_port   = var.ssh_port
        to_port     = var.ssh_port
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        
    }
    ingress {
        from_port   = var.HTTP_port
        to_port     = var.HTTP_port
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]# This should be updated to reflect the VPC CIDR block. However, since the private EC2 instances do not have internet access, this configuration does not currently impact them.
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}


resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = "myKey1"       # Create "myKey" to AWS!!
  public_key = tls_private_key.pk.public_key_openssh

provisioner "local-exec" { # Create "myKey.pem" to your computer!!
    command = <<EOT
echo '${tls_private_key.pk.private_key_pem}' > ./myKey1.pem
chmod 400 ./myKey1.pem
EOT
  }

}
