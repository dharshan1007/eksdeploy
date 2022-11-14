resource "aws_security_group" "jenkins_sg" {
name        = "jenkins_sg"
vpc_id      = var.default_vpc_id
description = "Exposes basic ports needed for jenkins"
#allow http 
ingress {
from_port   = 80
to_port     = 80
protocol    = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
# allow https
ingress {
from_port   = 443
to_port     = 443
protocol    = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
# allow SSH
ingress {
from_port   = 22
to_port     = 22
protocol    = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
ingress {
from_port   = 8080
to_port     = 8080
protocol    = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
#all outbound
egress {
from_port   = 0
to_port     = 0
protocol    = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
tags = {
Name = "jenkins_sg"
solution = var.solution
environment = var.environment
}
}

