##############################################################
# Read the AMI id to be used in the instance creation
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

##############################################################

# create the VPC
resource "aws_vpc" "qed_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "qed_vpc"
  }
}

# create the subnet
resource "aws_subnet" "qed_subnet" {
  vpc_id            = aws_vpc.qed_vpc.id
  cidr_block        = var.subnet_cidr
  availability_zone = var.subnet_region

  tags = {
    Name = "qed_subnet"
  }
}

# create the Security Group
resource "aws_security_group" "qed-sg" {
  name        = "qed-sg"
  description = "Security group used by Qed"
  vpc_id      = aws_vpc.qed_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
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

##############################################################

# create the instance
resource "aws_instance" "qed-instance" {
  ami           = data.aws_ami.ubuntu.image_id
  instance_type = "t2.micro"
  key_name      = "qed-key"
  subnet_id     = aws_subnet.qed_subnet.id
  
  security_groups = [aws_security_group.qed-sg.id]

  root_block_device {
    volume_size = 20
  }
  tags = {
    Name = var.instance_name
  }
}

resource "aws_eip" "qed_eip" {
  instance = aws_instance.qed-instance.id
  domain = "vpc"

  tags = {
    Name = "qed-instance-eip"
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.qed-instance.id
  allocation_id = aws_eip.qed_eip.id
}

resource "aws_internet_gateway" "qed_igw" {
  vpc_id = aws_vpc.qed_vpc.id

  tags = {
    Name = "qed-igw"
  }
}

resource "aws_route" "internet_access" {
  route_table_id            = aws_vpc.qed_vpc.main_route_table_id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.qed_igw.id
}

##############################################################

# # create public and private keys
# resource "tls_private_key" "qed_private_key" {
#   algorithm = "RSA"
#   rsa_bits  = 2048  # adjust the key size as needed
# }

# resource "aws_key_pair" "my_key_pair" {
#   key_name   = "my-key-pair"
#   public_key = tls_private_key.qed_private_key.public_key_openssh
# }

# resource "local_file" "private_key" {
#   content         = tls_private_key.qed_private_key.private_key_pem
#   filename        = "./private_key.pem"  # save private key in the current directory
# }

# resource "local_file" "public_key" {
#   content         = tls_private_key.qed_private_key.public_key_openssh
#   filename        = "./public_key.pub"  # save public key in the current directory
# }

output "public_ip" {
  value = aws_instance.qed-instance.public_ip
}

# output "private_key" {
#   value = tls_private_key.qed_private_key.private_key_pem
#   sensitive = true
# }