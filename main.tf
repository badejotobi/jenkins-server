provider "aws" {
  region = var.region
}
data "aws_ssm_parameter" "ami_id" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}



resource "aws_instance" "Jenkins" {
  ami                         = data.aws_ssm_parameter.ami_id.value
  subnet_id                   = aws_subnet.public1.id
  instance_type               = "t2.micro"
  key_name = "cs446"
  user_data                   = fileexists("scripts.sh") ? file("scripts.sh") : null
  security_groups             = [aws_security_group.jenkins.id]
  tags = {
    Name = "jenkins"
  }
}
