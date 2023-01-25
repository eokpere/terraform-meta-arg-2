# EC2 Instance
resource "aws_instance" "myec2" {
  ami = "ami-06c3426233c180fef"
  #instance_type = var.instance_type
  instance_type = var.instance_type_list[0]  # For List
  #instance_type = var.instance_type_map["dev"]  # For Map
  key_name = var.instance_keypair
  vpc_security_group_ids = [ aws_security_group.vpc-ssh.id ]
  count = 1
  tags = {
    "Name" = "Staging-${count.index}"
  }
}

# Create Security Group - SSH Traffic
resource "aws_security_group" "vpc-ssh" {
  name        = "vpc-ssh"
  description = "Staging VPC SSH"
  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all ip and ports outbound"    
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vpc-ssh"
  }
}