variable "aws_region" {
  description = "regiao onde os recursos serao criados"
  type = string  
  default = "us-east-1"
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type = string
  default = "t2.micro"
}

variable "instance_name" {
  description = "Nome da instancia EC2"
  type = string
  default = "Servidor-IIS"
}

variable "key_name" {
  description = "Nome chave SSH para acesso instancia"
  type = string  
  sensitive = true
}

variable "regras_ingress"{
  type = map(string)
  default = {
    3389 = "RDP"
    80 = "HTTP"
    5986 = "WinRM HTTPS para Ansible"
    5985 = "WinRM HTTP para Ansible"
  }
}