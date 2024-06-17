module "security_group" {
  source = "./security_group_module"
}

resource "aws_instance" "node_app_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [module.security_group.security_group_id]

   user_data = <<-EOF
              #!/bin/bash
              # Update and install Docker
              sudo yum update -y
              sudo amazon-linux-extras install docker -y
              sudo service docker start
              sudo usermod -a -G docker ec2-user

              # Pull and run the Docker container from Docker Hub
              docker pull andreidirlau/my-node-app:latest
              docker run -d -p 3000:3000 --restart unless-stopped andreidirlau/my-node-app:latest
              EOF

  tags = {
    Name = "NodeAppInstance"
  }
}