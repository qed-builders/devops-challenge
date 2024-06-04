module "qed-ec2" {
  source = "./ec2-module"

  key_name = "qed"
  vpc_cidr = "10.0.0.0/16"
  subnet_cidr = "10.0.1.0/24"
  subnet_region = "eu-central-1a"
  instance_name = "qed-instance"

}

output "public_ip" {
    value = public_ip.public_ip
}

output "private_key" {
  value = private_key.content
}