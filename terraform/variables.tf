variable "instance_type" {
  description = "The type of instance to start"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
  default     = "ami-0d2820455d08be628"
}

variable "public_key_path" {
  description = "The path to the public key to be used for the EC2 key pair"
  type        = string
  default     = "~/dev/deployer.pem"
}