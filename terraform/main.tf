provider "aws" {
    region = var.aws_region
}

data "aws_ami" "windows" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "windows_server" {               
  ami = data.aws_ami.windows.id                         
  instance_type = var.instance_type                     
  key_name = var.key_name                               
  associate_public_ip_address = true                    

  vpc_security_group_ids = [aws_security_group.allow.id] 

  tags = {
    Name = var.instance_name                            
  }
}

resource "aws_security_group" "allow"{
    name = "allow-rdp-http"
    description = "permitir RDP e HTTP"
   
  dynamic "ingress" {
    for_each = var.regras_ingress
    content {
      from_port = ingress.key
      to_port = ingress.key
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = ingress.value
    }
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks =["0.0.0.0/0"]
  }
}